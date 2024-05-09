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
using Serilog;

namespace h24
{
    public class NewCard
    {
        //klc01 db;
        private static List<string> _errors = new List<string>();

        public static string get_config_item(string cofnig_name)
        {
            var db = new klc01();
            string config_value = "";
            /*var config = db.settings.FirstOrDefault(c => c.config_name == cofnig_name);
            if (config != null)
            {
                config_value = config.config_value;
            }*/
            config_value = SettingsManager.GetSetting(cofnig_name);

            return config_value;            
        }

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
                int y = UpdateTeamRaceEnd(competitor_id);
            }

            int slip_id = this.InsertSlip(leg_id);

            //
            //_ = PostSlip(readout_id);
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
                    else
                    {
                        course_id = 0;
                    }
                    while (course_id == 0)
                    {
                        using (var db = new klc01())
                        {
                            int course_id_from_slips = db.slips.Where(b => b.readout_id == readout_id).Select(s => s.course_id).FirstOrDefault();
                            //unknown course
                            frmCourseNotFound frm = new frmCourseNotFound(competitor_id, readout_id, course_id_from_slips);
                            frm.ShowDialog();
                            course_id = frm.course;
                            frm.course = 0;
                        }
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

        public static int UpdateTeamRaceEnd(int competitor_id)
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
                string url = get_config_item("live_url");
                string uid = get_config_item("live_user");
                string pwd = get_config_item("live_password");

                var httpWebRequest = (HttpWebRequest)WebRequest.Create(url + "/register");
                httpWebRequest.ContentType = "application/json";
                httpWebRequest.Method = "POST";

                using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
                {
                    string json = "{\"client_name\":\"" + uid + "\"," +
                                  "\"password\":\"" + pwd + "\"}";

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
                string url = get_config_item("live_url");

                string pwd = get_config_item("live_password");
                string uid = get_config_item("live_user");

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
                var result = get_config_item("live_token");
                if (result != null)
                {
                    result = token;
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
                string live_entries = get_config_item("live_entries_truncate");
                string live_urls = get_config_item("live_url");
                string pwd = get_config_item("live_password");

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
                if (team == -1)
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
                    string live_urls = get_config_item("live_url");
                    string live_entries = get_config_item("live_entries");

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
                string live_competitors = get_config_item("live_competitors_truncate");
                string live_urls = get_config_item("live_url");
                string pwd = get_config_item("live_password");

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
                    string live_urls = get_config_item("live_url");
                    string live_competitors = get_config_item("live_competitors");

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
                string url = get_config_item("oris_entries");

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


        //API
        public static List<api_queue> GetPendingApiRequestsFromDatabase()
        {
            Log.Information("GetPendingApiRequestsFromDatabase");
            var db = new klc01();
            string status_new = NewCard.get_config_item("q_status_new");
            string status_done = NewCard.get_config_item("q_status_completed");

            int queue_timeout = Int32.Parse(NewCard.get_config_item("api_queue_timeout"));
            DateTime latest = DateTime.Now.AddSeconds(-queue_timeout);

            var olderThanSeconds = db.api_queue
                .Where(a => a.q_status == status_new || (a.q_status != status_done && a.as_of_date < latest))
                .ToList();

            return olderThanSeconds; // Replace with actual implementation
        }


        public async void CheckApiRequests(object state)
        {
            Log.Information("CheckApiRequests");
            //check new ROC punches
            string a = CheckNewROC();

            // Check the database for pending requests
            List<api_queue> pendingRequests = GetPendingApiRequestsFromDatabase();
            Log.Information("pendingRequests:" + pendingRequests.Count());

            foreach (api_queue apiRequest in pendingRequests)
            {
                Log.Information("CheckApiRequests - process " + apiRequest.q_id);
                try
                {
                    // Attempt to send the request to the API
                    bool success = await SendApiRequest(apiRequest);
                    Log.Information("SendApiRequest finished " + apiRequest.q_id);
                }
                catch (Exception e)
                {
                    WriteLog($"CheckApiRequests: {e.Message}\n q_id={apiRequest.q_id}", "CheckApiRequests");
                    Log.Error($"CheckApiRequests E: {e.Message}\n q_id={apiRequest.q_id}");
                }

                // Update the status based on the result
                //UpdateApiRequestStatus(apiRequest.q_id, success ? "Sent" : "Failed");

                /*                if (!success)
                                {
                                    // If the request fails, you can re-enqueue it or implement retry logic
                                    // For simplicity, let's assume requests are removed on failure
                                    MessageBox.Show("API request failed. Please check your internet connection.");
                                }*/
            }
        }

        // Implement your method to send API requests here
        public async Task<bool> SendApiRequest(api_queue request)
        {
            Log.Information("SendApiRequest " + request.q_id);

            // Your API request implementation logic here
            // Return true if the request was successful, false if it failed
            string q_status_in_progress = get_config_item("q_status_in_progress");
            string q_status_failed = get_config_item("q_status_failed");
            string q_status_completed = get_config_item("q_status_completed");

            UpdateApiRequestStatus(request.q_id, q_status_in_progress);

            Log.Information("request "+ request.q_content);
            //send
            HttpClient client = new HttpClient();
            HttpContent content = new StringContent(
            request.q_content,
            System.Text.Encoding.UTF8,
            "application/json"
            );
            string oneResponse = "";

            if (request.q_header != "")
            {
                client.DefaultRequestHeaders.Add("Accept", "application/json");
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");//.Add("Content-Type", "application/json");
                //client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", request.q_header);
                //client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Token", request.q_header);
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", request.q_header);
            }

            //Log.Information("client: " + content.ToString());
            var response = await client.PostAsync(request.q_url, content);
            try
            {
                response.EnsureSuccessStatusCode();
                oneResponse = await response.Content.ReadAsStringAsync();
                UpdateApiResponse(request.q_id, oneResponse, q_status_completed);
                return true;
            }
            catch (Exception e)
            {

                oneResponse = response.Content.ReadAsStringAsync().Result;
                Log.Error(request.q_url + " " + response.Content.ReadAsStringAsync().Result + "; " + $"Sending error: {e.Message}");
                UpdateApiResponse(request.q_id, oneResponse, q_status_failed);
                return false;
            }
        }

        private void UpdateApiRequestStatus(int requestId, string status)
        {
            Log.Information("UpdateApiRequestStatus " + requestId );
            using (var db = new klc01())
            {
                var result = db.api_queue.SingleOrDefault(b => b.q_id == requestId);
                if (result != null)
                {
                    result.q_status = status;
                    result.as_of_date = DateTime.Now;
                    db.SaveChanges();
                }
            }
        }

        private void UpdateApiResponse(int requestId, string response, string status)
        {
            Log.Information("UpdateApiResponse " + requestId + " " + response);
            string q_response;
            using (var db = new klc01())
            {
                try
                {
                    var result = db.api_queue.SingleOrDefault(b => b.q_id == requestId);
                    if (result != null)
                    {
                        q_response = response + "; " + result.q_response;
                        result.q_response = q_response.Left(3990);

                        result.q_status = status;
                        db.SaveChanges();
                    }
                }
                catch (Exception e)
                {
                    MessageBox.Show("UpdateApiResponse " + e.Message);
                }
            }
        }

        public async Task<string> PostSlip(int readout_id)
        {
            Log.Information("PostSlip " + readout_id);
            //insert record to queue
            using (var db = new klc01())
            {
                string OneSlip;
                int q_id = 0;

                OneSlip = db.get_slip_json(readout_id).FirstOrDefault();

                //write punch log
                string filename = @"c:\temp\slip_post_" + readout_id + "_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".json";
                File.WriteAllText(filename, OneSlip);

                string live_urls = get_config_item("live_url");
                string url_slips = get_config_item("live_slips");
                string q_status_in_progress = get_config_item("q_status_in_progress");
                string q_status_failed = get_config_item("q_status_failed");

                string[] urls = live_urls.Split(';');
                foreach (string oneUrl in urls)
                {
                    q_id = Insert_api_queue(oneUrl + url_slips, OneSlip != null ? OneSlip : "", q_status_in_progress, null);
                    Insert_api_queue_link(q_id, "readout", readout_id);

                    try
                    {
                        api_queue api_queue_request = db.api_queue.FirstOrDefault(a => a.q_id == q_id);
                        //fire queue processing
                        bool success = await SendApiRequest(api_queue_request);
                    }
                    catch (Exception e)
                    {
                        UpdateApiRequestStatus(q_id, q_status_failed);
                    }
                }
                return "";
            }
        }

        public string CheckNewROC()
        {
            Log.Information("CheckNewROC");
            //insert record to queue
            using (var db = new klc01())
            {
                //write punch log
                string filename;

                
                string sms_url = get_config_item("sms_url");
                string url_roc = get_config_item("live_roc");
                string q_status_completed = get_config_item("q_status_completed");
                string q_status_new = get_config_item("q_status_new");

                var new_punches = db.v_new_roc_punches.ToList();
                int i = 0;
                foreach (var punch in new_punches)
                {
                    //sms
                    string sms_send = get_config_item("sms_send");
                    if (sms_send == "true")
                    {
                        Insert_queue_SMS(punch);
                    }
                    //online results
                    string content = "{\"record_id\":" + punch.record_id +
                        ", \"control_code\":" + punch.control_code +
                        ", \"chip_id\":" + punch.chip_id +
                        ",\"punch_date\":\"" + punch.punch_date.Value.ToString("yyyy-MM-dd HH:mm:ss") +
                        "\", \"cat_name\":\"" + punch.cat_name +
                        "\", \"team_nr\":" + punch.team_nr +
                        ", \"team_name\":\"" + punch.team_name +
                        "\", \"comp_name\":\"" + punch.comp_name +
                        "\", \"comp_bib\":\"" + punch.bib + "\"}";

                    filename = @"c:\temp\roc_post_" + i + "_" + punch.chip_id + "_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".json";
                    if (File.Exists(filename))
                        filename = @"c:\temp\roc_post_" + i + "_" + punch.chip_id + "a_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".json";
                    //File.Delete(filename);
                    try
                    {
                        File.WriteAllText(filename, content);
                    }
                    catch (Exception e)
                    {
                        Log.Error("ERROR: CheckNewROC " + e.Message);
                        MessageBox.Show("CheckNewROC " + e.Message);
                    }

                    //different servers
                    string live_urls = get_config_item("live_url");
                    string[] urls = live_urls.Split(';');

                    foreach (string oneUrl in urls)
                    {
                        try
                        {
                            int q_id = Insert_api_queue(oneUrl + url_roc, content != null ? content : "", content != null ? q_status_new : q_status_completed, null);
                            Insert_api_queue_link(q_id, "roc_web", punch.record_id);

                            var result = db.roc_punches.SingleOrDefault(x => x.p_id == punch.record_id);
                            if (result != null)
                            {
                                result.status = q_status_completed;
                                db.SaveChanges();
                            }
                            Log.Information("CheckNewROC q_id = " + q_id);
                        }
                        catch (Exception e)
                        {
                            MessageBox.Show("ERR save q_status: " + e.Message);
                        }
                    }
                }
                return "";
            }


            /*
                        //string url;
                        List<string> allResponses = new List<string>();
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

                            string live_urls = get_config_item("live_url");
                            string url_slips = get_config_item("live_slips");

                            string[] urls = live_urls.Split(';');

                            foreach (string oneUrl in urls)
                            {
                                url = oneUrl + url_slips;
                                bool wasSent = false;
                                //try to send 3 times
                                for (int i = 0; i < 3; i++)
                                {
                                    var content = new StringContent(
                                    OneSlip,
                                    System.Text.Encoding.UTF8,
                                    "application/json"
                                    );

                                    try
                                    {
                                        var response = await client.PostAsync(url, content);
                                        response.EnsureSuccessStatusCode();
                                        oneResponse = url + " " + await response.Content.ReadAsStringAsync();
                                        allResponses.Add(oneResponse);
                                        wasSent = true;
                                        break;
                                    }
                                    catch (Exception e)
                                    {
                                        oneResponse = url + $"Sending error: attempt {i} - {e.Message}";
                                        allResponses.Add(oneResponse);
                                    }

                                }
                                if (!wasSent)
                                {
                                    MessageBox.Show("Sending error:  all attempts failed");
                                    _errors.Add(OneSlip);

                                    oneResponse = url + "Sending error:  all attempts failed";
                                    allResponses.Add(oneResponse);
                                }
                            }
                        }
                        return string.Join(Environment.NewLine, allResponses);
            */
        }

        public string Insert_queue_SMS(v_new_roc_punches onePunch)
        {
            Log.Information("Insert_queue_SMS");
            using (var db = new klc01())
            {
                string sms_method = get_config_item("sms_method");
                string sms_url;
                string q_status_completed = get_config_item("q_status_completed");
                string q_status_new = get_config_item("q_status_new");
                string sms_token;
                string sms_originator = get_config_item("sms_originator");

                try
                {
                    string recipient = onePunch.phone_number;
                    if (recipient == "")
                    {
                        return "m";
                    }
                    string body = onePunch.comp_name + ", " + onePunch.bib + " from team " + onePunch.team_name + " punched radio control at " + onePunch.punch_date + ".";
                    body = body.RemoveDiacritics();
                    string content;
                    switch (sms_method) {
                        case "local":
                            sms_url = get_config_item("sms_url");
                            content = "{\"message\": \"" + body + "\",\n    \"phoneNumbers\": [" + recipient + "], \"id\": \"" + onePunch.record_id + "\"}";
                            sms_token = get_config_item("sms_token");
                            break;
                        case "spryngsms":
                            sms_url = get_config_item("sms_url_spryng");
                            content = "{\"body\": \"" + body + "\",\n    \"encoding\": \"auto\",\n    \"originator\": \"" + sms_originator + "\",\n    \"recipients\": [\"" + recipient + "\"],\n    \"route\": \"business\"\n}";
                            sms_token = get_config_item("sms_token_spryng");
                            break;
                        case "gatewayapi":
                            sms_url = get_config_item("sms_url_gatewayapi");
                            content = "{\"message\": \"" + body + "\",\n    \"sender\": \"" + sms_originator + "\",\n    \"recipients\": [{\"msisdn\":\"" + recipient + "\"}]}";
                            sms_token = get_config_item("sms_token_gatewayapi");
                            break;
                        case "clickatel":
                            sms_url = get_config_item("sms_url_clickatel");
                            content = "{\"content\": \"" + body + "\",\n    \"from\": \"" + sms_originator + "\",\n    \"to\": [{" + recipient + "}]}";
                            sms_token = get_config_item("sms_token_clickatel");
                            break;
                        default://seven.io
                            sms_url = get_config_item("sms_url3");
                            content = "{\"text\": \"" + body + "\",\n    \"from\": \"" + sms_originator + "\",\n    \"to\": \"" + recipient + "\"}";
                            sms_token = get_config_item("sms_token3");
                            break;
                    }
                    int q_id = Insert_api_queue(sms_url, content, content != null ? q_status_new : q_status_completed, sms_token);

                    Insert_api_queue_link(q_id, "roc_sms", onePunch.record_id);

                    var result = db.roc_punches.SingleOrDefault(x => x.p_id == onePunch.record_id);
                    if (result != null)
                    {
                        result.status = q_status_completed;
                        db.SaveChanges();
                    }
                    Log.Information("Insert_queue_SMS q_id=" + q_id);
                    return "";
                }
                catch (Exception e)
                {
                    MessageBox.Show("ERR save q_status: " + e.Message);
                    return "err";
                }
            }

        }

        public int Insert_api_queue(string q_url, string q_content, string q_status, string q_header)
        {
            using (var db = new klc01())
            {
                try
                {
                    var api_queue_request = new api_queue
                    {
                        q_dtime = DateTime.Now,
                        q_url = q_url,
                        q_content = q_content != null ? q_content : "",
                        q_header = q_header,
                        q_status = q_status,
                        as_of_date = DateTime.Now
                    };
                    db.api_queue.Add(api_queue_request);
                    db.SaveChanges();

                    Log.Information("api_queue.Add " + api_queue_request.q_id);
                    return api_queue_request.q_id;
                }
                catch (Exception e)
                {
                    MessageBox.Show("ERR save api_queue: " + e.Message);
                    Log.Error("ERR save api_queue: " + e.Message);
                    return 0;
                }
            }
        }

        public int Insert_api_queue_link(int q_id, string link_to, int record_id)
        {
            using (var db = new klc01())
            {
                try
                {
                    var q_link = new api_queue_link
                    {
                        q_id = q_id,
                        link_to = link_to,
                        link_id = record_id,
                        as_of_date = DateTime.Now
                    };
                    db.api_queue_link.Add(q_link);
                    db.SaveChanges();
                    Log.Information("api_queue_link.Add " + q_id);
                    return q_link.link_id;
                }
                catch (Exception e)
                {
                    MessageBox.Show("ERR save api_queue_link: " + e.Message);
                    Log.Error("ERR save api_queue_link: " + e.Message);
                    return 0;
                }
            }
        }


        //private void SetTxtInfo(EnvironmentVariableTarget result)
        private void SetTxtInfo(string result)
        {
            FrmMain frmMain = new FrmMain();
            frmMain.txtInfo.AppendText(result);
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
                string live_legs = get_config_item("live_legs_truncate");
                string live_urls = get_config_item("live_url");
                string[] urls = live_urls.Split(';');
                string pwd = get_config_item("live_password");
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

                string live_roc = get_config_item(service_config);
                string live_urls = get_config_item("live_url");

                string[] urls = live_urls.Split(';');
                string pwd = get_config_item("live_password");

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

        public void WriteLog(string log_message, string log_type)
        {
            using (var db = new klc01())
            {
                var new_log = new logs
                {
                    logs_time = DateTime.Now,
                    logs_message = log_message,
                    logs_type = log_type,
                    as_of_date = DateTime.Now
                };
                try
                {
                    db.logs.Add(new_log);
                    db.SaveChanges();
                }
                catch (Exception e)
                {
                    MessageBox.Show("WriteLog failed: " + e.Message);
                }
            }
        }
    }
}
