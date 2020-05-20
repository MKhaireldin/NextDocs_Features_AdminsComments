<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
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

        const urlParams = new URLSearchParams(window.location.search);
        const itemsIds = urlParams.get('Ids');
        const listID = urlParams.get('listID');

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

        function retrieveListItems() {
            var clientContext = new SP.ClientContext(_spPageContextInfo.webAbsoluteUrl);

            var docIDs = itemsIds.split(",");
            docIDs.forEach(function (item, i) {
                var oList = clientContext.get_web().get_lists().getById(listID);
                var oListItem = oList.getItemById(item);
                var file = oListItem.get_file();
                file.checkOut();
                oListItem.set_item('AdminComments', document.getElementById("txt_AdminComments").value);

                oListItem.update();
                file.checkIn();

                clientContext.executeQueryAsync(Function.createDelegate(this, this.onQuerySucceeded), Function.createDelegate(this, this.onQueryFailed));
            });
        }
        function onQuerySucceeded() {
            window.location.replace("https://www.google.com/");
            closePopUp();
        }
        function onQueryFailed(sender, args) {
            alert('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
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
                <button id="btn_Save" type="button" onclick="retrieveListItems();">Save</button>
                <button id="btn_Cancel" type="button" onclick="closePopUp();">Cancel</button>
            </td>
        </tr>
    </table>
    <%--<script type="text/javascript" src="/_layouts/15/AdminComments/AdminCommentsJS.js"></script>--%>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Admin Comments
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Admin Comments
</asp:Content>