﻿
namespace h24
{
    partial class frmEntries
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
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.BtEntryRefresh = new System.Windows.Forms.Button();
            this.BtInsertCatagories = new System.Windows.Forms.Button();
            this.BtInsertXmlEntries = new System.Windows.Forms.Button();
            this.dgEntry_xml = new System.Windows.Forms.DataGridView();
            this.TbOrisId = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.BtnUploadXML = new System.Windows.Forms.Button();
            this.btnUpload = new System.Windows.Forms.Button();
            this.tbEntries = new System.Windows.Forms.TextBox();
            this.btnShowFile = new System.Windows.Forms.Button();
            this.btnBrowse = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.tbEntriesFile = new System.Windows.Forms.TextBox();
            this.BtnStarListXml = new System.Windows.Forms.Button();
            this.btnPost = new System.Windows.Forms.Button();
            this.dgEntries = new System.Windows.Forms.DataGridView();
            this.race_end = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.comp_name = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.bib = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.rented_chip = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.rank_order = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.comp_withdrawn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.comp_status = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.comp_country = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.comp_birthday = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cat_name = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cat_start_time = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cat_time_limit = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.btnClearCompetitors = new System.Windows.Forms.Button();
            this.cbAllowDeletion = new System.Windows.Forms.CheckBox();
            this.btClose = new System.Windows.Forms.Button();
            this.BtnRegisterClient = new System.Windows.Forms.Button();
            this.ChbTruncate = new System.Windows.Forms.CheckBox();
            this.teamnrDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamnameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamdidstartDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamstatusDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.idDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.classnameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamshortnameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamnameDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.legDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.familyDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.givenDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.genderDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.countryDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.birthdateDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.sichipDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.noteDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.oristeamidDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.entryxmlBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.coursesBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.coursecodesBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgEntry_xml)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgEntries)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.teamsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.entryxmlBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursecodesBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.DefaultExt = "txt";
            this.openFileDialog1.FileName = "openFileDialog1";
            this.openFileDialog1.Filter = "*.txt|*.*";
            this.openFileDialog1.Title = "Open Course File";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.BtEntryRefresh);
            this.groupBox1.Controls.Add(this.BtInsertCatagories);
            this.groupBox1.Controls.Add(this.BtInsertXmlEntries);
            this.groupBox1.Controls.Add(this.dgEntry_xml);
            this.groupBox1.Controls.Add(this.TbOrisId);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.BtnUploadXML);
            this.groupBox1.Controls.Add(this.btnUpload);
            this.groupBox1.Controls.Add(this.tbEntries);
            this.groupBox1.Controls.Add(this.btnShowFile);
            this.groupBox1.Controls.Add(this.btnBrowse);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.tbEntriesFile);
            this.groupBox1.Location = new System.Drawing.Point(12, 66);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(1225, 370);
            this.groupBox1.TabIndex = 8;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Upload Entries";
            // 
            // BtEntryRefresh
            // 
            this.BtEntryRefresh.Location = new System.Drawing.Point(1033, 28);
            this.BtEntryRefresh.Name = "BtEntryRefresh";
            this.BtEntryRefresh.Size = new System.Drawing.Size(93, 24);
            this.BtEntryRefresh.TabIndex = 20;
            this.BtEntryRefresh.Text = "Refresh";
            this.BtEntryRefresh.UseVisualStyleBackColor = true;
            this.BtEntryRefresh.Click += new System.EventHandler(this.BtEntryRefresh_Click);
            // 
            // BtInsertCatagories
            // 
            this.BtInsertCatagories.Location = new System.Drawing.Point(590, 330);
            this.BtInsertCatagories.Name = "BtInsertCatagories";
            this.BtInsertCatagories.Size = new System.Drawing.Size(127, 28);
            this.BtInsertCatagories.TabIndex = 19;
            this.BtInsertCatagories.Text = "Insert Categoreis";
            this.BtInsertCatagories.UseVisualStyleBackColor = true;
            this.BtInsertCatagories.Click += new System.EventHandler(this.BtInsertCatagories_Click);
            // 
            // BtInsertXmlEntries
            // 
            this.BtInsertXmlEntries.Location = new System.Drawing.Point(1022, 333);
            this.BtInsertXmlEntries.Name = "BtInsertXmlEntries";
            this.BtInsertXmlEntries.Size = new System.Drawing.Size(90, 25);
            this.BtInsertXmlEntries.TabIndex = 18;
            this.BtInsertXmlEntries.Text = "Insert XML Entries";
            this.BtInsertXmlEntries.UseVisualStyleBackColor = true;
            this.BtInsertXmlEntries.Click += new System.EventHandler(this.BtInsertXmlEntries_Click);
            // 
            // dgEntry_xml
            // 
            this.dgEntry_xml.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.dgEntry_xml.AutoGenerateColumns = false;
            this.dgEntry_xml.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgEntry_xml.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.idDataGridViewTextBoxColumn,
            this.classnameDataGridViewTextBoxColumn,
            this.teamshortnameDataGridViewTextBoxColumn,
            this.teamnameDataGridViewTextBoxColumn1,
            this.legDataGridViewTextBoxColumn,
            this.familyDataGridViewTextBoxColumn,
            this.givenDataGridViewTextBoxColumn,
            this.genderDataGridViewTextBoxColumn,
            this.countryDataGridViewTextBoxColumn,
            this.birthdateDataGridViewTextBoxColumn,
            this.sichipDataGridViewTextBoxColumn,
            this.noteDataGridViewTextBoxColumn,
            this.oristeamidDataGridViewTextBoxColumn});
            this.dgEntry_xml.DataSource = this.entryxmlBindingSource;
            this.dgEntry_xml.Location = new System.Drawing.Point(555, 92);
            this.dgEntry_xml.Name = "dgEntry_xml";
            this.dgEntry_xml.RowHeadersWidth = 51;
            this.dgEntry_xml.RowTemplate.Height = 24;
            this.dgEntry_xml.Size = new System.Drawing.Size(654, 231);
            this.dgEntry_xml.TabIndex = 17;
            this.dgEntry_xml.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgEntry_xml_CellEndEdit);
            // 
            // TbOrisId
            // 
            this.TbOrisId.Location = new System.Drawing.Point(654, 30);
            this.TbOrisId.Name = "TbOrisId";
            this.TbOrisId.Size = new System.Drawing.Size(116, 22);
            this.TbOrisId.TabIndex = 16;
            this.TbOrisId.Text = "7634";
            this.TbOrisId.Visible = false;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(570, 33);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(55, 17);
            this.label2.TabIndex = 15;
            this.label2.Text = "Oris ID:";
            this.label2.Visible = false;
            // 
            // BtnUploadXML
            // 
            this.BtnUploadXML.Location = new System.Drawing.Point(827, 29);
            this.BtnUploadXML.Name = "BtnUploadXML";
            this.BtnUploadXML.Size = new System.Drawing.Size(105, 23);
            this.BtnUploadXML.TabIndex = 14;
            this.BtnUploadXML.Text = "Oris XML";
            this.BtnUploadXML.UseVisualStyleBackColor = true;
            this.BtnUploadXML.Click += new System.EventHandler(this.BtnUploadXML_Click);
            // 
            // btnUpload
            // 
            this.btnUpload.Location = new System.Drawing.Point(55, 333);
            this.btnUpload.Name = "btnUpload";
            this.btnUpload.Size = new System.Drawing.Size(120, 23);
            this.btnUpload.TabIndex = 11;
            this.btnUpload.Text = "Upload csv";
            this.btnUpload.UseVisualStyleBackColor = true;
            this.btnUpload.Click += new System.EventHandler(this.btnUpload_Click);
            // 
            // tbEntries
            // 
            this.tbEntries.Location = new System.Drawing.Point(29, 92);
            this.tbEntries.Multiline = true;
            this.tbEntries.Name = "tbEntries";
            this.tbEntries.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.tbEntries.Size = new System.Drawing.Size(481, 232);
            this.tbEntries.TabIndex = 10;
            // 
            // btnShowFile
            // 
            this.btnShowFile.Location = new System.Drawing.Point(55, 54);
            this.btnShowFile.Name = "btnShowFile";
            this.btnShowFile.Size = new System.Drawing.Size(129, 23);
            this.btnShowFile.TabIndex = 9;
            this.btnShowFile.Text = "Show file";
            this.btnShowFile.UseVisualStyleBackColor = true;
            this.btnShowFile.Click += new System.EventHandler(this.btnShow_Click);
            // 
            // btnBrowse
            // 
            this.btnBrowse.Location = new System.Drawing.Point(389, 25);
            this.btnBrowse.Name = "btnBrowse";
            this.btnBrowse.Size = new System.Drawing.Size(75, 23);
            this.btnBrowse.TabIndex = 8;
            this.btnBrowse.Text = "Browse";
            this.btnBrowse.UseVisualStyleBackColor = true;
            this.btnBrowse.Click += new System.EventHandler(this.btnBrowse_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(26, 29);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(78, 17);
            this.label1.TabIndex = 7;
            this.label1.Text = "Entries file:";
            // 
            // tbEntriesFile
            // 
            this.tbEntriesFile.Location = new System.Drawing.Point(110, 26);
            this.tbEntriesFile.Name = "tbEntriesFile";
            this.tbEntriesFile.Size = new System.Drawing.Size(260, 22);
            this.tbEntriesFile.TabIndex = 6;
            this.tbEntriesFile.Text = "C:\\Users\\admin\\Downloads\\entries_24h_sample3.csv";
            // 
            // BtnStarListXml
            // 
            this.BtnStarListXml.Location = new System.Drawing.Point(41, 683);
            this.BtnStarListXml.Name = "BtnStarListXml";
            this.BtnStarListXml.Size = new System.Drawing.Size(107, 23);
            this.BtnStarListXml.TabIndex = 13;
            this.BtnStarListXml.Text = "Start List Xml";
            this.BtnStarListXml.UseVisualStyleBackColor = true;
            this.BtnStarListXml.Click += new System.EventHandler(this.BtnStarListXml_Click);
            // 
            // btnPost
            // 
            this.btnPost.Location = new System.Drawing.Point(1146, 683);
            this.btnPost.Name = "btnPost";
            this.btnPost.Size = new System.Drawing.Size(75, 23);
            this.btnPost.TabIndex = 12;
            this.btnPost.Text = "Post";
            this.btnPost.UseVisualStyleBackColor = true;
            this.btnPost.Click += new System.EventHandler(this.BtnPost_Click);
            // 
            // dgEntries
            // 
            this.dgEntries.AutoGenerateColumns = false;
            this.dgEntries.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgEntries.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.teamnrDataGridViewTextBoxColumn,
            this.teamnameDataGridViewTextBoxColumn,
            this.teamdidstartDataGridViewTextBoxColumn,
            this.teamstatusDataGridViewTextBoxColumn,
            this.race_end,
            this.comp_name,
            this.bib,
            this.rented_chip,
            this.rank_order,
            this.comp_withdrawn,
            this.comp_status,
            this.comp_country,
            this.comp_birthday,
            this.cat_name,
            this.cat_start_time,
            this.cat_time_limit});
            this.dgEntries.DataSource = this.teamsBindingSource;
            this.dgEntries.Location = new System.Drawing.Point(41, 442);
            this.dgEntries.Name = "dgEntries";
            this.dgEntries.RowHeadersWidth = 51;
            this.dgEntries.RowTemplate.Height = 24;
            this.dgEntries.Size = new System.Drawing.Size(1181, 223);
            this.dgEntries.TabIndex = 9;
            // 
            // race_end
            // 
            this.race_end.DataPropertyName = "race_end";
            this.race_end.HeaderText = "race_end";
            this.race_end.MinimumWidth = 6;
            this.race_end.Name = "race_end";
            this.race_end.Width = 125;
            // 
            // comp_name
            // 
            this.comp_name.DataPropertyName = "comp_name";
            this.comp_name.HeaderText = "comp_name";
            this.comp_name.MinimumWidth = 6;
            this.comp_name.Name = "comp_name";
            this.comp_name.Width = 125;
            // 
            // bib
            // 
            this.bib.DataPropertyName = "bib";
            this.bib.HeaderText = "bib";
            this.bib.MinimumWidth = 6;
            this.bib.Name = "bib";
            this.bib.Width = 125;
            // 
            // rented_chip
            // 
            this.rented_chip.DataPropertyName = "rented_chip";
            this.rented_chip.HeaderText = "rented_chip";
            this.rented_chip.MinimumWidth = 6;
            this.rented_chip.Name = "rented_chip";
            this.rented_chip.Width = 125;
            // 
            // rank_order
            // 
            this.rank_order.DataPropertyName = "rank_order";
            this.rank_order.HeaderText = "rank_order";
            this.rank_order.MinimumWidth = 6;
            this.rank_order.Name = "rank_order";
            this.rank_order.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.rank_order.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
            this.rank_order.Width = 125;
            // 
            // comp_withdrawn
            // 
            this.comp_withdrawn.DataPropertyName = "comp_withdrawn";
            this.comp_withdrawn.HeaderText = "comp_withdrawn";
            this.comp_withdrawn.MinimumWidth = 6;
            this.comp_withdrawn.Name = "comp_withdrawn";
            this.comp_withdrawn.Width = 125;
            // 
            // comp_status
            // 
            this.comp_status.DataPropertyName = "comp_status";
            this.comp_status.HeaderText = "comp_status";
            this.comp_status.MinimumWidth = 6;
            this.comp_status.Name = "comp_status";
            this.comp_status.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.comp_status.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
            this.comp_status.Width = 125;
            // 
            // comp_country
            // 
            this.comp_country.DataPropertyName = "comp_country";
            this.comp_country.HeaderText = "comp_country";
            this.comp_country.MinimumWidth = 6;
            this.comp_country.Name = "comp_country";
            this.comp_country.Width = 125;
            // 
            // comp_birthday
            // 
            this.comp_birthday.DataPropertyName = "comp_birthday";
            this.comp_birthday.HeaderText = "comp_birthday";
            this.comp_birthday.MinimumWidth = 6;
            this.comp_birthday.Name = "comp_birthday";
            this.comp_birthday.Width = 125;
            // 
            // cat_name
            // 
            this.cat_name.DataPropertyName = "cat_name";
            this.cat_name.HeaderText = "cat_name";
            this.cat_name.MinimumWidth = 6;
            this.cat_name.Name = "cat_name";
            this.cat_name.Width = 125;
            // 
            // cat_start_time
            // 
            this.cat_start_time.DataPropertyName = "cat_start_time";
            this.cat_start_time.HeaderText = "cat_start_time";
            this.cat_start_time.MinimumWidth = 6;
            this.cat_start_time.Name = "cat_start_time";
            this.cat_start_time.Width = 125;
            // 
            // cat_time_limit
            // 
            this.cat_time_limit.DataPropertyName = "cat_time_limit";
            this.cat_time_limit.HeaderText = "cat_time_limit";
            this.cat_time_limit.MinimumWidth = 6;
            this.cat_time_limit.Name = "cat_time_limit";
            this.cat_time_limit.Width = 125;
            // 
            // btnClearCompetitors
            // 
            this.btnClearCompetitors.Enabled = false;
            this.btnClearCompetitors.Location = new System.Drawing.Point(386, 23);
            this.btnClearCompetitors.Name = "btnClearCompetitors";
            this.btnClearCompetitors.Size = new System.Drawing.Size(75, 23);
            this.btnClearCompetitors.TabIndex = 10;
            this.btnClearCompetitors.Text = "Delete Competitors";
            this.btnClearCompetitors.UseVisualStyleBackColor = true;
            this.btnClearCompetitors.Click += new System.EventHandler(this.btnClearCompetitors_Click);
            // 
            // cbAllowDeletion
            // 
            this.cbAllowDeletion.AutoSize = true;
            this.cbAllowDeletion.Location = new System.Drawing.Point(240, 25);
            this.cbAllowDeletion.Name = "cbAllowDeletion";
            this.cbAllowDeletion.Size = new System.Drawing.Size(118, 21);
            this.cbAllowDeletion.TabIndex = 11;
            this.cbAllowDeletion.Text = "Allow Deletion";
            this.cbAllowDeletion.UseVisualStyleBackColor = true;
            this.cbAllowDeletion.CheckedChanged += new System.EventHandler(this.cbAllowDeletion_CheckedChanged);
            // 
            // btClose
            // 
            this.btClose.Location = new System.Drawing.Point(1121, 23);
            this.btClose.Name = "btClose";
            this.btClose.Size = new System.Drawing.Size(75, 23);
            this.btClose.TabIndex = 12;
            this.btClose.Text = "Close";
            this.btClose.UseVisualStyleBackColor = true;
            this.btClose.Click += new System.EventHandler(this.btClose_Click);
            // 
            // BtnRegisterClient
            // 
            this.BtnRegisterClient.Location = new System.Drawing.Point(745, 30);
            this.BtnRegisterClient.Name = "BtnRegisterClient";
            this.BtnRegisterClient.Size = new System.Drawing.Size(75, 23);
            this.BtnRegisterClient.TabIndex = 13;
            this.BtnRegisterClient.Text = "Register client";
            this.BtnRegisterClient.UseVisualStyleBackColor = true;
            this.BtnRegisterClient.Click += new System.EventHandler(this.BtnRegisterClient_Click);
            // 
            // ChbTruncate
            // 
            this.ChbTruncate.AutoSize = true;
            this.ChbTruncate.Location = new System.Drawing.Point(1034, 685);
            this.ChbTruncate.Name = "ChbTruncate";
            this.ChbTruncate.Size = new System.Drawing.Size(87, 21);
            this.ChbTruncate.TabIndex = 14;
            this.ChbTruncate.Text = "Truncate";
            this.ChbTruncate.UseVisualStyleBackColor = true;
            // 
            // teamnrDataGridViewTextBoxColumn
            // 
            this.teamnrDataGridViewTextBoxColumn.DataPropertyName = "team_nr";
            this.teamnrDataGridViewTextBoxColumn.HeaderText = "team_nr";
            this.teamnrDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamnrDataGridViewTextBoxColumn.Name = "teamnrDataGridViewTextBoxColumn";
            this.teamnrDataGridViewTextBoxColumn.Width = 125;
            // 
            // teamnameDataGridViewTextBoxColumn
            // 
            this.teamnameDataGridViewTextBoxColumn.DataPropertyName = "team_name";
            this.teamnameDataGridViewTextBoxColumn.HeaderText = "team_name";
            this.teamnameDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamnameDataGridViewTextBoxColumn.Name = "teamnameDataGridViewTextBoxColumn";
            this.teamnameDataGridViewTextBoxColumn.Width = 125;
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
            // teamsBindingSource
            // 
            this.teamsBindingSource.DataSource = typeof(h24.v_comp_teams);
            // 
            // idDataGridViewTextBoxColumn
            // 
            this.idDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.idDataGridViewTextBoxColumn.DataPropertyName = "id";
            this.idDataGridViewTextBoxColumn.HeaderText = "ID";
            this.idDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.idDataGridViewTextBoxColumn.Name = "idDataGridViewTextBoxColumn";
            this.idDataGridViewTextBoxColumn.Width = 50;
            // 
            // classnameDataGridViewTextBoxColumn
            // 
            this.classnameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.classnameDataGridViewTextBoxColumn.DataPropertyName = "class_name";
            this.classnameDataGridViewTextBoxColumn.HeaderText = "Class";
            this.classnameDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.classnameDataGridViewTextBoxColumn.Name = "classnameDataGridViewTextBoxColumn";
            this.classnameDataGridViewTextBoxColumn.Width = 71;
            // 
            // teamshortnameDataGridViewTextBoxColumn
            // 
            this.teamshortnameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCellsExceptHeader;
            this.teamshortnameDataGridViewTextBoxColumn.DataPropertyName = "team_short_name";
            this.teamshortnameDataGridViewTextBoxColumn.HeaderText = "Team";
            this.teamshortnameDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamshortnameDataGridViewTextBoxColumn.Name = "teamshortnameDataGridViewTextBoxColumn";
            this.teamshortnameDataGridViewTextBoxColumn.Width = 24;
            // 
            // teamnameDataGridViewTextBoxColumn1
            // 
            this.teamnameDataGridViewTextBoxColumn1.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCellsExceptHeader;
            this.teamnameDataGridViewTextBoxColumn1.DataPropertyName = "team_name";
            this.teamnameDataGridViewTextBoxColumn1.HeaderText = "Abbr";
            this.teamnameDataGridViewTextBoxColumn1.MinimumWidth = 6;
            this.teamnameDataGridViewTextBoxColumn1.Name = "teamnameDataGridViewTextBoxColumn1";
            this.teamnameDataGridViewTextBoxColumn1.Width = 24;
            // 
            // legDataGridViewTextBoxColumn
            // 
            this.legDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.legDataGridViewTextBoxColumn.DataPropertyName = "leg";
            this.legDataGridViewTextBoxColumn.HeaderText = "Leg";
            this.legDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.legDataGridViewTextBoxColumn.Name = "legDataGridViewTextBoxColumn";
            this.legDataGridViewTextBoxColumn.Width = 61;
            // 
            // familyDataGridViewTextBoxColumn
            // 
            this.familyDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.familyDataGridViewTextBoxColumn.DataPropertyName = "family";
            this.familyDataGridViewTextBoxColumn.HeaderText = "Family";
            this.familyDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.familyDataGridViewTextBoxColumn.Name = "familyDataGridViewTextBoxColumn";
            this.familyDataGridViewTextBoxColumn.Width = 77;
            // 
            // givenDataGridViewTextBoxColumn
            // 
            this.givenDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.givenDataGridViewTextBoxColumn.DataPropertyName = "given";
            this.givenDataGridViewTextBoxColumn.HeaderText = "Given";
            this.givenDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.givenDataGridViewTextBoxColumn.Name = "givenDataGridViewTextBoxColumn";
            this.givenDataGridViewTextBoxColumn.Width = 74;
            // 
            // genderDataGridViewTextBoxColumn
            // 
            this.genderDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.genderDataGridViewTextBoxColumn.DataPropertyName = "gender";
            this.genderDataGridViewTextBoxColumn.HeaderText = "Gender";
            this.genderDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.genderDataGridViewTextBoxColumn.Name = "genderDataGridViewTextBoxColumn";
            this.genderDataGridViewTextBoxColumn.Width = 85;
            // 
            // countryDataGridViewTextBoxColumn
            // 
            this.countryDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.countryDataGridViewTextBoxColumn.DataPropertyName = "country";
            this.countryDataGridViewTextBoxColumn.HeaderText = "Country";
            this.countryDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.countryDataGridViewTextBoxColumn.Name = "countryDataGridViewTextBoxColumn";
            this.countryDataGridViewTextBoxColumn.Width = 86;
            // 
            // birthdateDataGridViewTextBoxColumn
            // 
            this.birthdateDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.birthdateDataGridViewTextBoxColumn.DataPropertyName = "birth_date";
            this.birthdateDataGridViewTextBoxColumn.HeaderText = "BirthDate";
            this.birthdateDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.birthdateDataGridViewTextBoxColumn.Name = "birthdateDataGridViewTextBoxColumn";
            this.birthdateDataGridViewTextBoxColumn.Width = 96;
            // 
            // sichipDataGridViewTextBoxColumn
            // 
            this.sichipDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.sichipDataGridViewTextBoxColumn.DataPropertyName = "si_chip";
            this.sichipDataGridViewTextBoxColumn.HeaderText = "SI";
            this.sichipDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.sichipDataGridViewTextBoxColumn.Name = "sichipDataGridViewTextBoxColumn";
            this.sichipDataGridViewTextBoxColumn.Width = 49;
            // 
            // noteDataGridViewTextBoxColumn
            // 
            this.noteDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.noteDataGridViewTextBoxColumn.DataPropertyName = "note";
            this.noteDataGridViewTextBoxColumn.HeaderText = "Note";
            this.noteDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.noteDataGridViewTextBoxColumn.Name = "noteDataGridViewTextBoxColumn";
            this.noteDataGridViewTextBoxColumn.Width = 67;
            // 
            // oristeamidDataGridViewTextBoxColumn
            // 
            this.oristeamidDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.oristeamidDataGridViewTextBoxColumn.DataPropertyName = "oris_team_id";
            this.oristeamidDataGridViewTextBoxColumn.HeaderText = "OrisID";
            this.oristeamidDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.oristeamidDataGridViewTextBoxColumn.Name = "oristeamidDataGridViewTextBoxColumn";
            this.oristeamidDataGridViewTextBoxColumn.Width = 76;
            // 
            // entryxmlBindingSource
            // 
            this.entryxmlBindingSource.DataSource = typeof(h24.entry_xml);
            // 
            // coursesBindingSource
            // 
            this.coursesBindingSource.DataSource = typeof(h24.courses);
            // 
            // coursecodesBindingSource
            // 
            this.coursecodesBindingSource.DataSource = typeof(h24.course_codes);
            // 
            // frmEntries
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1294, 718);
            this.Controls.Add(this.ChbTruncate);
            this.Controls.Add(this.BtnRegisterClient);
            this.Controls.Add(this.btClose);
            this.Controls.Add(this.cbAllowDeletion);
            this.Controls.Add(this.btnClearCompetitors);
            this.Controls.Add(this.btnPost);
            this.Controls.Add(this.BtnStarListXml);
            this.Controls.Add(this.dgEntries);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmEntries";
            this.Text = "Entries";
            this.Load += new System.EventHandler(this.frmEntries_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgEntry_xml)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgEntries)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.teamsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.entryxmlBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursecodesBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.BindingSource coursesBindingSource;
        private System.Windows.Forms.BindingSource coursecodesBindingSource;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button btnUpload;
        private System.Windows.Forms.TextBox tbEntries;
        private System.Windows.Forms.Button btnShowFile;
        private System.Windows.Forms.Button btnBrowse;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox tbEntriesFile;
        private System.Windows.Forms.DataGridView dgEntries;
        private System.Windows.Forms.BindingSource teamsBindingSource;
        private System.Windows.Forms.Button btnClearCompetitors;
        private System.Windows.Forms.CheckBox cbAllowDeletion;
        private System.Windows.Forms.Button btClose;
        private System.Windows.Forms.Button btnPost;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamnrDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamnameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamdidstartDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamstatusDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn race_end;
        private System.Windows.Forms.DataGridViewTextBoxColumn comp_name;
        private System.Windows.Forms.DataGridViewTextBoxColumn bib;
        private System.Windows.Forms.DataGridViewCheckBoxColumn rented_chip;
        private System.Windows.Forms.DataGridViewTextBoxColumn rank_order;
        private System.Windows.Forms.DataGridViewCheckBoxColumn comp_withdrawn;
        private System.Windows.Forms.DataGridViewTextBoxColumn comp_status;
        private System.Windows.Forms.DataGridViewTextBoxColumn comp_country;
        private System.Windows.Forms.DataGridViewTextBoxColumn comp_birthday;
        private System.Windows.Forms.DataGridViewTextBoxColumn cat_name;
        private System.Windows.Forms.DataGridViewTextBoxColumn cat_start_time;
        private System.Windows.Forms.DataGridViewTextBoxColumn cat_time_limit;
        private System.Windows.Forms.Button BtnRegisterClient;
        private System.Windows.Forms.Button BtnStarListXml;
        private System.Windows.Forms.Button BtnUploadXML;
        private System.Windows.Forms.TextBox TbOrisId;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.DataGridView dgEntry_xml;
        private System.Windows.Forms.BindingSource entryxmlBindingSource;
        private System.Windows.Forms.Button BtInsertXmlEntries;
        private System.Windows.Forms.Button BtInsertCatagories;
        private System.Windows.Forms.Button BtEntryRefresh;
        private System.Windows.Forms.DataGridViewTextBoxColumn idDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn classnameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamshortnameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamnameDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn legDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn familyDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn givenDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn genderDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn countryDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn birthdateDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn sichipDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn noteDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn oristeamidDataGridViewTextBoxColumn;
        private System.Windows.Forms.CheckBox ChbTruncate;
    }
}