// Stopwatch
var stopwatchInterval = 0;      // 间隔为我们的循环.

var stopwatchClock = $(".stopwatch").find(".clock"),
    stopwatchDigits = stopwatchClock.find('span');

// 检查是否前一交易日为秒表正在运行时结束.
// 如果是的话有根据时间再次启动.
if(Number(localStorage.stopwatchBeginingTimestamp) && Number(localStorage.stopwatchRunningTime)){

    var runningTime = Number(localStorage.stopwatchRunningTime) + new Date().getTime() - Number(localStorage.stopwatchBeginingTimestamp);

    localStorage.stopwatchRunningTime = runningTime;

    startStopwatch();
}

// If there is any running time form previous session, write it on the clock.
// If there isn't initialise to 0.
if(localStorage.stopwatchRunningTime){
    stopwatchDigits.text(returnFormattedToMilliseconds(Number(localStorage.stopwatchRunningTime)));
}
else{
    localStorage.stopwatchRunningTime = 0;
}

$('#stopwatch-btn-start').on('click',function(){
    if(stopwatchClock.hasClass('inactive')){
        resetStopwatch();
        startStopwatch();
    }
});

$('#stopwatch-btn-pause').on('click',function(){
    pauseStopwatch();
});

$('#stopwatch-btn-reset').on('click',function(){
    resetStopwatch();
});

// Pressing the clock will pause/unpause the stopwatch.
stopwatchClock.on('click',function(){

    if(stopwatchClock.hasClass('inactive')){
        startStopwatch();
    }
    else{
        pauseStopwatch();
    }
});

// 开始计时
function startStopwatch(){
    // 防止多的时间间隔会在同一时间.
    clearInterval(stopwatchInterval);

    var startTimestamp = new Date().getTime(),
        runningTime = 0;

    localStorage.stopwatchBeginingTimestamp = startTimestamp;

    // 该应用程序还记得多久以前的会议上运行.
    if(Number(localStorage.stopwatchRunningTime)){
        runningTime = Number(localStorage.stopwatchRunningTime);
    }
    else{
        localStorage.stopwatchRunningTime = 1;
    }

    // 每100ms重新计算的运行时间，该公式是:
    // time = now - 当你上次启动的时钟+之前的运行时间

    stopwatchInterval = setInterval(function () {
        var stopwatchTime = (new Date().getTime() - startTimestamp + runningTime);

        stopwatchDigits.text(returnFormattedToMilliseconds(stopwatchTime));
    }, 100);

    stopwatchClock.removeClass('inactive');
}

// 暂停计时
function pauseStopwatch(){
    // 停止区间.
    clearInterval(stopwatchInterval);

    if(Number(localStorage.stopwatchBeginingTimestamp)){

        // 在暂停重新计算运行时间.
        // 新的运行时间=前一运行时间+现在 - 我们最后一次启动时钟.
        var runningTime = Number(localStorage.stopwatchRunningTime) + new Date().getTime() - Number(localStorage.stopwatchBeginingTimestamp);

        localStorage.stopwatchBeginingTimestamp = 0;
        localStorage.stopwatchRunningTime = runningTime;

        stopwatchClock.addClass('inactive');
    }
}

// 重置计时.
function resetStopwatch(){
    clearInterval(stopwatchInterval);

    stopwatchDigits.text(returnFormattedToMilliseconds(0));
    localStorage.stopwatchBeginingTimestamp = 0;
    localStorage.stopwatchRunningTime = 0;

    stopwatchClock.addClass('inactive');
}


function returnFormattedToMilliseconds(time){
    //var milliseconds = Math.floor((time % 1000) / 100),
    var seconds = Math.floor((time/1000) % 60),
        minutes = Math.floor((time/(1000*60)) % 60),
        hours = Math.floor((time/(1000*60*60)) % 24);

    seconds = seconds < 10 ? '0' + seconds : seconds;
    minutes = minutes < 10 ? '0' + minutes : minutes;


    return hours + ":" + minutes + ":" + seconds;
}