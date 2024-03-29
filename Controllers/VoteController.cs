using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using QAP4.Repository;
using QAP4.Models;
using QAP4.ViewModels;
using QAP4.Extensions;

namespace QAP4.Controllers
{
    [Produces("application/json")]
    [Route("[controller]")]
    public class VoteController : Controller
    {
        private IPostsRepository PostsRepo { get; set; }
        private IVoteRepository VoteRepo { get; set; }
        private IUserRepository UserRepo { get; set; }

        public VoteController(IPostsRepository _postsRepo, IVoteRepository _voteRepo, IUserRepository _userRepo)
        {
            PostsRepo = _postsRepo;
            VoteRepo = _voteRepo;
            UserRepo = _userRepo;
        }

        // GET: /api/vote?po_i=1&vo_t=1&u_i=0
        [HttpGet]
        [Route("/api/vote")]
        public IActionResult Get([FromQuery]int po_i, [FromQuery]int vo_t, [FromQuery]int u_i)
        {
            var votes = VoteRepo.GetVotes(po_i, vo_t, u_i);
            return Json(votes);
        }

        // POST: /api/vote
        [HttpPost]
        [Route("/api/vote")]
        public IActionResult Post(Votes model)
        {
            if (model == null)
            {
                return BadRequest();
            }

            var userId = HttpContext.Session.GetInt32(AppConstants.Session.USER_ID);
            var user = UserRepo.GetById(userId);
            if (null == user)
            {
                return Json(new MessageView(AppConstants.Warning.WAR_2003));
            }

            //check voted
            bool userVoted = VoteRepo.CheckUserVoted((int)userId, (int)model.PostsId, (int)model.VoteTypeId, (bool)model.IsOn);
            if (userVoted)
            {
                return Json(new MessageView(AppConstants.Warning.WAR_2002));
            }

            //create or update vote

            var voteCheck = VoteRepo.GetVote((int)userId, (int)model.PostsId, (int)model.VoteTypeId);
            if (voteCheck == null)
            {
                var vote = new Votes();
                vote.PostsId = model.PostsId;
                vote.VoteTypeId = model.VoteTypeId;
                vote.UserId = userId;
                vote.IsOn = model.IsOn;
                vote.CreationDate = DateTime.Now;
                VoteRepo.Create(vote);
            }else
            {
                voteCheck.IsOn = model.IsOn;
                voteCheck.CreationDate = DateTime.Now;
                VoteRepo.Update(voteCheck);
            }

            //update voteCount in posts
            var posts = PostsRepo.GetPosts(model.PostsId);
            if (posts != null)
            {
                var count = posts.VoteCount;
                if (model.IsOn == true)
                {
                    count++;
                }
                else
                {
                    count--;
                }
                posts.VoteCount = count;
                PostsRepo.Update(posts);
            }

            return Json(new MessageView(AppConstants.Message.MSG_1000));
        }

    }
}