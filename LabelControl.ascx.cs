﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Plugghest.Base2;
using DotNetNuke.Entities.Modules;
using System.Text.RegularExpressions;

namespace Plugghest.Modules.PlugghestControls
{

    public partial class LabelControl : PortalModuleBase
    {
        public int ItemId;
        public string CultureCode;
        public string CreatedInCultureCode;
        public ETextItemType ItemType;
        public EControlCase Case;
        public int ControlOrder;
        public string AttachQS;

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
                    hlEdit.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=" + ControlOrder, AttachQS);
                    break;
                case EControlCase.Edit:
                    TheText.Visible = false;
                    btnSave.Visible = true;
                    btnCancel.Visible = true;
                    pnlEditText.Visible = true;
                    if (t != null)
                    {
                        if(TheText.Text[0]=='<')
                        {
                            ddlHeadingType.SelectedIndex = Convert.ToInt16(TheText.Text.Substring(2, 1));
                            tbTheText.Text = TheText.Text.Remove(TheText.Text.Length - 5).Remove(0, 4);
                        }
                        else
                        {
                            ddlHeadingType.SelectedIndex = 0;
                            tbTheText.Text = TheText.Text;
                        }
                    }
                    break;
                case EControlCase.ViewAllowTranslate:
                    pnlOriginalText.Visible = true;
                    if (t != null)
                    {
                        lblCurrentText.Visible = true;
                        if (t.CultureCodeStatus == ECultureCodeStatus.GoogleTranslated)
                        {
                            pnlTranslateFromGoogle.Visible = true;
                            hlTranslateFromGoogle.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translatecp=" + ControlOrder, AttachQS);
                            btnGoogleOK.Visible = true;
                        }
                        else
                        {
                            pnlTranslateFromHuman.Visible = true;
                            hlTranslateFromHuman.NavigateUrl = DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translatecp=" + ControlOrder, AttachQS);
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
                    lblCurrentText.Visible = true;
                    pnlEditText.Visible = true;
                    TheText.Visible = false;
                    ddlHeadingType.Enabled  = false;
                    if (t != null)
                    {
                        if (TheText.Text[0] == '<')
                        {
                            ddlHeadingType.SelectedIndex = Convert.ToInt16(TheText.Text.Substring(2, 1));
                            tbTheText.Text = TheText.Text.Remove(TheText.Text.Length - 5).Remove(0, 4);
                        }
                        else
                        {
                            ddlHeadingType.SelectedIndex = 0;
                            tbTheText.Text = TheText.Text;
                        }
                    }                   
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
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", AttachQS));
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
            if (ddlHeadingType.SelectedIndex > 0)
            {
                t.Text = "<h" + ddlHeadingType.SelectedIndex.ToString() + ">" + t.Text + "</h" + ddlHeadingType.SelectedIndex.ToString() + ">";
            }
            t.ModifiedByUserId = UserId;
            if (Case == EControlCase.Edit)
            {
                bh.SavePhTextInAllCc(t);
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", AttachQS));
            }
            else if (Case == EControlCase.Translate)
            {
                t.CultureCodeStatus = ECultureCodeStatus.HumanTranslated;
                bh.SavePhText(t);
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", AttachQS));
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (Case == EControlCase.Edit)
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "edit=0", AttachQS ));
            else
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(TabId, "", "translate=0", AttachQS));
        }
    }
}