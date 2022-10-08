<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>


<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostByPostId(postId);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><%= p.getpTitle()%> || TechBlog by Learn with Stack-Overflow </title>
    <!--css-->
    <style>
        .banner-background{
            clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 100%, 86% 96%, 18% 98%, 0 93%, 0 0);
        }
        .post-title{
            font-weight: 100;
            font-size: 20px;
        }
        .post-content{
            font-weight: 100;
            font-size: 25px;
        }
        .post-date{
            font-style: italic;
            font-weight: bold;
        }
        .post-user-info{
            font-size: 20px;
        }
        .row-user{
            border: 1px solid #0097a7;
            padding-top: 15px;
        }
        body{
            background: url(img/bg.jpg);
            background-size: cover;
            background-attachment: fixed;
        }
        .post-code{
            background-color: black
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

</head>
<body>

    <!--navbar-->
    <nav class="navbar navbar-expand-lg navbar-dark primary-background">
        <a class="navbar-brand" href="index.jsp"> <span class="fa fa-asterisk"></span>  Tech Blog</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="profile.jsp"> <span class="fa fa-book"></span> Blog Community <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="fa fa-caret-square-o-down"></span> Categories
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="#">Programming Language</a>
                        <a class="dropdown-item" href="#">Project Implementation</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Data Structure</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-address-book"></span>  Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span><i class="fa fa-clipboard" aria-hidden="true"></i></span>  Do Post</a>
                </li>


            </ul>
            <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle "></span>  <%= user.getName()%></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out"></span>  Logout</a>
                </li>
            </ul>

        </div>
    </nav>

    <!--end of navbar-->

    <!--main content of body-->

    <div class="container">
        <div class="row my-4">
            <div class="col-md-8 offset-md-2">
                <div class="card">

                    <div class="card-header primary-background text-white text-center">
                        <h4 class="post-title"><%= p.getpTitle()%></h4>
                    </div>

                    <div class="card-body">

                        <img class="card-img-top my-2" src="blog_pics/<%= p.getpPic()%>" alt="Image not available">

                        <div class="row my-3 row-user">
                            <div class="col-md-8">
                                <%
                                    UserDao ud = new UserDao(ConnectionProvider.getConnection());

                                %>
                                <p class="post-user-info"><a href="#!"><%= ud.getUserByUserId(p.getUserId()).getName()%></a> has posted</p>
                            </div>
                            <div class="col-md-4">
                                <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                            </div>
                        </div>

                        <p class="post-content"><%= p.getpContent()%></p>

                        <br>
                        <br>
                        <div class="post-code">
                            <code><%= p.getpCode()%></code>
                        </div>
                    </div>
                    <div class="card-footer text-center">

                        <%
                            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                        %>

                        <a href="#!" onclick="doLike(<%= p.getPid()%>,<%= user.getId()%>)" class="btn btn-outline-primary btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span>  </a>

                        <a href="#!" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i> <span>20</span> </a>

                    </div>

                </div>
            </div>
        </div>
    </div>


    <!--end of main content of body-->


    <!--profile model-->

    <!-- Button trigger modal -->

    <!-- Modal -->
    <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header primary-background text-white text-center btn-outline-dark">
                    <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container text-center">
                        <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius: 50%; max-width: 150px;"  />
                        <br>
                        <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>
                        <!--details-->
                        <div id="profile-details">
                            <table class="table">
                                <thead>

                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">ID</th>
                                        <td><%= user.getId()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Email</th>
                                        <td><%= user.getEmail()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Gender</th>
                                        <td><%= user.getGender()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Status</th>
                                        <td><%= user.getAbout()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Registered on</th>
                                        <td><%= user.getDateTime()%></td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!--profile edit-->
                        <div id="profile-edit" style="display: none">
                            <h3 class="mt-2">Please Edit Carefully</h3> 
                            <form action="EditServlet" method="post" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <th>ID</th>
                                        <th><%= user.getId()%></th>
                                    </tr>
                                    <tr>
                                        <td>Email</td>
                                        <td><input class="form-control" type="email" name="user_email" value="<%= user.getEmail()%>" /></td>
                                    </tr>
                                    <tr>
                                        <td>Name</td>
                                        <td><input class="form-control" type="text" name="user_name" value="<%= user.getName()%>" /></td>
                                    </tr>
                                    <tr>
                                        <td>Password</td>
                                        <td><input class="form-control" type="password" name="user_password" value="<%= user.getPassword()%>" /></td>
                                    </tr>
                                    <tr>
                                        <td>Gender</td>
                                        <td><%= user.getGender().toUpperCase()%></td>
                                    </tr>
                                    <tr>
                                        <td>About</td>
                                        <td>
                                            <textarea rows="3" class="form-control" name="user_about"><%= user.getAbout()%>
                                            </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>New Profile:</td>
                                        <td>
                                            <input type="file" name="image" class="form-control"/>
                                        </td>
                                    </tr>
                                </table>

                                <div class="container">
                                    <button type="submit" class="btn btn-outline-dark primary-background text-white text-center">SAVE</button>
                                </div>


                            </form>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-outline-dark" data-dismiss="modal">Close</button>
                    <button id="edit-profile-btn" type="button" class="btn btn-primary primary-background text-white btn-outline-dark">EDIT</button>
                </div>
            </div>
        </div>
    </div>
    <!--end of profile modal-->

    <!--add post modal-->
    <!-- Button trigger modal -->

    <!-- Modal -->
    <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Provide the post details..</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="add-post-form" action="AddPostServlet" method="post">

                        <div class="form-group">
                            <select class="form-control" name="cid">
                                <option selected disabled>--Select Category--</option>
                                <%
                                    PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = postd.getAllCategories();
                                    for (Category c : list) {


                                %>
                                <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            <input name="pTitle" type="text" placeholder="Enter post Title" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <textarea name="pContent" class="form-control" style="height: 150px" placeholder="Enter your content"></textarea>
                        </div>
                        <div class="form-group">
                            <textarea name="pCode" class="form-control" style="height: 150px" placeholder="Enter your program(if any)"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Select your pic</label>
                            <br>
                            <input name="pic" type="file" />
                        </div>
                        <div class="container text-center">
                            <button type="submit" class="btn btn-outline-primary">POST</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
    <!--end post modal-->

    <!--java-Script-->
    <script
        src="https://code.jquery.com/jquery-3.6.1.min.js"
        integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="js/myjs.js" type="text/javascript"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <script>
                            $(document).ready(function () {
                                let editStatus = false;

                                $('#edit-profile-btn').click(function () {
//                    alert("button clicked");
                                    if (editStatus == false) {
                                        $("#profile-details").hide()
                                        $("#profile-edit").show();
                                        editStatus = true;
                                        $(this).text("BACK")
                                    } else {
                                        $("#profile-details").show()
                                        $("#profile-edit").hide();
                                        editStatus = false;
                                        $(this).text("EDIT")
                                    }
                                });
                            });
    </script>

    <!--now add post js-->
    <script>
        $(document).ready(function (e) {
            //
            $("#add-post-form").on("submit", function (event) {
                //this code gets called when form is submitted....
                event.preventDefault();
                console.log("you have clicked on submit..")
                let form = new FormData(this);
                //now requesting to server
                $.ajax({
                    url: "AddPostServlet",
                    type: 'POST',
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        //success ..
                        console.log(data);
                        if (data.trim() == 'done')
                        {
                            swal("Good job!", "saved successfully", "success");

                        } else
                        {
                            swal("Error!!", "Something went wrong try again...", "error");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //error..
                        swal("Error!!", "Something went wrong try again...", "error");
                    },
                    processData: false,
                    contentType: false
                })
            })
        })
    </script>



</body>
</html>
