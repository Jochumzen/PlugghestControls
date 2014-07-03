<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LatexControl.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.LatexControl" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/texteditor.ascx" %>

<asp:Panel ID="pnlOriginalText" runat="server" Visible ="false">
    <h4><asp:Label ID="lblOriginalText" resourcekey="OriginText" runat="server" ></asp:Label></h4>
    <asp:Literal ID="ltOriginalText" runat="server" /><br />
</asp:Panel>

<h4><asp:Label ID="lblCurrentText" resourcekey="CurrentText" runat="server" Visible="false" ></asp:Label></h4>

<asp:Panel ID="pnlTheText" runat="server" >
    <asp:Literal ID="ltTheText" runat="server" /><br />
</asp:Panel>

<asp:Panel ID="pnlEnterLatex" runat="server" Visible="false">
    <asp:Textbox ID="tbEnterLatex" runat="server" Height="120px" TextMode="MultiLine" Width="530px" /><br />
</asp:Panel>

<asp:Panel ID="pnlTranslate" runat="server" Visible ="false">
    <dnn:texteditor runat="server" id="teTranslate"></dnn:texteditor>
</asp:Panel>

<asp:Panel ID="pnlEdit" runat="server" Visible ="false" >
    <asp:HyperLink ID="hlEdit" resourcekey="Edit" runat="server" /><br />
</asp:Panel>

<asp:Panel ID="pnlTranslateFromGoogle" runat="server" Visible ="false" >
    <asp:HyperLink ID="hlTranslateFromGoogle" resourcekey="TranslateGoogle" runat="server" /><br />
</asp:Panel>

<asp:Panel ID="pnlTranslateFromHuman" runat="server" Visible ="false" >
    <asp:HyperLink ID="hlTranslateFromHuman" resourcekey="TranslateHuman" runat="server" /><br />
</asp:Panel>

<asp:Button ID="btnGoogleOK" resourcekey ="GoogleOK" runat="server" Visible ="false" OnClick="btnGoogleOK_Click" />
<asp:Button ID="btnSave" resourcekey ="Save" runat="server" Visible ="false" OnClick="btnSave_Click" />&nbsp;
<asp:Button ID="btnCancel" resourcekey ="Cancel" runat="server" Visible ="false" OnClick="btnCancel_Click" />