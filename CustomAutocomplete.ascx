<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomAutocomplete.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.CustomAutocomplete" %>

<style>
    .autocomplete
    {
        width: 250px!important;
        padding: 10px!important;
    }

    .ui-autocomplete-category
    {
        border-bottom: 1px solid #ccc;
        display: block;
        line-height: 1.3em;
        width: 100%;
        height: auto;
        text-transform: uppercase;
        color: #999;
        font-weight: bold;
        padding: 20px 0 10px 5px;
    }

    .ui-autocomplete
    {
        padding: 0 10px 10px 10px;
    }

        .ui-autocomplete li.ui-menu-item
        {
            margin: 10px 0px 10px 0px;
        }

    .ui-state-focus
    {
        color: White!important;
        background: none repeat scroll 0 0 #ff6600!important;
        outline: none;
    }

    .ui-corner-all
    {
        border-top-left-radius: 0px;
        border-top-right-radius: 0px;
        border-bottom-left-radius: 0px;
        border-bottom-right-radius: 0px;
    }

    .ui-widget-content
    {
        background: url("images/ui-bg_flat_75_ffffff_40x100.png") repeat-x scroll 50% 50% #ffffff;
        border: 1px solid #aaaaaa;
        color: #222222;
    }

    .ui-widget
    {
        font-family: Verdana,Arial,sans-serif;
        font-size: 1.1em;
    }

    .ui-menu
    {
        list-style: none outside none;
        margin: 0;
        outline: medium none;
    }

    .ui-autocomplete
    {
        cursor: default;
        position: absolute;
    }
    .ui-helper-hidden-accessible {
    display:none!important;
    }
</style>


<script>

    $(function () {
        $(".catcomplete").click(function () {
            var e = jQuery.Event("keydown");
            e.keyCode = 40;
            $(".catcomplete").trigger(e);
        });

        $('.catcomplete').on('keydown', function (e) {
            if (e.keyCode == 13) {
                window.location.href = $(this).attr('resulturl') + "/search_keyword/" + $(this).val();
            }
        });

        $(".catcomplete").catcomplete({
            source: function (request, response) {
                var _url = $($(this)[0].element[0]).attr("Action-url");
                $.ajax({
                    type: "post",
                    url: _url + '?portalId=0&inst=452&sb-page=1&sb-pagesize=10&sb-search=' + request.term + '&format=json',
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.SearchResults, function (item) {
                            return {
                                text: ' ' + item.Title.replace('&lt;', '<').replace('&gt;', '>') + ' ',
                                label: item.SearchKey.replace('avtsb.User search-', ''),
                                category: item.Type == 'rule' ? 'Title' : 'Pages'
                            }
                        }));
                    },
                });
            },
            minLength: 1,
            select: function (event, ui) {
                window.location.href = $(this).attr('resulturl') + "/search_keyword/" + ui.item.label;
                console.log(ui.item ?
                "Selected: " + ui.item.label + " category : " + ui.item.category :
                "Nothing selected, input was " + this.value);
            },
            open: function () {
                $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
            },
            close: function () {
                $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
            }
        });
    });

    $.widget("custom.catcomplete", $.ui.autocomplete, {
        _renderMenu: function (ul, items) {
            var that = this;
            $.each(items, function (index, item) {
                if (item.category != 'Pages') {
                    that._renderItemData(ul, item);
                }
            });
        }
    });
</script>


<input id="Text1" class="autocomplete catcomplete" action-url="http://dnndev.me/DesktopModules/SearchBoost/SearchService.ashx" resulturl="<%= ResolveUrl("http://dnndev.me/en-us/Search-result")  %>">