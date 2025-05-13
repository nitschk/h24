
namespace h24
{
    partial class FrmResults
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource2 = new Microsoft.Reporting.WinForms.ReportDataSource();
            this.bindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.ds_result = new h24.ds_result();
            this.rv_Results = new Microsoft.Reporting.WinForms.ReportViewer();
            this.rpt_resultsTableAdapter = new h24.ds_resultTableAdapters.rpt_resultsTableAdapter();
            this.BtnRefresh = new System.Windows.Forms.Button();
            this.BtnTeamResults = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.BtnCourseResults = new System.Windows.Forms.Button();
            this.cbCategory = new System.Windows.Forms.ComboBox();
            this.btXMLresult = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ds_result)).BeginInit();
            this.SuspendLayout();
            // 
            // bindingSource
            // 
            this.bindingSource.DataSource = this.ds_result;
            this.bindingSource.Position = 0;
            // 
            // ds_result
            // 
            this.ds_result.DataSetName = "ds_result";
            this.ds_result.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // rv_Results
            // 
            this.rv_Results.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            reportDataSource2.Name = "dsResult";
            reportDataSource2.Value = this.bindingSource;
            this.rv_Results.LocalReport.DataSources.Add(reportDataSource2);
            this.rv_Results.LocalReport.ReportEmbeddedResource = "rpt_results.rdlc";
            this.rv_Results.Location = new System.Drawing.Point(20, 60);
            this.rv_Results.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.rv_Results.Name = "reportViewer1";
            this.rv_Results.Size = new System.Drawing.Size(1025, 500);
            this.rv_Results.TabIndex = 0;
            // 
            // rpt_resultsTableAdapter
            // 
            this.rpt_resultsTableAdapter.ClearBeforeFill = true;
            // 
            // BtnRefresh
            // 
            this.BtnRefresh.Location = new System.Drawing.Point(559, 13);
            this.BtnRefresh.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.BtnRefresh.Name = "BtnRefresh";
            this.BtnRefresh.Size = new System.Drawing.Size(149, 29);
            this.BtnRefresh.TabIndex = 0;
            this.BtnRefresh.Text = "Refresh Report";
            this.BtnRefresh.UseVisualStyleBackColor = true;
            this.BtnRefresh.Click += new System.EventHandler(this.BtnRefresh_Click);
            // 
            // BtnTeamResults
            // 
            this.BtnTeamResults.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.BtnTeamResults.Location = new System.Drawing.Point(1116, 70);
            this.BtnTeamResults.Name = "BtnTeamResults";
            this.BtnTeamResults.Size = new System.Drawing.Size(134, 32);
            this.BtnTeamResults.TabIndex = 1;
            this.BtnTeamResults.Text = "Team Results";
            this.BtnTeamResults.UseVisualStyleBackColor = true;
            this.BtnTeamResults.Click += new System.EventHandler(this.BtnTeamResults_Click);
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(1112, 37);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(113, 20);
            this.label1.TabIndex = 2;
            this.label1.Text = "Offline Results";
            // 
            // BtnCourseResults
            // 
            this.BtnCourseResults.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.BtnCourseResults.Location = new System.Drawing.Point(1116, 112);
            this.BtnCourseResults.Name = "BtnCourseResults";
            this.BtnCourseResults.Size = new System.Drawing.Size(134, 32);
            this.BtnCourseResults.TabIndex = 3;
            this.BtnCourseResults.Text = "Course Results";
            this.BtnCourseResults.UseVisualStyleBackColor = true;
            this.BtnCourseResults.Click += new System.EventHandler(this.BtnCourseResults_Click);
            // 
            // cbCategory
            // 
            this.cbCategory.FormattingEnabled = true;
            this.cbCategory.Location = new System.Drawing.Point(198, 14);
            this.cbCategory.Name = "cbCategory";
            this.cbCategory.Size = new System.Drawing.Size(277, 28);
            this.cbCategory.TabIndex = 6;
            // 
            // btXMLresult
            // 
            this.btXMLresult.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btXMLresult.Location = new System.Drawing.Point(1116, 292);
            this.btXMLresult.Name = "btXMLresult";
            this.btXMLresult.Size = new System.Drawing.Size(134, 40);
            this.btXMLresult.TabIndex = 7;
            this.btXMLresult.Text = "XML Result";
            this.btXMLresult.UseVisualStyleBackColor = true;
            this.btXMLresult.Click += new System.EventHandler(this.btXMLresult_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(106, 17);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(77, 20);
            this.label2.TabIndex = 9;
            this.label2.Text = "Category:";
            // 
            // FrmResults
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1280, 599);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.rv_Results);
            this.Controls.Add(this.btXMLresult);
            this.Controls.Add(this.cbCategory);
            this.Controls.Add(this.BtnCourseResults);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.BtnTeamResults);
            this.Controls.Add(this.BtnRefresh);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "FrmResults";
            this.Text = "frmResults";
            this.Load += new System.EventHandler(this.FrmResults_Load);
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ds_result)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer rv_Results;
        private System.Windows.Forms.Button BtnRefresh;
        private ds_result ds_result;
        private System.Windows.Forms.BindingSource bindingSource;
        private ds_resultTableAdapters.rpt_resultsTableAdapter rpt_resultsTableAdapter;
        private System.Windows.Forms.Button BtnTeamResults;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button BtnCourseResults;
        private System.Windows.Forms.ComboBox cbCategory;
        private System.Windows.Forms.Button btXMLresult;
        private System.Windows.Forms.Label label2;
    }
}
