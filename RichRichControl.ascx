<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RichRichControl.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.RichRichControl" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/texteditor.ascx" %>

<asp:Panel ID="pnlOriginalText" runat="server" Visible ="false">
    <h4><asp:Label ID="lblOriginalText" resourcekey="OriginText" runat="server" ></asp:Label></h4>
    <asp:Literal ID="ltOriginalText" runat="server" /><br />
</asp:Panel>

<h4><asp:Label ID="lblCurrentText" resourcekey="CurrentText" runat="server" Visible="false" ></asp:Label></h4>

<asp:Literal ID="TheText" runat="server"></asp:Literal>

<asp:Panel ID="pnlRichRich" runat="server" Visible ="false">
    <dnn:texteditor runat="server" id="richrichtext"></dnn:texteditor>
</asp:Panel>

<asp:Panel ID="pnlEdit" runat="server" Visible ="false">
    <asp:HyperLink ID="hlEdit" resourcekey="Edit" runat="server" /><br />
</asp:Panel>

<asp:Panel ID="pnlTranslateFromGoogle" runat="server" Visible ="false">
    <asp:HyperLink ID="hlTranslateFromGoogle" resourcekey="TranslateGoogle" runat="server" /><br />
</asp:Panel>

<asp:Panel ID="pnlTranslateFromHuman" runat="server" Visible ="false">
    <asp:HyperLink ID="hlTranslateFromHuman" resourcekey="TranslateHuman" runat="server" /><br />
</asp:Panel>

<asp:Button ID="btnGoogleOK" resourcekey ="GoogleOK" runat="server" Visible ="false" OnClick="btnGoogleOK_Click" />
<asp:Button ID="btnSave" resourcekey ="Save" runat="server" Visible ="false" OnClick="btnSave_Click" />&nbsp;
<asp:Button ID="btnCancel" resourcekey ="Cancel" runat="server" Visible ="false" OnClick="btnCancel_Click" />
