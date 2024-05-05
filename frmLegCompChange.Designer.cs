
namespace h24
{
    partial class frmLegCompChange
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
            this.btClear = new System.Windows.Forms.Button();
            this.tbSearch = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnAssign = new System.Windows.Forms.Button();
            this.dgCompetitors = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.bibDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.compnameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamnameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.chip_id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamnrDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamdidstartDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamstatusDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.comp_id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.rentedchipDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.rankorderDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.compwithdrawnDataGridViewCheckBoxColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.compstatusDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.compvalidflagDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.withdrawndatetimeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.vcompteamsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.dgCompetitors)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.vcompteamsBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // btClear
            // 
            this.btClear.Location = new System.Drawing.Point(454, 70);
            this.btClear.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btClear.Name = "btClear";
            this.btClear.Size = new System.Drawing.Size(129, 42);
            this.btClear.TabIndex = 8;
            this.btClear.Text = "Clear";
            this.btClear.UseVisualStyleBackColor = true;
            this.btClear.Click += new System.EventHandler(this.btClear_Click);
            // 
            // tbSearch
            // 
            this.tbSearch.Location = new System.Drawing.Point(235, 74);
            this.tbSearch.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbSearch.Name = "tbSearch";
            this.tbSearch.Size = new System.Drawing.Size(169, 26);
            this.tbSearch.TabIndex = 6;
            this.tbSearch.TextChanged += new System.EventHandler(this.tbSearch_TextChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(110, 78);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(60, 20);
            this.label3.TabIndex = 7;
            this.label3.Text = "Search";
            // 
            // btnCancel
            // 
            this.btnCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCancel.Location = new System.Drawing.Point(778, 475);
            this.btnCancel.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(84, 29);
            this.btnCancel.TabIndex = 11;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnAssign
            // 
            this.btnAssign.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnAssign.Location = new System.Drawing.Point(778, 420);
            this.btnAssign.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnAssign.Name = "btnAssign";
            this.btnAssign.Size = new System.Drawing.Size(84, 29);
            this.btnAssign.TabIndex = 10;
            this.btnAssign.Text = "Save";
            this.btnAssign.UseVisualStyleBackColor = true;
            this.btnAssign.Click += new System.EventHandler(this.btnAssign_Click);
            // 
            // dgCompetitors
            // 
            this.dgCompetitors.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgCompetitors.AutoGenerateColumns = false;
            this.dgCompetitors.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgCompetitors.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.bibDataGridViewTextBoxColumn,
            this.compnameDataGridViewTextBoxColumn,
            this.teamnameDataGridViewTextBoxColumn,
            this.chip_id,
            this.teamnrDataGridViewTextBoxColumn,
            this.teamdidstartDataGridViewTextBoxColumn,
            this.teamstatusDataGridViewTextBoxColumn,
            this.comp_id,
            this.rentedchipDataGridViewTextBoxColumn,
            this.rankorderDataGridViewTextBoxColumn,
            this.compwithdrawnDataGridViewCheckBoxColumn,
            this.compstatusDataGridViewTextBoxColumn,
            this.compvalidflagDataGridViewTextBoxColumn,
            this.withdrawndatetimeDataGridViewTextBoxColumn});
            this.dgCompetitors.DataSource = this.vcompteamsBindingSource;
            this.dgCompetitors.Location = new System.Drawing.Point(34, 262);
            this.dgCompetitors.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgCompetitors.Name = "dgCompetitors";
            this.dgCompetitors.RowHeadersWidth = 51;
            this.dgCompetitors.RowTemplate.Height = 24;
            this.dgCompetitors.Size = new System.Drawing.Size(707, 242);
            this.dgCompetitors.TabIndex = 6;
            this.dgCompetitors.DoubleClick += new System.EventHandler(this.dgCompetitors_DoubleClick);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(69, 149);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(148, 20);
            this.label1.TabIndex = 12;
            this.label1.Text = "Change competitor:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(69, 184);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(51, 20);
            this.label2.TabIndex = 13;
            this.label2.Text = "label2";
            // 
            // bibDataGridViewTextBoxColumn
            // 
            this.bibDataGridViewTextBoxColumn.DataPropertyName = "bib";
            this.bibDataGridViewTextBoxColumn.HeaderText = "bib";
            this.bibDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.bibDataGridViewTextBoxColumn.Name = "bibDataGridViewTextBoxColumn";
            this.bibDataGridViewTextBoxColumn.Width = 125;
            // 
            // compnameDataGridViewTextBoxColumn
            // 
            this.compnameDataGridViewTextBoxColumn.DataPropertyName = "comp_name";
            this.compnameDataGridViewTextBoxColumn.HeaderText = "comp_name";
            this.compnameDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.compnameDataGridViewTextBoxColumn.Name = "compnameDataGridViewTextBoxColumn";
            this.compnameDataGridViewTextBoxColumn.Width = 125;
            // 
            // teamnameDataGridViewTextBoxColumn
            // 
            this.teamnameDataGridViewTextBoxColumn.DataPropertyName = "team_name";
            this.teamnameDataGridViewTextBoxColumn.HeaderText = "team_name";
            this.teamnameDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamnameDataGridViewTextBoxColumn.Name = "teamnameDataGridViewTextBoxColumn";
            this.teamnameDataGridViewTextBoxColumn.Width = 125;
            // 
            // chip_id
            // 
            this.chip_id.DataPropertyName = "comp_chip_id";
            this.chip_id.HeaderText = "comp_chip_id";
            this.chip_id.MinimumWidth = 6;
            this.chip_id.Name = "chip_id";
            this.chip_id.Width = 125;
            // 
            // teamnrDataGridViewTextBoxColumn
            // 
            this.teamnrDataGridViewTextBoxColumn.DataPropertyName = "team_nr";
            this.teamnrDataGridViewTextBoxColumn.HeaderText = "team_nr";
            this.teamnrDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamnrDataGridViewTextBoxColumn.Name = "teamnrDataGridViewTextBoxColumn";
            this.teamnrDataGridViewTextBoxColumn.Visible = false;
            this.teamnrDataGridViewTextBoxColumn.Width = 125;
            // 
            // teamdidstartDataGridViewTextBoxColumn
            // 
            this.teamdidstartDataGridViewTextBoxColumn.DataPropertyName = "team_did_start";
            this.teamdidstartDataGridViewTextBoxColumn.HeaderText = "team_did_start";
            this.teamdidstartDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamdidstartDataGridViewTextBoxColumn.Name = "teamdidstartDataGridViewTextBoxColumn";
            this.teamdidstartDataGridViewTextBoxColumn.Width = 125;
            // 
            // teamstatusDataGridViewTextBoxColumn
            // 
            this.teamstatusDataGridViewTextBoxColumn.DataPropertyName = "team_status";
            this.teamstatusDataGridViewTextBoxColumn.HeaderText = "team_status";
            this.teamstatusDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamstatusDataGridViewTextBoxColumn.Name = "teamstatusDataGridViewTextBoxColumn";
            this.teamstatusDataGridViewTextBoxColumn.Width = 125;
            // 
            // comp_id
            // 
            this.comp_id.DataPropertyName = "comp_id";
            this.comp_id.HeaderText = "comp_id";
            this.comp_id.MinimumWidth = 6;
            this.comp_id.Name = "comp_id";
            this.comp_id.Visible = false;
            this.comp_id.Width = 125;
            // 
            // rentedchipDataGridViewTextBoxColumn
            // 
            this.rentedchipDataGridViewTextBoxColumn.DataPropertyName = "rented_chip";
            this.rentedchipDataGridViewTextBoxColumn.HeaderText = "rented_chip";
            this.rentedchipDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.rentedchipDataGridViewTextBoxColumn.Name = "rentedchipDataGridViewTextBoxColumn";
            this.rentedchipDataGridViewTextBoxColumn.Width = 125;
            // 
            // rankorderDataGridViewTextBoxColumn
            // 
            this.rankorderDataGridViewTextBoxColumn.DataPropertyName = "rank_order";
            this.rankorderDataGridViewTextBoxColumn.HeaderText = "rank_order";
            this.rankorderDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.rankorderDataGridViewTextBoxColumn.Name = "rankorderDataGridViewTextBoxColumn";
            this.rankorderDataGridViewTextBoxColumn.Width = 125;
            // 
            // compwithdrawnDataGridViewCheckBoxColumn
            // 
            this.compwithdrawnDataGridViewCheckBoxColumn.DataPropertyName = "comp_withdrawn";
            this.compwithdrawnDataGridViewCheckBoxColumn.HeaderText = "comp_withdrawn";
            this.compwithdrawnDataGridViewCheckBoxColumn.MinimumWidth = 6;
            this.compwithdrawnDataGridViewCheckBoxColumn.Name = "compwithdrawnDataGridViewCheckBoxColumn";
            this.compwithdrawnDataGridViewCheckBoxColumn.Width = 125;
            // 
            // compstatusDataGridViewTextBoxColumn
            // 
            this.compstatusDataGridViewTextBoxColumn.DataPropertyName = "comp_status";
            this.compstatusDataGridViewTextBoxColumn.HeaderText = "comp_status";
            this.compstatusDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.compstatusDataGridViewTextBoxColumn.Name = "compstatusDataGridViewTextBoxColumn";
            this.compstatusDataGridViewTextBoxColumn.Width = 125;
            // 
            // compvalidflagDataGridViewTextBoxColumn
            // 
            this.compvalidflagDataGridViewTextBoxColumn.DataPropertyName = "comp_valid_flag";
            this.compvalidflagDataGridViewTextBoxColumn.HeaderText = "comp_valid_flag";
            this.compvalidflagDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.compvalidflagDataGridViewTextBoxColumn.Name = "compvalidflagDataGridViewTextBoxColumn";
            this.compvalidflagDataGridViewTextBoxColumn.Width = 125;
            // 
            // withdrawndatetimeDataGridViewTextBoxColumn
            // 
            this.withdrawndatetimeDataGridViewTextBoxColumn.DataPropertyName = "withdrawn_datetime";
            this.withdrawndatetimeDataGridViewTextBoxColumn.HeaderText = "withdrawn_datetime";
            this.withdrawndatetimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.withdrawndatetimeDataGridViewTextBoxColumn.Name = "withdrawndatetimeDataGridViewTextBoxColumn";
            this.withdrawndatetimeDataGridViewTextBoxColumn.Width = 125;
            // 
            // vcompteamsBindingSource
            // 
            this.vcompteamsBindingSource.DataSource = typeof(h24.v_comp_teams);
            // 
            // frmLegCompChange
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(900, 562);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnAssign);
            this.Controls.Add(this.dgCompetitors);
            this.Controls.Add(this.btClear);
            this.Controls.Add(this.tbSearch);
            this.Controls.Add(this.label3);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmLegCompChange";
            this.Text = "frmLegCompChange";
            this.Load += new System.EventHandler(this.frmLegCompChange_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgCompetitors)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.vcompteamsBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btClear;
        private System.Windows.Forms.TextBox tbSearch;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnAssign;
        private System.Windows.Forms.DataGridView dgCompetitors;
        private System.Windows.Forms.BindingSource vcompteamsBindingSource;
        private System.Windows.Forms.DataGridViewTextBoxColumn bibDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn compnameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamnameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn chip_id;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamnrDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamdidstartDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamstatusDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn comp_id;
        private System.Windows.Forms.DataGridViewTextBoxColumn rentedchipDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn rankorderDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn compwithdrawnDataGridViewCheckBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn compstatusDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn compvalidflagDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn withdrawndatetimeDataGridViewTextBoxColumn;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
    }
}