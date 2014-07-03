using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using Plugghest.Base2;

namespace Plugghest.Modules.PlugghestControls
{
    public partial class YouTubeControl : PortalModuleBase
    {
        public int PluggComponentId;
        public string CultureCode;
        public EControlCase Case;
        public int ControlOrder;
        protected void Page_Load(object sender, EventArgs e)
        {
            BaseHandler bh = new BaseHandler();
            YouTube yt = bh.GetYouTubeByComponentId(PluggComponentId);
            if (yt != null && Case != EControlCase.Edit)
                pnlYouTube.Controls.Add(new LiteralControl(yt.GetIframeString(CultureCode)));
            if (Case == EControlCase.ViewAllowEdit)
            {
                pnlEdit.Visible = true;
                hlEdit.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=" + ControlOrder);
            }
            if (Case == EControlCase.Edit)
            {
                btnSave.Visible = true;
                btnCancel.Visible = true;
                pnlYouTubeInput.Visible = true;
                if (yt != null)
                    tbYouTube.Text = yt.YouTubeCode;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            BaseHandler bh = new BaseHandler();
            YouTube yt = bh.GetYouTubeByComponentId(PluggComponentId);
            if (yt == null)
                yt = new YouTube();
            yt.YouTubeTitle = yttitle.Value;
            yt.YouTubeDuration = Convert.ToInt32(ytduration.Value);
            yt.YouTubeCode = ytYouTubeCode.Value;
            yt.YouTubeAuthor = ytAuthor.Value;
            yt.YouTubeCreatedOn = Convert.ToDateTime(ytYouTubeCreatedOn.Value);
            yt.YouTubeComment = ytYouTubeComment.Value;
            yt.PluggComponentId = PluggComponentId;
            bh.SaveYouTube(yt);
            Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
        }
    }
}