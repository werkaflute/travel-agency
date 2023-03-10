using System;
using CommonComponents.Models;
using MassTransit;


namespace TripService.Saga
{
    public class ReservationState : SagaStateMachineInstance
    {
        public Guid CorrelationId { get; set; }
        public int CurrentState { get; set; }
        public int hotelPrice { get; set; }
        public int transportPrice { get; set; }
        public string Username { get; set; }
        public Guid? RequestId { get; set; }
        public Guid? TimeoutId { get; set; }
        public Uri? ResponseAddress { get; set; }
        public ReserveTripOfferParameters ReserveTripOfferParameters { get; set; }

        public string RoomTypeName { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public string FoodTypeName { get; set; }
        public string HotelName { get; set; }
        public int HotelId { get; set; }
        public string TransportTypeName { get; set; }
    }
}