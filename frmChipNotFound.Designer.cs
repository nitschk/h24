
namespace h24
{
    partial class frmChipNotFound
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.tbChipId = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.tbSearch = new System.Windows.Forms.TextBox();
            this.btClear = new System.Windows.Forms.Button();
            this.dgCompetitors = new System.Windows.Forms.DataGridView();
            this.vcompteamsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.btnAssign = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
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
            ((System.ComponentModel.ISupportInitialize)(this.dgCompetitors)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.vcompteamsBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(256, 35);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(259, 38);
            this.label1.TabIndex = 0;
            this.label1.Text = "Chip Not Found";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(100, 122);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(63, 20);
            this.label2.TabIndex = 1;
            this.label2.Text = "Chip Id:";
            // 
            // tbChipId
            // 
            this.tbChipId.Location = new System.Drawing.Point(225, 119);
            this.tbChipId.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbChipId.Name = "tbChipId";
            this.tbChipId.Size = new System.Drawing.Size(170, 26);
            this.tbChipId.TabIndex = 2;
            this.tbChipId.TabStop = false;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(100, 196);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(60, 20);
            this.label3.TabIndex = 3;
            this.label3.Text = "Search";
            // 
            // tbSearch
            // 
            this.tbSearch.Location = new System.Drawing.Point(225, 192);
            this.tbSearch.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbSearch.Name = "tbSearch";
            this.tbSearch.Size = new System.Drawing.Size(169, 26);
            this.tbSearch.TabIndex = 1;
            this.tbSearch.TextChanged += new System.EventHandler(this.tbSearch_TextChanged);
            // 
            // btClear
            // 
            this.btClear.Location = new System.Drawing.Point(444, 189);
            this.btClear.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btClear.Name = "btClear";
            this.btClear.Size = new System.Drawing.Size(129, 42);
            this.btClear.TabIndex = 5;
            this.btClear.Text = "Clear";
            this.btClear.UseVisualStyleBackColor = true;
            this.btClear.Click += new System.EventHandler(this.btClear_Click);
            // 
            // dgCompetitors
            // 
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
            this.dgCompetitors.Location = new System.Drawing.Point(34, 285);
            this.dgCompetitors.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgCompetitors.Name = "dgCompetitors";
            this.dgCompetitors.RowHeadersWidth = 51;
            this.dgCompetitors.RowTemplate.Height = 24;
            this.dgCompetitors.Size = new System.Drawing.Size(655, 196);
            this.dgCompetitors.TabIndex = 6;
            this.dgCompetitors.DoubleClick += new System.EventHandler(this.dgCompetitors_DoubleClick);
            // 
            // vcompteamsBindingSource
            // 
            this.vcompteamsBindingSource.DataSource = typeof(h24.v_comp_teams);
            // 
            // btnAssign
            // 
            this.btnAssign.Location = new System.Drawing.Point(756, 369);
            this.btnAssign.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnAssign.Name = "btnAssign";
            this.btnAssign.Size = new System.Drawing.Size(84, 29);
            this.btnAssign.TabIndex = 7;
            this.btnAssign.Text = "Save";
            this.btnAssign.UseVisualStyleBackColor = true;
            this.btnAssign.Click += new System.EventHandler(this.btnAssign_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(756, 441);
            this.btnCancel.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(84, 29);
            this.btnCancel.TabIndex = 8;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // bibDataGridViewTextBoxColumn
            // 
            this.bibDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.bibDataGridViewTextBoxColumn.DataPropertyName = "bib";
            this.bibDataGridViewTextBoxColumn.HeaderText = "bib";
            this.bibDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.bibDataGridViewTextBoxColumn.Name = "bibDataGridViewTextBoxColumn";
            this.bibDataGridViewTextBoxColumn.Width = 66;
            // 
            // compnameDataGridViewTextBoxColumn
            // 
            this.compnameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.compnameDataGridViewTextBoxColumn.DataPropertyName = "comp_name";
            this.compnameDataGridViewTextBoxColumn.HeaderText = "comp_name";
            this.compnameDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.compnameDataGridViewTextBoxColumn.Name = "compnameDataGridViewTextBoxColumn";
            this.compnameDataGridViewTextBoxColumn.Width = 133;
            // 
            // teamnameDataGridViewTextBoxColumn
            // 
            this.teamnameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.teamnameDataGridViewTextBoxColumn.DataPropertyName = "team_name";
            this.teamnameDataGridViewTextBoxColumn.HeaderText = "team_name";
            this.teamnameDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamnameDataGridViewTextBoxColumn.Name = "teamnameDataGridViewTextBoxColumn";
            this.teamnameDataGridViewTextBoxColumn.Width = 130;
            // 
            // chip_id
            // 
            this.chip_id.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.chip_id.DataPropertyName = "comp_chip_id";
            this.chip_id.HeaderText = "comp_chip_id";
            this.chip_id.MinimumWidth = 6;
            this.chip_id.Name = "chip_id";
            this.chip_id.Width = 143;
            // 
            // teamnrDataGridViewTextBoxColumn
            // 
            this.teamnrDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.teamnrDataGridViewTextBoxColumn.DataPropertyName = "team_nr";
            this.teamnrDataGridViewTextBoxColumn.HeaderText = "team_nr";
            this.teamnrDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamnrDataGridViewTextBoxColumn.Name = "teamnrDataGridViewTextBoxColumn";
            this.teamnrDataGridViewTextBoxColumn.Visible = false;
            this.teamnrDataGridViewTextBoxColumn.Width = 104;
            // 
            // teamdidstartDataGridViewTextBoxColumn
            // 
            this.teamdidstartDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.teamdidstartDataGridViewTextBoxColumn.DataPropertyName = "team_did_start";
            this.teamdidstartDataGridViewTextBoxColumn.HeaderText = "team_did_start";
            this.teamdidstartDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamdidstartDataGridViewTextBoxColumn.Name = "teamdidstartDataGridViewTextBoxColumn";
            this.teamdidstartDataGridViewTextBoxColumn.Width = 152;
            // 
            // teamstatusDataGridViewTextBoxColumn
            // 
            this.teamstatusDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.teamstatusDataGridViewTextBoxColumn.DataPropertyName = "team_status";
            this.teamstatusDataGridViewTextBoxColumn.HeaderText = "team_status";
            this.teamstatusDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamstatusDataGridViewTextBoxColumn.Name = "teamstatusDataGridViewTextBoxColumn";
            this.teamstatusDataGridViewTextBoxColumn.Width = 134;
            // 
            // comp_id
            // 
            this.comp_id.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.comp_id.DataPropertyName = "comp_id";
            this.comp_id.HeaderText = "comp_id";
            this.comp_id.MinimumWidth = 6;
            this.comp_id.Name = "comp_id";
            this.comp_id.Visible = false;
            this.comp_id.Width = 105;
            // 
            // rentedchipDataGridViewTextBoxColumn
            // 
            this.rentedchipDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.rentedchipDataGridViewTextBoxColumn.DataPropertyName = "rented_chip";
            this.rentedchipDataGridViewTextBoxColumn.HeaderText = "rented_chip";
            this.rentedchipDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.rentedchipDataGridViewTextBoxColumn.Name = "rentedchipDataGridViewTextBoxColumn";
            this.rentedchipDataGridViewTextBoxColumn.Width = 129;
            // 
            // rankorderDataGridViewTextBoxColumn
            // 
            this.rankorderDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.rankorderDataGridViewTextBoxColumn.DataPropertyName = "rank_order";
            this.rankorderDataGridViewTextBoxColumn.HeaderText = "rank_order";
            this.rankorderDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.rankorderDataGridViewTextBoxColumn.Name = "rankorderDataGridViewTextBoxColumn";
            this.rankorderDataGridViewTextBoxColumn.Width = 122;
            // 
            // compwithdrawnDataGridViewCheckBoxColumn
            // 
            this.compwithdrawnDataGridViewCheckBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.compwithdrawnDataGridViewCheckBoxColumn.DataPropertyName = "comp_withdrawn";
            this.compwithdrawnDataGridViewCheckBoxColumn.HeaderText = "comp_withdrawn";
            this.compwithdrawnDataGridViewCheckBoxColumn.MinimumWidth = 6;
            this.compwithdrawnDataGridViewCheckBoxColumn.Name = "compwithdrawnDataGridViewCheckBoxColumn";
            this.compwithdrawnDataGridViewCheckBoxColumn.Width = 134;
            // 
            // compstatusDataGridViewTextBoxColumn
            // 
            this.compstatusDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.compstatusDataGridViewTextBoxColumn.DataPropertyName = "comp_status";
            this.compstatusDataGridViewTextBoxColumn.HeaderText = "comp_status";
            this.compstatusDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.compstatusDataGridViewTextBoxColumn.Name = "compstatusDataGridViewTextBoxColumn";
            this.compstatusDataGridViewTextBoxColumn.Width = 137;
            // 
            // compvalidflagDataGridViewTextBoxColumn
            // 
            this.compvalidflagDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.compvalidflagDataGridViewTextBoxColumn.DataPropertyName = "comp_valid_flag";
            this.compvalidflagDataGridViewTextBoxColumn.HeaderText = "comp_valid_flag";
            this.compvalidflagDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.compvalidflagDataGridViewTextBoxColumn.Name = "compvalidflagDataGridViewTextBoxColumn";
            this.compvalidflagDataGridViewTextBoxColumn.Width = 159;
            // 
            // withdrawndatetimeDataGridViewTextBoxColumn
            // 
            this.withdrawndatetimeDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.withdrawndatetimeDataGridViewTextBoxColumn.DataPropertyName = "withdrawn_datetime";
            this.withdrawndatetimeDataGridViewTextBoxColumn.HeaderText = "withdrawn_datetime";
            this.withdrawndatetimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.withdrawndatetimeDataGridViewTextBoxColumn.Name = "withdrawndatetimeDataGridViewTextBoxColumn";
            this.withdrawndatetimeDataGridViewTextBoxColumn.Width = 187;
            // 
            // frmChipNotFound
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(900, 562);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnAssign);
            this.Controls.Add(this.dgCompetitors);
            this.Controls.Add(this.btClear);
            this.Controls.Add(this.tbSearch);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.tbChipId);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmChipNotFound";
            this.Text = "frmChiNotFound";
            this.Load += new System.EventHandler(this.frmChipNotFound_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgCompetitors)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.vcompteamsBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox tbChipId;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox tbSearch;
        private System.Windows.Forms.Button btClear;
        private System.Windows.Forms.DataGridView dgCompetitors;
        private System.Windows.Forms.Button btnAssign;
        private System.Windows.Forms.Button btnCancel;
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
    }
}