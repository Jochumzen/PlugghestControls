<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearhList.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.SearhList" %>
<link href="http://dnndev.me/Script/dataTable/jquery.dataTables.css" rel="stylesheet" />
<script type="text/javascript" src="http://dnndev.me/Script/dataTable/jquery.dataTables.js"></script>
<script>
    $(document).delegate('span.discriptiontoggle', 'click', function () {
        if ($(this).hasClass("collapsed-text")) {
            $(this).css("display", "none");
            $(this).prev("span").css("display", "block");
            $(this).closest('.expandable').find('.expandable-content').css('height', '30px');

        }
        if ($(this).hasClass("expanded-text")) {
            $(this).css("display", "none");
            $(this).next("span").css("display", "block");
            $(this).closest('.expandable').find('.expandable-content').css('height', 'auto');
        }
    });
</script>

<div class="mod booklist">
    <div>
    <asp:DropDownList ID="ddlPluggorCourse" runat="server">
        <asp:ListItem Text="Plugg and Course" Value="0"></asp:ListItem>
        <asp:ListItem Text="Pluggs" Value="1"></asp:ListItem>
        <asp:ListItem Text="Courses" Value="2"></asp:ListItem>
    </asp:DropDownList><br />

    <asp:DropDownList ID="ddlLanguage" runat="server">
        <asp:ListItem Text="Any Language" Value="0"></asp:ListItem>
        <asp:ListItem Text="Current Language" Value="1"></asp:ListItem>
    </asp:DropDownList><br />


    <asp:Label runat="server" ID="lblTitle" Text="Title"></asp:Label>
    <asp:TextBox runat="server" ID="txtTitle"></asp:TextBox><br />
    <asp:Label runat="server" ID="lblSubject" Text="Subject"></asp:Label>
    <asp:TextBox runat="server" ID="txtSubject"></asp:TextBox><br />
    <asp:Button ID="btnSearch" runat="server" Text="Searh" OnClick="btnSearch_Click"/>
</div>


    <div class="inner">
        <div class="bd">
            <asp:Repeater ID="rptSearchResult" runat="server">
                <HeaderTemplate>
                    <table class="dataTable dt">
                </HeaderTemplate>
                <ItemTemplate>
                    <tr class='item'>
                        <td>
                            <div class='media product '>
                                <div class='price-container right'>
                                    <div class='left inner-right'>
                                        <div style='display: block;' class='dcc_rnc_CLSelector' co_type='Q' apppath='' ratingmode='ratings' moduleid='<%#  (int)Eval("Type") ==1?Eval("PluggRatingsModuleId"):Eval("CourseRatingsModuleId") %>'
                                            co_val='tabid:<%# Eval("TabID") %>'>
                                            <!-- User customizable content starts -->
                                            <table border='0' cellspacing='0' cellpadding='3'>
                                                <tr>
                                                    <td colspan='1'>
                                                        <img src='[PRC_AVERAGERATINGIMAGE]' alt='Avg. Rating [PRC_AVERAGERATINGVALUE]' title='Avg. Rating [PRC_AVERAGERATINGVALUE]'>
                                                    </td>
                                                    <td style='font-family: Tahoma; font-size: 10px; font-weight: bold; color: #000000; white-space: nowrap;'>[PRC_TOTALRATINGS]
                                                        <asp:Label ID="lblRatings" runat="server" Text="Rating(s)" meta:resourcekey="lblRatingsResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <!-- User customizable content ends -->
                                        </div>
                                    </div>
                                </div>
                                <figure class='img'>
                                    <a href='/e-bok/9781446209424/good-essay-writing'>
                                        <img width='66px' height='97px' src='https://image.bokus.com/images2/9781446209424_small' alt='Good Essay Writing'>
                                    </a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </figure>
                                <div class='bd'>
                                    <ul class='verticalList no-margin'>
                                        <li>
                                            <ul class='booklist-rating'>
                                                <li class='booklist-top'>
                                                    <h3 class='booklist-title'>
                                                        <a href='<%# evaluateRedirectURL(Convert.ToInt16( Eval("TabID"))) %>'><%# Eval("Text")%> </a>
                                                     <img src='<%#ResolveUrl((int)Eval("Type") == 1 ? "~\\images\\Courses.png" : "~\\images\\icon_extensions_24px.gif" ) %>' width="16px" />
                                                    </h3>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <h3 class='booklist-title'>
                                                <a href='#'>&nbsp;&nbsp;</a>
                                            </h3>
                                        </li>
                                        <li>
                                            <h4 class='booklist-author'>
                                                <asp:Label ID="lblAuthor" runat="server" Text="Author :" meta:resourcekey="lblAuthorResource1"></asp:Label>
                                                <a href='/Activity-Feed/UserId/<%# Eval("AuthorId")%>'><%# Eval("DisplayName")%></a>
                                            </h4>
                                        </li>
                                        <li>
                                            <h4 class='booklist-author'>
                                                <asp:Label ID="Label1" runat="server" Text="Subject :" meta:resourcekey="lblAuthorResource1"></asp:Label>
                                                <%# getSubjectByID( Convert.ToInt16( Eval("SubjectId")) )%>
                                            </h4>
                                        </li>
                                        <li class='description'>
                                            <div class='expandable js-expandable js-auto-expand'>
                                                <div class='expandable-content'><%# Eval("Description")%></div>
                                                <br />
                                                <br />
                                                <div class='expandable-trigger-container'>
                                                    <div class='expandable-fade'></div>
                                                    <a class='blue expandable-trigger js-expandable-trigger' href='#toggle'>
                                                        <span class='expanded-text discriptiontoggle'>
                                                            <asp:Label ID="lblexpand" runat="server" Text="+ View More" meta:resourcekey="lblexpandResource1"></asp:Label></span>
                                                        <span class='collapsed-text discriptiontoggle'>
                                                            <asp:Label ID="lblCollapsed" runat="server" Text="- View Less" meta:resourcekey="lblCollapsedResource1"></asp:Label></span>
                                                    </a>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <hr />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
</div>
<asp:HiddenField ID="hdnKeyword" runat="server" />
<style>
    table.dataTable td.sorting_1
    {
        background-color: white;
        border: 1px lightgrey;
    }

    table.dataTable td
    {
        background-color: white;
        border: 1px lightgrey;
    }

    table.dataTable tr.odd
    {
        background-color: white;
        border: 1px lightgrey;
    }

    table.dataTable tr.even
    {
        background-color: white;
        border: 1px lightgrey;
    }

    .collapsed-text
    {
        display: none;
    }

    .expandable-content
    {
        height: 30px;
    }

    li.ui-menu-item:hover
    {
        background: none repeat scroll 0 0 #ff6600 !important;
        color: White !important;
    }

    a.ui-state-focus
    {
        background: none !important;
        color: White !important;
    }

    .mod
    {
        height: 100%;
        margin-bottom: 2em;
        overflow: visible;
        padding-bottom: 2em;
    }

    .verticalList
    {
        float: none;
    }

    ul, ol
    {
        margin: 0!important;
    }

    .mod.booklist .inner .bd li.item
    {
        border-top: 1px solid #e3dccc;
        height: 100%;
        overflow: hidden;
        padding: 1em 0;
    }

    .verticalList li
    {
        display: block;
        float: none;
    }

    li
    {
        list-style: none outside none;
    }

    .mod.booklist .media
    {
        padding: 0;
        width: 100%;
    }

    .media.product
    {
        float: left;
    }

    .right
    {
        float: right;
    }

    .inner-right
    {
        text-align: right;
    }

    .left
    {
        float: left;
    }

    .price-container .price
    {
        display: block;
        float: right;
        font-size: 184.6%;
        margin: 8px 10px 0 0;
    }

    .price
    {
        font-family: Helvetica,Arial,sans-serif;
    }

    .bold
    {
        font-weight: bold;
    }

    .price-container .button.red.large
    {
        padding: 0 11px;
    }

    .button.red.large
    {
        font-size: 14px;
    }

    .button.red
    {
        background: -moz-linear-gradient(center top, #ff7c00 0%, #ff5000 100%) repeat scroll 0 0 rgba(0, 0, 0, 0);
        border-bottom: 1px solid #d34e07;
        color: white !important;
        font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;
        font-weight: bold;
        text-shadow: 0 -1px 1px #d34e07;
    }

    .button.large
    {
        height: 40px;
        line-height: 40px;
    }

    .button
    {
        border-radius: 3px;
        cursor: pointer;
        display: inline-block;
        text-align: center;
        text-transform: none;
    }

    .red, .red:active, .red:visited
    {
        color: #ff6600 !important;
    }

    .red
    {
        color: #ff6600 !important;
    }

    .red
    {
        color: #ff6600 !important;
    }

    a, a:active, a:visited
    {
        color: #222222;
    }

    a
    {
        text-decoration: none;
    }

    .mod.booklist .media .img
    {
        float: left;
        padding-left: 4px;
    }

    article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section
    {
        display: block;
    }

    a, a:active, a:visited
    {
        color: #222222;
        cursor: pointer;
    }

    a
    {
        text-decoration: none;
    }

    .mod.booklist .media .bd
    {
        margin-left: 100px;
        margin-right: 260px;
    }

    .no-margin
    {
        margin: 0 !important;
    }

    .verticalList
    {
        float: none;
    }

    ul, ol
    {
        margin: 0;
    }

    .verticalList li ul.booklist-rating .booklist-top
    {
        margin-right: 25px;
    }

    .ebook-label.medium
    {
        background: url("https://dito.se/img/icons/icons.png") no-repeat scroll -280px -1139px rgba(0, 0, 0, 0);
        height: 21px;
        line-height: 25.2px;
    }

    .ebook-label
    {
        display: block;
        margin-bottom: 0.5em;
        padding-left: 1.9em;
    }

    .audio-book-label, .ebook-label
    {
        width: 50px !important;
    }

    .verticalList li ul.booklist-rating .booklist-top
    {
        margin-right: 25px;
    }

    .verticalList li ul.booklist-rating .booklist-top, .verticalList li ul.booklist-rating .booklist-middle
    {
        display: inline;
        float: left;
        position: relative;
    }

    li
    {
        list-style: none outside none;
    }

    .rating-text
    {
        display: inline;
        float: left;
        height: 0;
        line-height: 25.2px;
        padding-right: 5px;
    }

    p
    {
        margin-bottom: 1em;
    }

    .star-rating, .average-star-rating
    {
        float: left;
        height: 13px;
        list-style: none outside none;
        overflow: hidden;
        padding: 0;
        position: relative;
        top: 5px;
        width: 85px;
    }

    .average-star-rating
    {
        background: url("https://dito.se/img/average-grade_sprite.png") repeat-x scroll 0 0 rgba(0, 0, 0, 0);
    }

    .verticalList li ul.booklist-rating li
    {
        float: none;
        margin-right: 6px;
    }

    .average-star-rating li.average-current-rating
    {
        background: url("https://dito.se/img/average-grade_sprite.png") repeat scroll 0 -17px rgba(0, 0, 0, 0);
    }

    .star-rating li.current-rating, .average-star-rating li.average-current-rating
    {
        display: block;
        height: 13px;
        position: absolute;
        text-indent: -9000px;
        z-index: 1;
    }

    .star-rating li, .average-star-rating li
    {
        clear: left;
        padding: 0;
    }

    li
    {
        list-style: none outside none;
    }

    h3.booklist-title
    {
        color: #ff6600;
        font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;
        font-size: 138.5%;
        margin: 0!important;
        padding: 0!important;
    }

    h4
    {
        margin: 0 !important;
    }

        h4.booklist-author
        {
            color: #484842;
            font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;
            font-size: 100%;
        }

    .verticalList li
    {
        display: block;
        float: none;
    }

    li
    {
        list-style: none outside none;
    }

    .mod.booklist .inner .bd li.item .description .expandable
    {
        max-height: 60px;
    }

    .description .expandable
    {
        overflow: hidden;
        position: relative;
    }

    .mod.booklist .inner .bd li.item .description .expandable
    {
        max-height: 60px;
    }

    .description .expandable
    {
        overflow: hidden;
        position: relative;
    }

        .description .expandable .expandable-trigger-container
        {
            bottom: 0;
            left: 0;
            position: absolute;
            width: 100%;
        }

            .description .expandable .expandable-trigger-container .expandable-fade
            {
                background: url("/images/book-description-fade.png") repeat-x scroll 0 100% transparent;
                height: 20px;
            }

            .description .expandable .expandable-trigger-container .expandable-trigger
            {
                background-color: #fcfcf9;
                display: block;
                padding-top: 10px;
            }

    .blue, .blue:active, .blue:visited
    {
        color: #0088cc;
    }

    a, a:active, a:visited
    {
        cursor: pointer;
    }

    a
    {
        text-decoration: none;
    }

    h3.booklist-title a
    {
        color: #ff6600;
        font-weight: bold;
    }

    a, a:active, a:visited
    {
        cursor: pointer;
    }

    a
    {
        text-decoration: none;
    }

    mod.booklist .media .img img
    {
        height: 97px;
        width: 66px;
    }

    .media.product .img img
    {
        border-bottom-right-radius: 5px;
        border-top-right-radius: 5px;
        box-shadow: 0 0 3px 1px #999999;
    }

    img
    {
        max-width: 100%;
    }
</style>
