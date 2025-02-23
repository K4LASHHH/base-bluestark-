var input = new Map();

input.load = () => {
    var listPos = {
        [1]: { container: "300", holders: "130" },
        [2]: { container: "400", holders: "230" },
        [3]: { container: "500", holders: "330" },
        [4]: { container: "570", holders: "420" }
    }

    function showInput(bool, data) {
        if (bool) {

            let placeHolders = ""
            let currentIterator = 0

            data.placeHolders.forEach(element => {
                placeHolders = placeHolders + `<div id="placeholder"> <h2 class = ".input-container h2">${element.label}</h2> <input type="text" id="plc_${currentIterator}" placeholder="" class="input-container-input" required="true" name="need" neo="true" > </div>`
                currentIterator = currentIterator + 1
            })




            $(".input-container-textContainer").html(
                `<h1 class = ".input-container h1">${data.label}</h1>` +
                `<div id="allPlaceHolders" data-aos="zoom-in"></div>` +
                `<button id="input-container-submit" style="outline: none;">${data.submitLabel}</button>`
            );
            $("#allPlaceHolders").html(placeHolders);

            if (!listPos[currentIterator]) {

                $(".input-container").css("height", `${listPos[4].container}px`);
                $("#allPlaceHolders").css("height", `${listPos[4].holders}px`);
            } else {
                $(".input-container").css("height", `${listPos[currentIterator].container}px`);
                $("#allPlaceHolders").css("height", `${listPos[currentIterator].holders}px`);
            }





            $(".input-container").show();


            document.getElementById("input-container-submit").onmouseover = function () { mouseOver() };
            document.getElementById("input-container-submit").onmouseout = function () { mouseOut() };

            function mouseOver() {

                if (checkForAccept(currentIterator)) {
                    document.getElementById("input-container-submit").style.backgroundColor = "rgb(62, 255, 0)";
                } else {
                    document.getElementById("input-container-submit").style.backgroundColor = "rgb(255, 0, 0)";
                }

            }

            function mouseOut() {
                document.getElementById("input-container-submit").style.backgroundColor = "rgb(51, 153, 255)";
            }

            $("#input-container-submit").click(function () {
                if (checkForAccept(currentIterator)) {
                    $.post(`https://${GetParentResourceName()}/input:receiveData`, JSON.stringify(getInfoForAccept(currentIterator)));
                }
            })

            document.onkeyup = function (data) {
                if (data.which == 13) {
                    if (checkForAccept(currentIterator)) {
                        document.getElementById("input-container-submit").style.backgroundColor = "rgb(62, 255, 0)";
                        $.post(`https://${GetParentResourceName()}/input:receiveData`, JSON.stringify(getInfoForAccept(currentIterator)));
                        return
                    } else {
                        document.getElementById("input-container-submit").style.backgroundColor = "rgb(255, 0, 0)";
                    }
                } else if (data.which == 27) {
                    $.post(`https://${GetParentResourceName()}/input:exit`, JSON.stringify({}));
                    showInput(false)
                    return
                }
            };

            // Set focus on the first input element
            $("#allPlaceHolders input:first").focus();
        } else {
            $(".input-container").hide();
        }
    }

    function checkForAccept(max) {
        let accepted = true
        for (let element = 0; element < max; element++) {
            if (!$(`#plc_${element}`).val()) {
                accepted = false
                break
            }
        }
        return accepted
    }

    function getInfoForAccept(max) {
        var table = {}
        for (let element = 0; element < max; element++) {
            table[element] = $(`#plc_${element}`).val()
        }
        return table
    }

    window.addEventListener('message', function (event) {
        var item = event.data;

        if (item.type == "input") {
            if (item.action == true) {
                showInput(true, item.data)
            } else if (item.action == false) {
                showInput(false)
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post(`https://${GetParentResourceName()}/input:exit`, JSON.stringify({}));
            showInput(false)
            return
        }
    };

    showInput(false)
}

export { input }