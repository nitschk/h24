using CsvHelper.Configuration.Attributes;

namespace h24
{
    class Entries
    {
        public int id { get; set; }
        public string team { get; set; }
        public string reg { get; set; }
        public string kat { get; set; }
        public string prijmeni1 { get; set; }
        public string jmeno1 { get; set; }
        public string sex1 { get; set; }
        public string country1 { get; set; }
        [Default(-1)]  // set to 0 when the field is empty
        public int chip1 { get; set; }
        public bool rented1 { get; set; }
        public string nar1 { get; set; }
        public string prijmeni2 { get; set; }
        public string jmeno2 { get; set; }
        public string sex2 { get; set; }
        public string country2 { get; set; }
        [Default(-1)]  // set to 0 when the field is empty
        public int chip2 { get; set; }
        public bool rented2 { get; set; }
        public string nar2 { get; set; }
        public string prijmeni3 { get; set; }
        public string jmeno3 { get; set; }
        public string sex3 { get; set; }
        public string country3 { get; set; }
        [Default(-1)]  // set to 0 when the field is empty
        public int chip3 { get; set; }
        public bool rented3 { get; set; }
        public string nar3 { get; set; }
        public string prijmeni4 { get; set; }
        public string jmeno4 { get; set; }
        public string sex4 { get; set; }
        public string country4 { get; set; }
        [Default(-1)]  // set to 0 when the field is empty
        public int chip4 { get; set; }
        public bool rented4 { get; set; }
        public string nar4 { get; set; }
        public string prijmeni5 { get; set; }
        public string jmeno5 { get; set; }
        public string sex5 { get; set; }
        public string country5 { get; set; }
        [Default(-1)]  // set to 0 when the field is empty
        public int chip5 { get; set; }
        public bool rented5 { get; set; }
        public string nar5 { get; set; }
        public string prijmeni6 { get; set; }
        public string jmeno6 { get; set; }
        public string sex6 { get; set; }
        public string country6 { get; set; }
        [Default(-1)]  // set to 0 when the field is empty
        public int chip6 { get; set; }
        public bool rented6 { get; set; }
        public string nar6 { get; set; }
        public string status { get; set; }
        /*        public string message { get; set; }
                [Default(0)]  // set to 0 when the field is empty
                public decimal total { get; set; }
                [Default(0)]  // set to 0 when the field is empty
                public decimal paid { get; set; }
                [Default(0)]  // set to 0 when the field is empty
                public decimal rozdil { get; set; }
                public string mena { get; set; }
                [Default(0)]  // set to 0 when the field is empty
                public decimal dluzi { get; set; }
                public string hod { get; set; }
                [Default(0)]  // set to 0 when the field is empty
                public string cislo { get; set; }*/
    }
}
