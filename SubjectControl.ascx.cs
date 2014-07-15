using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using Plugghest.Base2;
using DotNetNuke.Services.Localization;
using System.Web.Script.Serialization;
using System.Text;
using System.Collections.Specialized;


namespace Plugghest.Modules.PlugghestControls
{
    public partial class SubjectControl : PortalModuleBase
    {
        public ESubjectCase SubjectCase;
        public int SubjectId;
        public int ItemId;
        public string CultureCode;
        public EControlCase Case;
        public int ControlOrder;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (SubjectId == 0)
                ltSubject.Text = Localization.GetString("NoSubject", LocalResourceFile);
            else
            {
                BaseHandler bh = new BaseHandler();
                var SubList = bh.GetSubjectsAsFlatList(CultureCode);
                ltSubject.Text = bh.GetSubjectString(CultureCode, SubjectId);
            }
            if (Case == EControlCase.ViewAllowEdit)
            {
                phEdit.Visible = true;
                hlEdit.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=" + ControlOrder);
            }
            if (Case == EControlCase.Edit)
            {
                btnSave.Visible = true;
                btnCancel.Visible = true;
                phSelect.Visible = true;
                ltTheTree.Visible = true;
                ltTheTree.Text = "<div class=\"tree\"><div id=\"tree2\"></div></div><br />";
                BaseHandler bh = new BaseHandler();
                var tree = bh.GetSubjectsAsTree(CultureCode);
                JavaScriptSerializer TheSerializer = new JavaScriptSerializer();
                hdnTreeData.Value = TheSerializer.Serialize(tree);
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            switch (SubjectCase )
            {
                case ESubjectCase.Plugg:
                    PluggContainer pc = new PluggContainer(CultureCode, ItemId);
                    if (pc.ThePlugg != null && pc.ThePlugg.PluggId != 0)
                    {
                        pc.ThePlugg.SubjectId = Convert.ToInt32(hdnNodeSubjectId.Value);
                        pc.UpdatePluggEntity();
                    }
                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
                    break;
                case ESubjectCase.Course:
                    CourseContainer cc = new CourseContainer(CultureCode, ItemId);
                    if (cc.TheCourse != null && cc.TheCourse.CourseId != 0)
                    {
                        cc.TheCourse.SubjectId = Convert.ToInt32(hdnNodeSubjectId.Value);
                        cc.UpdateCourseEntity();
                    }
                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
                    break;
                case ESubjectCase.NotSet:
                    throw new Exception("Subject case not set");
                    break;
            }

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
        }
    }
}