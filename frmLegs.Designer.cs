
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
            this.btnGenerateLegs = new System.Windows.Forms.Button();
            this.dgCourses = new System.Windows.Forms.DataGridView();
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
            this.txPrefix = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.CbDeleteLegs = new System.Windows.Forms.CheckBox();
            this.btDeleteLegs = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgLegs)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.competitorsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.legsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgCourses)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // dgLegs
            // 
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
            this.dgLegs.Location = new System.Drawing.Point(31, 398);
            this.dgLegs.Name = "dgLegs";
            this.dgLegs.RowHeadersWidth = 51;
            this.dgLegs.RowTemplate.Height = 24;
            this.dgLegs.Size = new System.Drawing.Size(651, 224);
            this.dgLegs.TabIndex = 0;
            this.dgLegs.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgLegs_CellEndEdit);
            this.dgLegs.DataError += new System.Windows.Forms.DataGridViewDataErrorEventHandler(this.dgLegs_DataError);
            // 
            // leg_id
            // 
            this.leg_id.DataPropertyName = "leg_id";
            this.leg_id.HeaderText = "leg_id";
            this.leg_id.MinimumWidth = 6;
            this.leg_id.Name = "leg_id";
            this.leg_id.Width = 125;
            // 
            // compidDataGridViewTextBoxColumn
            // 
            this.compidDataGridViewTextBoxColumn.DataPropertyName = "comp_id";
            this.compidDataGridViewTextBoxColumn.DataSource = this.competitorsBindingSource;
            this.compidDataGridViewTextBoxColumn.DisplayMember = "comp_name";
            this.compidDataGridViewTextBoxColumn.HeaderText = "comp_id";
            this.compidDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.compidDataGridViewTextBoxColumn.Name = "compidDataGridViewTextBoxColumn";
            this.compidDataGridViewTextBoxColumn.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.compidDataGridViewTextBoxColumn.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.compidDataGridViewTextBoxColumn.ValueMember = "comp_id";
            this.compidDataGridViewTextBoxColumn.Width = 125;
            // 
            // competitorsBindingSource
            // 
            this.competitorsBindingSource.DataSource = typeof(h24.competitors);
            // 
            // course_id
            // 
            this.course_id.DataPropertyName = "course_id";
            this.course_id.DataSource = this.coursesBindingSource1;
            this.course_id.DisplayMember = "course_name";
            this.course_id.HeaderText = "course_id";
            this.course_id.MinimumWidth = 6;
            this.course_id.Name = "course_id";
            this.course_id.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.course_id.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.course_id.ValueMember = "course_id";
            this.course_id.Width = 125;
            // 
            // coursesBindingSource1
            // 
            this.coursesBindingSource1.DataSource = typeof(h24.courses);
            // 
            // readoutidDataGridViewTextBoxColumn
            // 
            this.readoutidDataGridViewTextBoxColumn.DataPropertyName = "readout_id";
            this.readoutidDataGridViewTextBoxColumn.HeaderText = "readout_id";
            this.readoutidDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.readoutidDataGridViewTextBoxColumn.Name = "readoutidDataGridViewTextBoxColumn";
            this.readoutidDataGridViewTextBoxColumn.Width = 125;
            // 
            // startdtimeDataGridViewTextBoxColumn
            // 
            this.startdtimeDataGridViewTextBoxColumn.DataPropertyName = "start_dtime";
            this.startdtimeDataGridViewTextBoxColumn.HeaderText = "start_dtime";
            this.startdtimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.startdtimeDataGridViewTextBoxColumn.Name = "startdtimeDataGridViewTextBoxColumn";
            this.startdtimeDataGridViewTextBoxColumn.Width = 125;
            // 
            // starttimeDataGridViewTextBoxColumn
            // 
            this.starttimeDataGridViewTextBoxColumn.DataPropertyName = "start_time";
            this.starttimeDataGridViewTextBoxColumn.HeaderText = "start_time";
            this.starttimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.starttimeDataGridViewTextBoxColumn.Name = "starttimeDataGridViewTextBoxColumn";
            this.starttimeDataGridViewTextBoxColumn.Width = 125;
            // 
            // finishdtimeDataGridViewTextBoxColumn
            // 
            this.finishdtimeDataGridViewTextBoxColumn.DataPropertyName = "finish_dtime";
            this.finishdtimeDataGridViewTextBoxColumn.HeaderText = "finish_dtime";
            this.finishdtimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.finishdtimeDataGridViewTextBoxColumn.Name = "finishdtimeDataGridViewTextBoxColumn";
            this.finishdtimeDataGridViewTextBoxColumn.Width = 125;
            // 
            // finishtimeDataGridViewTextBoxColumn
            // 
            this.finishtimeDataGridViewTextBoxColumn.DataPropertyName = "finish_time";
            this.finishtimeDataGridViewTextBoxColumn.HeaderText = "finish_time";
            this.finishtimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.finishtimeDataGridViewTextBoxColumn.Name = "finishtimeDataGridViewTextBoxColumn";
            this.finishtimeDataGridViewTextBoxColumn.Width = 125;
            // 
            // legsBindingSource
            // 
            this.legsBindingSource.DataSource = typeof(h24.legs);
            // 
            // btnGenerateLegs
            // 
            this.btnGenerateLegs.Location = new System.Drawing.Point(765, 99);
            this.btnGenerateLegs.Name = "btnGenerateLegs";
            this.btnGenerateLegs.Size = new System.Drawing.Size(160, 23);
            this.btnGenerateLegs.TabIndex = 1;
            this.btnGenerateLegs.Text = "Generate Legs";
            this.btnGenerateLegs.UseVisualStyleBackColor = true;
            this.btnGenerateLegs.Click += new System.EventHandler(this.btnGenerateLegs_Click);
            // 
            // dgCourses
            // 
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
            this.dgCourses.Location = new System.Drawing.Point(31, 34);
            this.dgCourses.Name = "dgCourses";
            this.dgCourses.RowHeadersWidth = 51;
            this.dgCourses.RowTemplate.Height = 24;
            this.dgCourses.Size = new System.Drawing.Size(651, 200);
            this.dgCourses.TabIndex = 2;
            // 
            // courseidDataGridViewTextBoxColumn1
            // 
            this.courseidDataGridViewTextBoxColumn1.DataPropertyName = "course_id";
            this.courseidDataGridViewTextBoxColumn1.HeaderText = "course_id";
            this.courseidDataGridViewTextBoxColumn1.MinimumWidth = 6;
            this.courseidDataGridViewTextBoxColumn1.Name = "courseidDataGridViewTextBoxColumn1";
            this.courseidDataGridViewTextBoxColumn1.Width = 125;
            // 
            // coursenameDataGridViewTextBoxColumn
            // 
            this.coursenameDataGridViewTextBoxColumn.DataPropertyName = "course_name";
            this.coursenameDataGridViewTextBoxColumn.HeaderText = "course_name";
            this.coursenameDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.coursenameDataGridViewTextBoxColumn.Name = "coursenameDataGridViewTextBoxColumn";
            this.coursenameDataGridViewTextBoxColumn.Width = 125;
            // 
            // courselengthDataGridViewTextBoxColumn
            // 
            this.courselengthDataGridViewTextBoxColumn.DataPropertyName = "course_length";
            this.courselengthDataGridViewTextBoxColumn.HeaderText = "course_length";
            this.courselengthDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.courselengthDataGridViewTextBoxColumn.Name = "courselengthDataGridViewTextBoxColumn";
            this.courselengthDataGridViewTextBoxColumn.Width = 125;
            // 
            // courseclimbDataGridViewTextBoxColumn
            // 
            this.courseclimbDataGridViewTextBoxColumn.DataPropertyName = "course_climb";
            this.courseclimbDataGridViewTextBoxColumn.HeaderText = "course_climb";
            this.courseclimbDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.courseclimbDataGridViewTextBoxColumn.Name = "courseclimbDataGridViewTextBoxColumn";
            this.courseclimbDataGridViewTextBoxColumn.Width = 125;
            // 
            // coursetypeDataGridViewTextBoxColumn
            // 
            this.coursetypeDataGridViewTextBoxColumn.DataPropertyName = "course_type";
            this.coursetypeDataGridViewTextBoxColumn.HeaderText = "course_type";
            this.coursetypeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.coursetypeDataGridViewTextBoxColumn.Name = "coursetypeDataGridViewTextBoxColumn";
            this.coursetypeDataGridViewTextBoxColumn.Width = 125;
            // 
            // controlcountDataGridViewTextBoxColumn
            // 
            this.controlcountDataGridViewTextBoxColumn.DataPropertyName = "control_count";
            this.controlcountDataGridViewTextBoxColumn.HeaderText = "control_count";
            this.controlcountDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.controlcountDataGridViewTextBoxColumn.Name = "controlcountDataGridViewTextBoxColumn";
            this.controlcountDataGridViewTextBoxColumn.Width = 125;
            // 
            // asofdateDataGridViewTextBoxColumn1
            // 
            this.asofdateDataGridViewTextBoxColumn1.DataPropertyName = "as_of_date";
            this.asofdateDataGridViewTextBoxColumn1.HeaderText = "as_of_date";
            this.asofdateDataGridViewTextBoxColumn1.MinimumWidth = 6;
            this.asofdateDataGridViewTextBoxColumn1.Name = "asofdateDataGridViewTextBoxColumn1";
            this.asofdateDataGridViewTextBoxColumn1.Width = 125;
            // 
            // coursecodesDataGridViewTextBoxColumn
            // 
            this.coursecodesDataGridViewTextBoxColumn.DataPropertyName = "course_codes";
            this.coursecodesDataGridViewTextBoxColumn.HeaderText = "course_codes";
            this.coursecodesDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.coursecodesDataGridViewTextBoxColumn.Name = "coursecodesDataGridViewTextBoxColumn";
            this.coursecodesDataGridViewTextBoxColumn.Width = 125;
            // 
            // legsDataGridViewTextBoxColumn
            // 
            this.legsDataGridViewTextBoxColumn.DataPropertyName = "legs";
            this.legsDataGridViewTextBoxColumn.HeaderText = "legs";
            this.legsDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.legsDataGridViewTextBoxColumn.Name = "legsDataGridViewTextBoxColumn";
            this.legsDataGridViewTextBoxColumn.Width = 125;
            // 
            // coursesBindingSource
            // 
            this.coursesBindingSource.DataSource = typeof(h24.courses);
            // 
            // txPrefix
            // 
            this.txPrefix.Location = new System.Drawing.Point(825, 60);
            this.txPrefix.Name = "txPrefix";
            this.txPrefix.Size = new System.Drawing.Size(100, 22);
            this.txPrefix.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(762, 63);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(47, 17);
            this.label1.TabIndex = 4;
            this.label1.Text = "Prefix:";
            // 
            // CbDeleteLegs
            // 
            this.CbDeleteLegs.AutoSize = true;
            this.CbDeleteLegs.Location = new System.Drawing.Point(812, 439);
            this.CbDeleteLegs.Name = "CbDeleteLegs";
            this.CbDeleteLegs.Size = new System.Drawing.Size(106, 21);
            this.CbDeleteLegs.TabIndex = 5;
            this.CbDeleteLegs.Text = "Delete Legs";
            this.CbDeleteLegs.UseVisualStyleBackColor = true;
            // 
            // btDeleteLegs
            // 
            this.btDeleteLegs.Location = new System.Drawing.Point(959, 433);
            this.btDeleteLegs.Name = "btDeleteLegs";
            this.btDeleteLegs.Size = new System.Drawing.Size(108, 27);
            this.btDeleteLegs.TabIndex = 6;
            this.btDeleteLegs.Text = "Online Delete";
            this.btDeleteLegs.UseVisualStyleBackColor = true;
            this.btDeleteLegs.Click += new System.EventHandler(this.btDeleteLegs_Click);
            // 
            // frmLegs
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1216, 650);
            this.Controls.Add(this.btDeleteLegs);
            this.Controls.Add(this.CbDeleteLegs);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txPrefix);
            this.Controls.Add(this.dgCourses);
            this.Controls.Add(this.btnGenerateLegs);
            this.Controls.Add(this.dgLegs);
            this.Name = "frmLegs";
            this.Text = "frmLegs";
            this.Load += new System.EventHandler(this.frmLegs_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgLegs)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.competitorsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.legsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgCourses)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgLegs;
        private System.Windows.Forms.BindingSource legsBindingSource;
        private System.Windows.Forms.Button btnGenerateLegs;
        private System.Windows.Forms.DataGridView dgCourses;
        private System.Windows.Forms.DataGridViewTextBoxColumn courseidDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn coursenameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn courselengthDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn courseclimbDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn coursetypeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn controlcountDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn asofdateDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn coursecodesDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn legsDataGridViewTextBoxColumn;
        private System.Windows.Forms.BindingSource coursesBindingSource;
        private System.Windows.Forms.TextBox txPrefix;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.BindingSource competitorsBindingSource;
        private System.Windows.Forms.BindingSource coursesBindingSource1;
        private System.Windows.Forms.DataGridViewTextBoxColumn leg_id;
        private System.Windows.Forms.DataGridViewComboBoxColumn compidDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewComboBoxColumn course_id;
        private System.Windows.Forms.DataGridViewTextBoxColumn readoutidDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn startdtimeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn starttimeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn finishdtimeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn finishtimeDataGridViewTextBoxColumn;
        private System.Windows.Forms.CheckBox CbDeleteLegs;
        private System.Windows.Forms.Button btDeleteLegs;
    }
}