<%@ Assembly Name="AdminComments, Version=1.0.0.0, Culture=neutral, PublicKeyToken=e329ee010310cb35" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminComments.aspx.cs" Inherits="AdminComments.Layouts.AdminComments.AdminComments" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">

<script type="text/javascript">	

    $.urlParam = function (name) {
        var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
        if (results == null) {
            return null;
        }
        else {
            return decodeURI(results[1]) || 0;
        }
    }

    var itemsIds = $.urlParam('Ids');
    var listID = $.urlParam('listID');

    function closePopUp() {
        try {
            window.frameElement.cancelPopUp();
        }
        catch (e) {
            if (Boolean(top) && Boolean(top.postMessage))
                top.postMessage('CloseDialog', '*');
        }
        return false;
    }  
	
	function UpdateAdminComments()
	{	
		var serviceUri = _spPageContextInfo.webAbsoluteUrl + "/_vti_bin/SystemUpdateService.svc/SystemUpdate/" + listID + "/" + itemsIds + "/" + "AdminComments/"+ document.getElementById("txt_AdminComments").value;		
		SP.UI.ModalDialog.showWaitScreenWithNoClose('Processing...', 'Please wait while request is in progress...', 150, 500);
		$.ajax({
			type: "GET",
			contentType: "application/json",
			url: serviceUri,
			dataType: "json",
			success:
				function (response) {														
					RefreshParent();					
				},
			error:
				function (err) {
					alert(err);
				}
		});	
	}
	
	function RefreshParent() 
	{
        window.parent.location.reload();
    }	

</script>
	<table style="width: 100%;padding-top: 15px;">
        <tr>
            <td style="vertical-align: text-top;">Comments</td>
            <td><textarea id="txt_AdminComments" rows="5" cols="45" class="ms-fullWidth"></textarea></td>
        </tr>
		 <tr>
			<td></td>
            <td style="text-align: right; padding-top: 45px;">
                <button id="btn_Save" type="button" onclick="UpdateAdminComments();">Save</button>
                <button id="btn_Cancel" type="button" onclick="closePopUp();">Cancel</button>
            </td>
        </tr>
    </table>    
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Admin Comments
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Admin Comments
</asp:Content>
