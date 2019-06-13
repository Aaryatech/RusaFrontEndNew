
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- JavaScript-->
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jcarousel.responsive.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.jcarousel.min.js"></script>
    
                  <script>
$(function() {
    $('.jcarousel')
        .jcarousel({
              interval: 3000,
            target: '+=1',
            autostart: true
        })
        .jcarouselAutoscroll({
            interval: 3000,
            target: '+=1',
            autostart: true
        })
		
		create: $('.jcarousel').hover(function() 
    {
        $(this).jcarouselAutoscroll('stop');
    },
    function() 
    {
        $(this).jcarouselAutoscroll('start');
    });
    ;
});
</script>


<script
	src="${pageContext.request.contextPath}/resources/js/ekko-lightbox.js"></script>

<c:url value="/visitorCount" var="visitorCount"></c:url>
<c:url value="/fixContrast" var="fixContrast"></c:url>
<script type="text/javascript">
	$(document)
			.ready(
					function($) {

						// delegate calls to data-toggle="lightbox"
						$(document)
								.delegate(
										'*[data-toggle="lightbox"]',
										'click',
										function(event) {
											event.preventDefault();
											return $(this)
													.ekkoLightbox(
															{
																onShown : function() {
																	if (window.console) {
																		return console
																				.log('Checking our the events huh?');
																	}
																},
																onNavigate : function(
																		direction,
																		itemIndex) {
																	if (window.console) {
																		return console
																				.log('Navigating '
																						+ direction
																						+ '. Current item: '
																						+ itemIndex);
																	}
																}
															});
										});

						//Programatically call
						$('#open-image').click(function(e) {
							e.preventDefault();
							$(this).ekkoLightbox();
						});
						$('#open-youtube').click(function(e) {
							e.preventDefault();
							$(this).ekkoLightbox();
						});

					});
</script>
<script>
	$(document).ready(
			function() {

				//link click
				/*  $("a[target='_blank']:not([href$='.pdf'])").click(function () {
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
				 */
				var $affectedElements = $("div,p,a,h5,h4,h3,h2, li.nav-link"); // Can be extended, ex. $("div, p, span.someClass")
				var rtext = 0;
				// Storing the original size in a data attribute so size can be reset
				$affectedElements.each(function() {
					var $this = $(this);
					$this.data("orig-size", $this.css("font-size"));
				});

				$(".increase").click(function() {
					if (rtext < 3) {
						rtext = rtext + 1;
						changeFontSize(1);
					}
				})

				$(".decrease").click(function() {
					if (rtext > -1) {
						rtext = rtext - 1;
						changeFontSize(-1);
					}
				})

				$(".reset").click(function() {
					$affectedElements.each(function() {
						var $this = $(this);
						$this.css("font-size", $this.data("orig-size"));
					});
				})

				function changeFontSize(direction) {

					$affectedElements.each(function() {
						var $this = $(this);
						//alert(parseInt($this.css("font-size"))+direction);
						$this.css("font-size", parseInt($this.css("font-size"))
								+ direction);
					});
				}

				// Function to change webpage background color

				$(".black").click(function() {
					$('body').addClass('black_act')
					fixContrast("black_act");
					/*   $("body").css("background","#000");
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
					  $(".login-re a").css("color","#02263c");
					  
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
					  $(".inner-slider h1").css("color","#ff0"); */

				})
				$(".white").click(function() {
					$('body').removeClass('black_act')
					fixContrast("");
					/*  $("body").css("background","#fff");
					 $("footer").css("background","#e8e8e8");
					 $("footer p").css("color","#21316c");

					 
					 $("footer h6").css("color","#21316c");
					 $(".menusats").css("background","#fff");
					 $("a").css("color","#21316c");
					 $("li").css("color","#21316c");

					 //top-section
					 $(".top-section").css("background","#02263c");
					 $(".top-section a").css("color","#fff");
					 $(".top-section a span").css("color","#fff");
					 $(".btn .button .search").css("color","#fff");
					 $(".date").css("color","#fff");


					 $(".login-re a").css("color","#02263c");
					 
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
					 //
					 
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
					 $(".inner-slider h1").css("color","#fff"); */

				})
			});
</script>
<script>
	// When the user scrolls down 20px from the top of the document, show the button
	window.onscroll = function() {
		scrollFunction()
	};

	function scrollFunction() {
		if (document.body.scrollTop > 20
				|| document.documentElement.scrollTop > 20) {
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

<script>
	function fixContrast(contrast) {

		$.getJSON('${fixContrast}', {

			contrast : contrast,
			ajax : 'true',

		}, function(data) {
			//alert(data);
			//location.reload(true);

		});

	}
</script>

<script>
	$(document).ready(function() {
				$.getJSON('${visitorCount}', {
			ajax : 'true',

		}, function(data) {
			$("#visitorCnt").html(data.msg);
			//document.getElementById('visitorCnt').innerHTML = data.msg;

		});
	});
</script>

<script>
window.onscroll = function() {myFunction()};

var header = document.getElementById("stick-menu");
var sticky = header.offsetTop;

function myFunction() {
  if (window.pageYOffset > sticky) {
    header.classList.add("sticky");
  } else {
    header.classList.remove("sticky");
  }
}
</script> 
