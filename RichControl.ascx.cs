using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using Plugghest.Base2;
using DotNetNuke.Services.Localization;

namespace Plugghest.Modules.PlugghestControls
{
    public partial class RichControl : PortalModuleBase 
    {
        public int ItemId;
        public string CultureCode;
        public string CreatedInCultureCode;
        public ETextItemType ItemType;
        public EControlCase Case;
        public int ControlOrder;

        protected void Page_Load(object sender, EventArgs e)
        {
            BaseHandler bh = new BaseHandler();
            PHText t = bh.GetCurrentVersionText(CultureCode, ItemId, ItemType);
            PHText translatedFrom;
            if (t != null)
                TheText.Text = t.Text;
            switch (Case)
            {
                case EControlCase.ViewAllowEdit:
                    pnlEdit.Visible = true;
                    hlEdit.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=" + ControlOrder);
                    break;
                case EControlCase.Edit:
                    TheText.Visible = false;
                    btnSave.Visible = true;
                    btnCancel.Visible = true;
                    pnlRichTextbox.Visible = true;
                    if (t != null)
                        hdnrichtext.Value = TheText.Text;
                    break;
                case EControlCase.ViewAllowTranslate:
                    pnlOriginalText.Visible = true;
                    if (t != null)
                    {
                        pnlOriginalText.Visible = true;
                        lblCurrentText.Visible = true;
                        if (t.CultureCodeStatus == ECultureCodeStatus.GoogleTranslated)
                        {
                            pnlTranslateFromGoogle.Visible = true;
                            if (ItemType == ETextItemType.CoursePluggText)
                                hlTranslateFromGoogle.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translatecp=" + ControlOrder, "cp=" + ItemId);
                            else
                                hlTranslateFromGoogle.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=" + ControlOrder);
                            btnGoogleOK.Visible = true;
                        }
                        else
                        {
                            pnlTranslateFromHuman.Visible = true;
                            if (ItemType == ETextItemType.CoursePluggText)
                                hlTranslateFromHuman.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translatecp=" + ControlOrder, "cp=" + ItemId);
                            else
                                hlTranslateFromHuman.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=" + ControlOrder);
                        }
                    }
                    translatedFrom = bh.GetCurrentVersionText(CreatedInCultureCode, ItemId, ItemType);
                    if (translatedFrom != null)
                        ltOriginalText.Text = translatedFrom.Text;
                    break;
                case EControlCase.Translate:
                    pnlOriginalText.Visible = true;
                    btnSave.Visible = true;
                    btnCancel.Visible = true;
                    pnlRichTextbox.Visible = true;
                    lblCurrentText.Visible = true;
                    TheText.Visible = false;
                    if (t != null)
                        hdnrichtext.Value = TheText.Text;
                    translatedFrom = bh.GetCurrentVersionText(CreatedInCultureCode, ItemId, ItemType);
                    if (translatedFrom != null)
                        ltOriginalText.Text = translatedFrom.Text;
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
                if (ItemType == ETextItemType.CoursePluggText)
                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "cp=" + ItemId));
                else
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
            t.Text = System.Net.WebUtility.HtmlDecode(hdnrichtext.Value);
            t.ModifiedByUserId = UserId;
            if (Case == EControlCase.Edit)
            {
                bh.SavePhTextInAllCc(t);
                if (ItemType == ETextItemType.CoursePluggText)
                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "cp=" + ItemId));
                else
                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
            }
            else if (Case == EControlCase.Translate)
            {
                t.CultureCodeStatus = ECultureCodeStatus.HumanTranslated;
                bh.SavePhText(t);
                if (ItemType == ETextItemType.CoursePluggText)
                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "cp=" + ItemId));
                else
                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=0"));
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if(ItemType== ETextItemType.CoursePluggText)
            {
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "cp=" + ItemId));
            }
            if (Case == EControlCase.Edit)
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0"));
            else
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=0"));
        }
    }
}