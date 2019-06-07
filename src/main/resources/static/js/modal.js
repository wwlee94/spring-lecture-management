var action = "";
var url = "";
var type = "";
var bno = 0;

$(document).ready(function () {

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

    $("#outRoombtn").click(function () {
        url = "/report/delete/"+$("#roomNo").val();

        // var data = {
        //     "name": $("#name").val(),
        //     "password": $("#password").val(),
        //     "manager" : $("#manager").val(),
        //     "info": $("#info").val()
        // };

        $.ajax({
            url: url,
            type: "post",
            // data: data,
            complete: function () {
                location.href = "/report"
            }
        })
    });
});