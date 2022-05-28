using System.Threading.Tasks;
using ApiGateway.Hubs.Clients;
using Microsoft.AspNetCore.SignalR;

namespace ApiGateway.Hubs
{
    public class NotificationHub : Hub<INotificationClient>
    {
    }
}