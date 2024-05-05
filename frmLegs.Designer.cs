
namespace h24
{
    partial class frmLegs
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
            this.dgLegs = new System.Windows.Forms.DataGridView();
            this.btnGenerateLegs = new System.Windows.Forms.Button();
            this.dgCourses = new System.Windows.Forms.DataGridView();
            this.txPrefix = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.CbDeleteLegs = new System.Windows.Forms.CheckBox();
            this.btDeleteLegs = new System.Windows.Forms.Button();
            this.btAssignFirstLeg = new System.Windows.Forms.Button();
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            this.label2 = new System.Windows.Forms.Label();
            this.cbCategory = new System.Windows.Forms.ComboBox();
            this.courseidDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.coursenameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.courselengthDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.courseclimbDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.coursetypeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.controlcountDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.asofdateDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.coursecodesDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.legsDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.coursesBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.leg_id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.compidDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewComboBoxColumn();
            this.competitorsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.course_id = new System.Windows.Forms.DataGridViewComboBoxColumn();
            this.coursesBindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.readoutidDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.startdtimeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.starttimeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.finishdtimeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.finishtimeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.legsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.dgLegs)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgCourses)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.competitorsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.legsBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // dgLegs
            // 
            this.dgLegs.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgLegs.AutoGenerateColumns = false;
            this.dgLegs.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgLegs.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.leg_id,
            this.compidDataGridViewTextBoxColumn,
            this.course_id,
            this.readoutidDataGridViewTextBoxColumn,
            this.startdtimeDataGridViewTextBoxColumn,
            this.starttimeDataGridViewTextBoxColumn,
            this.finishdtimeDataGridViewTextBoxColumn,
            this.finishtimeDataGridViewTextBoxColumn});
            this.dgLegs.DataSource = this.legsBindingSource;
            this.dgLegs.Location = new System.Drawing.Point(35, 339);
            this.dgLegs.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgLegs.Name = "dgLegs";
            this.dgLegs.RowHeadersWidth = 51;
            this.dgLegs.RowTemplate.Height = 24;
            this.dgLegs.Size = new System.Drawing.Size(732, 280);
            this.dgLegs.TabIndex = 0;
            this.dgLegs.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgLegs_CellEndEdit);
            this.dgLegs.DataError += new System.Windows.Forms.DataGridViewDataErrorEventHandler(this.dgLegs_DataError);
            // 
            // btnGenerateLegs
            // 
            this.btnGenerateLegs.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnGenerateLegs.Location = new System.Drawing.Point(861, 116);
            this.btnGenerateLegs.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnGenerateLegs.Name = "btnGenerateLegs";
            this.btnGenerateLegs.Size = new System.Drawing.Size(180, 29);
            this.btnGenerateLegs.TabIndex = 1;
            this.btnGenerateLegs.Text = "Generate Legs Relay";
            this.btnGenerateLegs.UseVisualStyleBackColor = true;
            this.btnGenerateLegs.Click += new System.EventHandler(this.btnGenerateLegs_Click);
            // 
            // dgCourses
            // 
            this.dgCourses.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgCourses.AutoGenerateColumns = false;
            this.dgCourses.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgCourses.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.courseidDataGridViewTextBoxColumn1,
            this.coursenameDataGridViewTextBoxColumn,
            this.courselengthDataGridViewTextBoxColumn,
            this.courseclimbDataGridViewTextBoxColumn,
            this.coursetypeDataGridViewTextBoxColumn,
            this.controlcountDataGridViewTextBoxColumn,
            this.asofdateDataGridViewTextBoxColumn1,
            this.coursecodesDataGridViewTextBoxColumn,
            this.legsDataGridViewTextBoxColumn});
            this.dgCourses.DataSource = this.coursesBindingSource;
            this.dgCourses.Location = new System.Drawing.Point(35, 42);
            this.dgCourses.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgCourses.Name = "dgCourses";
            this.dgCourses.RowHeadersWidth = 51;
            this.dgCourses.RowTemplate.Height = 24;
            this.dgCourses.Size = new System.Drawing.Size(732, 250);
            this.dgCourses.TabIndex = 2;
            // 
            // txPrefix
            // 
            this.txPrefix.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.txPrefix.Location = new System.Drawing.Point(934, 67);
            this.txPrefix.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txPrefix.Name = "txPrefix";
            this.txPrefix.Size = new System.Drawing.Size(175, 26);
            this.txPrefix.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(857, 73);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(52, 20);
            this.label1.TabIndex = 4;
            this.label1.Text = "Prefix:";
            // 
            // CbDeleteLegs
            // 
            this.CbDeleteLegs.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.CbDeleteLegs.AutoSize = true;
            this.CbDeleteLegs.Location = new System.Drawing.Point(914, 549);
            this.CbDeleteLegs.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.CbDeleteLegs.Name = "CbDeleteLegs";
            this.CbDeleteLegs.Size = new System.Drawing.Size(121, 24);
            this.CbDeleteLegs.TabIndex = 5;
            this.CbDeleteLegs.Text = "Delete Legs";
            this.CbDeleteLegs.UseVisualStyleBackColor = true;
            // 
            // btDeleteLegs
            // 
            this.btDeleteLegs.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btDeleteLegs.Location = new System.Drawing.Point(1079, 541);
            this.btDeleteLegs.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btDeleteLegs.Name = "btDeleteLegs";
            this.btDeleteLegs.Size = new System.Drawing.Size(122, 34);
            this.btDeleteLegs.TabIndex = 6;
            this.btDeleteLegs.Text = "Online Delete";
            this.btDeleteLegs.UseVisualStyleBackColor = true;
            this.btDeleteLegs.Click += new System.EventHandler(this.btDeleteLegs_Click);
            // 
            // btAssignFirstLeg
            // 
            this.btAssignFirstLeg.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btAssignFirstLeg.Location = new System.Drawing.Point(861, 392);
            this.btAssignFirstLeg.Name = "btAssignFirstLeg";
            this.btAssignFirstLeg.Size = new System.Drawing.Size(248, 42);
            this.btAssignFirstLeg.TabIndex = 7;
            this.btAssignFirstLeg.Text = "1 leg assign - a-h";
            this.toolTip1.SetToolTip(this.btAssignFirstLeg, "This assigns correct course to 1st leg of relay based on first number of each cat" +
        "egory");
            this.btAssignFirstLeg.UseVisualStyleBackColor = true;
            this.btAssignFirstLeg.Click += new System.EventHandler(this.btAssignFirstLeg_Click);
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(855, 341);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(73, 20);
            this.label2.TabIndex = 8;
            this.label2.Text = "Category";
            // 
            // cbCategory
            // 
            this.cbCategory.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.cbCategory.FormattingEnabled = true;
            this.cbCategory.Location = new System.Drawing.Point(934, 338);
            this.cbCategory.Name = "cbCategory";
            this.cbCategory.Size = new System.Drawing.Size(176, 28);
            this.cbCategory.TabIndex = 9;
            // 
            // courseidDataGridViewTextBoxColumn1
            // 
            this.courseidDataGridViewTextBoxColumn1.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.courseidDataGridViewTextBoxColumn1.DataPropertyName = "course_id";
            this.courseidDataGridViewTextBoxColumn1.HeaderText = "course_id";
            this.courseidDataGridViewTextBoxColumn1.MinimumWidth = 6;
            this.courseidDataGridViewTextBoxColumn1.Name = "courseidDataGridViewTextBoxColumn1";
            this.courseidDataGridViewTextBoxColumn1.Width = 114;
            // 
            // coursenameDataGridViewTextBoxColumn
            // 
            this.coursenameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.coursenameDataGridViewTextBoxColumn.DataPropertyName = "course_name";
            this.coursenameDataGridViewTextBoxColumn.HeaderText = "course_name";
            this.coursenameDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.coursenameDataGridViewTextBoxColumn.Name = "coursenameDataGridViewTextBoxColumn";
            this.coursenameDataGridViewTextBoxColumn.Width = 142;
            // 
            // courselengthDataGridViewTextBoxColumn
            // 
            this.courselengthDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.courselengthDataGridViewTextBoxColumn.DataPropertyName = "course_length";
            this.courselengthDataGridViewTextBoxColumn.HeaderText = "course_length";
            this.courselengthDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.courselengthDataGridViewTextBoxColumn.Name = "courselengthDataGridViewTextBoxColumn";
            this.courselengthDataGridViewTextBoxColumn.Width = 146;
            // 
            // courseclimbDataGridViewTextBoxColumn
            // 
            this.courseclimbDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.courseclimbDataGridViewTextBoxColumn.DataPropertyName = "course_climb";
            this.courseclimbDataGridViewTextBoxColumn.HeaderText = "course_climb";
            this.courseclimbDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.courseclimbDataGridViewTextBoxColumn.Name = "courseclimbDataGridViewTextBoxColumn";
            this.courseclimbDataGridViewTextBoxColumn.Width = 138;
            // 
            // coursetypeDataGridViewTextBoxColumn
            // 
            this.coursetypeDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.coursetypeDataGridViewTextBoxColumn.DataPropertyName = "course_type";
            this.coursetypeDataGridViewTextBoxColumn.HeaderText = "course_type";
            this.coursetypeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.coursetypeDataGridViewTextBoxColumn.Name = "coursetypeDataGridViewTextBoxColumn";
            this.coursetypeDataGridViewTextBoxColumn.Width = 132;
            // 
            // controlcountDataGridViewTextBoxColumn
            // 
            this.controlcountDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.controlcountDataGridViewTextBoxColumn.DataPropertyName = "control_count";
            this.controlcountDataGridViewTextBoxColumn.HeaderText = "control_count";
            this.controlcountDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.controlcountDataGridViewTextBoxColumn.Name = "controlcountDataGridViewTextBoxColumn";
            this.controlcountDataGridViewTextBoxColumn.Width = 142;
            // 
            // asofdateDataGridViewTextBoxColumn1
            // 
            this.asofdateDataGridViewTextBoxColumn1.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.asofdateDataGridViewTextBoxColumn1.DataPropertyName = "as_of_date";
            this.asofdateDataGridViewTextBoxColumn1.HeaderText = "as_of_date";
            this.asofdateDataGridViewTextBoxColumn1.MinimumWidth = 6;
            this.asofdateDataGridViewTextBoxColumn1.Name = "asofdateDataGridViewTextBoxColumn1";
            this.asofdateDataGridViewTextBoxColumn1.Width = 126;
            // 
            // coursecodesDataGridViewTextBoxColumn
            // 
            this.coursecodesDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.coursecodesDataGridViewTextBoxColumn.DataPropertyName = "course_codes";
            this.coursecodesDataGridViewTextBoxColumn.HeaderText = "course_codes";
            this.coursecodesDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.coursecodesDataGridViewTextBoxColumn.Name = "coursecodesDataGridViewTextBoxColumn";
            this.coursecodesDataGridViewTextBoxColumn.Width = 145;
            // 
            // legsDataGridViewTextBoxColumn
            // 
            this.legsDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.legsDataGridViewTextBoxColumn.DataPropertyName = "legs";
            this.legsDataGridViewTextBoxColumn.HeaderText = "legs";
            this.legsDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.legsDataGridViewTextBoxColumn.Name = "legsDataGridViewTextBoxColumn";
            this.legsDataGridViewTextBoxColumn.Width = 74;
            // 
            // coursesBindingSource
            // 
            this.coursesBindingSource.DataSource = typeof(h24.courses);
            // 
            // leg_id
            // 
            this.leg_id.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.leg_id.DataPropertyName = "leg_id";
            this.leg_id.HeaderText = "leg_id";
            this.leg_id.MinimumWidth = 6;
            this.leg_id.Name = "leg_id";
            this.leg_id.Width = 87;
            // 
            // compidDataGridViewTextBoxColumn
            // 
            this.compidDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.compidDataGridViewTextBoxColumn.DataPropertyName = "comp_id";
            this.compidDataGridViewTextBoxColumn.DataSource = this.competitorsBindingSource;
            this.compidDataGridViewTextBoxColumn.DisplayMember = "comp_name";
            this.compidDataGridViewTextBoxColumn.HeaderText = "comp_id";
            this.compidDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.compidDataGridViewTextBoxColumn.Name = "compidDataGridViewTextBoxColumn";
            this.compidDataGridViewTextBoxColumn.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.compidDataGridViewTextBoxColumn.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.compidDataGridViewTextBoxColumn.ValueMember = "comp_id";
            this.compidDataGridViewTextBoxColumn.Width = 105;
            // 
            // competitorsBindingSource
            // 
            this.competitorsBindingSource.DataSource = typeof(h24.competitors);
            // 
            // course_id
            // 
            this.course_id.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.course_id.DataPropertyName = "course_id";
            this.course_id.DataSource = this.coursesBindingSource1;
            this.course_id.DisplayMember = "course_name";
            this.course_id.HeaderText = "course_id";
            this.course_id.MinimumWidth = 6;
            this.course_id.Name = "course_id";
            this.course_id.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.course_id.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.course_id.ValueMember = "course_id";
            this.course_id.Width = 114;
            // 
            // coursesBindingSource1
            // 
            this.coursesBindingSource1.DataSource = typeof(h24.courses);
            // 
            // readoutidDataGridViewTextBoxColumn
            // 
            this.readoutidDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.readoutidDataGridViewTextBoxColumn.DataPropertyName = "readout_id";
            this.readoutidDataGridViewTextBoxColumn.HeaderText = "readout_id";
            this.readoutidDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.readoutidDataGridViewTextBoxColumn.Name = "readoutidDataGridViewTextBoxColumn";
            this.readoutidDataGridViewTextBoxColumn.Width = 121;
            // 
            // startdtimeDataGridViewTextBoxColumn
            // 
            this.startdtimeDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.startdtimeDataGridViewTextBoxColumn.DataPropertyName = "start_dtime";
            this.startdtimeDataGridViewTextBoxColumn.HeaderText = "start_dtime";
            this.startdtimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.startdtimeDataGridViewTextBoxColumn.Name = "startdtimeDataGridViewTextBoxColumn";
            this.startdtimeDataGridViewTextBoxColumn.Width = 125;
            // 
            // starttimeDataGridViewTextBoxColumn
            // 
            this.starttimeDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.starttimeDataGridViewTextBoxColumn.DataPropertyName = "start_time";
            this.starttimeDataGridViewTextBoxColumn.HeaderText = "start_time";
            this.starttimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.starttimeDataGridViewTextBoxColumn.Name = "starttimeDataGridViewTextBoxColumn";
            this.starttimeDataGridViewTextBoxColumn.Width = 116;
            // 
            // finishdtimeDataGridViewTextBoxColumn
            // 
            this.finishdtimeDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.finishdtimeDataGridViewTextBoxColumn.DataPropertyName = "finish_dtime";
            this.finishdtimeDataGridViewTextBoxColumn.HeaderText = "finish_dtime";
            this.finishdtimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.finishdtimeDataGridViewTextBoxColumn.Name = "finishdtimeDataGridViewTextBoxColumn";
            this.finishdtimeDataGridViewTextBoxColumn.Width = 130;
            // 
            // finishtimeDataGridViewTextBoxColumn
            // 
            this.finishtimeDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.finishtimeDataGridViewTextBoxColumn.DataPropertyName = "finish_time";
            this.finishtimeDataGridViewTextBoxColumn.HeaderText = "finish_time";
            this.finishtimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.finishtimeDataGridViewTextBoxColumn.Name = "finishtimeDataGridViewTextBoxColumn";
            this.finishtimeDataGridViewTextBoxColumn.Width = 121;
            // 
            // legsBindingSource
            // 
            this.legsBindingSource.DataSource = typeof(h24.legs);
            // 
            // frmLegs
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1225, 640);
            this.Controls.Add(this.cbCategory);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.btAssignFirstLeg);
            this.Controls.Add(this.btDeleteLegs);
            this.Controls.Add(this.CbDeleteLegs);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txPrefix);
            this.Controls.Add(this.dgCourses);
            this.Controls.Add(this.btnGenerateLegs);
            this.Controls.Add(this.dgLegs);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmLegs";
            this.Text = "frmLegs";
            this.Load += new System.EventHandler(this.frmLegs_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgLegs)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgCourses)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.competitorsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.legsBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgLegs;
        private System.Windows.Forms.BindingSource legsBindingSource;
        private System.Windows.Forms.Button btnGenerateLegs;
        private System.Windows.Forms.DataGridView dgCourses;
        private System.Windows.Forms.BindingSource coursesBindingSource;
        private System.Windows.Forms.TextBox txPrefix;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.BindingSource competitorsBindingSource;
        private System.Windows.Forms.BindingSource coursesBindingSource1;
        private System.Windows.Forms.CheckBox CbDeleteLegs;
        private System.Windows.Forms.Button btDeleteLegs;
        private System.Windows.Forms.Button btAssignFirstLeg;
        private System.Windows.Forms.ToolTip toolTip1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cbCategory;
        private System.Windows.Forms.DataGridViewTextBoxColumn courseidDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn coursenameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn courselengthDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn courseclimbDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn coursetypeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn controlcountDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn asofdateDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn coursecodesDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn legsDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn leg_id;
        private System.Windows.Forms.DataGridViewComboBoxColumn compidDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewComboBoxColumn course_id;
        private System.Windows.Forms.DataGridViewTextBoxColumn readoutidDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn startdtimeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn starttimeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn finishdtimeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn finishtimeDataGridViewTextBoxColumn;
    }
}