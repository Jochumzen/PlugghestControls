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


namespace Plugghest.Modules.PlugghestControls
{
    public partial class SubjectControl : PortalModuleBase
    {
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
                var SubList = bh.GetSubjectsAsTree(CultureCode);
                Subject s = bh.FindSubject(SubList, SubjectId);
                StringBuilder theS = new StringBuilder(s.label);
                while (s.MotherId != 0)
                {
                    s = s.Mother;
                    theS.Insert(0, s.label + " <span class=\"glyphicons glyph-right-arrow\"></span> ");
                }
                ltSubject.Text = theS.ToString();
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
                ltTheTree.Text = "<div class=\"tree\"><div id=\"tree2\"></div></div>";
                BaseHandler bh = new BaseHandler();
                var tree = bh.GetSubjectsAsTree(CultureCode);
                JavaScriptSerializer TheSerializer = new JavaScriptSerializer();
                hdnTreeData.Value = TheSerializer.Serialize(tree);
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            PluggContainer pc = new PluggContainer(CultureCode, ItemId);
            if (pc.ThePlugg != null && pc.ThePlugg.PluggId != 0)
            {
                pc.ThePlugg.SubjectId = Convert.ToInt32(hdnNodeSubjectId.Value);
                pc.UpdatePluggEntity();
            }
            Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
        }
    }
}