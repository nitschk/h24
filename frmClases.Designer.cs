
namespace h24
{
    partial class frmClases
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.dgCategories = new System.Windows.Forms.DataGridView();
            this.teamsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.teamsDataGridView = new System.Windows.Forms.DataGridView();
            this.dataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewCheckBoxColumn1 = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.categoriesBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.catidDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.catnameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.first_start_number = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.catstarttimeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cattimelimitDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.validDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.force_order = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.asofdateDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.teamsDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dgCategories)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.teamsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.teamsDataGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.categoriesBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // dgCategories
            // 
            this.dgCategories.AutoGenerateColumns = false;
            this.dgCategories.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgCategories.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.catidDataGridViewTextBoxColumn,
            this.catnameDataGridViewTextBoxColumn,
            this.first_start_number,
            this.catstarttimeDataGridViewTextBoxColumn,
            this.cattimelimitDataGridViewTextBoxColumn,
            this.validDataGridViewTextBoxColumn,
            this.force_order,
            this.asofdateDataGridViewTextBoxColumn,
            this.teamsDataGridViewTextBoxColumn});
            this.dgCategories.DataSource = this.categoriesBindingSource;
            this.dgCategories.Location = new System.Drawing.Point(43, 33);
            this.dgCategories.Name = "dgCategories";
            this.dgCategories.RowHeadersWidth = 51;
            this.dgCategories.RowTemplate.Height = 24;
            this.dgCategories.Size = new System.Drawing.Size(671, 209);
            this.dgCategories.TabIndex = 0;
            this.dgCategories.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgCategories_CellEndEdit);
            // 
            // teamsBindingSource
            // 
            this.teamsBindingSource.DataMember = "teams";
            this.teamsBindingSource.DataSource = this.categoriesBindingSource;
            // 
            // teamsDataGridView
            // 
            this.teamsDataGridView.AutoGenerateColumns = false;
            this.teamsDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.teamsDataGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.dataGridViewTextBoxColumn1,
            this.dataGridViewCheckBoxColumn1});
            this.teamsDataGridView.DataSource = this.teamsBindingSource;
            this.teamsDataGridView.Location = new System.Drawing.Point(200, 317);
            this.teamsDataGridView.Name = "teamsDataGridView";
            this.teamsDataGridView.RowHeadersWidth = 51;
            this.teamsDataGridView.RowTemplate.Height = 24;
            this.teamsDataGridView.Size = new System.Drawing.Size(514, 291);
            this.teamsDataGridView.TabIndex = 1;
            // 
            // dataGridViewTextBoxColumn1
            // 
            this.dataGridViewTextBoxColumn1.DataPropertyName = "Count";
            this.dataGridViewTextBoxColumn1.HeaderText = "Count";
            this.dataGridViewTextBoxColumn1.MinimumWidth = 6;
            this.dataGridViewTextBoxColumn1.Name = "dataGridViewTextBoxColumn1";
            this.dataGridViewTextBoxColumn1.ReadOnly = true;
            this.dataGridViewTextBoxColumn1.Width = 125;
            // 
            // dataGridViewCheckBoxColumn1
            // 
            this.dataGridViewCheckBoxColumn1.DataPropertyName = "IsReadOnly";
            this.dataGridViewCheckBoxColumn1.HeaderText = "IsReadOnly";
            this.dataGridViewCheckBoxColumn1.MinimumWidth = 6;
            this.dataGridViewCheckBoxColumn1.Name = "dataGridViewCheckBoxColumn1";
            this.dataGridViewCheckBoxColumn1.ReadOnly = true;
            this.dataGridViewCheckBoxColumn1.Width = 125;
            // 
            // categoriesBindingSource
            // 
            this.categoriesBindingSource.DataSource = typeof(h24.categories);
            // 
            // catidDataGridViewTextBoxColumn
            // 
            this.catidDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.catidDataGridViewTextBoxColumn.DataPropertyName = "cat_id";
            this.catidDataGridViewTextBoxColumn.HeaderText = "cat_id";
            this.catidDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.catidDataGridViewTextBoxColumn.Name = "catidDataGridViewTextBoxColumn";
            this.catidDataGridViewTextBoxColumn.Visible = false;
            this.catidDataGridViewTextBoxColumn.Width = 75;
            // 
            // catnameDataGridViewTextBoxColumn
            // 
            this.catnameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.catnameDataGridViewTextBoxColumn.DataPropertyName = "cat_name";
            dataGridViewCellStyle1.Format = "dd. MM. yyyy HH:mm:ss";
            this.catnameDataGridViewTextBoxColumn.DefaultCellStyle = dataGridViewCellStyle1;
            this.catnameDataGridViewTextBoxColumn.HeaderText = "Category Name";
            this.catnameDataGridViewTextBoxColumn.MinimumWidth = 12;
            this.catnameDataGridViewTextBoxColumn.Name = "catnameDataGridViewTextBoxColumn";
            this.catnameDataGridViewTextBoxColumn.Width = 124;
            // 
            // first_start_number
            // 
            this.first_start_number.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.first_start_number.DataPropertyName = "first_start_number";
            this.first_start_number.HeaderText = "First Start Number";
            this.first_start_number.MinimumWidth = 6;
            this.first_start_number.Name = "first_start_number";
            this.first_start_number.Width = 139;
            // 
            // catstarttimeDataGridViewTextBoxColumn
            // 
            this.catstarttimeDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.catstarttimeDataGridViewTextBoxColumn.DataPropertyName = "cat_start_time";
            this.catstarttimeDataGridViewTextBoxColumn.HeaderText = "Start Time";
            this.catstarttimeDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.catstarttimeDataGridViewTextBoxColumn.Name = "catstarttimeDataGridViewTextBoxColumn";
            this.catstarttimeDataGridViewTextBoxColumn.Width = 94;
            // 
            // cattimelimitDataGridViewTextBoxColumn
            // 
            this.cattimelimitDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.cattimelimitDataGridViewTextBoxColumn.DataPropertyName = "cat_time_limit";
            this.cattimelimitDataGridViewTextBoxColumn.HeaderText = "Time Limit";
            this.cattimelimitDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.cattimelimitDataGridViewTextBoxColumn.Name = "cattimelimitDataGridViewTextBoxColumn";
            this.cattimelimitDataGridViewTextBoxColumn.Width = 93;
            // 
            // validDataGridViewTextBoxColumn
            // 
            this.validDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.validDataGridViewTextBoxColumn.DataPropertyName = "valid";
            this.validDataGridViewTextBoxColumn.HeaderText = "Valid";
            this.validDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.validDataGridViewTextBoxColumn.Name = "validDataGridViewTextBoxColumn";
            this.validDataGridViewTextBoxColumn.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.validDataGridViewTextBoxColumn.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.validDataGridViewTextBoxColumn.Width = 68;
            // 
            // force_order
            // 
            this.force_order.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.force_order.DataPropertyName = "force_order";
            this.force_order.HeaderText = "force order";
            this.force_order.MinimumWidth = 6;
            this.force_order.Name = "force_order";
            this.force_order.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.force_order.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.force_order.Width = 99;
            // 
            // asofdateDataGridViewTextBoxColumn
            // 
            this.asofdateDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.asofdateDataGridViewTextBoxColumn.DataPropertyName = "as_of_date";
            this.asofdateDataGridViewTextBoxColumn.HeaderText = "as_of_date";
            this.asofdateDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.asofdateDataGridViewTextBoxColumn.Name = "asofdateDataGridViewTextBoxColumn";
            this.asofdateDataGridViewTextBoxColumn.Visible = false;
            this.asofdateDataGridViewTextBoxColumn.Width = 108;
            // 
            // teamsDataGridViewTextBoxColumn
            // 
            this.teamsDataGridViewTextBoxColumn.DataPropertyName = "teams";
            this.teamsDataGridViewTextBoxColumn.HeaderText = "teams";
            this.teamsDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.teamsDataGridViewTextBoxColumn.Name = "teamsDataGridViewTextBoxColumn";
            this.teamsDataGridViewTextBoxColumn.Visible = false;
            this.teamsDataGridViewTextBoxColumn.Width = 125;
            // 
            // frmClases
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(959, 628);
            this.Controls.Add(this.teamsDataGridView);
            this.Controls.Add(this.dgCategories);
            this.Name = "frmClases";
            this.Text = "frmClases";
            this.Load += new System.EventHandler(this.frmClases_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgCategories)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.teamsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.teamsDataGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.categoriesBindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dgCategories;
        private System.Windows.Forms.BindingSource categoriesBindingSource;
        private System.Windows.Forms.BindingSource teamsBindingSource;
        private System.Windows.Forms.DataGridView teamsDataGridView;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewCheckBoxColumn dataGridViewCheckBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn catidDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn catnameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn first_start_number;
        private System.Windows.Forms.DataGridViewTextBoxColumn catstarttimeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn cattimelimitDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn validDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn force_order;
        private System.Windows.Forms.DataGridViewTextBoxColumn asofdateDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn teamsDataGridViewTextBoxColumn;
    }
}