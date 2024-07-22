
namespace h24
{
    partial class FrmStatusChange
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
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource1 = new Microsoft.Reporting.WinForms.ReportDataSource();
            this.slipsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.slip = new h24.slip();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.btRefreshSlip = new System.Windows.Forms.Button();
            this.reportViewer2 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.cmStatus = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.tbPenalty = new System.Windows.Forms.TextBox();
            this.btSave = new System.Windows.Forms.Button();
            this.btClose = new System.Windows.Forms.Button();
            this.slipsTableAdapter = new h24.slipTableAdapters.slipsTableAdapter();
            this.cbLegValid = new System.Windows.Forms.CheckBox();
            ((System.ComponentModel.ISupportInitialize)(this.slipsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.slip)).BeginInit();
            this.SuspendLayout();
            // 
            // slipsBindingSource
            // 
            this.slipsBindingSource.DataMember = "slips";
            this.slipsBindingSource.DataSource = this.slip;
            // 
            // slip
            // 
            this.slip.DataSetName = "slip";
            this.slip.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // reportViewer1
            // 
            reportDataSource1.Name = "dsSlip";
            reportDataSource1.Value = this.slipsBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "h24.rptSlip1.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(53, 36);
            this.reportViewer1.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(451, 651);
            this.reportViewer1.TabIndex = 0;
            // 
            // btRefreshSlip
            // 
            this.btRefreshSlip.Location = new System.Drawing.Point(228, 14);
            this.btRefreshSlip.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.btRefreshSlip.Name = "btRefreshSlip";
            this.btRefreshSlip.Size = new System.Drawing.Size(95, 19);
            this.btRefreshSlip.TabIndex = 1;
            this.btRefreshSlip.Text = "Refresh Slip";
            this.btRefreshSlip.UseVisualStyleBackColor = true;
            this.btRefreshSlip.Click += new System.EventHandler(this.button1_Click);
            // 
            // reportViewer2
            // 
            this.reportViewer2.Location = new System.Drawing.Point(0, 0);
            this.reportViewer2.Name = "ReportViewer";
            this.reportViewer2.Size = new System.Drawing.Size(396, 246);
            this.reportViewer2.TabIndex = 0;
            // 
            // cmStatus
            // 
            this.cmStatus.FormattingEnabled = true;
            this.cmStatus.Items.AddRange(new object[] {
            "OK",
            "DSK",
            "DNF"});
            this.cmStatus.Location = new System.Drawing.Point(617, 153);
            this.cmStatus.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.cmStatus.Name = "cmStatus";
            this.cmStatus.Size = new System.Drawing.Size(118, 21);
            this.cmStatus.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(547, 156);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(61, 13);
            this.label1.TabIndex = 4;
            this.label1.Text = "Leg Status:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(547, 190);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(45, 13);
            this.label2.TabIndex = 5;
            this.label2.Text = "Penalty:";
            // 
            // tbPenalty
            // 
            this.tbPenalty.Location = new System.Drawing.Point(617, 187);
            this.tbPenalty.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.tbPenalty.Name = "tbPenalty";
            this.tbPenalty.Size = new System.Drawing.Size(118, 20);
            this.tbPenalty.TabIndex = 6;
            // 
            // btSave
            // 
            this.btSave.Location = new System.Drawing.Point(655, 250);
            this.btSave.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.btSave.Name = "btSave";
            this.btSave.Size = new System.Drawing.Size(50, 21);
            this.btSave.TabIndex = 7;
            this.btSave.Text = "Save";
            this.btSave.UseVisualStyleBackColor = true;
            this.btSave.Click += new System.EventHandler(this.btSave_Click);
            // 
            // btClose
            // 
            this.btClose.Location = new System.Drawing.Point(655, 281);
            this.btClose.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.btClose.Name = "btClose";
            this.btClose.Size = new System.Drawing.Size(50, 22);
            this.btClose.TabIndex = 8;
            this.btClose.Text = "Close";
            this.btClose.UseVisualStyleBackColor = true;
            this.btClose.Click += new System.EventHandler(this.btClose_Click);
            // 
            // slipsTableAdapter
            // 
            this.slipsTableAdapter.ClearBeforeFill = true;
            // 
            // cbLegValid
            // 
            this.cbLegValid.AutoSize = true;
            this.cbLegValid.Location = new System.Drawing.Point(617, 220);
            this.cbLegValid.Name = "cbLegValid";
            this.cbLegValid.Size = new System.Drawing.Size(70, 17);
            this.cbLegValid.TabIndex = 9;
            this.cbLegValid.Text = "Leg Valid";
            this.cbLegValid.UseVisualStyleBackColor = true;
            // 
            // FrmStatusChange
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = true;
            this.ClientSize = new System.Drawing.Size(854, 518);
            this.Controls.Add(this.cbLegValid);
            this.Controls.Add(this.btClose);
            this.Controls.Add(this.btSave);
            this.Controls.Add(this.tbPenalty);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.cmStatus);
            this.Controls.Add(this.btRefreshSlip);
            this.Controls.Add(this.reportViewer1);
            this.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.Name = "FrmStatusChange";
            this.Text = "FrmStatusChange";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FrmStatusChange_FormClosing);
            this.Load += new System.EventHandler(this.FrmStatusChange_Load);
            ((System.ComponentModel.ISupportInitialize)(this.slipsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.slip)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource slipsBindingSource;
        private slip slip;
        private slipTableAdapters.slipsTableAdapter slipsTableAdapter;
        private System.Windows.Forms.Button btRefreshSlip;
        private Microsoft.Reporting.WinForms.ReportViewer reportViewer2;
        private System.Windows.Forms.ComboBox cmStatus;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox tbPenalty;
        private System.Windows.Forms.Button btSave;
        private System.Windows.Forms.Button btClose;
        private System.Windows.Forms.CheckBox cbLegValid;
    }
}
