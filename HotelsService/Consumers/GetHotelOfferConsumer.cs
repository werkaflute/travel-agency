using System;
using System.Threading.Tasks;
using ApiGateway.Models;
using CommonComponents.Models;
using CommonComponents;
using CommonComponents.Exceptions;
using HotelsService.Models;
using HotelsService.Repositories;
using HotelsService.Services;
using MassTransit;
using Hotel = HotelsService.Models.Hotel;

namespace HotelsService.Consumers
{
    public class GetHotelOfferConsumer : IConsumer<GetHotelOfferQuery>
    {
        private IHotelRepository _hotelRepository;
        private IHotelService _hotelService;

        public GetHotelOfferConsumer(IHotelRepository hotelRepository, IHotelService hotelService)
        {
            _hotelRepository = hotelRepository;
            _hotelService = hotelService;
        }

        public async Task Consume(ConsumeContext<GetHotelOfferQuery> context)
        {
            try
            {
                TripOfferQueryParameters tripOfferQueryParameters = context.Message.TripOfferQueryParameters;
                HotelWithDescription selectedHotel =
                    _hotelRepository.GetHotelWithDescription(tripOfferQueryParameters.HotelId);
                HotelOffer hotelOffer = _hotelService.createHotelOffer(tripOfferQueryParameters, selectedHotel);
                foreach (HotelRoom hotelOfferRoomsConfiguration in hotelOffer.RoomsConfigurations)
                {
                    hotelOfferRoomsConfiguration.Price =
                        PriceCalculator.CalculateHotelRoomConfigPrice(hotelOfferRoomsConfiguration,
                            tripOfferQueryParameters, hotelOffer.Stars);
                }
                await context.RespondAsync(new GetHotelOfferResponse()
                {
                    HotelOffer = hotelOffer
                });
            }
            catch (Exception exception)
            {
                if (exception is HotelDoesNotExistException || exception is SuitableRoomConfigurationNotFoundException)
                    await context.RespondAsync(new GetHotelOfferResponse());
                else
                {
                    throw;
                }
            }
        }
    }
}