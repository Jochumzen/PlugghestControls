using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Plugghest.Base2;
using DotNetNuke.Data;
using System.Data;

namespace Plugghest.Modules.PlugghestControls
{
    public partial class SearhList : System.Web.UI.UserControl
    {
        private string _keyword;
        public string searchInfo
        {
            get
            {
                if (null != Request.QueryString["search_keyword"])
                {
                    _keyword = Request.QueryString["search_keyword"];
                    return _keyword;
                }
                else
                    return string.Empty;
            }
        }

        public IEnumerable<advancesearch> DataSource
        {
            set
            {
                rptSearchResult.DataSource = value;
                rptSearchResult.DataBind();
            }
        }


        private string CurrentLanguage
        {
            get
            {
                return (Page as DotNetNuke.Framework.PageBase).PageCulture.Name;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string evaluateRedirectURL(int tabid)
        {
            return DotNetNuke.Common.Globals.NavigateURL(tabid, "", new string[] { "language=" + this.CurrentLanguage });
        }

        public string getSubjectByID(int subjectId)
        {
            if (subjectId == 0 || subjectId == -1)
                return "No subject";
            BaseHandler bh = new BaseHandler();
            return bh.GetSubjectString("en-US", subjectId);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

            using (IDataContext ctx = DataContext.Instance())
            {
                this.DataSource = ctx.ExecuteQuery<advancesearch>(CommandType.StoredProcedure, "advSearch",
                                                                                         ddlPluggorCourse.SelectedValue,
                                                                                         Convert.ToInt16(ddlLanguage.SelectedValue) == 0 ? "" : this.CurrentLanguage,
                                                                                         txtTitle.Text.StartsWith("\"") && txtTitle.Text.StartsWith("\"") ? txtTitle.Text.Replace("\"", "") : txtTitle.Text,
                                                                                         txtTitle.Text.StartsWith("\"") ? 1 : 0,
                                                                                         txtSubject.Text,
                                                                                         txtDisplayName.Value,
                                                                                         txtPluggCourseContaining.Text
                                                                                         );
            }
        }
    }

    public class advancesearch
    {
        public int TestId { get; set; }
        public int PluggId { get; set; }
        public int CourseId { get; set; }
        public int TabID { get; set; }
        public int CourseTabID { get; set; }
        public int PluggRatingsModuleId { get; set; }
        public int CourseRatingsModuleId { get; set; }
        public int SubjectId { get; set; }
        public int Type { get; set; }
        public int AuthorId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string DisplayName { get; set; }
    }
}