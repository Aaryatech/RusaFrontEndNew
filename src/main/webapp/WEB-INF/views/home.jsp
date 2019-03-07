<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.ats.rusafrontend.model.Maintainance"%>
<%@ page session="true" %>

<%
	//allow access only if session exists
//	HttpSession session = request.getSession();
	String user = null;
	if (session.getAttribute("menuList") == null) {
		String mapping = (String) session.getAttribute("mapping");
		String contextPath = request.getContextPath();
		contextPath = contextPath + "/retriveSession/" + mapping;
		response.sendRedirect(contextPath);
	}
%> 
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description"
	content="${sessionScope.homePageMetaData.metaDescription}">
<meta name="author"
	content="${sessionScope.homePageMetaData.metaAuthor}">
<link rel="icon" href="../../favicon.ico">
<title>${sessionScope.homePageMetaData.siteTitle}</title>
<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/jcarousel.responsive.css" rel="stylesheet" type="text/css" >
<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800|Playfair+Display:400,700,900" rel="stylesheet">
<jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>

<script>
        var strMsg = "This link will take you to extneranl web site.";
           var strMsgPdf = "PDF file that opens in a new window.";

       </script>
       <script>(function(d, s, id) {
               var js, fjs = d.getElementsByTagName(s)[0];
               if (d.getElementById(id)) return;
               js = d.createElement(s); js.id = id;
               js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5&appId=809225772483402";
               fjs.parentNode.insertBefore(js, fjs);
             }(document, 'script', 'facebook-jssdk'));</script>
</head>
<body>
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
<!--   <div class="top-section">
   
<div class="date">21 Feb, 2019 | 11:39 AM IST</div>
    	 <div class="date">09 Dec, 2018 | 12:38 PM IST</div>
        <div class="top-right-menu">
        	<ul>
            	<li><a href="#main-content" class="dropdown-arrow"><span>Skip to main content</span></a></li>
                <li> <a href="#slider" class="dropdown-arrow"><span>Skip to navigation</span></a></li>
           <li> <a href="javascript:void(0);" class="black" data-rel="." title=".">A</a>
            <a href="javascript:void(0);" class="white" data-rel="," title=",">A</a></li>
            <li><a href=""><strong>Text Size</strong></a>
            <a href="javascript:void(0);" title="Text Size: Decrease" id="btn-decrease" class="decrease">A-</a>
            <a href="javascript:void(0);" title="Text Size: Normal" id="btn-orig" class="reset">A</a>
            <a href="javascript:void(0);" title="Text Size: Increase" id="btn-increase" class="increase">A+</a></li>
        	<li class="login-re"><a href="#">Login</a>
                <a href="#">Register</a></li>
                <li><a href="/rusafronend/changeLangage/1-/">English</a>
                <a href="/rusafronend/changeLangage/2-/">à¤®à¤°à¤¾à¤ à¥€</a></li>
            </ul>
            
           
        </div>
		
        <div class="clearfix"></div>        
    </div>
	 -->
<script>
			function checkMaintainance() {

				$.getJSON('/rusafronend/checkMaintainance', {
					 ajax : 'true'
				});
			}
		</script>

	<div class="slider" id="slider">
		<div class="container">
			<h1>${editbanner.sliderName}<br> <span>${editbanner.text1}</span>
			</h1>
			<p>${editbanner.text2}</p>
				<a href="${editbanner.urlLink}" class="btn button "><span>${editbanner.linkName}</span></a>
		</div>
	</div>

	<div class="container main-content" id="main-content">
	<div class="card sub-link">
			<div class="row">
				<c:forEach items="${getCMSDesc}" var="getCMSDesc" varStatus="count">

					<div class="col-12 col-sm-3 col-lg-3">
						<div class="sub-link-icon">
							<img
								src="${pageContext.request.contextPath}/resources/images/icon.jpg"
								alt="">
						</div>
						<c:set var="string1" value="${getCMSDesc.pageDesc}" />
						<c:set var="string2" value="${fn:substring(string1, 0, 256)}" />
						<h2>${getCMSDesc.heading}</h2>
						<p>${string2}
						
						</p>
						<div class="more" style="clear:both">
						<a href="${pageContext.request.contextPath}/info/${getCMSDesc.pageSlug}">more... </a>
						</div>
					</div>

				</c:forEach>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-sm-6 col-lg-6">
				<ul class="nav nav-tabs" role="tablist">
					<li class="nav-item nutrition-task-bar-item"><a
						class="nav-link active" data-toggle="tab" href="#update">News And Notification</a></li>

				</ul>
				<div class="tab-content">
					<div id="update" class="tab-pane active">
						<div class="tab-content-section">
							<h5>Digital Launch of Rashtriya Uchchatar Shiksha Abhiyan (RUSA) Projects</h5>
							<p>Digital Launch of Rashtriya Uchchatar Shiksha Abhiyan (RUSA) Projects by Hon’ble Prime Minister on 3rd February 2019 ...</p>
						</div>
						<div class="tab-content-section">
							<h5>15th Meeting of the Project Approval Board</h5>
							<p> 
							PAB meeting to be held on 24th January 2019.  
							Click here to view the minutes of the 15th PAB Meeting Presentation of proposals by institutions approved under component.   ...</p>
						</div>
						<div class="tab-content-section">
							<h5>RUSA Meeting on Preparedness of Digital Launch</h5>
							<p></p>
						</div>
					</div>
				</div>
			</div>


					
    		<div class="col-12 col-sm-3 col-lg-3 gallery">
						<c:if test="${photoList.size()>0}">
						<div class="col-12 col-sm-6 col-lg-6">
							<h3>Recent Gallery</h3>
							<div id="carouselExampleControls" class="carousel slide"
								data-ride="carousel">
								<div class="carousel-inner">

									<c:forEach items="${photoList}" var="editPhotoDetail"
										varStatus="count">

										<c:choose>
											<c:when test="${count.last}">
												<div class="carousel-item active">
													<img
														src="${sessionScope.gallryImageURL}${editPhotoDetail.fileName}"
														width="250" height="228" alt="${editPhotoDetail.title}">
												</div>
											</c:when>
											<c:otherwise>
												<div class="carousel-item">
													<img
														src="${sessionScope.gallryImageURL}${editPhotoDetail.fileName}"
														width="250" height="228" alt="${editPhotoDetail.title}" >
												</div>
											</c:otherwise>
										</c:choose>


									</c:forEach>

								</div>
								<a class="carousel-control-prev" href="#carouselExampleControls"
									role="button" data-slide="prev"> <span
									class="carousel-control-prev-icon" aria-hidden="true"></span> <span
									class="sr-only">Previous</span>
								</a> <a class="carousel-control-next"
									href="#carouselExampleControls" role="button" data-slide="next">
									<span class="carousel-control-next-icon" aria-hidden="true"></span>
									<span class="sr-only">Next</span>
								</a>
							</div>

						</div>
					</c:if>
						</div>
					

			<div class="col-12 col-sm-3 col-lg-3 gallery">
						<h3>Video</h3>
                        <div class="border-box">	
					${videoGalleryDetail[0].fileName}	</div>
                    </div>
                
                
		</div>
		<div class="row news-section">
			<h2>
				<span>News</span>
			</h2>
				<c:forEach items="${newsBlogsList}" var="newsBlogsList"
										varStatus="count">
										<div class="col-12 col-sm-3 col-lg-3">
				<a href="${newsBlogsList.newsSourceUrlName}"><img src="${sessionScope.gallryImageURL}${newsBlogsList.featuredImage}" width="250" height="228" alt="${newsBlogsList.heading}"></a>
				<h5>${newsBlogsList.heading}</h5>
				<c:set var="string4" value="${newsBlogsList.descriptions}" />
				<c:set var="string3" value="${fn:substring(string4, 0, 100)}" />
				<p>${string3}</p>
				<a href="${pageContext.request.contextPath}/NewsDetails/${newsBlogsList.languageId}/${newsBlogsList.pageId}/${newsBlogsList.newsblogsId}">more
				</a>
		</div>
		</c:forEach></div>
		
		<div class="row bottom-section">
			<div class="col-12 col-sm-3 col-lg-3">
				      <div class="twitter">
                        <a class="twitter-timeline" data-chrome="nofooter" data-widget-id="634609273125732352" href="https://twitter.com/HRDMinistry" tabindex="-1">Tweets by @HRDMinistry</a> 
                        <script>window.twttr = (function(d, s, id) {
                                var js, fjs = d.getElementsByTagName(s)[0],
                                  t = window.twttr || {};
                                if (d.getElementById(id)) return t;
                                js = d.createElement(s);
                                js.id = id;
                                js.src = "https://platform.twitter.com/widgets.js";
                                fjs.parentNode.insertBefore(js, fjs);
                              
                                t._e = [];
                                t.ready = function(f) {
                                  t._e.push(f);
                                };
                              
                                return t;
                              }(document, "script", "twitter-wjs"));</script>
                    </div>
			</div>
			<div class="col-12 col-sm-3 col-lg-3">
				  <div class="twitter">
                            <div class="fb-page" data-adapt-container-width="false" data-height="270" data-hide-cover="false" data-href="https://www.facebook.com/HRDMinistry/" data-show-facepile="false" data-small-header="true" data-tabs="timeline" data-width="262">
                                <div class="fb-xfbml-parse-ignore">
                                <blockquote cite="https://www.facebook.com/HRDMinistry/"><p>
                                            <a href="https://www.facebook.com/HRDMinistry/">Ministry of Human Resource Development, Government of India</a></p></blockquote>
                                </div>
                    </div>
                    </div>
			</div> 
			<div class="col-12 col-sm-6 col-lg-6">
				<div class="testimonials">
						<h5>Testimonials</h5>
					<div id="carouselExampleControls2" class="carousel slide"
						data-ride="carousel">
						<div class="carousel-inner"> 
                            <div class="carousel-item active">
                                 
							  <c:forEach items="${sessionScope.testImonial}" var="testImonial"
								varStatus="count">
								<c:choose>
									<c:when test="${count.last}">
										<div class="carousel-item active">

											<c:if test="${not empty testImonial.imageName}">
												<img
													src="${sessionScope.gallryImageURL}${testImonial.imageName}"
													width="100" height="100" alt="${testImonial.fromName}" class="user">

											</c:if>
											<p>
												<strong>${testImonial.fromName}</strong>
											</p>
											<p>${testImonial.message}</p>
										</div>
									</c:when>
									<c:otherwise>
										<div class="carousel-item ">

											<c:if test="${not empty testImonial.imageName}">
												<img
													src="${sessionScope.gallryImageURL}${testImonial.imageName}"
													width="100" height="100" alt="${testImonial.fromName}" class="user">

											</c:if>
											<p>
												<strong>${testImonial.fromName}</strong>
											</p>
											<p>${testImonial.message}</p>
										</div>

									</c:otherwise>
								</c:choose>
							</c:forEach> 
                                </div>

						</div>
						<a class="carousel-control-prev" href="#carouselExampleControls2"
							role="button" data-slide="prev"> <span
							class="carousel-control-prev-icon" aria-hidden="true"></span> <span
							class="sr-only">Previous</span>
						</a> <a class="carousel-control-next" href="#carouselExampleControls2"
							role="button" data-slide="next"> <span
							class="carousel-control-next-icon" aria-hidden="true"></span> <span
							class="sr-only">Next</span>
						</a>
					</div>

				</div>
			</div>
		</div>
	</div>


	


	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>

 	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
	<!-- JavaScript-->

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include> 
	
     <!-- JavaScript-->
     <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
     <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
     <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>    
     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jcarousel.responsive.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.jcarousel.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/ekko-lightbox.js"></script>
<script type="text/javascript">
    $(document).ready(function ($) {

        // delegate calls to data-toggle="lightbox"
        $(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
            event.preventDefault();
            return $(this).ekkoLightbox({
                onShown: function() {
                    if (window.console) {
                        return console.log('Checking our the events huh?');
                    }
                },
                onNavigate: function(direction, itemIndex) {
                    if (window.console) {
                        return console.log('Navigating '+direction+'. Current item: '+itemIndex);
                    }
                }
            });
        });

        //Programatically call
        $('#open-image').click(function (e) {
            e.preventDefault();
            $(this).ekkoLightbox();
        });
        $('#open-youtube').click(function (e) {
            e.preventDefault();
            $(this).ekkoLightbox();
        });
        
        
    });
    
    
</script>   
<script>
           

        $(document).ready(function(){
            
            //link click
            $("a[target='_blank']:not([href$='.pdf'])").click(function () {
                var hrefTemp =$(this).attr('href');
                    var r = confirm(strMsg);
                    alert(r);
                    if (r == true) {
                      //  alert(hrefTemp)
                       // window.location=hrefTemp; 
                       // window.open(hrefTemp);
                        return false;
                     } 

            });
            $("a[target='_blank'][href$='.pdf']").click(function () {
                var hrefTemp =$(this).attr('href');
                    var r = confirm(strMsgPdf);
                    if (r == true) {
                      //  alert(hrefTemp)
                       // window.location=hrefTemp; 
                        window.open(hrefTemp);
                        return false;
                     }
              
            });

            $(document).on("click", "aaaa", function(evt){
                //evt.preventDefault();
               // alert(document.domain);
                    var hrefTemp =$(this).attr('href');
                    var r = confirm(strMsg);
                    if (r == true) {
                        alert(hrefTemp)
                       // window.location=hrefTemp; 
                        window.open(hrefTemp);
                        return false;
                     }
            });

            var $affectedElements = $("div,p,a,h5,h4,h3,h2, li.nav-link"); // Can be extended, ex. $("div, p, span.someClass")
            var rtext = 0;
                // Storing the original size in a data attribute so size can be reset
                $affectedElements.each( function(){
                var $this = $(this);
                $this.data("orig-size", $this.css("font-size") );
                });

                $(".increase").click(function(){
                    if(rtext<3){
                            rtext = rtext + 1;
                            changeFontSize(1);
                        }
                })

                $(".decrease").click(function(){
                    if(rtext>-1){
                            rtext = rtext - 1;
                            changeFontSize(-1);
                                }
                })

                $(".reset").click(function(){
                    $affectedElements.each( function(){
                            var $this = $(this);
                            $this.css( "font-size" , $this.data("orig-size") );
                    });
                })

                function changeFontSize(direction){
                   
                    $affectedElements.each( function(){
                        var $this = $(this);
                        //alert(parseInt($this.css("font-size"))+direction);
                        $this.css( "font-size" , parseInt($this.css("font-size"))+direction );
                    });
                }
            

            // Function to change webpage background color
             
            $(".black").click(function(){
                $("body").css("background","#000");
                $("footer").css("background","#000");
                $("footer p").css("color","#ff0");
                $("footer h6").css("color","#ff0");
                //
                $(".menusats").css("background","#fff");
                $("a").css("color","#ff0");
                $("li").css("color","#ff0");
             //top-section
                $(".top-section").css("background","#000");
                $(".top-section a").css("color","#ff0");
                $(".top-section a span").css("color","#ff0");
                $(".btn .button .search").css("color","#ff0");
                $(".date").css("color","#ff0");
              
              //
                $(".bg-dark_new").css("background","#000");
                $(".bg-dark_new a").css("color","#ff0");

                
                
                
                $(".dropdown-submenu").css("background","#000");
                $(".dropdown-submenu a").css("background","#000");
                $(".dropdown-submenu a").css("color","#ff0");
                 
                $(".dropdown-menu").css("background","#000");
                $(".dropdown-item").css("background","#000");

                //slider
                $(".slider").css("background","#000");
                $(".slider h1").css("color","#ff0");
                $(".slider h1 span").css("color","#ff0");
                $(".slider p").css("color","#ff0");

                $(".slider span").css("color","#ff0");


                //card 
                $(".sub-link").css("background","#000");
                $(".sub-link h2").css("color","#ff0");
                $(".sub-link p").css("color","#ff0");

               // $(".main-content").css("background","#000");

                $("h2 span").css("color","#ff0");
                $(".news-section a").css("color","#ff0");
                $(".news-section p").css("color","#ff0");

                //testimonials
                $(".testimonials").css("background","#000");
                $(".testimonials").css("color","#ff0");
                
                $(".testimonials h5").css("color","#ff0");
                $(".testimonials p").css("color","#ff0");


                
                $(".copy-right").css("background","#000");
                $(".copy-right").css("color","#ff0");
                
                
               // 
                $(".main-content h2").css("color","#ff0");
                $(".main-content p").css("color","#ff0");
                
                //
                $(".leftColm").css("background","#000");
                $(".leftColm h3").css("color","#ff0");
                $(".leftColm h3").css("background","#000");
                $(".leftColm .menu li a").css("color","#ff0");
                //inner-slider
                $(".inner-slider").css("background","#000");
                $(".inner-slider h1").css("color","#ff0");
               
            })
            $(".white").click(function(){
                $("body").css("background","#fff");
                $("footer").css("background","#e8e8e8");
                $("footer p").css("color","#21316c");

                
                $("footer h6").css("color","#21316c");
                $(".menusats").css("background","#fff");
                $("a").css("color","#21316c");
                $("li").css("color","#21316c");

                //top-section
                $(".top-section").css("background","#ececec");
                $(".top-section a").css("color","#21316c");
                $(".top-section a span").css("color","#21316c");
                $(".btn .button .search").css("color","#21316c");
                $(".date").css("color","#21316c");
                
                $(".bg-dark_new").css("background","#21316c");
                $(".bg-dark_new a").css("color","#fff");
                $(".dropdown-submenu").css("background","#fff");
                $(".dropdown-submenu a").css("color","#16181b");
                $(".dropdown-menu").css("background","#fff");
                $(".dropdown-item").css("background","#fff");
                $(".dropdown-item").css("color","#16181b");
                $(".dropdown-item a").css("color","#16181b");
                $(".dropdown-submenu").css("background","#fff");
                $(".dropdown-submenu a").css("background","#fff");
                $(".dropdown-submenu a").css("color","#16181b");
                
                
                //slider
                //$(".slider").css("background","url(/rusafronend/resources/images/slider-bg.jpg) repeat-x");
                document.getElementById('slider').style.backgroundImage="url(/rusafronend/resources/images/slider-bg.jpg)"; // specify the image path here

                $(".slider h1").css("color","#e1341a");
                $(".slider h1 span").css("color","#212121");
                $(".slider p").css("color","#333333");
                $(".slider span").css("color","#21316c");
                
                //card 
                $(".sub-link").css("background","#fff");
                $(".sub-link h2").css("color","#21316c");
                $(".sub-link p").css("color","#4f4f4f");

               // $(".main-content").css("background","#fff");

                $("h2 span").css("color","#21316c");
                
                $(".news-section a").css("color","#21316c");
                $(".news-section p").css("color","#4f4f4f");

                //testimonials
                $(".testimonials").css("background","#ebedf4");
                $(".testimonials").css("color","#000");

                $(".testimonials h5").css("color","#000");
                $(".testimonials p").css("color","#000");

                $(".copy-right").css("background","#21316c");
                $(".copy-right").css("color","#fff");
                $(".copy-right a").css("color","#fff");
                
                $(".main-content h2").css("color","#2d2d2d");
                $(".main-content p").css("color","#4f4f4f");
                
                //
                $(".leftColm").css("background","#efefef"); 
                $(".leftColm h3").css("color","#fff");
                $(".leftColm h3").css("background","#21316c");
                //
                $(".leftColm .menu li a").css("color","#353535");
                
                //inner-slider
                $(".inner-slider").css("background","#00104a");
                $(".inner-slider h1").css("color","#fff");
               
            })
        });
     
    </script>
 <script>
// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    document.getElementById("myBtn").style.display = "block";
  } else {
    document.getElementById("myBtn").style.display = "none";
  }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}
</script>

</body>
</html>

