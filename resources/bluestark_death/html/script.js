
time = 0
seconds = 0

resetDeath = false;

window.addEventListener("message", function (event) {
  time = event.data.time
  if (event.data.type == true) {
    $("body").fadeIn(800);
    startTimer(event.data.time)
  } else if (event.data.type == false) {
    $("body").fadeOut(800);
    reset()
  } else if (event.data.type == "reset") {
    resetDeath = true;
  }
});

init = ""
function startTimer(time) {
  reset()
  let counter = document.getElementById('counter'), seconds = time, init;
  init = setInterval(() => {
    seconds--;

    let minutes = Math.floor(seconds / 60)
    let scss = seconds % 60;

    counter.innerHTML = minutes + ":" + (scss < 10 ? "0" : "") + String(scss);
    if (seconds == 0) {
      clearInterval(init);
      reset()
      $.post('http://bluestark_death/respawn', JSON.stringify({}));
    }

    if (resetDeath) {
      clearInterval(init);
      reset();
      resetDeath = false;
    }
  }, 1000);
}

function reset() {
  let counter = document.getElementById("counter");
  let minutes = Math.floor(time / 60)
  let scss = time % 60
  counter.innerHTML = `${minutes}:${scss}`
  $(".svg").css({ 'left': '38rem', 'top': '19.6rem', 'width': '15rem' })
  $(".svg2").css({ 'left': '62rem', 'top': '19.6rem', 'width': '15rem' })
  init = "";
}

document.addEventListener("keydown", (event) => {
  if (event.key === "g") {
    $.post('http://bluestark_death/sendDispatch', JSON.stringify({}));
  }
});

document.addEventListener("keydown", (event) => {
  if (event.key === "e") {
    $.post('http://bluestark_death/respawn', JSON.stringify({}));
  }
});