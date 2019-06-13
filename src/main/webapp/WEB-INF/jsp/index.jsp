<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Time Manager</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">

  <style type="text/css">
    /* banner */
    .banner {position: relative; width: 850px; height: 525px; top: 50px;  margin:0 auto; padding:0; overflow: hidden;}
    .banner ul {position: absolute; margin: 0px; padding:0; list-style: none; }
    .banner ul li {float: left; width: 850px; height: 525px; margin:0; padding:0;}

  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

  <script language="JavaScript">
    <!--
    $(document).ready(function() {
      var $banner = $(".banner").find("ul");

      var $bannerWidth = $banner.children().outerWidth();//이미지의 폭
      var $bannerHeight = $banner.children().outerHeight(); // 높이
      var $length = $banner.children().length;//이미지의 갯수
      var rollingId;

      //정해진 초마다 함수 실행
      rollingId = setInterval(function() { rollingStart(); }, 3000);//다음 이미지로 롤링 애니메이션 할 시간차

      function rollingStart() {
        $banner.css("width", $bannerWidth * $length + "px");
        $banner.css("height", $bannerHeight + "px");
        //alert(bannerHeight);
        //배너의 좌측 위치를 옮겨 준다.
        $banner.animate({left: - $bannerWidth + "px"}, 1500, function() { //숫자는 롤링 진행되는 시간이다.
          //첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
          $(this).append("<li>" + $(this).find("li:first").html() + "</li>");
          //뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
          $(this).find("li:first").remove();
          //다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
          $(this).css("left", 0);
          //이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
        });
      }
    });
    //-->
  </script>

</head>

<body id="page-top">

  <!-- Navbar jsp  -->
  <jsp:include page="./common/navbar.jsp"/>

  <div id="wrapper">

    <!-- sidebar jsp -->
   <jsp:include page="./common/sidebar.jsp"/>

    <div id="content-wrapper">


      <div class="contents">

        <div class="banner">
          <ul>
            <li><img src="https://cdn.pixabay.com/photo/2016/02/01/16/10/eye-1173863__340.jpg" width="850" height="525"></li>
            <li><img src="https://cdn.pixabay.com/photo/2017/12/30/13/25/portrait-3050076__340.jpg" width="850" height="525"></li>
            <li><img src="https://cdn.pixabay.com/photo/2015/07/09/22/45/tree-838667__340.jpg" width="850" height="525"></li>
            <li><img src="https://cdn.pixabay.com/photo/2016/03/05/20/01/art-1238602__340.jpg" width="850" height="525"></li>
            <li><img src="https://cdn.pixabay.com/photo/2015/07/31/15/01/guitar-869217__340.jpg" width="850" height="525"></li>
          </ul>
        </div>
      </div


      <%--footer jsp--%>
      <jsp:include page="./common/footer.jsp"/>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Bootstrap core JavaScript-->
  <script src="/vendor/jquery/jquery.min.js"></script>
  <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="/vendor/chart.js/Chart.min.js"></script>
  <script src="/vendor/datatables/jquery.dataTables.js"></script>
  <script src="/vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/js/sb-admin.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="/js/demo/datatables-demo.js"></script>
  <script src="/js/demo/chart-area-demo.js"></script>

  <script>
    $('#sidebar-1').addClass("active");
  </script>
</body>


</html>
