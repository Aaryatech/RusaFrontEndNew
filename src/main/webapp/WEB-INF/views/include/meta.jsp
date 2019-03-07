<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

        <!-- Bootstrap core CSS -->
        <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/resources/css/ekko-lightbox.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
         <link href="${pageContext.request.contextPath}/resources/css/jcarousel.responsive.css" rel="stylesheet" type="text/css" >
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800|Playfair+Display:400,700,900" rel="stylesheet">
        <script type="text/javascript">
	var st_url = "${sessionScope.siteFrontEndUrl}";
	var dm_url = "${sessionScope.siteDomainUrl}";
	
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