using System.ServiceModel;
using System.ServiceModel.Web;

namespace AdminComments.ISAPI
{
    [ServiceContract]
    interface ISystemUpdateService
    {
        [OperationContract(Name = "SystemUpdate")]
        [WebGet(UriTemplate = "SystemUpdate/{listID}/{itemIds}/{fieldName}/{fieldvalue}",
        ResponseFormat = WebMessageFormat.Json)]
        string SystemUpdate(string listID, string itemIds, string fieldName, string fieldvalue);
		
		
		
		
		//Test-1 
		
		//test-2
		
		//Test-3
    }
}
