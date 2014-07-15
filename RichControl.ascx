<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RichControl.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.RichControl" %>


<%--<link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.no-icons.min.css" rel="stylesheet">--%>
<link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet">
<link href="/js/bootstrap-wysiwyg/index.css" rel="stylesheet" />
<script src="/js/bootstrap-wysiwyg/jquery.hotkeys.js"></script>
<script src="/js/bootstrap-wysiwyg/bootstrap-wysiwyg.js"></script>
<style>
    select {
        background-color: #ffffff;
        border: 1px solid #cccccc;
        width: 220px;
    }

    select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
        border-radius: 4px;
        color: #555555;
        display: inline-block;
        font-size: 14px;
        height: 30px;
        line-height: 20px;
        padding: 4px 6px;
        vertical-align: middle;
    }
    .container {
    width:auto!important;
    }
</style>
<asp:Panel ID="pnlOriginalText" runat="server" Visible="false">
    <h4>
        <asp:Label ID="lblOriginalText" resourcekey="OriginText" runat="server"></asp:Label></h4>
    <asp:Literal ID="ltOriginalText" runat="server" /><br />
</asp:Panel>

<h4>
    <asp:Label ID="lblCurrentText" resourcekey="CurrentText" runat="server" Visible="false"></asp:Label></h4>

<asp:Literal ID="TheText" runat="server"></asp:Literal>

<asp:HiddenField ID="hdnrichtext" runat="server" />
<asp:Panel ID="pnlRichTextbox" runat="server" Visible="false">
    <div class='container'>
        <div class='hero-unit'>

            <div id='alerts'></div>
            <div class='btn-toolbar' data-role='editor-toolbar' data-target='#editor'>


                <div class='btn-group'>
                    <a class='btn' data-edit='bold' title='Bold (Ctrl/Cmd+B)'><i class='icon-bold'></i></a>
                    <a class='btn' data-edit='italic' title='Italic (Ctrl/Cmd+I)'><i class='icon-italic'></i></a>
                </div>

                <div class='btn-group'>
                    <a class='btn' data-edit='insertunorderedlist' title='Bullet list'><i class='icon-list-ul'></i></a>
                    <a class='btn' data-edit='insertorderedlist' title='Number list'><i class='icon-list-ol'></i></a>
                </div>

                <div class='btn-group'>
                    <select onchange="formatDoc('formatblock',this[this.selectedIndex].value);this.selectedIndex=0;">
                        <option selected>- formatting -</option>
                        <option value="h1">Title 1 &lt;h1&gt;</option>
                        <option value="h2">Title 2 &lt;h2&gt;</option>
                        <option value="h3">Title 3 &lt;h3&gt;</option>
                        <option value="h4">Title 4 &lt;h4&gt;</option>
                        <option value="h5">Title 5 &lt;h5&gt;</option>
                        <option value="h6">Subtitle &lt;h6&gt;</option>
                        <option value="p">Paragraph &lt;p&gt;</option>
                        <option value="pre">Preformatted &lt;pre&gt;</option>
                    </select>
                </div>

                <div class='btn-group'>
                    <a class='btn dropdown-toggle' data-toggle='dropdown' title='Hyperlink'><i class='icon-link'></i></a>
                    <div class='dropdown-menu input-append'>
                        <input class='span2' placeholder='URL' type='text' data-edit='createLink' />
                        <button class='btn' type='button'>Add</button>
                    </div>
                    <a class='btn' data-edit='unlink' title='Remove Hyperlink'><i class='icon-cut'></i></a>
                </div>

                <div class='btn-group'>
                    <a class='btn' data-edit='undo' title='Undo (Ctrl/Cmd+Z)'><i class='icon-undo'></i></a>
                    <a class='btn' data-edit='redo' title='Redo (Ctrl/Cmd+Y)'><i class='icon-repeat'></i></a>
                </div>

            </div>
            <div id='editor'>
                Go ahead&hellip;
            </div>
            <br />

        </div>
    </div>
</asp:Panel>

<asp:Panel ID="pnlEdit" runat="server" Visible="false">
    <asp:HyperLink ID="hlEdit" resourcekey="Edit" runat="server" /><br />
</asp:Panel>

<asp:Panel ID="pnlTranslateFromGoogle" runat="server" Visible="false">
    <asp:HyperLink ID="hlTranslateFromGoogle" resourcekey="TranslateGoogle" runat="server" /><br />
</asp:Panel>

<asp:Panel ID="pnlTranslateFromHuman" runat="server" Visible="false">
    <asp:HyperLink ID="hlTranslateFromHuman" resourcekey="TranslateHuman" runat="server" /><br />
</asp:Panel>

<asp:Button ID="btnGoogleOK" resourcekey="GoogleOK" runat="server" Visible="false" OnClick="btnGoogleOK_Click" />
<asp:Button ID="btnSave" resourcekey="Save" runat="server" Visible="false" OnClientClick="getRichtext()" OnClick="btnSave_Click" />&nbsp;
<asp:Button ID="btnCancel" resourcekey="Cancel" runat="server" Visible="false" OnClick="btnCancel_Click" />

<script>
    $(document).ready(function () {
        initToolbarBootstrapBindings();
        $('#editor').wysiwyg();
        window.prettyPrint && prettyPrint();
        $('#editor').html($('#' + '<%=hdnrichtext.ClientID%>').val());
        function initToolbarBootstrapBindings() {

            var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier',
                  'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
                  'Times New Roman', 'Verdana'],
                  fontTarget = $('[title=Font]').siblings('.dropdown-menu');
            $.each(fonts, function (idx, fontName) {
                fontTarget.append($('<li><a data-edit="fontName ' + fontName + '" style="font-family:\'' + fontName + '\'">' + fontName + '</a></li>'));
            });
            $('a[title]').tooltip({ container: 'body' });
            $('.dropdown-menu input').click(function () { return false; })
       .change(function () { $(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle'); })
               .keydown('esc', function () { this.value = ''; $(this).change(); });

            $('[data-role=magic-overlay]').each(function () {
                var overlay = $(this), target = $(overlay.data('target'));
                overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
            });
            if ("onwebkitspeechchange" in document.createElement("input")) {
                var editorOffset = $('#editor').offset();
                $('#voiceBtn').css('position', 'absolute').offset({ top: editorOffset.top, left: editorOffset.left + $('#editor').innerWidth() - 35 });
            } else {
                $('#voiceBtn').hide();
            }
        };
        function showErrorAlert(reason, detail) {
            var msg = '';
            if (reason === 'unsupported-file-type') { msg = "Unsupported format " + detail; }
            else {
                console.log("error uploading file", reason, detail);
            }
            $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>' +
            '<strong>File upload error</strong> ' + msg + ' </div>').prependTo('#alerts');
        };


    });
    function getRichtext() {
        $('#' + '<%=hdnrichtext.ClientID%>').val($('#editor').html());
    }

    function formatDoc(sCmd, sValue) {
        document.execCommand(sCmd, false, sValue);
    }
</script>

