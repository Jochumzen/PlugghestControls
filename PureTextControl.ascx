<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PureTextControl.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.PureTextControl" %>


<asp:Panel ID="pnlOriginalText" runat="server" Visible ="false">
    <h4><asp:Label ID="lblOriginalText" resourcekey="OriginText" runat="server" ></asp:Label></h4>
    <asp:TextBox ID="tbOriginalText" runat="server" Width="530px" Enabled ="false" /><br />
</asp:Panel>

<h4><asp:Label ID="lblCurrentText" resourcekey="CurrentText" runat="server" Visible="false" ></asp:Label></h4>

<asp:Panel ID="pnlTheText" runat="server" >
    <asp:TextBox ID="tbTheText" runat="server" Width="530px" Enabled ="false" /><br />
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