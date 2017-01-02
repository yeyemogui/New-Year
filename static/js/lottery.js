/**
 * Created by wumingqin on 2017/1/1.
 */
var shuffle = function(arr){
    for(var j, x, i = arr.length; i; j = parseInt(Math.random() * i, 10), x = arr[--i], arr[i] = arr[j], arr[j] = x);
    return arr;
};
var _employeeList = []

var paused = false;
var timer = '';
var start = function(){
    API.get("employee", function(data){
        _employeeList = [];
        _employeeList = shuffle(data);
    })

    $("#lucky").text('The lucky guy is ?');
    index = 0;
    timer = setInterval(function () {
        var im = '<img src="avatar/?.jpg"/ title="?-?" id="folk">';
        index = (index + 1)%_employeeList.length;
        im = im.replace(/\?/, _employeeList[index].num);
        im = im.replace(/\?/, _employeeList[index].name)
        im = im.replace(/\?/, _employeeList[index].num)
        $("#pic").empty();
        $("#pic").append(im);

    }, 10)
};

var snow = function(){
    $("canvas").let_it_snow({
        windPower: 3,
        speed: 1,
        count: 50,
        size: 10,
        image: "/image/white-snowflake.png"
    });
};

//$(document).bind('keyup.return', function(){
$(document).keydown(function(event) {
    if(event.keyCode != 13) {
        return;
    }

    if(paused == false){
        paused = true;
        clearInterval(timer);
        timer = '';
        var title = $("#folk").attr("title");
        var co = title.split('-');
        var name = co[0];
        num = co[1];
        API.post("lucky1", {pool: num});
        $("#lucky").text('Congratuation' + ' ' + name + '(' + num + ')');
        var ca = '<canvas id="ca" width="1920" height="1080" style="position: absolute;z-index: 10;top:0px;left: 0px;"></canvas>'
        $("#ca").append(ca);
        snow();
    }
    else{
        paused = false;
        $("#ca").empty();

        start();
    }
})
//snow();
start();