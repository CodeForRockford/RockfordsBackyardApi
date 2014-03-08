using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WWW.Controllers
{
    public class RepositoryController : ApiController
    {
        //// GET api/repository
        //public IEnumerable<string> Get()
        //{
        //    return new string[] { "value1", "value2" };
        //}

        //// GET api/repository/5
        //public string Get(int id)
        //{
        //    return "value";
        //}

        public List<Models.@event> GetAllEvents()
        {
            System.Web.HttpContext.Current.Response.AppendHeader("Access-Control-Allow-Origin", "*");
            var repo = new Models.Repository.EventsRepository();
            return repo.RetrieveAll();
        }

        // GET api/repository/5
        [HttpPost]
        public void DeleteEvent([FromBody]Models.@event wwwEvent)
        {
            System.Web.HttpContext.Current.Response.AppendHeader("Access-Control-Allow-Origin", "*");
            var repo = new Models.Repository.EventsRepository();
            repo.DeleteEvent(wwwEvent);
        }

        // POST api/repository
        [HttpPost]
        public void CreateEvent([FromBody]Models.@event wwwEvent)
        {
            System.Web.HttpContext.Current.Response.AppendHeader("Access-Control-Allow-Origin", "*");
            var repo = new Models.Repository.EventsRepository();
            repo.CreateEvent(wwwEvent);
        }
    }
}
