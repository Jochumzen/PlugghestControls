<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="YouTubeControl.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.YouTubeControl" %>

<asp:HiddenField ID="hdnlabel" runat="server" />
<asp:HiddenField ID="yttitle" runat="server" />
<asp:HiddenField ID="ytduration" runat="server" />
<asp:HiddenField ID="ytYouTubeCode" runat="server" />
<asp:HiddenField ID="ytAuthor" runat="server" />
<asp:HiddenField ID="ytYouTubeCreatedOn" runat="server" />
<asp:HiddenField ID="ytYouTubeComment" runat="server" />

<asp:Panel ID="pnlYouTubeInput" runat="server" Visible="false">
    <asp:Label ID="lblYouTube" runat="server" Text="YouTube: " />&nbsp;&nbsp;
    <asp:TextBox ID="tbYouTube" runat="server" Width="369px" />&nbsp;
    <input type="button" id="btnGetYoutubeVideo" value="Get Video" onclick="CheckURL(this);" />
    <p class="title"></p>
    <p class="duration"></p>
    <p class="YouTubeCode"></p>
    <p class="Author"></p>
    <p class="YouTubeCreatedOn"></p>
    <p class="YouTubeComment"></p>

    <script type="text/javascript">
        function CheckURL(Control) {
            var code = "";
            var url = $($(Control).parent()).find('input[type=text]').val();
            if (url.length == 11) {
                code = url;
            }
            else if (url.indexOf("www.youtube.com") > -1) {
                code = url.substr(url.length - 11, 11);
            }
            else {
                alert("Invalid URL");
            }

            if ($(Control).parent().find("iframe").length > 0) {
                $(Control).parent().find("iframe").remove();
            }
            $($($(Control).parent()).find("input[type=button]")).after("  <iframe style='display: block' width='420' height='345'src='http://www.youtube.com/embed/" + code + "'></iframe>");
            $.getJSON('http://gdata.youtube.com/feeds/api/videos/' + code + '?v=2&alt=jsonc', function (data, status, xhr) {
                $($($(Control).parent()).find(".title")).html("Title: <span id='title'>" + data.data.title + "</span><br />");
                $($($(Control).parent()).find(".duration")).html("Duration :<span id='duration'>" + data.data.duration + "</span> Seconds<br />");
                $($($(Control).parent()).find(".YouTubeCode")).html("YouTube Code: <span id='YouTubeCode'>" + data.data.id + "</span><br />");
                $($($(Control).parent()).find(".Author")).html("Author: <span id='Author'>" + data.data.uploader + "</span><br />");
                $($($(Control).parent()).find(".YouTubeCreatedOn")).html("YouTube CreatedOn: <span id='YouTubeCreatedOn'>" + data.data.uploaded + "</span><br />");
                $($($(Control).parent()).find(".YouTubeComment")).html("YouTube Author Comment: <span id='YouTubeComment'>" + data.data.description + "</span><br />");
            });
        };

        function getYt() {
            var a = $("#title").text();
            $("#" + '<%=yttitle.ClientID%>').val(a);
            $("#" + '<%=ytduration.ClientID%>').val($("#duration").text());
            $("#" + '<%=ytYouTubeCode.ClientID%>').val($("#YouTubeCode").text());
            $("#" + '<%=ytAuthor.ClientID%>').val($("#Author").text());
            $("#" + '<%=ytYouTubeCreatedOn.ClientID%>').val($("#YouTubeCreatedOn").text());
            $("#" + '<%=ytYouTubeComment.ClientID%>').val($("#YouTubeComment").text());
        }


    </script>
    <asp:Button ID="btnSave" resourcekey="Save" runat="server" Visible="false" OnClientClick="getYt()" OnClick="btnSave_Click" />&nbsp;
    <asp:Button ID="btnCancel" resourcekey="Cancel" runat="server" Visible="false" OnClick="btnCancel_Click" />

</asp:Panel>

<asp:Panel ID="pnlYouTube" runat="server"></asp:Panel>




<asp:Panel ID="pnlYouTubeInfo" runat="server" CssClass="classHide">
    <asp:Label ID="lblYTTitle" runat="server" resourcekey="YTTitle" Font-Bold="True"></asp:Label>
    <asp:Label ID="lblTheYTTitle" runat="server" ></asp:Label><br />
    <asp:Label ID="lblYTAuthor" runat="server" resourcekey="YTAuthor" Font-Bold="True"></asp:Label>
    <asp:Label ID="lblTheYTAuthor" runat="server" ></asp:Label><br />
    <asp:Label ID="lblYTText" runat="server" resourcekey="YTText" Font-Bold="True"></asp:Label>
    <asp:Label ID="lblTheYTText" runat="server" ></asp:Label><br />
</asp:Panel>

<asp:HyperLink ID="lnkShowInfo" runat="server" Text="Show YouTube information" Style="cursor: pointer;" Visible ="false"></asp:HyperLink>

<asp:Panel ID="pnlEdit" runat="server" Visible="false">
    <asp:HyperLink ID="hlEdit" resourcekey="Edit" runat="server" /><br />
</asp:Panel>

<script>
    $(document).delegate('#<%= lnkShowInfo.ClientID%>', 'click', function (e) {
        var element = $('#<%= pnlYouTubeInfo.ClientID %>');
        var link = $('#<%= lnkShowInfo.ClientID %>');
        if ($(element).hasClass('classShow')) {
            $(element).removeClass('classShow');
            $(element).addClass('classHide');
            $(link).html('Show');
        }
        else if ($(element).hasClass('classHide')) {
            $(element).removeClass('classHide');
            $(element).addClass('classShow');
            $(link).html('Hide');
        }
    });

</script>

<style>
    .classShow {
        display: block;
    }

    .classHide {
        display: none;
    }
</style>


