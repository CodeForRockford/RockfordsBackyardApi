using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WWW.Models.Repository
{
    public class EventsRepository
    {
        WhatWhenWhereEntities ctx = new WhatWhenWhereEntities();

        public void CreateEvent(Models.@event wwwEvent)
        {
            ctx.events.Add(new @event
            {
                NameOfEvent = wwwEvent.NameOfEvent,
                StartDate = wwwEvent.StartDate,
                EndDate = wwwEvent.EndDate,
                EventAddress = wwwEvent.EventAddress,
                Attendance = wwwEvent.Attendance,
                EventSite = wwwEvent.EventSite,
                HotelAddress = wwwEvent.HotelAddress,
                HQHotel = wwwEvent.HQHotel,
                RoomNights = wwwEvent.RoomNights,
                Sponsor = wwwEvent.Sponsor
            });
            ctx.SaveChanges();
        }
        public List<Models.@event> RetrieveAll()
        {
            return ctx.events.ToList<Models.@event>();
        }

        public void UpdateEvent(Models.@event wwwEvent)
        {
            ctx.events.Remove(wwwEvent);
            ctx.SaveChanges();
        }

        public void DeleteEvent(Models.@event wwwEvent)
        {
            ctx.events.Remove(wwwEvent);
            ctx.SaveChanges();
        }
    }
}