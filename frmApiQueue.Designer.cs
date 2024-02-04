
namespace h24
{
    partial class frmApiQueue
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
            this.dgApiRequests = new System.Windows.Forms.DataGridView();
            this.link_to = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.link_id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.brRefresh = new System.Windows.Forms.Button();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.cbRefresh = new System.Windows.Forms.CheckBox();
            this.q_id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.q_dtime = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.q_url = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.q_content = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.q_status = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.q_response = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.as_of_date = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.q_header = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.apiqueueBindingSource = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.dgApiRequests)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.apiqueueBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(445, 20);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(161, 29);
            this.label1.TabIndex = 0;
            this.label1.Text = "API requests";
            // 
            // dgApiRequests
            // 
            this.dgApiRequests.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.dgApiRequests.AutoGenerateColumns = false;
            this.dgApiRequests.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgApiRequests.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.q_id,
            this.q_dtime,
            this.q_url,
            this.q_content,
            this.q_status,
            this.q_response,
            this.as_of_date,
            this.link_to,
            this.link_id,
            this.q_header});
            this.dgApiRequests.DataSource = this.apiqueueBindingSource;
            this.dgApiRequests.Location = new System.Drawing.Point(79, 110);
            this.dgApiRequests.Name = "dgApiRequests";
            this.dgApiRequests.RowHeadersWidth = 30;
            this.dgApiRequests.RowTemplate.Height = 28;
            this.dgApiRequests.Size = new System.Drawing.Size(1223, 493);
            this.dgApiRequests.TabIndex = 1;
            // 
            // link_to
            // 
            this.link_to.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.link_to.DataPropertyName = "link_to";
            this.link_to.HeaderText = "Link To";
            this.link_to.MinimumWidth = 8;
            this.link_to.Name = "link_to";
            this.link_to.Width = 96;
            // 
            // link_id
            // 
            this.link_id.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.link_id.DataPropertyName = "link_id";
            this.link_id.HeaderText = "Link ID";
            this.link_id.MinimumWidth = 8;
            this.link_id.Name = "link_id";
            this.link_id.Width = 95;
            // 
            // brRefresh
            // 
            this.brRefresh.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.brRefresh.Location = new System.Drawing.Point(1213, 15);
            this.brRefresh.Name = "brRefresh";
            this.brRefresh.Size = new System.Drawing.Size(89, 34);
            this.brRefresh.TabIndex = 2;
            this.brRefresh.Text = "Refresh";
            this.brRefresh.UseVisualStyleBackColor = true;
            this.brRefresh.Click += new System.EventHandler(this.brRefresh_Click);
            // 
            // timer1
            // 
            this.timer1.Interval = 2000;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // cbRefresh
            // 
            this.cbRefresh.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.cbRefresh.Appearance = System.Windows.Forms.Appearance.Button;
            this.cbRefresh.AutoSize = true;
            this.cbRefresh.Location = new System.Drawing.Point(1213, 65);
            this.cbRefresh.Name = "cbRefresh";
            this.cbRefresh.Size = new System.Drawing.Size(72, 30);
            this.cbRefresh.TabIndex = 3;
            this.cbRefresh.Text = "Update";
            this.cbRefresh.UseVisualStyleBackColor = true;
            this.cbRefresh.CheckedChanged += new System.EventHandler(this.cbRefresh_CheckedChanged);
            // 
            // q_id
            // 
            this.q_id.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.q_id.DataPropertyName = "q_id";
            this.q_id.HeaderText = "ID";
            this.q_id.MinimumWidth = 8;
            this.q_id.Name = "q_id";
            this.q_id.Width = 62;
            // 
            // q_dtime
            // 
            this.q_dtime.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.q_dtime.DataPropertyName = "q_dtime";
            this.q_dtime.HeaderText = "Time";
            this.q_dtime.MinimumWidth = 8;
            this.q_dtime.Name = "q_dtime";
            this.q_dtime.Width = 79;
            // 
            // q_url
            // 
            this.q_url.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.q_url.DataPropertyName = "q_url";
            this.q_url.HeaderText = "URL";
            this.q_url.MinimumWidth = 8;
            this.q_url.Name = "q_url";
            this.q_url.Width = 78;
            // 
            // q_content
            // 
            this.q_content.DataPropertyName = "q_content";
            this.q_content.FillWeight = 87.89063F;
            this.q_content.HeaderText = "q_content";
            this.q_content.MinimumWidth = 8;
            this.q_content.Name = "q_content";
            this.q_content.Width = 150;
            // 
            // q_status
            // 
            this.q_status.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.q_status.DataPropertyName = "q_status";
            this.q_status.HeaderText = "Status";
            this.q_status.MinimumWidth = 8;
            this.q_status.Name = "q_status";
            this.q_status.Width = 92;
            // 
            // q_response
            // 
            this.q_response.DataPropertyName = "q_response";
            this.q_response.FillWeight = 148.3885F;
            this.q_response.HeaderText = "Response";
            this.q_response.MinimumWidth = 8;
            this.q_response.Name = "q_response";
            this.q_response.Width = 253;
            // 
            // as_of_date
            // 
            this.as_of_date.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.as_of_date.DataPropertyName = "as_of_date";
            this.as_of_date.HeaderText = "Last Changed";
            this.as_of_date.MinimumWidth = 8;
            this.as_of_date.Name = "as_of_date";
            this.as_of_date.Width = 145;
            // 
            // q_header
            // 
            this.q_header.DataPropertyName = "q_header";
            this.q_header.FillWeight = 63.72083F;
            this.q_header.HeaderText = "q_header";
            this.q_header.MinimumWidth = 8;
            this.q_header.Name = "q_header";
            this.q_header.Width = 109;
            // 
            // apiqueueBindingSource
            // 
            this.apiqueueBindingSource.DataSource = typeof(h24.api_queue);
            // 
            // frmApiQueue
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1352, 688);
            this.Controls.Add(this.cbRefresh);
            this.Controls.Add(this.brRefresh);
            this.Controls.Add(this.dgApiRequests);
            this.Controls.Add(this.label1);
            this.Name = "frmApiQueue";
            this.Text = "frmApiQueue";
            ((System.ComponentModel.ISupportInitialize)(this.dgApiRequests)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.apiqueueBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgApiRequests;
        private System.Windows.Forms.BindingSource apiqueueBindingSource;
        private System.Windows.Forms.Button brRefresh;
        private System.Windows.Forms.DataGridViewTextBoxColumn q_id;
        private System.Windows.Forms.DataGridViewTextBoxColumn q_dtime;
        private System.Windows.Forms.DataGridViewTextBoxColumn q_url;
        private System.Windows.Forms.DataGridViewTextBoxColumn q_content;
        private System.Windows.Forms.DataGridViewTextBoxColumn q_status;
        private System.Windows.Forms.DataGridViewTextBoxColumn q_response;
        private System.Windows.Forms.DataGridViewTextBoxColumn as_of_date;
        private System.Windows.Forms.DataGridViewTextBoxColumn link_to;
        private System.Windows.Forms.DataGridViewTextBoxColumn link_id;
        private System.Windows.Forms.DataGridViewTextBoxColumn q_header;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.CheckBox cbRefresh;
    }
}
