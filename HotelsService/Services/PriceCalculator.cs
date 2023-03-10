using ApiGateway.Models;
using CommonComponents.Models;

namespace HotelsService.Services
{
    public class PriceCalculator
    {
        private static int NORMAL_PRICE_PER_PERSON = 140;
        private static int PREMIUM_PRICE_PER_PERSON = 200;

        public static int CalculateHotelLowestPrice(Hotel hotelOffer, TripParameters tripParameters,
            bool isOnlyPremiumAvailable)
        {
            if (isOnlyPremiumAvailable)
                return CalculatePrice(tripParameters, PREMIUM_PRICE_PER_PERSON, hotelOffer.Stars);
            else
                return CalculatePrice(tripParameters, NORMAL_PRICE_PER_PERSON, hotelOffer.Stars);
        }

        public static int CalculateHotelRoomConfigPrice(Models.Hotel hotel, ReserveTripOfferParameters parameters)
        {
            if (parameters.RoomTypeId >= 8)
                return CalculatePrice(parameters, PREMIUM_PRICE_PER_PERSON, hotel.Stars.GetValueOrDefault());
            else
                return CalculatePrice(parameters, NORMAL_PRICE_PER_PERSON, hotel.Stars.GetValueOrDefault());
        }

        public static int CalculateHotelRoomConfigPrice(HotelRoom config, TripOfferQueryParameters parameters,
            int stars)
        {
            if (config.RoomtypeId >= 8) //PREMIUM ROOM TYPES HAVE ALWAYS ID >= 8
                return CalculatePrice(parameters, PREMIUM_PRICE_PER_PERSON, stars);
            else
                return CalculatePrice(parameters, NORMAL_PRICE_PER_PERSON, stars);
        }

        private static int CalculatePrice(ReserveTripOfferParameters tripParameters, int pricePerPerson, int stars)
        {
            int duration = (tripParameters.EndDate - tripParameters.StartDate).Days;
            return (int)((tripParameters.Adults * pricePerPerson +
                          tripParameters.ChildrenUnder18 * pricePerPerson +
                          tripParameters.ChildrenUnder10 * pricePerPerson * 0.7 +
                          tripParameters.ChildrenUnder3 * pricePerPerson * 0.5) * duration * (stars * 0.2));
        }

        private static int CalculatePrice(TripOfferQueryParameters tripParameters, int pricePerPerson, int stars)
        {
            int duration = (tripParameters.EndDate - tripParameters.StartDate).Days;
            return (int)((tripParameters.Adults * pricePerPerson +
                          tripParameters.ChildrenUnder18 * pricePerPerson +
                          tripParameters.ChildrenUnder10 * pricePerPerson * 0.7 +
                          tripParameters.ChildrenUnder3 * pricePerPerson * 0.5) * duration * (stars * 0.2));
        }

        private static int CalculatePrice(TripParameters tripParameters, int pricePerPerson, int stars)
        {
            int duration = (tripParameters.EndDate - tripParameters.StartDate).Days;
            return (int)((tripParameters.Adults * pricePerPerson +
                          tripParameters.ChildrenUnder18 * pricePerPerson +
                          tripParameters.ChildrenUnder10 * pricePerPerson * 0.7 +
                          tripParameters.ChildrenUnder3 * pricePerPerson * 0.5) * duration * (stars * 0.2));
        }
    }
}