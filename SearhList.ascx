<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearhList.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.SearhList" %>
<link href="http://dnndev.me/cdn.datatables.net/1.10.0/css/jquery.dataTables.css" rel="stylesheet" />
<script type="text/javascript" src="//cdn.datatables.net/1.10.0/js/jquery.dataTables.js"></script>
<script>
    $(document).ready(function () {
        $('.bd table:eq(0)').dataTable({
            "bPaginate": true,
            "bLengthChange": true,
            "bFilter": false,
            "bSort": true,
            "bInfo": true,
            "bAutoWidth": true,
            "scrollY": "500px",
            "scrollCollapse": true,
            "aoColumns": [
                               null //put as many null values as your columns
            ]
        });
        $('.dataTables_length').css('display', 'none');
    });

</script>
<div class="mod booklist">
    <div class="inner">
        <div class="bd">
            <asp:Repeater ID="rptSearchResult" runat="server">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th></th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr class='item'>
                        <td>
                            <div class='media product '>
                                <div class='price-container right'>
                                    <div class='left inner-right'>
                                        <span class='price bold'>$220</span>
                                    </div>
                                    <a class='button red large js-present-modal' data-type='purchase' data-arg='9781446209424' href='#purchase,9781446209424'>Purchase</a>
                                </div>
                                <figure class='img'>
                                    <a href='/e-bok/9781446209424/good-essay-writing'>
                                        <img width='66px' height='97px' src='https://image.bokus.com/images2/9781446209424_small' alt='Good Essay Writing'>
                                    </a>
                                </figure>
                                <div class='bd'>
                                    <ul class='verticalList no-margin'>
                                        <li>
                                            <ul class='booklist-rating'>
                                                <li class='booklist-top'>
                                                    <span class='js-ebook-label ebook-label medium'>E-bok</span>
                                                </li>
                                                <li class='booklist-top'>

                                                    <%----Rating thing----%>
                                                    <div style='display: block;' class='dcc_rnc_CLSelector' co_type='Q' apppath='' ratingmode='ratings' moduleid='449'
                                                        co_val='qsp:tabid' co_val2='<%# Eval("TabID") %>'>
                                                        <!-- User customizable content starts -->
                                                        <table border='0' cellspacing='0' cellpadding='3'>
                                                            <tr>
                                                                <td colspan='1'>
                                                                    <img src='[PRC_AVERAGERATINGIMAGE]' alt='Avg. Rating [PRC_AVERAGERATINGVALUE]' title='Avg. Rating [PRC_AVERAGERATINGVALUE]'>
                                                                </td>
                                                           
                                                                <td style='font-family: Tahoma; font-size: 10px; font-weight: bold; color: #000000; white-space: nowrap;'>[PRC_TOTALRATINGS] Rating(s)
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <!-- User customizable content ends -->
                                                    </div>
                                                    <%----End Rating thing-----%>
                                                </li>
                                                <li>
                                                    <p style='padding-top: 4px;'></p>
                                                </li>
                                            </ul>
                                             <br />
                                            </br>
                                        </li>
                                        <li>
                                            <h3 class='booklist-title'>
                                                <a href='<%# Eval("TabID") %>'><%#Eval("Title")%> </a>
                                            </h3>
                                        </li>
                                        <li>
                                            <h4 class='booklist-author'>Author :  
                                                 <a href='/e-bok/författare/Peter Redman, Wendy Maples'><%#Eval("Author")%></a>
                                            </h4>
                                        </li>
                                        <li class='description'>
                                            <div class='expandable js-expandable js-auto-expand'>
                                                <div class='expandable-content'><%#Eval("Discription")%></div>
                                                <div class='expandable-trigger-container'>
                                                    <div class='expandable-fade'></div>
                                                    <a class='blue expandable-trigger js-expandable-trigger' href='#toggle'>
                                                        <span class='expanded-text'>+ View More</span>
                                                        <span class='collapsed-text'>- View Less</span>
                                                    </a>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
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
        line-height: 0px!important;
        margin: 0!important;
        padding: 0!important;
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
                background: url("../img/book-description-fade.png") repeat-x scroll 0 100% transparent;
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
