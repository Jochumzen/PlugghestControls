<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomAutocomplete.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.CustomAutocomplete" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">

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
            margin:10px 0px 10px 0px;
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
</style>


<script>

    $(function () {
        $(".autocomplete").click(function () {
            var e = jQuery.Event("keydown");
            e.keyCode = 40;
            $("#city").trigger(e);
        });

        $(".autocomplete").catcomplete({
            source: function (request, response) {
                var _url = $($(this)[0].element[0]).attr("Action-url");
                $.ajax({
                    type: "post",
                    url: _url,
                    data: {
                        cmd: 'test_search',
                        data: request.term,
                        iinst: 452
                 
                    },
                    dataType: "text/html",
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (data) {
                        console.log(JSON.stringify(data));
                        response($.map($(data).filter('a:contains("(rule)")'), function (item) {
                            return {
                                label: item.text().replace(' (rule)', ''),
                                category: 'Title'
                            }
                        }));
                        //response($.map(data, function (item) {
                        //    return {
                        //        label: item.label.substring(0, item.label.length - 1),//item.Name,
                        //        value: item.label.substring(0, item.label.length - 1),
                        //        category: (item.label.substring(item.label.length - 1) == '1' || item.label.substring(item.label.length - 1) == '^') ? 'Title' : (item.label.substring(item.label.length - 1) == '2' || item.label.substring(item.label.length - 1) == '~') ? 'Author' : 'Pages'//item.category
                        //    }
                        //}));
                    },
                    complete: function (_data) {
                        var _html = $.parseHTML(_data.responseText);
                        response($.map($(_html).filter('a:contains("(rule)")'), function (item) {
                            return {
                                label: $(item).text().replace(' (rule)', ''),
                                category: 'Title'
                            }
                        }));
                    }
                });
                //type: "POST",
                //url: _url + request.term,
                //contentType: "application/json; charset=utf-8",
                //dataType: "json",
            },
            minLength: 1,
            select: function (event, ui) {
                document.cookie = "searchinfo=" + ui.item.label;
                window.location.href = $(this).attr("resulturl");
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
            var currentCategory = "";
            items.sort(function (a, b) {
                return a.category < b.category;
            });

            $.each(items, function (index, item) {
                if (item.category != 'Pages') {
                    //if (item.category != currentCategory) {
                    //    $('<li/>').addClass('ui-autocomplete-category').html(item.category).appendTo(ul);
                    //    currentCategory = item.category;
                    //}
                    that._renderItemData(ul, item);
                }
            });
        }
    });
</script>

<input id="city" class="autocomplete" action-url="http://dnndev.me/DesktopModules/SearchBoost/AdminApi.aspx?alias=dnndev.me" resulturl="http://dnndev.me/en-us/Search-result">
<%--<input id="city" class="autocomplete" action-url="http://dnndev.me/DesktopModules/SearchBoost/Autocomplete.ashx?cmd=autocomplete&size=8&term=" resulturl="<%= Request.Url.ToString()  %>">--%>
<%--Action-url="<%: ResolveUrl("~/svc/time")%>"--%>