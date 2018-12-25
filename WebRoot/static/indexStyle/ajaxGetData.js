$(document).ready(function () {
    var liWidth = $("#myTabContent li").width() - 160;
    var searchBox = $("#myTab").width() - 340;
    var searchBox1 = $("#myTab").width();
    $("#ulContent").width(searchBox1);
    $("#myTabContent a").width(liWidth);

    var boxHeight = $("#textCont").height();
    $("#indexCarousel img").css("height", boxHeight);
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串

    $.ajax({
        type: "get",
        url: "http://localhost:8081/a/ecpp/planinformation/Analysisnew",
        dateType:"json",
        success: function (data) {
            $("#mbToatal").text(data.mbToatal);
            $("#gjxToatal").text(data.gjxToatal);
            $("#mbNum1").text(data.mbNum1);
            $("#gjxNum1").text(data.gjxNum1);
            $("#mbNum2").text(data.mbNum2);
            $("#gjxNum2").text(data.gjxNum2);
            $("#mbToatal1").text(data.mbToatal);
            $("#gjxToatal2").text(data.gjxToatal);
        },
        error: function (data) {
            console.info("error: " + data.responseText);
        }
    });
});