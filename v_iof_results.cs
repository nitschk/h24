//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace h24
{
    using System;
    using System.Collections.Generic;
    
    public partial class v_iof_results
    {
        public int course_id { get; set; }
        public string course_name { get; set; }
        public Nullable<int> course_length { get; set; }
        public Nullable<int> course_climb { get; set; }
        public int comp_id { get; set; }
        public string comp_name { get; set; }
        public Nullable<int> team_id { get; set; }
        public string team_name { get; set; }
        public string bib { get; set; }
        public Nullable<System.DateTime> start_dtime { get; set; }
        public Nullable<System.DateTime> finish_dtime { get; set; }
        public string leg_status { get; set; }
        public string control_code { get; set; }
        public Nullable<int> l_time { get; set; }
        public Nullable<int> t_behind { get; set; }
        public Nullable<int> split_time { get; set; }
        public Nullable<int> position { get; set; }
        public int slip_id { get; set; }
    }
}
