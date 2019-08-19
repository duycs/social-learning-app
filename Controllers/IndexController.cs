﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using QAP4.Infrastructure.Repositories;
using Microsoft.AspNetCore.Http;
using QAP4.Extensions;
using QAP4.Models;
using Microsoft.AspNetCore.Http.Features;
using QAP4.ViewModels;
using QAP4.Domain.AggreatesModels.Posts.Models;
using QAP4.Application.Services;

namespace QAP4.Controllers
{
    /// <summary>
    /// This is Controller for views under MVC
    /// </summary>
    public class IndexController : WebPageController
    {
        private readonly IPostsRepository _postsRepository;
        private readonly ITagRepository _tagRepository;
        private readonly IPostsTagRepository _postsTagRepository;
        private readonly IUserRepository _userRepository;
        private readonly IQuoteRepository _quoteRepository;
        private readonly ISearchService _searchService;

        public IndexController(
            IPostsRepository postsRepository,
            ITagRepository tagRepository,
            IPostsTagRepository postsTagRepository,
            IUserRepository userRepository,
            IQuoteRepository quoteRepository,
            ISearchService searchService
            )
        {
            _postsRepository = postsRepository;
            _tagRepository = tagRepository;
            _postsTagRepository = postsTagRepository;
            _userRepository = userRepository;
            _quoteRepository = quoteRepository;
            _searchService = searchService
        }

        /// <summary>
        /// route: /
        /// Home page
        /// </summary>
        /// <returns></returns>
        [HttpGet("")]
        public IActionResult Index()
        {
            HomeView homeView = new HomeView();
            int page = 0;

            var userId = HttpContext.Session.GetInt32(AppConstants.Session.USER_ID);
            var user = _userRepository.GetById(userId);
            homeView.User = user;
            homeView.PostsFeed = _postsRepository.GetPostsByCreateDate(page);
            homeView.Quote = _quoteRepository.GetAutoQuote();
            homeView.TagsFeature = _tagRepository.GetTagsFeature();
            homeView.UsersFeature = _userRepository.GetUsersFeature();

            return View(homeView);
        }


        /// <summary>
        /// route: /contact
        /// Contact page
        /// </summary>
        /// <returns></returns>
        [HttpGet("contact")]
        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        /// <summary>
        /// route: /error
        /// Error page
        /// </summary>
        /// <returns></returns>
        [HttpGet("error")]
        public IActionResult Error()
        {
            return View();
        }

        /// <summary>
        /// route: /about
        /// About page
        /// </summary>
        /// <returns></returns>
        [HttpGet("about")]
        public IActionResult AboutUs()
        {
            return View();
        }

        /// <summary>
        /// route: /editors
        /// Posts manager page with an editor and posts list by user
        /// </summary>
        /// <param name="pg">page number</param>
        /// <param name="or_b">order by</param>
        /// <param name="u_i">user id</param>
        /// <param name="po_t">post type</param>
        /// <param name="po_lst_t">post list type</param>
        /// <returns></returns>
        [HttpGet]
        [Route("/editors")]
        public IActionResult PostsManagerView(
            [FromQuery]int pg,
            [FromQuery]string or_b,
            [FromQuery]int u_i,
            [FromQuery]int po_t,
            [FromQuery]int po_lst_t)
        {
            // Get this url then set to session with current user, when redirect from another page(ex from login to here) can correct to this link with user
            var thisUrl = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.Path}?po_lst_t={po_lst_t}&po_t={po_t}&u_i={u_i}";
            HttpContext.Session.SetString("thisUrl", thisUrl);

            // Get user from session
            var userId = HttpContext.Session.GetInt32(AppConstants.Session.USER_ID);
            var user = _userRepository.GetById(userId);

            // If not have user, redirect to login
            if (user == null)
            {
                return RedirectToAction("login", "user", new MessageView(0, AppConstants.Warning.WAR_2003, AppConstants.Screen.POSTS_MANAGER));
            }

            //var PostsLst = _postsRepository.GetPosts(pg, or_b, u_i, po_lst_t, 0);

            return View("PostsManager");
        }

        /// <summary>
        /// route: /reads
        /// Read page
        /// </summary>
        /// <param name="pg">page</param>
        /// <param name="type">post type</param>
        /// <returns></returns>
        [HttpGet("reads")]
        public IActionResult GetReads([FromQuery]int pg, [FromQuery]string type)
        {
            // Get user from session
            var userId = HttpContext.Session.GetInt32(AppConstants.Session.USER_ID);
            var user = _userRepository.GetById(userId);

            //TODO: think about listing

            // Posts single
            var postsSimple = _postsRepository.GetPostsByType(pg, (int)PostsType.POSTS);

            // Tutorials
            var tutorials = _postsRepository.GetPostsByType(pg, (int)PostsType.TUTORIAL);
            var questions = _postsRepository.GetPostsByType(pg, (int)PostsType.QUESTION);

            // Tutorials answer
            //var tutorialsAnswer = tutorials.Where(w => !string.IsNullOrEmpty(w.RelatedPosts));

            // Tags and Users feature
            var tagsFeature = _tagRepository.GetTagsFeature();
            var usersFeature = _userRepository.GetUsersFeature();

            var viewModal = new PostsView
            {
                User = user,
                PostsSimple = postsSimple,
                QuestionsAnswer = questions,
                TutorialsAnswer = tutorials,
                TagsFeature = tagsFeature,
                UsersFeature = usersFeature
            };

            return View("Posts", viewModal);
        }


        /// <summary>
        /// route: /answers
        /// </summary>
        /// <param name="pg">page</param>
        /// <param name="type">postsType</param>
        /// <returns></returns>
        [HttpGet("answers")]
        public IActionResult GetAnswers([FromQuery]int pg, [FromQuery]string type)
        {
            // Get user from session
            var userId = HttpContext.Session.GetInt32(AppConstants.Session.USER_ID);
            var user = _userRepository.GetById(userId);

            var postsWaitAnswer = new List<Posts>();
            var postsAnswer = new List<Posts>();

            // Tutorials and Questions
            var tutorials = _postsRepository.GetPostsByType(pg, (int)PostsType.TUTORIAL);
            var questions = _postsRepository.GetPostsByType(pg, (int)PostsType.QUESTION);

            // Tutorials wait to answer
            var tutorialsWaitAnswer = tutorials.Where(w => string.IsNullOrEmpty(w.RelatedPosts));

            // Tutorials answered
            var tutorialsAnswer = tutorials.Where(w => !string.IsNullOrEmpty(w.RelatedPosts));

            // Questions wait to answer
            var questionsWaitAnswer = questions.Where(w => w.AnswerCount == 0);
            var questionsAnswer = questions.Where(w => w.AnswerCount > 0);

            // Set posts wait answer, include tutorial and questions
            postsWaitAnswer.AddRange(questionsWaitAnswer);
            postsWaitAnswer.AddRange(tutorialsWaitAnswer);
            //questionsView.PostsWaitAnswer = postsWaitAnswer;

            // Set posts answer, include tutorials and questions
            postsAnswer.AddRange(questionsAnswer);
            postsAnswer.AddRange(tutorialsAnswer);
            //questionsView.PostsAnswer = postsAnswer;

            // Tags and users feature
            var tagsFeature = _tagRepository.GetTagsFeature();
            var usersFeature = _userRepository.GetUsersFeature();

            // Get total posts
            var count = postsAnswer.Count() + postsWaitAnswer.Count();

            var viewModel = new QuestionsView
            {
                User = user,
                TagsFeature = tagsFeature,
                UsersFeature = usersFeature,
                PostsWaitAnswer = postsWaitAnswer,
                PostsAnswer = postsAnswer,
                Count = count
            };

            return View("Questions", viewModel);
        }


        // // GET: /answers?t=2
        // // posts can be a posts normal (1), a question (2) or an answer (postType=3)
        // [HttpGet]
        // [Route("questions")]
        // public ActionResult QuestionsView(int pg, [FromQuery]int postsTypeId)
        // {
        //     ViewBag.UserName = HttpContext.Session.GetString(AppConstants.Session.USER_NAME);
        //     ViewBag.UserId = HttpContext.Session.GetInt32(AppConstants.Session.USER_ID);
        //     QuestionsView questionsView = new QuestionsView();
        //     var postWaitAnswer = new List<Posts>();

        //     //get posts wait answer
        //     var tutorialWaitAnswer = _postsRepository.GetPostsByType(pg, postsTypeId);

        //     var questionWaitAnswer = _postsRepository.GetQuestionsQueue(pg, 0);
        //     postWaitAnswer.AddRange(questionWaitAnswer);
        //     postWaitAnswer.AddRange(tutorialWaitAnswer);
        //     questionsView.PostsWaitAnswer = postWaitAnswer;

        //     //get posts answer
        //     questionsView.PostsAnswer = _postsRepository.GetAnswersNewest(pg, 0);

        //     //get tags
        //     questionsView.TagsFeature = _tagRepository.GetTagsFeature();
        //     questionsView.UsersFeature = _userRepository.GetUsersFeature();

        //     return View("Questions", questionsView);
        // }

        /// <summary>
        /// route: /ask
        /// Ask a question
        /// </summary>
        /// <param name="u_i">userId</param>
        /// <returns></returns>
        [HttpGet]
        [Route("ask")]
        public ActionResult GetAsk([FromQuery]int u_i)
        {
            // Get current link and set to session
            var thisUrl = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.Path}";
            HttpContext.Session.SetString("thisUrl", thisUrl);

            // Get user from session
            var userId = HttpContext.Session.GetInt32(AppConstants.Session.USER_ID);
            var user = _userRepository.GetById(userId);

            // If not exsit user to redirect login
            if (user == null)
            {
                return RedirectToAction("login", "user", new MessageView(AppConstants.Warning.WAR_2003, AppConstants.Screen.POSTS_ASK));
            }

            return View("Ask");
        }


        /// <summary>
        /// route: /{postsId}
        /// </summary>
        /// <param name="id">postsId</param>
        /// <param name="po_br_i">postsBranchId</param>
        /// <returns></returns>
        [HttpGet("{id:int}")]
        public IActionResult PostsDetail(int id, [FromQuery]int po_br_i)
        {
            // Get user from session
            var userId = HttpContext.Session.GetInt32(AppConstants.Session.USER_ID);
            var user = _userRepository.GetById(userId);

            //ViewBag.UserName = HttpContext.Session.GetString(AppConstants.Session.USER_NAME);
            //ViewBag.UserId = HttpContext.Session.GetInt32(AppConstants.Session.USER_ID);

            // Get posts by id
            var posts = _postsRepository.GetPosts(id);

            if (null == posts)
                return BadRequest();

            // Check postsType to custome display view
            var postsTypeId = (int)posts.PostTypeId;

            // If this is single posts
            if (AppConstants.PostsType.POSTS.Equals(postsTypeId))
            {
                var postsSameTags = _postsRepository.GetPostsSameTags(id, posts.Tags, postsTypeId);
                var postsSameAuthor = _postsRepository.GetPostsSameAuthor(id, posts.OwnerUserId, postsTypeId);

                var viewModel = new PostsDetailView
                {
                    User = user,
                    Posts = posts,
                    PostsSameTags = postsSameTags,
                    PostsSameAuthor = postsSameAuthor
                };

                return View("PostsDetail", viewModel);
            }

            // If this is question
            if (AppConstants.PostsType.QUESTION.Equals(postsTypeId))
            {
                var answers = _postsRepository.GetPosts(0, AppConstants.QueryString.CREATION_DATE, 0, AppConstants.PostsType.ANSWER, id);
                var sameQuestions = _postsRepository.GetSameQuestion(posts.Title, 5);

                var viewModel = new QuestionDetailView
                {
                    User = user,
                    Posts = posts,
                    Answers = answers,
                    SameQuestions = sameQuestions
                };

                return View("QuestionDetail", viewModel);
            }

            // Id this is tutorial
            if (AppConstants.PostsType.TUTORIAL.Equals(postsTypeId))
            {
                int postsParentId = id;
                var viewModel = GetTutorialDetail(user, posts, postsParentId, po_br_i);

                return View("TutorialDetail", viewModel);
            }

            // If not found any postsTypeId, return not found
            return NotFound();
        }

        /// <summary>
        /// route: /posts/list
        /// Get posts list view
        /// </summary>
        /// <param name="pg">page</param>
        /// <param name="or_b">orderBy</param>
        /// <param name="u_i">userId</param>
        /// <param name="po_t">postTypeId</param>
        /// <param name="pr_i">postParentId</param>
        /// <returns></returns>
        [HttpGet]
        [Route("/posts/list")]
        public IActionResult PostsList([FromQuery]int pg, [FromQuery]string or_b, [FromQuery]int u_i, [FromQuery]int po_t, [FromQuery]int pr_i)
        {
            var postsList = _postsRepository.GetPosts(pg, or_b, u_i, po_t, pr_i);
            return View("PostsList", postsList);
        }

        /// <summary>
        /// route: /groups/
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("groups/{groupId: int}")]
        public IActionResult Group(int groupId)
        {
            //var group
            //return View("Group", );
            return NotFound();
        }

        /// <summary>
        /// Get Search view
        /// 
        /// Search all: object=all, t=0
        /// GET: /search/all?q=sách&t=0&p=2
        /// search an object:
        /// GET: /search/posts?q=sách&t=1&p=2
        /// </summary>
        /// <param name="obj">object</param>
        /// <param name="q">query</param>
        /// <param name="po_t">postsType</param>
        /// <param name="pg">page</param>
        /// <returns></returns>
        [HttpGet]
        [Route("/search/{obj}")]
        public IActionResult SearchView(string obj, [FromQuery]string q, [FromQuery]int po_t, [FromQuery]int pg)
        {
            try
            {
                if (string.IsNullOrEmpty(obj) || string.IsNullOrEmpty(q))
                {
                    return BadRequest();
                }

                var viewModel = _searchService.FindAll(obj, q, po_t, pg, 10);

                return View("Search", viewModel);
            }
            catch (Exception)
            {
                return View("Search");
            }
        }

        private TutorialDetailView GetTutorialDetail(Users user, Posts posts, int postsParentId, int po_br_i)
        {
            var TutorialView = new TutorialDetailView();
            int relatedPost = 0;
            TutorialView.Tutorial = posts;
            TutorialView.User = user;

            // ralated posts by id and link
            List<KeyValuePair<int, string>> relatedPosts = new List<KeyValuePair<int, string>>();

            if (posts.RelatedPosts != null && posts.RelatedPosts.Any())
            {
                //gen list link key val
                if (!string.IsNullOrEmpty(posts.TableContent))
                {
                    var lstTitle = posts.TableContent.Split(',').ToArray();
                    var lstId = posts.RelatedPosts.Split(',').ToArray();
                    int i = 0;
                    foreach (var item in lstId)
                    {
                        relatedPosts.Add(new KeyValuePair<int, string>(Int32.Parse(lstId[i]), lstTitle[i]));
                        i++;
                    }

                    if (po_br_i == 0)
                    {
                        relatedPost = Int32.Parse(lstId[0]);
                    }
                    else
                    {
                        relatedPost = po_br_i;
                    }
                    TutorialView.Posts = _postsRepository.GetPosts(relatedPost);
                    TutorialView.RelatedPosts = relatedPosts;

                }
            }
            else
            {
                // Find all posts where parternId is this postsId
                var chirldPosts = _postsRepository.GetChirldPosts(0, postsParentId, (int)PostsType.TUTORIAL);
                if (chirldPosts != null && chirldPosts.Any())
                {
                    // Get first element
                    TutorialView.Posts = chirldPosts.ElementAt(0);

                    int i = 0;
                    foreach (var item in chirldPosts)
                    {
                        relatedPosts.Add(new KeyValuePair<int, string>(item.Id, i + ""));
                        i++;
                    }

                    TutorialView.RelatedPosts = relatedPosts;
                }

            }

            return TutorialView;
        }

    }
}
