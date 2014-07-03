using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Plugghest.Base2;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Services.Localization;

namespace Plugghest.Modules.PlugghestControls
{
    public partial class LatexControl : PortalModuleBase
    {
        public int ItemId;
        public string CultureCode;
        public string CreatedInCultureCode;
        public ELatexItemType ItemType;
        public EControlCase Case;
        public int ControlOrder;

        protected void Page_Load(object sender, EventArgs e)
        {
            BaseHandler bh = new BaseHandler();
            PHLatex t = bh.GetCurrentVersionLatexText(CultureCode, ItemId, ItemType);
            PHLatex translatedFrom;
            if (t != null)
                ltTheText.Text = t.HtmlText;
            switch (Case)
            {
                case EControlCase.ViewAllowEdit:
                    pnlEdit.Visible = true;
                    hlEdit.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=" + ControlOrder);
                    break;
                case EControlCase.Edit:
                    lblCurrentText.Visible = true;
                    pnlTheText.Visible = false;
                    pnlEnterLatex.Visible = true;
                    if (t != null)
                        tbEnterLatex.Text = t.Text;
                    btnSave.Visible = true;
                    btnCancel.Visible = true;
                    break;
                case EControlCase.ViewAllowTranslate:
                    lblCurrentText.Visible = true;
                    pnlOriginalText.Visible = true;
                    if (t != null)
                    {
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
                    translatedFrom = bh.GetCurrentVersionLatexText(CreatedInCultureCode, ItemId, ItemType);
                    if (translatedFrom != null)
                        ltOriginalText.Text = translatedFrom.HtmlText;

                    break;
                case EControlCase.Translate:
                    lblCurrentText.Visible = true;
                    pnlTheText.Visible = false;
                    pnlOriginalText.Visible = true;
                    pnlTranslate.Visible = true;
                    btnSave.Visible = true;
                    btnCancel.Visible = true;
                    if (t != null)
                        teTranslate.Text = t.HtmlText;
                    translatedFrom = bh.GetCurrentVersionLatexText(CreatedInCultureCode, ItemId, ItemType);
                    if (translatedFrom != null)
                        ltOriginalText.Text = translatedFrom.HtmlText;
                    break;
            }
        }

        protected void btnGoogleOK_Click(object sender, EventArgs e)
        {
            BaseHandler bh = new BaseHandler();
            PHLatex t = bh.GetCurrentVersionLatexText(CultureCode, ItemId, ItemType);
            if (t != null)
            {
                t.CultureCodeStatus = ECultureCodeStatus.HumanTranslated;
                t.ModifiedByUserId = UserId;
                bh.SaveLatexText(t);
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=0"));
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            BaseHandler bh = new BaseHandler();
            PHLatex t = bh.GetCurrentVersionLatexText(CultureCode, ItemId, ItemType);
            if (t == null)
            {
                t = new PHLatex();
                t.CreatedByUserId = UserId;
                t.CultureCode = CultureCode;
                t.ItemId = ItemId;
                t.ItemType = ItemType;
            }
            t.ModifiedByUserId = UserId;
            if (Case == EControlCase.Edit)
            {
                t.Text = tbEnterLatex.Text;
                t.HtmlText = "";
                bh.SaveLatexTextInAllCc(t);
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
            }
            else if (Case == EControlCase.Translate)
            {
                PHLatex translatedFrom = bh.GetCurrentVersionLatexText(CreatedInCultureCode, ItemId, ItemType);
                if (translatedFrom != null)
                {
                    t.Text = translatedFrom.Text;
                    t.HtmlText = System.Net.WebUtility.HtmlDecode(teTranslate.Text);
                    t.CultureCodeStatus = ECultureCodeStatus.HumanTranslated;
                    bh.SaveLatexText(t);
                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=0"));
                }
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