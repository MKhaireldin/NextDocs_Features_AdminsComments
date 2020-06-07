function EnableCommentsButton() {
    var context = SP.ClientContext.get_current();
    var list;
    var selectedItems = SP.ListOperation.Selection.getSelectedItems(context);
    var totalSelectedItems = selectedItems.length;

    if (totalSelectedItems > 0) {
        var web = context.get_web();
        context.load(web);
        var listId = SP.ListOperation.Selection.getSelectedList();
        list = web.get_lists().getById(listId);

        var hadToMakeCall = false;

        if (typeof this.itemRows == "undefined" || this.itemRows.length != totalSelectedItems) {
            hadToMakeCall = true;
            GetItemsStatus();
        }

        if (hadToMakeCall) {
            return false;
        }
        else {
            return this._can_be_enabled;
        }
    }
    else {
        this.itemRows = undefined;
        return false;
    }

    function GetItemsStatus() {

        itemRows = [];

        for (i in selectedItems) {
            itemRows[i] = list.getItemById(selectedItems[i].id);
            context.load(itemRows[i]);
        }

        context.executeQueryAsync(Function.createDelegate(this, onGetItemsSuccess), Function.createDelegate(this, onGetItemsQueryFailed));
    }

    function onGetItemsSuccess() {
        this._can_be_enabled = true;

        for (i in itemRows) {
            this._can_be_enabled = this._can_be_enabled && itemRows[i].get_item("_vti_ItemDeclaredRecord") == null;
        }

        RefreshCommandUI();
    }

    function onGetItemsQueryFailed(sender, args) {
        alert(args.get_message());
    }
}

function OpenAdminCommentsPopUp() {
    var selectedIds = '';
    var ctx = SP.ClientContext.get_current();
    var listID = SP.ListOperation.Selection.getSelectedList();
    var items = SP.ListOperation.Selection.getSelectedItems(ctx);

    items.forEach(function (item, i) {
        if (i == 0) {
            selectedIds += item.id;
        }
        else {
            selectedIds += ',' + item.id;
        }
    });

    SP.UI.ModalDialog.OpenPopUpPage(ctx.get_url() + '/_layouts/15/AdminComments/AdminComments.aspx?Ids=' + selectedIds + '&listID=' + listID);
}