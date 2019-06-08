var action = "";
var url = "";
var type = "";

$(document).ready(function () {

    //방 생성하기
    $("#modalCreate").click(function () {

        url = "/report/create";

        var data = {
            "name": $("#name").val(),
            "password": $("#password").val(),
            "manager" : $("#manager").val(),
            "info": $("#info").val()
        };

        $.ajax({
            url: url,
            type: "post",
            data: data,
            complete: function (data) {
                location.reload();
            }
        })
    });

    //방나가기
    $("#outRoombtn").click(function () {
        url = "/report/delete/"+$("#roomNo").val();


        $.ajax({
            url: url,
            type: "post",
            complete: function () {
                location.href = "/report"
            }
        })
    });

    //방들어가기
    $("#goInRoom").click(function () {
        url = "/report/attend/"+$("#roomId").val();

        var data = {
            "inputPassword": $("#inputPassword").val(),
        };

        $.ajax({
            url: url,
            type: "post",
            data: JSON.stringify(data),
            async:false,
            dataType :"json",
            contentType: 'application/json',
            complete: function (result) {
                if (result['responseText'] == 'fail') {
                    $("#warning").text('비밀번호가 틀렸습니다.');
                } else {
                    location.href="/report/room/"+result['responseText'];
                }
            }
        })
    });

    //글 쓰기
    $("#addBoardBtn").click(function () {
        url = "/report/report/"+$("#roomNoFromReport").val();

        var data = {
            "title": $("#boardTitle").val(),
            "contents": $("#contents").val()
        };

        $.ajax({
            url: url,
            type: "post",
            data: JSON.stringify(data),
            dataType :"json",
            contentType: 'application/json',
            complete: function (result) {
                location.reload();
            }
        })
    });

    //글 삭제하기
    $("#deleteBoardBtn").click(function () {
        url = "/report/report/"+$("#deleteBno").val();

        $.ajax({
            url: url,
            type: "delete",
            complete: function () {
                location.href = '/report/report/'+$("#roomNoFromDetailReport").val();
            }
        })
    });

    //글 수정하기
    $("#modifiedModalBtn").click(function () {
        url = "/report/report/"+$("#roomNoFromDetailReport").val();

        var data = {
            "bno": $("#modifiedBno").val(),
            "title": $("#modifiedBoardTitle").val(),
            "contents": $("#modifedBoardContents").val()
        };

        $.ajax({
            url: url,
            type: "put",
            data: JSON.stringify(data),
            dataType :"json",
            contentType: 'application/json',
            complete: function (result) {
                location.reload();
            }
        })
    });
});
