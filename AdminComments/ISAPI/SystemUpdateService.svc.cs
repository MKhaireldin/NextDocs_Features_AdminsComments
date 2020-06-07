using Microsoft.SharePoint;
using System;
using System.Runtime.InteropServices;
using System.ServiceModel.Activation;

namespace AdminComments.ISAPI
{
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Required)]
    public class SystemUpdateService : ISystemUpdateService
    {
        public string SystemUpdate(string listID, string itemIds, string fieldName, string fieldvalue)
        {
            var updated = string.Empty;
            try
            {
                using (var site = new SPSite(SPContext.Current.Site.Url))
                {
                    using (var web = site.OpenWeb())
                    {
                        web.AllowUnsafeUpdates = true;
                        var list = web.Lists[new Guid(listID)];

                        var ids = itemIds.Split(',');
                        foreach (var id in ids)
                        {
                            var item = list.GetItemById(Convert.ToInt32(id));
                            item[fieldName] = fieldvalue;
                            item.SystemUpdate();
                            updated = "True";
                        }
                        web.AllowUnsafeUpdates = false;
                    }
                }
            }
            catch (Exception ex)
            {
                updated = ex.Message;
            }
            return updated;
        }
    }
}
