var action = "";
var url = "";
var type = "";
var bno = 0;

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
});
