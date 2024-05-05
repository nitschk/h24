
namespace h24
{
    partial class frmSetup
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
            this.dgSettings = new System.Windows.Forms.DataGridView();
            this.sidDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.confignameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.configvalueDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.settingsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.label1 = new System.Windows.Forms.Label();
            this.CbROC = new System.Windows.Forms.CheckBox();
            this.BtUpdateROC = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgSettings)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.settingsBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // dgSettings
            // 
            this.dgSettings.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgSettings.AutoGenerateColumns = false;
            this.dgSettings.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgSettings.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.sidDataGridViewTextBoxColumn,
            this.confignameDataGridViewTextBoxColumn,
            this.configvalueDataGridViewTextBoxColumn});
            this.dgSettings.DataSource = this.settingsBindingSource;
            this.dgSettings.Location = new System.Drawing.Point(60, 84);
            this.dgSettings.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgSettings.Name = "dgSettings";
            this.dgSettings.RowHeadersWidth = 51;
            this.dgSettings.RowTemplate.Height = 24;
            this.dgSettings.Size = new System.Drawing.Size(1204, 451);
            this.dgSettings.TabIndex = 0;
            this.dgSettings.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgSettings_CellEndEdit);
            // 
            // sidDataGridViewTextBoxColumn
            // 
            this.sidDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.sidDataGridViewTextBoxColumn.DataPropertyName = "s_id";
            this.sidDataGridViewTextBoxColumn.HeaderText = "s_id";
            this.sidDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.sidDataGridViewTextBoxColumn.Name = "sidDataGridViewTextBoxColumn";
            this.sidDataGridViewTextBoxColumn.Width = 74;
            // 
            // confignameDataGridViewTextBoxColumn
            // 
            this.confignameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.confignameDataGridViewTextBoxColumn.DataPropertyName = "config_name";
            this.confignameDataGridViewTextBoxColumn.HeaderText = "config_name";
            this.confignameDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.confignameDataGridViewTextBoxColumn.Name = "confignameDataGridViewTextBoxColumn";
            this.confignameDataGridViewTextBoxColumn.Width = 137;
            // 
            // configvalueDataGridViewTextBoxColumn
            // 
            this.configvalueDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.configvalueDataGridViewTextBoxColumn.DataPropertyName = "config_value";
            this.configvalueDataGridViewTextBoxColumn.HeaderText = "config_value";
            this.configvalueDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.configvalueDataGridViewTextBoxColumn.Name = "configvalueDataGridViewTextBoxColumn";
            this.configvalueDataGridViewTextBoxColumn.Width = 134;
            // 
            // settingsBindingSource
            // 
            this.settingsBindingSource.DataSource = typeof(h24.settings);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(324, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(172, 46);
            this.label1.TabIndex = 1;
            this.label1.Text = "Settings";
            // 
            // CbROC
            // 
            this.CbROC.AutoSize = true;
            this.CbROC.Location = new System.Drawing.Point(74, 591);
            this.CbROC.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.CbROC.Name = "CbROC";
            this.CbROC.Size = new System.Drawing.Size(126, 24);
            this.CbROC.TabIndex = 4;
            this.CbROC.Text = "ROC Service";
            this.CbROC.UseVisualStyleBackColor = true;
            this.CbROC.CheckedChanged += new System.EventHandler(this.CbROC_CheckedChanged);
            // 
            // BtUpdateROC
            // 
            this.BtUpdateROC.Location = new System.Drawing.Point(233, 585);
            this.BtUpdateROC.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.BtUpdateROC.Name = "BtUpdateROC";
            this.BtUpdateROC.Size = new System.Drawing.Size(84, 35);
            this.BtUpdateROC.TabIndex = 5;
            this.BtUpdateROC.Text = "Stop";
            this.BtUpdateROC.UseVisualStyleBackColor = true;
            this.BtUpdateROC.Click += new System.EventHandler(this.BtUpdateROC_Click);
            // 
            // frmSetup
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1331, 645);
            this.Controls.Add(this.BtUpdateROC);
            this.Controls.Add(this.CbROC);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dgSettings);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmSetup";
            this.Text = "frmSetup";
            this.Load += new System.EventHandler(this.frmSetup_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgSettings)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.settingsBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgSettings;
        private System.Windows.Forms.BindingSource settingsBindingSource;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridViewTextBoxColumn sidDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn confignameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn configvalueDataGridViewTextBoxColumn;
        private System.Windows.Forms.CheckBox CbROC;
        private System.Windows.Forms.Button BtUpdateROC;
    }
}