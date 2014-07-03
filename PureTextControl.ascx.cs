using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Plugghest.Base2;
using Plugghest.DNN;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Services.Localization;
using System.Text.RegularExpressions;

namespace Plugghest.Modules.PlugghestControls
{
    public partial class PureTextControl : PortalModuleBase
    {
        public int ItemId;
        public string CultureCode;
        public string CreatedInCultureCode;
        public ETextItemType ItemType;
        public EControlCase Case;
        public int ControlOrder;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (ItemType == ETextItemType.PluggDescription)
            {
                tbTheText.TextMode = TextBoxMode.MultiLine;
                tbTheText.Height = 120;
                tbOriginalText.TextMode = TextBoxMode.MultiLine;
                tbOriginalText.Height = 120;                
            }
            BaseHandler bh = new BaseHandler();
            PHText t = bh.GetCurrentVersionText(CultureCode, ItemId, ItemType);
            PHText translatedFrom;
            if (t != null)
                tbTheText.Text = t.Text;
            switch (Case)
            {
                case EControlCase.ViewAllowEdit:
                    pnlEdit.Visible = true;
                    hlEdit.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=" + ControlOrder);
                    break;
                case EControlCase.Edit:
                    tbTheText.Enabled = true;
                    btnSave.Visible = true;
                    btnCancel.Visible = true;
                    if (t != null)
                        tbTheText.Text = t.Text;
                    break;
                case EControlCase.ViewAllowTranslate:
                    if (t != null)
                    {
                        pnlOriginalText.Visible = true;
                        lblCurrentText.Visible = true;
                        if (t.CultureCodeStatus == ECultureCodeStatus.GoogleTranslated)
                        {
                            pnlTranslateFromGoogle.Visible = true;
                            hlTranslateFromGoogle.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=" + ControlOrder);
                            btnGoogleOK.Visible = true;
                        }
                        else
                        {
                            pnlTranslateFromHuman.Visible = true;
                            hlTranslateFromHuman.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=" + ControlOrder);
                        }
                    }
                    translatedFrom = bh.GetCurrentVersionText(CreatedInCultureCode, ItemId, ItemType);
                    if (translatedFrom != null)
                        tbOriginalText.Text = translatedFrom.Text;
                    break;
                case EControlCase.Translate:
                    btnSave.Visible = true;
                    btnCancel.Visible = true;
                    tbTheText.Enabled = true;
                    pnlOriginalText.Visible = true;
                    lblCurrentText.Visible = true;
                    if (t != null)
                        tbTheText.Text = t.Text;
                    translatedFrom = bh.GetCurrentVersionText(CreatedInCultureCode, ItemId, ItemType);
                    if (translatedFrom != null)
                        tbOriginalText.Text = translatedFrom.Text;
                    break;
            }
        }

        protected void btnGoogleOK_Click(object sender, EventArgs e)
        {
            BaseHandler bh = new BaseHandler();
            PHText t = bh.GetCurrentVersionText(CultureCode, ItemId, ItemType);
            if (t != null)
            {
                t.CultureCodeStatus = ECultureCodeStatus.HumanTranslated;
                t.ModifiedByUserId = UserId;
                bh.SavePhText(t);
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=0"));
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            BaseHandler bh = new BaseHandler();
            PHText t = bh.GetCurrentVersionText(CultureCode, ItemId, ItemType);
            if (t == null)
            {
                t = new PHText();
                t.CreatedByUserId = UserId;
                t.CultureCode = CultureCode;
                t.ItemId = ItemId;
                t.ItemType = ItemType;
            }
            t.Text = Regex.Replace(tbTheText.Text, "<[^>]*>", String.Empty); 
            t.ModifiedByUserId = UserId;
            if (Case == EControlCase.Edit)
            {
                bh.SavePhTextInAllCc(t);
                if (ItemType == ETextItemType.PluggTitle)
                {
                    string newPageName = ItemId.ToString() + ": " + t.Text;
                    PluggContainer pc = new PluggContainer(CultureCode, ItemId);
                    DNNHelper h = new DNNHelper();
                    h.RenameTab(pc.ThePlugg.TabId, newPageName);
                }
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
            }
            else if (Case == EControlCase.Translate)
            {
                t.CultureCodeStatus = ECultureCodeStatus.HumanTranslated;
                bh.SavePhText(t);
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=0"));
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (Case == EControlCase.Edit)
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
            else
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=0"));
        }
    }
}