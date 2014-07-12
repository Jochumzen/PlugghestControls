<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomAutocomplete.ascx.cs" Inherits="Plugghest.Modules.PlugghestControls.CustomAutocomplete" %>

<link href="http://dnndev.me/Script/CustomAutocomplete/CustomAutocomplete.css" rel="stylesheet" />


<script src="http://dnndev.me/Script/CustomAutocomplete/jsCustomAutocomplete.js" type="text/javascript"></script>


<input id="Text1" class="autocomplete catcomplete customAutoControl" 
    action-url="http://dnndev.me/DesktopModules/SearchBoost/SearchService.ashx"
    moduleid="452" 
    allowredirect="true" 
    ruleName ="usersearch"
    resulturl="<%= ResolveUrl("http://dnndev.me//")  %>">