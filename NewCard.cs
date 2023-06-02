using SPORTident;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using System.Text;
using Newtonsoft.Json.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Net;
using System.IO;
using System.Net.Http.Headers;
using System.Xml.Linq;

namespace h24
{
    public class NewCard
    {
        //klc01 db;

        public int HandleNewCard(int readout_id)
        {
            var db = new klc01();
            string chip_id_s = db.si_readout.First(a => a.readout_id == readout_id).chip_id;

            int competitor_id = this.GetRunnerByCardId(chip_id_s);
            while (competitor_id == 0)
            {
                //chip not found
                frmChipNotFound f2 = new frmChipNotFound(chip_id_s);
                f2.ShowDialog();
                competitor_id = this.GetRunnerByCardId(chip_id_s);
            }
            //insert leg
            int leg_id = this.InsertLeg(readout_id, competitor_id, out int guessed_course);
            int slip_id = this.InsertSlip(leg_id);

            return slip_id; //processedResult;
        }

        public long UpdateLeg(int readout_id)
        {
            int leg_id;
            using (var db = new klc01())
            {
                //string chip_id_s = db.legs.First(a => a.leg_id == leg_id).chip_id;
                string action = "U";
                int competitor_id;
                int course_id;
                int guessed_course;

                var query = (from r in db.si_readout
                             join l in db.legs on r.readout_id equals l.readout_id into gl
                             from x in gl.DefaultIfEmpty()
                             where r.readout_id == readout_id
                             select new
                             {
                                 chip_id = r.chip_id,
                                 leg_id = x != null ? x.leg_id : 0,
                                 comp_id = x != null ? x.comp_id : 0,
                                 course_id = x != null ? x.course_id : 0
                             }).FirstOrDefault();

                int chip_id = int.Parse(query.chip_id);
                leg_id = query.leg_id;
                if (leg_id == 0)
                    action = "I";

                if (query.comp_id == 0)
                    competitor_id = db.competitors.First(a => a.comp_chip_id == chip_id).comp_id;
                else
                    competitor_id = query.comp_id;

                //if ((int)query.course_id == 0)
                course_id = GetCourseAndGuessed(competitor_id, readout_id, out guessed_course);
                //else
                //course_id = (int)query.course_id;

                //update or insert to legs
//TODO - tohle nejak nefunguje
                //var aaa = db.sp_upsert_legs(readout_id, competitor_id, course_id, guessed_course, action);
                leg_id = int.Parse(db.sp_upsert_legs(readout_id, competitor_id, course_id, guessed_course, action).FirstOrDefault().ToString());
                int y= UpdateTeamRaceEnd(competitor_id);
            }

            int slip_id = this.InsertSlip(leg_id);

            _ = PostSlip(readout_id);
            return 0; //processedResult;
        }

        public int GetRunnerByCardId(string cardId)
        {
            int competitor_id;
            long chip_id = Int32.Parse(cardId);

            try
            {
                using (var db = new klc01())
                {
                    competitor_id = db.competitors.First(a => a.comp_chip_id == chip_id).comp_id;
                }
                return competitor_id;
            }
            catch (Exception ex)
            {
                //MessageBox.Show($"An exception occured finding {chip_id}: \n\n{ex.Message}.", "ReaderDemoProject", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return 0;
            }

        }

        public List<int> GuessCourse(int readout_id)
        {
            using (var db = new klc01())
            {
                var a = db.sp_guess_course(readout_id);//.FirstOrDefault();
                return a.Where(x => x != null).Cast<int>().ToList();
                //return b;
            }
        }

        public int GetCourseFromLegs(long competitor_id)
        {
            using (var db = new klc01())
            {
                var leg = db.legs.FirstOrDefault(a => a.comp_id == competitor_id && a.readout_id == null);
                if (leg == null)
                    return 0;
                else
                    return (int)leg.course_id;
            }
        }

        public int GetCourseAndGuessed(int competitor_id, int readout_id, out int guessed_course)
        {
            int course_id = 0;
            List<int> guessed_courses;
            try
            {
                course_id = this.GetCourseFromLegs(competitor_id);
                guessed_courses = this.GuessCourse(readout_id);

                if (course_id == 0)
                {
                    if (guessed_courses.Count() == 1)
                        course_id = guessed_courses[0];

                    while (course_id == 0)
                    {
                        //unknown course
                        frmCourseNotFound frm = new frmCourseNotFound(competitor_id, readout_id);
                        frm.ShowDialog();
                        course_id = frm.course;
                        frm.course = 0;
                    }
                }

                if (guessed_courses.Contains(course_id))
                    guessed_course = course_id;
                else
                    guessed_course = 0;
                return course_id;
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
                string err = "";
                foreach (var eve in ex.EntityValidationErrors)
                {
                    err += "Entity of type " + eve.Entry.Entity.GetType().Name + " in state " + eve.Entry.State + " has the following validation errors:";
                    foreach (var ve in eve.ValidationErrors)
                    {
                        err += "- Property: " + ve.PropertyName + ", Error: " + ve.ErrorMessage + "";
                    }
                }
                MessageBox.Show(err);
                throw;
            }

        }


        public int InsertLeg(int readout_id, int competitor_id, out int guessed_course)
        {
            using (var db = new klc01())
            {
                int course_id;

                try
                {
                    course_id = GetCourseAndGuessed(competitor_id, readout_id, out guessed_course);

                    //update or insert to legs
                    int leg_id = int.Parse(db.sp_upsert_legs(readout_id, competitor_id, course_id, guessed_course, "I").FirstOrDefault().ToString());
                    int x = UpdateTeamRaceEnd(competitor_id);
                    return leg_id;
                }
                catch (System.Data.Entity.Validation.DbEntityValidationException ex)
                {
                    string err = "";
                    foreach (var eve in ex.EntityValidationErrors)
                    {
                        err += "Entity of type " + eve.Entry.Entity.GetType().Name + " in state " + eve.Entry.State + " has the following validation errors:";
                        foreach (var ve in eve.ValidationErrors)
                        {
                            err += "- Property: " + ve.PropertyName + ", Error: " + ve.ErrorMessage + "";
                        }
                    }
                    MessageBox.Show(err);
                    throw;
                }
            }
        }

        public int UpdateTeamRaceEnd(int competitor_id)
        {
            using (var db = new klc01())
            {
                try
                {
                    int cnt = int.Parse(db.update_team_race_end(competitor_id).ToString());
                    return cnt;
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    throw;
                }
            }
        }

        public int InsertSlip(int leg_id)
        {
            using (var db = new klc01())
            {
                try
                {
                    //update or insert to slips
                    return db.sp_insert_slips(leg_id);
                }
                catch (System.Data.Entity.Validation.DbEntityValidationException ex)
                {
                    string err = "";
                    foreach (var eve in ex.EntityValidationErrors)
                    {
                        err += "Entity of type " + eve.Entry.Entity.GetType().Name + " in state " + eve.Entry.State + " has the following validation errors:";
                        foreach (var ve in eve.ValidationErrors)
                        {
                            err += "- Property: " + ve.PropertyName + ", Error: " + ve.ErrorMessage + "";
                        }
                    }
                    MessageBox.Show(err);
                    throw;
                }
            }
        }

        public long GetResult(SportidentCard card)//, long competitor_id)
        {
            if (card == null)
            {
                throw new ArgumentNullException("card");
            }
            return 0;
        }

        public static async Task RegisterClient()
        {
            using (var db = new klc01())
            {
                string url = db.settings.FirstOrDefault(c => c.config_name == "live_url").config_value;
                string uid= db.settings.FirstOrDefault(c => c.config_name == "live_user").config_value;
                string pwd = db.settings.FirstOrDefault(c => c.config_name == "live_password").config_value;

                var httpWebRequest = (HttpWebRequest)WebRequest.Create(url + "/register");
                httpWebRequest.ContentType = "application/json";
                httpWebRequest.Method = "POST";

                using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
                {
                    string json = "{\"client_name\":\"" + uid + "\"," +
                                  "\"password\":\""+ pwd + "\"}";

                    streamWriter.Write(json);
                }

                var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    var result = streamReader.ReadToEnd();
                }

            }
        }

        public static async Task<string> LoginClient()
        {
            using (var db = new klc01())
            {
                HttpClient httpClient = new HttpClient();
                string url = db.settings.FirstOrDefault(c => c.config_name == "live_url").config_value;

                string pwd = db.settings.FirstOrDefault(c => c.config_name == "live_password").config_value;
                string uid = db.settings.FirstOrDefault(c => c.config_name == "live_user").config_value;

                string uri = url + "/login";
                string json = "{\"client_name\":\"" + uid + "\"," +
                                 "\"password\":\"" + pwd + "\"}";
                StringContent httpContent = new StringContent(json, Encoding.UTF8, "application/json");
                var response = await httpClient.PostAsync(uri, httpContent);

                // Save the token for further requests.
                var responseToken = await response.Content.ReadAsStringAsync();

                dynamic JsonResponse = JObject.Parse(responseToken);
                string token = JsonResponse.token;

                //update token in db
                var result = db.settings.FirstOrDefault(c => c.config_name == "live_token");
                if (result != null)
                {
                    result.config_value = token;
                    db.SaveChanges();
                }

                // Set the authentication header. 
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                return token != null ? token : null;
            }

        }

        public static async Task TruncateEntries()
        {
            using (var db = new klc01())
            {
                HttpClient client = new HttpClient();
                string live_entries = db.settings.FirstOrDefault(c => c.config_name == "live_entries_truncate").config_value;
                string live_urls = db.settings.FirstOrDefault(c => c.config_name == "live_url").config_value;
                string pwd = db.settings.FirstOrDefault(c => c.config_name == "live_password").config_value;

                string[] urls = live_urls.Split(';');
                string json = "{\"truncate\":\"yes\"," +
                                "\"password\":\"" + pwd + "\"}";

                foreach (string oneUrl in urls)
                {
                    string url_truncate = oneUrl + live_entries;

                    //make request
                    StringContent httpContent = new StringContent(json, Encoding.UTF8, "application/json");

                    HttpResponseMessage response = await client.PostAsync(url_truncate, httpContent);
                    try
                    {
                        response.EnsureSuccessStatusCode();
                    }
                    catch
                    {
                        MessageBox.Show("ERR EnsureSuccessStatusCode truncate");
                        return;
                    }

                    string info = await response.Content.ReadAsStringAsync();
                    MessageBox.Show("API response: " + info);
                }
            }
        }

        public static async Task PostEntries(int team = -1)
        {
            int i = 0;
            using (var db = new klc01())
            {
                List<int> AllTeams;
                if(team == -1)
                {
                    AllTeams = db.teams.Where(s => s.team_did_start == true)
                    .Select(s => s.team_id).ToList();
                }
                else
                {
                    AllTeams = db.teams.Where(s => s.team_did_start == true && s.team_id == team)
                    .Select(s => s.team_id).ToList();
                }

                if (AllTeams.Count > 0)
                {
                    //send all entries
                    HttpClient client = new HttpClient();
                    string live_urls = db.settings.FirstOrDefault(c => c.config_name == "live_url").config_value;
                    string live_entries = db.settings.FirstOrDefault(c => c.config_name == "live_entries").config_value;

                    string[] urls = live_urls.Split(';');
                    string entry;

                    foreach (int team_id in AllTeams)
                    {
                        entry = db.get_one_entry_json(team_id).FirstOrDefault();

                        string filename = @"c:\temp\entry_post_" + team_id + "_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".json";
                        File.WriteAllText(filename, entry);

                        foreach (string oneUrl in urls)
                        {
                            string url_entries = oneUrl + live_entries;

                            //var data = new FormUrlEncodedContent(entry);
                            var entry_content = new StringContent(
                                entry,
                                System.Text.Encoding.UTF8,
                                "application/json"
                                );
                            HttpResponseMessage response = await client.PostAsync(url_entries, entry_content);
                            try
                            {
                                response.EnsureSuccessStatusCode();
                            }
                            catch
                            {
                                MessageBox.Show("ERR EnsureSuccessStatusCode post");
                                return;
                            }

                            var result = await response.Content.ReadAsStringAsync();
                            i++;
                        }
                    }
                }
            }
            //return i;
        }

        public static async Task TruncateCompetitors()
        {
            using (var db = new klc01())
            {
                HttpClient client = new HttpClient();
                string live_competitors = db.settings.FirstOrDefault(c => c.config_name == "live_competitors_truncate").config_value;
                string live_urls = db.settings.FirstOrDefault(c => c.config_name == "live_url").config_value;
                string pwd = db.settings.FirstOrDefault(c => c.config_name == "live_password").config_value;

                string[] urls = live_urls.Split(';');
                string json = "{\"truncate\":\"yes\"," +
                                "\"password\":\"" + pwd + "\"}";

                foreach (string oneUrl in urls)
                {
                    string url_truncate = oneUrl + live_competitors;

                    //make request
                    StringContent httpContent = new StringContent(json, Encoding.UTF8, "application/json");

                    HttpResponseMessage response = await client.PostAsync(url_truncate, httpContent);
                    try
                    {
                        response.EnsureSuccessStatusCode();
                    }
                    catch
                    {
                        MessageBox.Show("ERR EnsureSuccessStatusCode truncate");
                        return;
                    }

                    string info = await response.Content.ReadAsStringAsync();
                    MessageBox.Show("API response: " + info);
                }
            }
        }

        public static async Task PostCompetitors(int comp = -1)
        {
            int i = 0;
            using (var db = new klc01())
            {
                List<int> AllTeams;
                if (comp == -1)
                {
                    AllTeams = db.competitors.Where(s => s.comp_valid_flag == true)
                    .Select(s => s.comp_id).ToList();
                }
                else
                {
                    AllTeams = db.competitors.Where(s => s.comp_valid_flag == true && s.comp_id == comp)
                    .Select(s => s.comp_id).ToList();
                }

                if (AllTeams.Count > 0)
                {
                    //send all entries
                    HttpClient client = new HttpClient();
                    string live_urls = db.settings.FirstOrDefault(c => c.config_name == "live_url").config_value;
                    string live_competitors = db.settings.FirstOrDefault(c => c.config_name == "live_competitors").config_value;

                    string[] urls = live_urls.Split(';');
                    string entry;

                    foreach (int comp_id in AllTeams)
                    {
                        entry = db.get_one_competitor_json(comp_id).FirstOrDefault();

                        string filename = @"c:\temp\comp_post_" + comp_id + "_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".json";
                        File.WriteAllText(filename, entry);

                        foreach (string oneUrl in urls)
                        {
                            string url_competitors = oneUrl + live_competitors;

                            //var data = new FormUrlEncodedContent(entry);
                            var entry_content = new StringContent(
                                entry,
                                System.Text.Encoding.UTF8,
                                "application/json"
                                );
                            HttpResponseMessage response = await client.PostAsync(url_competitors, entry_content);
                            try
                            {
                                response.EnsureSuccessStatusCode();
                            }
                            catch
                            {
                                MessageBox.Show("ERR EnsureSuccessStatusCode post");
                                return;
                            }

                            var result = await response.Content.ReadAsStringAsync();
                            i++;
                        }
                    }
                }
            }
            //return i;
        }


        public async static Task<string> OrisGetEntries()
        {
            string result;
            using (var db = new klc01())
            {
                //get entries from Oris
                HttpClient client = new HttpClient();
                string url = db.settings.FirstOrDefault(c => c.config_name == "oris_entries").config_value;

                //string entry;
                HttpResponseMessage response = await client.GetAsync(url);
                try
                {
                    response.EnsureSuccessStatusCode();
                }
                catch
                {
                    MessageBox.Show("ERR EnsureSuccessStatusCode post");
                    return "0";
                }

                result = await response.Content.ReadAsStringAsync();

                string filename = @"c:\temp\oris_entries_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".xml";
                File.WriteAllText(filename, result);

            }
            return result;
        }

        public static string FormatXml(string xml)
        {
            try
            {
                XDocument doc = XDocument.Parse(xml);
                return doc.ToString();
            }
            catch (Exception)
            {
                // Handle and throw if fatal exception here; don't just ignore them
                return xml;
            }
        }

        public static async Task<string> PostSlip(int readout_id)
        {
            string url;
            string allResponses = "";
            string oneResponse = "";
            HttpClient client = new HttpClient();
            //int i = 0;
            using (var db = new klc01())
            {
                string OneSlip;
                OneSlip = db.get_slip_json(readout_id).FirstOrDefault();

                //write punch log
                string filename = @"c:\temp\slip_post_" + readout_id + "_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".json";
                File.WriteAllText(filename, OneSlip);

                string live_urls = db.settings.FirstOrDefault(c => c.config_name == "live_url").config_value;
                string url_slips = db.settings.FirstOrDefault(c => c.config_name == "live_slips").config_value;

                string[] urls = live_urls.Split(';');

                foreach (string oneUrl in urls)
                {
                    url = oneUrl + url_slips;

                    var content = new StringContent(
                        OneSlip,
                        System.Text.Encoding.UTF8,
                        "application/json"
                        );

                    var response = await client.PostAsync(url, content);
                    try
                    {
                        response.EnsureSuccessStatusCode();
                        oneResponse = url + " " + await response.Content.ReadAsStringAsync();
                    }
                    catch
                    {
                        MessageBox.Show("ERR EnsureSuccessStatusCode post");
                        oneResponse = url + "ERR EnsureSuccessStatusCode post";
                    }
                    allResponses += oneResponse;
                }
            }
            return allResponses;
        }

        private void SetTxtInfo(EnvironmentVariableTarget result)
        {
            FrmMain frmMain = new FrmMain();
            frmMain.txtInfo.AppendText(result.ToString());
        }

        /*        public DateTime GetStartTime(long competitor_id)
                {
                    int prevRunnerId = this.GetPrevRunnerId(competitor_id);
                    Result prevRunnerResult = this.dao.GetResultByRunnerId(prevRunnerId);
                    Result prevTeamResult = this.dao.GetMaxResultByTeam(runner.Team.Id);

                    DateTime startTime = new DateTime();

                    if (prevRunnerResult == null && prevTeamResult == null)
                    {
                        startTime = Constants.ZeroTime;
                    }
                    else if ((prevTeamResult != null && prevRunnerResult == null) || (prevTeamResult.Id > prevRunnerResult.Id))
                    {
                        startTime = prevTeamResult.FinishTime;
                    }
                    else
                    {
                        startTime = prevRunnerResult.FinishTime;
                    }

                    return startTime;
                }
        */
        /*
                private long GetPrevRunnerId(long competitor_id)
                {
                    int prevRunnerId = 0;

                    Dictionary<int, int> positions = this.dao.GetRunnerPositions(runner.Team.Id);
                    prevRunnerId = this.CalculatePrevRunnerId(runner.Position, positions);
                }

                    return prevRunnerId;
                }
        */

        public static async Task TruncateLegs()
        {
            using (var db = new klc01())
            {
                HttpClient client = new HttpClient();
                string live_legs = db.settings.FirstOrDefault(c => c.config_name == "live_legs_truncate").config_value;
                string live_urls = db.settings.FirstOrDefault(c => c.config_name == "live_url").config_value;
                string[] urls = live_urls.Split(';');
                string pwd = db.settings.FirstOrDefault(c => c.config_name == "live_password").config_value;
                string json = "{\"truncate\":\"yes\"," +
                                    "\"password\":\"" + pwd + "\"}";

                foreach (string oneUrl in urls)
                {
                    string url_truncate = oneUrl + live_legs;

                    //make request
                    StringContent httpContent = new StringContent(json, Encoding.UTF8, "application/json");

                    HttpResponseMessage response = await client.PostAsync(url_truncate, httpContent);
                    try
                    {
                        response.EnsureSuccessStatusCode();
                    }
                    catch
                    {
                        MessageBox.Show("ERR EnsureSuccessStatusCode truncate");
                        return;
                    }

                string info = await response.Content.ReadAsStringAsync();
                MessageBox.Show("API response: " + info);
                }
            }
        }

        public static async Task StartEndRocService(bool start_service)
        {
            using (var db = new klc01())
            {
                HttpClient client = new HttpClient();
                string service_config = "stop_roc_service";
                if (start_service)
                {
                    service_config = "start_roc_service";
                }
                
                string live_roc = db.settings.FirstOrDefault(c => c.config_name == service_config).config_value;
                string live_urls = db.settings.FirstOrDefault(c => c.config_name == "live_url").config_value;

                string[] urls = live_urls.Split(';');
                string pwd = db.settings.FirstOrDefault(c => c.config_name == "live_password").config_value;

                foreach (string oneUrl in urls)
                {
                    string url_roc_service = oneUrl + live_roc;

                    string json = "{\"truncate\":\"yes\"," +
                                        "\"password\":\"" + pwd + "\"}";
                    //make request
                    StringContent httpContent = new StringContent(json, Encoding.UTF8, "application/json");

                    HttpResponseMessage response = await client.PostAsync(url_roc_service, httpContent);
                    try
                    {
                        response.EnsureSuccessStatusCode();
                    }
                    catch
                    {
                        MessageBox.Show("ERR EnsureSuccessStatusCode truncate");
                        return;
                    }

                    string info = await response.Content.ReadAsStringAsync();
                    MessageBox.Show("API response: " + info);
                }
            }

        }

    }
}
