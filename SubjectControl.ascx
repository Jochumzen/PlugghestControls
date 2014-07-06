<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SubjectControl.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.SubjectControl" %>

<asp:Label ID="lblSubject" resourcekey="Subject" runat="server" />
<asp:Literal ID="ltSubject" runat="server"></asp:Literal>

<script src="/js/jqTree/tree.jquery.js"></script>
<link href="/js/jqTree/jqtree.css" rel="stylesheet" />

<asp:PlaceHolder ID="phEdit" Visible="false" runat="server">
    <asp:HyperLink ID="hlEdit" Style="float: right;" runat="server" resourcekey="Edit" /><br />
</asp:PlaceHolder>

<asp:PlaceHolder ID="phSelect" Visible="false" runat="server">
    <br />
    <asp:Label ID="lblSelect" runat="server" resourcekey="Select" /><br />
</asp:PlaceHolder>

<asp:HiddenField ID="hdnTreeData" runat="server" Value="" />
<asp:HiddenField ID="hdnGetJosnResult" runat="server" />
<asp:HiddenField ID="hdnNodeSubjectId" runat="server" />

<asp:Literal ID="ltTheTree" runat ="server" Visible ="false" />

<asp:Button ID="btnSave" resourcekey="Save" runat="server" Visible="false" OnClientClick="return getsubjectid();" OnClick="btnSave_Click" />&nbsp;
<asp:Button ID="btnCancel" resourcekey="Cancel" runat="server" Visible="false" OnClick="btnCancel_Click" />


<script type="text/javascript">

    $(document).ready(function () {

        if ($('#tree2') != 'undefined') {
            $('#tree2').tree({
                data: eval($("#" + '<%=hdnTreeData.ClientID%>').attr('value')),
                dragAndDrop: false,
                selectable: true,
                autoEscape: false,
                autoOpen: false
            });
        }


    });

    function getsubjectid() {
        var node = $('#tree2').tree('getSelectedNode');
        var Error = "";

        if (!node)
            Error = 'Please Select Node \n';
        if (Error != "") {
            alert(Error);
            return false;
        }
        $("#<%=hdnNodeSubjectId.ClientID%>").val(node.SubjectId);
    }
</script>
