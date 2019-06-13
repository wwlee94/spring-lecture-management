<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>리포트 관리</title>

    <!-- Custom fonts for this template-->
    <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/css/sb-admin.css" rel="stylesheet">

    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>
    <style>
        .scrollspy-example {
            position: relative;
            height: 400px;
            margin-top: 10px;
            overflow: auto;
        }
    </style>

</head>

<body id="page-top">

<!-- Navbar jsp  -->
<jsp:include page="../common/navbar.jsp"/>

<jsp:include page="modal.jsp"/>
<div id="wrapper">

    <!-- sidebar jsp -->
    <jsp:include page="../common/sidebar.jsp"/>

    <div id="content-wrapper">

        <div class="container-fluid">

            <%--상단 탭 --%>
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link" href="/report/room/${roomNo}">방 소개</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/report/report/${roomNo}">과제</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/report/trello/${roomNo}">업무 배분</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/report/chat/${roomNo}">채팅</a>
                </li>
                <input type="hidden" id="room" value="${roomNo}"/>
            </ul>
            <br>


            <div class="container">
                <div id="scroll" class="scrollspy-example">
                    <div id="main-content" class="container">
                        <div class="row">
                            <div class="col-md-6" style="display: none">
                                <div class="form-group">
                                    <label for="connect">WebSocket connection:</label>
                                    <button id="connect" onclick="connect()" class="btn btn-default" type="submit">
                                        Connect
                                    </button>
                                    <button id="disconnect" class="btn btn-default" type="submit" disabled="disabled">
                                        Disconnect
                                    </button>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <table id="conversation" class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>대화방</th>
                                    </tr>
                                    </thead>
                                    <tbody id="greetings">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-9">
                        <div class="form-group">
                            <input type="text" id="name1" class="form-control" placeholder="#Message"
                                   onkeypress="if(event.keyCode==13) {sendName(); return false;}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <button id="send" class="btn btn-default" type="submit">Send</button>
                    </div>
                </div>


            </div>
            <%--footer jsp--%>
            <jsp:include page="../common/footer.jsp"/>
        </div>
        <!-- /.content-wrapper -->
    </div>
    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <script type="text/javascript">

        var stompClient = null;
        var roomNo = $("#roomNo").val();

        connect();

        function setConnected(connected) {
            $("#connect").prop("disabled", connected);
            $("#disconnect").prop("disabled", !connected);
            if (connected) {
                $("#conversation").show();
            } else {
                $("#conversation").hide();
            }
            $("#greetings").html("");
        }

        function connect() {
            var socket = new SockJS('/chat-websocket');
            stompClient = Stomp.over(socket);
            console.log('Connected: test');
            stompClient.connect({}, function (frame) {
                setConnected(true);
                console.log('Connected: ' + frame);
                stompClient.subscribe('/topic/greetings', function (greeting) {
                    console.log(JSON.parse(greeting.body).roomId);
                    console.log(roomNo);
                    if(JSON.parse(greeting.body).roomNo == roomNo ) {
                        showGreeting(JSON.parse(greeting.body).content);
                    }
                });
            });
        }

        function disconnect() {
            if (stompClient !== null) {
                stompClient.disconnect();
            }
            setConnected(false);
            console.log("Disconnected");
        }

        function sendName() {
            stompClient.send("/app/hello/"+roomNo, {}, JSON.stringify({'name': $("#name1").val(),'roomId':roomNo}));
            $("#name1").val("");
        }

        function showGreeting(message) {
            $("#greetings").append("<tr><td>" + message + "</td></tr>");
        }

        $(function () {
            $("form").on('submit', function (e) {
                e.preventDefault();
            });
            $("#connect").click(function () {
                connect();
            });
            $("#disconnect").click(function () {
                disconnect();
            });
            // $( "#send" ).click(function() { sendName(); });
            $("#send").click(function () {
                sendName();
            });
        });
    </script>

    <!-- Bootstrap core JavaScript-->
    <script src="/vendor/jquery/jquery.min.js"></script>
    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/js/sb-admin.min.js"></script>

</body>

</html>
