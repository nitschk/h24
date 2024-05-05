
namespace h24
{
    partial class frmCourseNotFound
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
            this.dgCourses = new System.Windows.Forms.DataGridView();
            this.course_name = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.course_length = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.course_climb = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.control_count = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.course_id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.coursesBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.btnSave = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.txSearch = new System.Windows.Forms.TextBox();
            this.btClear = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgCourses)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(277, 32);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(206, 29);
            this.label1.TabIndex = 0;
            this.label1.Text = "Unknown course";
            // 
            // dgCourses
            // 
            this.dgCourses.AllowUserToAddRows = false;
            this.dgCourses.AllowUserToDeleteRows = false;
            this.dgCourses.AllowUserToOrderColumns = true;
            this.dgCourses.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgCourses.AutoGenerateColumns = false;
            this.dgCourses.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgCourses.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.course_name,
            this.course_length,
            this.course_climb,
            this.control_count,
            this.course_id});
            this.dgCourses.DataSource = this.coursesBindingSource;
            this.dgCourses.Location = new System.Drawing.Point(78, 198);
            this.dgCourses.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgCourses.Name = "dgCourses";
            this.dgCourses.ReadOnly = true;
            this.dgCourses.RowHeadersWidth = 51;
            this.dgCourses.RowTemplate.Height = 24;
            this.dgCourses.Size = new System.Drawing.Size(727, 318);
            this.dgCourses.TabIndex = 3;
            this.dgCourses.ColumnWidthChanged += new System.Windows.Forms.DataGridViewColumnEventHandler(this.dgCourses_ColumnWidthChanged);
            this.dgCourses.DoubleClick += new System.EventHandler(this.dgCourses_DoubleClick);
            // 
            // course_name
            // 
            this.course_name.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.course_name.DataPropertyName = "course_name";
            this.course_name.HeaderText = "Course";
            this.course_name.MinimumWidth = 6;
            this.course_name.Name = "course_name";
            this.course_name.ReadOnly = true;
            this.course_name.Width = 96;
            // 
            // course_length
            // 
            this.course_length.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.course_length.DataPropertyName = "course_length";
            this.course_length.HeaderText = "Length";
            this.course_length.MinimumWidth = 6;
            this.course_length.Name = "course_length";
            this.course_length.ReadOnly = true;
            // 
            // course_climb
            // 
            this.course_climb.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.course_climb.DataPropertyName = "course_climb";
            this.course_climb.HeaderText = "Climb";
            this.course_climb.MinimumWidth = 6;
            this.course_climb.Name = "course_climb";
            this.course_climb.ReadOnly = true;
            // 
            // control_count
            // 
            this.control_count.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.control_count.DataPropertyName = "control_count";
            this.control_count.HeaderText = "control_count";
            this.control_count.MinimumWidth = 6;
            this.control_count.Name = "control_count";
            this.control_count.ReadOnly = true;
            // 
            // course_id
            // 
            this.course_id.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.course_id.DataPropertyName = "course_id";
            this.course_id.HeaderText = "course_id";
            this.course_id.MinimumWidth = 6;
            this.course_id.Name = "course_id";
            this.course_id.ReadOnly = true;
            // 
            // coursesBindingSource
            // 
            this.coursesBindingSource.DataSource = typeof(h24.courses);
            // 
            // btnSave
            // 
            this.btnSave.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btnSave.Location = new System.Drawing.Point(331, 544);
            this.btnSave.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(84, 29);
            this.btnSave.TabIndex = 6;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCancel.Location = new System.Drawing.Point(488, 544);
            this.btnCancel.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(84, 29);
            this.btnCancel.TabIndex = 7;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(84, 163);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(64, 20);
            this.label2.TabIndex = 8;
            this.label2.Text = "Search:";
            // 
            // txSearch
            // 
            this.txSearch.Location = new System.Drawing.Point(200, 159);
            this.txSearch.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txSearch.Name = "txSearch";
            this.txSearch.Size = new System.Drawing.Size(112, 26);
            this.txSearch.TabIndex = 0;
            this.txSearch.TextChanged += new System.EventHandler(this.txSearch_TextChanged);
            // 
            // btClear
            // 
            this.btClear.Location = new System.Drawing.Point(342, 159);
            this.btClear.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btClear.Name = "btClear";
            this.btClear.Size = new System.Drawing.Size(84, 29);
            this.btClear.TabIndex = 10;
            this.btClear.Text = "Clear";
            this.btClear.UseVisualStyleBackColor = true;
            this.btClear.Click += new System.EventHandler(this.btClear_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(84, 78);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(0, 25);
            this.label3.TabIndex = 11;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(85, 117);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(0, 20);
            this.label4.TabIndex = 12;
            // 
            // frmCourseNotFound
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(900, 654);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btClear);
            this.Controls.Add(this.txSearch);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.dgCourses);
            this.Controls.Add(this.label1);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmCourseNotFound";
            this.Text = "frmCourseNotFound";
            this.Load += new System.EventHandler(this.frmCourseNotFound_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgCourses)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.coursesBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgCourses;
        private System.Windows.Forms.BindingSource coursesBindingSource;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txSearch;
        private System.Windows.Forms.Button btClear;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.DataGridViewTextBoxColumn course_name;
        private System.Windows.Forms.DataGridViewTextBoxColumn course_length;
        private System.Windows.Forms.DataGridViewTextBoxColumn course_climb;
        private System.Windows.Forms.DataGridViewTextBoxColumn control_count;
        private System.Windows.Forms.DataGridViewTextBoxColumn course_id;
    }
}