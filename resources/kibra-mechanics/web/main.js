var lang = []
var subMenu = []
var secilmisMenu = 0
var nitro = 0
var alttablo = []
var platefiyat = 0 
var bossmenugardas = false
var plate = "Kibra"
var nTable = []
var freeMi = false
var mechanicId = 0
var aracParcaOran = 0 
var employees = []
var memati = []
var toplamOdenecek = 0
var rgbColor = false
var CalisaninAlacagiYazik = 0
var company = false 
var repairfee = 0 
var mevcutRenkMenu = null 
var vehicleColor1 = 0
var vehicleColor2 = 0
var vehicleColor3 = 0
var vehshop = false
var vehiclePrice = 0
var aracoran = 0

function GetHornName(index){
    if (index == 0){
        return "Truck Horn"
    } else if (index == 1){
        return "Cop Horn"
    } else if (index == 2){ 
        return "Clown Horn"
    } else if (index == 3){ 
        return "Musical 1"
    } else if (index == 4){ 
        return "Musical 2"
    } else if (index == 5){ 
        return "Musical 3"
    } else if (index == 6){ 
        return "Musical 4"
    } else if (index == 7){ 
        return "Musical 5"
    } else if (index == 8){ 
        return "Sad Trombone"
    } else if (index == 9){ 
        return "Classical 1"
    } else if (index == 10){ 
        return "Classical 2"
    } else if (index == 11){ 
        return "Classical 3"
    } else if (index == 12){ 
        return "Classical 4"
    } else if (index == 13){ 
        return "Classical 5"
    } else if (index == 14){ 
        return "Classical 6"
    } else if (index == 15){ 
        return "Classical 7"
    } else if (index == 16){ 
        return "Scale - Do"
    } else if (index == 17){ 
        return "Scale - Re"
    } else if (index == 18){ 
        return "Scale - Mi"
    } else if (index == 19){ 
        return "Scale - Fa"
    } else if (index == 20){ 
        return "Scale - Sol"
    } else if (index == 21){ 
        return "Scale - La"
    } else if (index == 22){ 
        return "Scale - Ti"
    } else if (index == 23){ 
        return "Scale - Do"
    } else if (index == 24){ 
        return "Jazz 1"
    } else if (index == 25){ 
        return "Jazz 2"
    } else if (index == 26){ 
        return "Jazz 3"
    } else if (index == 27){ 
        return "Jazz"
    } else if (index == 28){ 
        return "Star Spangled 1"
    } else if (index == 29){ 
        return "Star Spangled 2"
    } else if (index == 30){ 
        return "Star Spangled 3"
    } else if (index == 31){ 
        return "Star Spangled 4"
    } else if (index == 32){ 
        return "Classical 8"
    } else if (index == 33){ 
        return "Classical 9"
    } else if (index == 34){ 
        return "Classical 10"
    } else if (index == 35){ 
        return "Classical 8"
    } else if (index == 36){ 
        return "Classical 9"
    } else if (index == 37){ 
        return "Classical 10"
    } else if (index == 38){ 
        return "Funeral"
    } else if (index == 39){ 
        return "Funeral"
    } else if (index == 40){ 
        return "Spooky"
    } else if (index == 41){ 
        return "Spooky"
    } else if (index == 42){ 
        return "San Andreas"
    } else if (index == 43){ 
        return "San Andreas"
    } else if (index == 44){ 
        return "Liberty City"
    } else if (index == 45){ 
        return "Liberty City"
    } else if (index == 46){ 
        return "Festive 1"
    } else if (index == 47){ 
        return "Festive 1"
    } else if (index == 48){ 
        return "Festive 2"
    } else if (index == 49){ 
        return "Festive 2"
    } else if (index == 50){ 
        return "Festive 3"
    } else if (index == 51){ 
        return "Festive 3"
    } else {
        return "Unknown"
    }
}

function GetWindowName(index){
    if (index == 1){
        return "Pure Black"
    } else if (index == 2){
        return "Darksmoke"
    } else if (index == 3){
        return "Lightsmoke"
    } else if (index == 4){
        return "Limo"
    } else if (index == 5){
        return "Green"
    } else {
        return "Unknown"
    }
}

function GetHeadLightBarColorNames(index){
    if(index == 0){
        return "White"
    } else if (index == 1){
        return "Blue"
    } else if (index == 2){
        return "Electric Blue"
    } else if (index == 3){
        return "Mint Green"
    } else if (index == 4){
        return "Lime Green"
    } else if (index == 5){
        return "Yellow"
    } else if (index == 6){
        return "Golden Shower"
    } else if (index == 7){
        return "Orange"
    } else if (index == 8){
        return "Red"
    } else if (index == 9){
        return "Pony Pink"
    } else if (index == 10){
        return "Hot Pink"
    } else if (index == 11){
        return "Purple"
    } else if (index == 12){
        return "Black Light"
    }
}

function GetPlatesName(index){
    if (index == 0){
        return "Blue On White"
    } else if (index == 1){
        return "Yellow on Black"
    } else if (index == 2){
        return "Yellow Blue"
    } else if (index == 3){
        return "Blue On White 2"
    } else if (index == 4){
        return "Blue On White 3"
    }
}

var plateSpace = null
var rgbFee = null 

$(function() {
    window.addEventListener('message', function(event) {
        var type = event.data.type
        var data = event.data
        if (type === 'OpenMechanic'){
            $("#mContainer").fadeIn(500);
            if(data.plateDegistirilebilemez === false){
                $('.PlateChangeButton').hide()
            }
            $("#CarModelName").html(data.modelname)
            $('#carplateprice').html(data.plateprice);
            $('#FixlemeUcret').html("$"+data.fixucret);
            repairfee = data.fixucret
            platefiyat = data.plateprice;
            LoadCar(data)
            nitro = data.data.modTurbo
            plateSpace = data.plateSpace
            rgbColor = data.rgbColor
            vehshop = data.vehicleshop
            nTable = data.mech
            memati = data.colorType
            vehiclePrice = data.vehiclePrice 
            aracoran = data.aracOran 
            aracParcaOran = data.aracparcaoran
            LoadMenu(data.mechanicmenu)
            freeMi = data.freeEmployee
            rgbFee = data.rgbColorPrice
            vehicleColor1 = data.renk1
            vehicleColor2 = data.renk2
            vehicleColor3 = data.renk3
            mechanicId = data.id
            plate = data.plate
            lang = data.lang
            company = data.company
            subMenu = data.kibraSubMenu
            $('#pressmouseactive').html(data.mousetext);
            if(company){
                $('#paybutton').html(lang["SendInvoice"])
            } else {
                $('#paybutton').html(lang["Payment"])
            }
        } else if (type == "Almayacam"){
            $('.KabulEttinmiTablosu').fadeOut(500);
        } else if (type == "OpenTowTruckMenu"){
            LoadTowTrucks(data.vehicles)
        } else if (type == "Towtruckkapat"){
            $('.TowTruckMenu').fadeOut(500);
            $('.TowTrucksList').html("");
        } else if (type == "ShowReqScreen"){
            PlayerRequestMenu(data.data, data.table, data.mysource)
        } else if (type == "FaturaKesilecekler"){
            $('.ButtonKisim').html("");
            BillMenu(data.tablo)
        } else if (type == "OpenBossMenu"){
            mechanicId = data.data.mId
            lang = data.data.lang
            employees = data.data.calisanlar
            bossmenugardas = true
            OpenBossMenu(data.data)
        } else if (type == "YanimdakileriYukle"){
            AroundMePersons(data.Table)
        } else if (type == "ZorlaKapat"){
            $('#bossMenuMain').fadeOut(500);
            $('#BurayaGelecek').html("")
            $('#BurayaGelecek2').html("");
            $('.OyuncularGelecek').html("");
            $.post('http://kibra-mechanics/CloseBossMenu', JSON.stringify({}))
        } else if (type == "OdemeBasarili"){
            $('#mContainer').fadeOut(500);
            $('.ButtonKisim').html("");
            $('.FaturalandirmaPanel').fadeOut(500)
            $.post('http://kibra-mechanics/Klose', JSON.stringify({}));
        } else if(type == "OpenBillingPanel"){
            $('.ButtonKisim').html("");
            OpenBillingMenuTable(data.data)
        } else if(type == "OpenBireyselFatura"){
            $('.Sepeticerik').html("")
            OpenBillingBireysel(data.data)
        } else if (type == "RefreshMenu"){
            $('.CarCustomize').html("");
            LoadMenu(data.mechanicmenu)
        } else if (type == "KapatBan"){
            $('.KabulEttinmiTablosu').fadeOut(500);
            $('.ButtonKisim').html("");
            $('.Liste').html("")
        } else if (type == "Refo"){
            OpenBillingMenuTableMini(data.data)
        } else if (type == "UiKapat"){
            HerseyiKapat5()
        } else if (type == "LoadSubMenuV"){
            $('.CarCustomize').html("");
            LoadSubMenu(data.mechanicmenu)
        } else if (type == "requestColorTable"){
            RenkTabloUplaod(data.table, data.icon, data.modtype, data.backMenu, data.menuType, data.menuStringID, data.modname)
        } else if (type === "CloseMechanic"){
            $('#mContainer').fadeOut(500)
        } else if (type == "Notify"){
            Notification(event.data.text, event.data.typex);
        } else if (type == "CalisanlarYukle"){
            CalisanlariYukle();
        } else if(type == "PlateChangeTemplate"){
            OpenPlateChange(event.data.plate) 
        } else if(type == "RefreshBasket"){
            LoadBasket(event.data.data)
        } else if(type == "LoadMenu"){
            LoadOption(data.menu, data.icon, data.modType, data.props, data.parcaid, data.tekerlenk, data.back)
            lang = data.lang
            alttablo = data.butarzbenim
            if(data.modType == 17){
                nitro = data.props.modTurbo
            }
            subMenu = data.kibraSubMenu
        } else if (type == "loadSubMenu"){
            let mechanic = data.subMenu
            var back = data.back
            if(back == null){back = "back"}
            $('.CarCustomize').html(`
            <div id="${back}" style="top: ${data.yukseklik};" class="XPoart">
                <center><i class="fa-solid fa-rotate-left"></i></center>
                <h3>Back</h3>
            </div>
            `);
            var mtext = ""
            for (let data = 0; data < mechanic.length; data++){
                const v = mechanic[data];
                if(v.menuImg){
                    mtext = mtext + `
                    
                    <div id="menuButton" ikinci="${v.modtyp}" data-modtype="${v.type}" class="XPoart">
                        <center><img class="mechaniclogo" src="${v.menuIcon}"></center>
                        <h4>${v.menuLabel}</h4>
                    </div>`
                } else {
                    mtext = mtext + `
                    <div ikinci="${v.modtyp}" id="menuButton" data-modtype="${v.type}" class="XPoart">
                        <center><i class="${v.menuIcon}"></i></center>
                        <h3>${v.menuLabel}</h3>
                    </div>`
                }      
            }
            $('.CarCustomize').append(mtext);
        }
    });
});

LoadTowTrucks = function(data){
    $('.TowTruckMenu').fadeIn(500)
    for (let index = 0; index < data.length; index++) {
        const element = data[index];
        var Model = element.Model
        let popo = null
        if(Model === "flatbed3"){
            Model = "flatbed"
        }
        if(element.isAddon == false){
            popo = `
            <div id="SelectCar" arac-id="${index}" data-arac="${element.Model}" class="TowTruck1">
                <center><img src="https://docs.fivem.net/vehicles/${Model}.webp"></center>
                <h1>${element.Label}</h1>
            </div>
            `
        } else {
            popo = `
            <div id="SelectCar" arac-id="${index}" data-arac="${element.Model}" class="TowTruck1">
                <center><img src="img/${element.img}"></center>
                <h1>${element.Label}</h1>
            </div>
            `
        }
        $('.TowTrucksList').append(popo)
    }
}

$(document).on('click','#SelectCar',function(){
    $.post('http://kibra-mechanics/SpawnTownTruck', JSON.stringify({
        mechid: $(this).attr("arac-id"),
        carmodel: $(this).attr("data-arac"),
    }));
})

OpenBillingMenuTableMini = function(data){
    $('.UrunSepeti').html("")
    var otext = ""
    var data = data
    var sum = 0
    var sum2 = 0
    var array = data.tablo
    $('#toplamUcret').html(0)
    $('#toplamUcret2').html(0);
    $('#bizimkininalacagi').html(0)
    $('#bizimkininalacagi').html(0)
    for (let index = 0; index < array.length; index++) {
        var total = sum += parseInt(array[index].Price)
        var totos = sum2 += parseInt(array[index].Price) 
        if(company){
            if(data.discount > 0){
                TotalFiyat = musteriDiscount(totos, data.discount)
                toplamOdenecek = TotalFiyat
                $('#toplamUcret2').html(TotalFiyat);
                $('#bizimkininalacagi').html('<span id="getBenimMaas">'+percentage(TotalFiyat, data.pay)+'</span>' + ' <font size="font-size: 2vh;">(%'+data.pay+')</font>')
                CalisaninAlacagiYazik = percentage(TotalFiyat, data.pay)
            } else {
                toplamOdenecek = total
                $('#bizimkininalacagi').html('<span id="getBenimMaas">'+percentage(totos, data.pay)+'</span>')
            }
        } else {
            $('#KemanciyiReportla').html(total);
            toplamOdenecek = total
        }
        $('#toplamUcret').html(total)
        const element = array[index];
        otext = `
        <div class="Urun1">
            <div class="Taraf">
                <button tablo="${array}" data="${data.tablo}" modtype="${element.Type}" id="CinYurt" class="Cinyurt"><i class="fa-solid fa-trash"></i></button>
            </div>
            <div class="Kesme">
                <h1>${element.ModName} - $${element.Price}</h1>
            </div>
        </div>`
        $('.UrunSepeti').append(otext)
    }
}

PlayerRequestMenu = function(data, table, mysource){
    var bu2 = ""
    $('.ListOne').html("");
    $('.FaturalandirmaPanel').hide()
    $('.KabulEttinmiTablosu').fadeIn(500)
    $("#Param").html("$"+data.TotalUcret)
    $('.buttonbeyler').html(`
    <button felsefeci="${mysource}" id="KapatBirader" class="MerhabaGey">Cancel</button>
    <button id="Alacam" total="${data.TotalUcret}" idx="${data.MekanikID}" felsefeci="${mysource}" calisan="${data.CalisaninAlacagi}" source="${data.MusteriSource}" class="MerhabaGey" style="background: #1a9a39;">Approve</button>`)
    for (let index = 0; index < table.length; index++) {
        const element = table[index];
        bu2 = `
        <div class="ListOne">
            <p>${element.ModName} - $${element.Price}</p>
        </div>`
        $('#Kemanci').append(bu2)
    }
}

$(document).on('click','#Alacam',function(){
    $.post('http://kibra-mechanics/Klose', JSON.stringify({}));
    $.post('http://kibra-mechanics/Verified', JSON.stringify({
        source: $(this).attr("source"),
        calisan: $(this).attr("calisan"),
        calisansrc: $(this).attr("felsefeci"),
        total: $(this).attr("total"),
        mekid: $(this).attr("idx"),
        plate: plate
    }));
})

$(document).on('click','#KapatBirader',function(){
    $.post('http://kibra-mechanics/CloseMechanic', JSON.stringify({}));
    $.post('http://kibra-mechanics/AlmayacamBaba', JSON.stringify({
        calisanID: $(this).attr("felsefeci")
    }));
})

$(document).on('click','#FixClean',function(){
    $.post('http://kibra-mechanics/FixCleanCar', JSON.stringify({
        ucret: repairfee
    }));
})


OpenBillingBireysel = function(data){
    $('#mContainer').fadeOut(500)
    $('.FaturalandirmaPanel').fadeIn(500);
    $('#mechanicName').html(data.mechanicName);
    $('.UrunSepeti').html("");
    $('.ButtonKisim').html("");
    var otext = ""
    var data = data
    var sum = 0
    var sum2 = 0
    var byte = ""
    var TotalFiyat = 0
    var Totos = 0
    var array = data.sepet
    for (let index = 0; index < array.length; index++) {
        TotalFiyat = sum += parseInt(array[index].Price)
        Totos = sum2 += parseInt(array[index].Price)
        const element = array[index];
        toplamOdenecek = TotalFiyat
        butu = `
        <div class="SepetOnemli">
            <h1>PAY</h1>
        </div>
        <div class="NameKutuBaba">
            <h3>Invoice Person: <font style="font-weight: 600;">${data.PlayerName}</font></h3>
        </div>
        <div style="position: relative; top: -6vh;" class="OdenecekTutarKutusu"></div>` 
        $('#Sepeticerik').html(butu)
        byte =  `                    
        <h1>AMOUNT TO BE PAID</h1>
        <p><font style="font-weight: 600;">$<span id="KemanciyiReportla">${toplamOdenecek}</span></font></p>`
        otext = `
        <div class="Urun1">
            <div class="Taraf">
                <button tablo="${array}" data="${data}" modtype="${element.Type}" id="CinYurt" class="Cinyurt"><i class="fa-solid fa-trash"></i></button>
            </div>
            <div class="Kesme">
                <h1>${element.ModName} - $${element.Price}</h1>
            </div>
        </div>`
        $('.OdenecekTutarKutusu').html(byte)
        $('.UrunSepeti').append(otext)
        $(".ButtonKisim").css("position", "relative");
        $(".ButtonKisim").css("top", "9vh");
        $('.ButtonKisim').html(`
    <button id="BireyselFaturaKes" mod="${element.Type}" icerik="${element.Mod}" MusteriSource="${data.source}" class="FaturaGonder">Pay</button>
    <button id="GeriDon" style="top: 2vh;" class="FaturaGonder">Back to Modification</button>);`);
    }
}

$(document).on('click', '#BireyselFaturaKes', function(){
    $.post('http://kibra-mechanics/BireyselOdeme', JSON.stringify({
        MusteriSource: $(this).attr("MusteriSource"),
        TotalUcret: toplamOdenecek,
        CalisaninAlacagi: CalisaninAlacagiYazik,
        MekanikID: mechanicId,
        mod: $(this).attr("mod"),
        icerik: $(this).attr("icerik")
    }));
})

OpenBillingMenuTable = function(data){
    $('#mContainer').fadeOut(500)
    $('.FaturalandirmaPanel').fadeIn(500);
    $('#mechanicName').html(data.mechanicName);
    $('#KesilecekKisi').html(data.PlayerName);
    $('.UrunSepeti').html("");
    $('.ButtonKisim').html("");
    var otext = ""
    var data = data
    var sum = 0
    var sum2 = 0
    var byte = ""
    var TotalFiyat = 0
    var Totos = 0
    var array = data.sepet
    for (let index = 0; index < array.length; index++) {
        TotalFiyat = sum += parseInt(array[index].Price)
        Totos = sum2 += parseInt(array[index].Price)
        const element = array[index];
        if(data.discount > 0){
            TotalFiyat = musteriDiscount(Totos, data.discount)
            toplamOdenecek = TotalFiyat
            byte =  `
            <h1>AMOUNT TO BE PAID</h1>
            <del><p><font style="font-size: 1.9vh;position: relative;color: #ccc; top: -2vh;" font-weight: 600;">$<span id="toplamUcret">${Totos}</span></font></p></del>
            <p><font style="position: relative;top: -6vh; font-weight: 600;">$<span id="toplamUcret2">${TotalFiyat}</span></font></p>`
        } else {
            toplamOdenecek = TotalFiyat
            byte =  `                    
            <h1>AMOUNT TO BE PAID</h1>
            <p><font style="font-weight: 600;">$${TotalFiyat}</span></font></p>`
        }
        CalisaninAlacagiYazik = percentage(TotalFiyat, data.mechanicPay)
        $('#bizimkininalacagi').html('<span id="getBenimMaas">'+percentage(TotalFiyat, data.mechanicPay)+'</span>' + ' <font size="font-size: 2vh;">(%'+data.mechanicPay+')</font>')
        otext = `
        <div class="Urun1">
            <div class="Taraf">
                <button tablo="${array}" data="${data}" modtype="${element.Type}" id="CinYurt" class="Cinyurt"><i class="fa-solid fa-trash"></i></button>
            </div>
            <div class="Kesme">
                <h1>${element.ModName} - $${element.Price}</h1>
            </div>
        </div>`
        $('.OdenecekTutarKutusu').html(byte)
        $('.UrunSepeti').append(otext)
        $('.ButtonKisim').html(`
    <button id="OkudumKabulEdiyom" mod="${element.Type}" icerik="${element.Mod}" MusteriSource="${data.source}" class="FaturaGonder">Send Invoice</button>
    <button id="GeriDon" style="top: 2vh;" class="FaturaGonder">Back to Modification</button>);`);
    }
    if(freeMi == true){
        $('.ButtonKisim').append(`<button id="FreeMekanik" style="height: 4vh; top: 2vh; margin-top: 1vh;" class="FaturaGonder">Use Employee Discount (Free)</button>`)
    }
}

$(document).on('click','#OkudumKabulEdiyom',function(){
    $.post('http://kibra-mechanics/BuyModifiye', JSON.stringify({
        MusteriSource: $(this).attr("MusteriSource"),
        TotalUcret: toplamOdenecek,
        CalisaninAlacagi: CalisaninAlacagiYazik,
        MekanikID: mechanicId,
        mod: $(this).attr("mod"),
        icerik: $(this).attr("icerik")
    }));
})

$(document).on('click', '#FreeMekanik', function(){
    Notification(lang["InstalledModifie"], "success")
    HerseyiKapat5()
    $.post('http://kibra-mechanics/CloseMechanicBaba', JSON.stringify({}));
})

$(document).on('click','#CinYurt',function(){
    $.post('http://kibra-mechanics/TablodanSil', JSON.stringify({
        tablo: $(this).attr("tablo"),
        modtype: $(this).attr("modtype"),
        data: $(this).attr("data"),
        mekanikID: mechanicId
    }));
})

$(document).on('click','#TekrarEskiyiAc',function(){
    $('.FaturalandirmaPanel').fadeOut(500)
    $('.OyuncularGelecek').html("");
    $('.UrunListesi').html("");
    $('.ButtonKisim').html("");
    $.post('http://kibra-mechanics/FaturaKesilebilecekAdamlar', JSON.stringify({}));
})

$(document).on('click','#GeriDon',function(){
    $('.ButtonKisim').html("");
    $('.OdenecekTutarKutusu').html("");
    $('.FaturaKesilecekMenusu').fadeOut(500)
    $('.OyuncularGelecek').html("");
    $('.FaturalandirmaPanel').hide()
    $('.UrunSepeti').html("")
    $("#mContainer").fadeIn(500);
    $.post('http://kibra-mechanics/TabloBosalt', JSON.stringify({}));
})

function percentage(fiyat, yuzde) {
    var kdv = fiyat*yuzde/100;
    var toplam = parseInt(fiyat) + parseInt(kdv);
    return Math.ceil(kdv)
}

function musteriDiscount(fiyat, yuzde) {
    var kdv = fiyat*yuzde/100;
    var toplam = parseInt(fiyat) + parseInt(kdv);
    return fiyat-Math.ceil(kdv)
}

OpenBossMenu = function(data){
    var cfg = data.mekanik
    $('#bossMenuMain').fadeIn(500);
    CalisanlariYukle();
    $('#BurayaGelecek').html("")
    $('#BurayaGelecek2').html("")
    $('#BurayaGelecek3').html("")
    $('#CalisanSayi').html(data.calisaniscisayisi)
    $('#BurayaGelecek4').html("")
    $('#MechanicOwner').html(data.playerName)
    $('#MechanicName').html(cfg.MechanicName)
    $('#MechanicMoney').html(cfg.Money),
    $('.ListelenecekKisim').html("")
    CustomerMenuLoad(data.customers)
    $('#mekanikSalePrice').html(data.mekanikSalePrice)
    let mekanikSalaryPermod = '%'+cfg.SalaryPerMod
    let discount = '%'+cfg.DiscountRate
    let ctext = `<input id="YuzdeMiktar" type="number" placeholder="${mekanikSalaryPermod}" class="gorunmezUnput">`
    let ytext = `<input id="MechanicNameX" style="font-size: 3vh; top: 3vh;" type="text" placeholder="${cfg.MechanicName}" class="gorunmezUnput">`
    let ytextx = `<input id="MechanicRate" type="number" style="font-size: 3vh; top: 3vh;" type="text" placeholder="${discount}" class="gorunmezUnput">`
    let ytextxx = `<input id="MechanicFixFee" type="number" style="font-size: 3vh; top: 3vh;" type="text" placeholder="$${cfg.VehicleRepairAndCleaningLaborPrice}" class="gorunmezUnput">`
    $('#BurayaGelecek').append(ctext)
    $('#BurayaGelecek2').append(ytext)
    $('#BurayaGelecek3').append(ytextx)
    $('#BurayaGelecek4').append(ytextxx)
}

CustomerMenuLoad = function(data){
    for (let index = 0; index < data.length; index++) {
        const element = data[index];
        var huu = ""
        huu = `
        <div class="byCengiz">
            <div class="solLeft">
                <p>${index+1}</p>
                <div class="isimkutusu">
                    <p>${element.PlayerName}</p>
                </div>
            </div>
            <div class="sagRight">
                <p>$${element.Price}</p>
                <h6 class="platexx">(${element.Plate})</h6>
            </div>
        </div>`
        $('.ListelenecekKisim').append(huu)
    }
}

BillMenu = function(data){
    $('.FaturaKesilecekMenusu').fadeIn(500)
    $('.OyuncularGelecek').html("");
    $('.Homelander').fadeIn(500);
    var tablo = data.tablo
    for (let index = 0; index < tablo.length; index++) {
        const element = tablo[index];
        let rtx = ""
        if(element.Identifier == data.owner){
           rtx = `
            <div id="BasMoruk" source="${element.Source}" identifier="${element.Identifier}" name="${element.PlayerName}" class="Oyuncu1">
                <h3>Source ${element.Source}</h3>
                <p>${element.PlayerName}</p>
                <h4>(${lang["CarOwner"]})</h4>
            </div>`
        } else {
            rtx = `
            <div id="BasMoruk" source="${element.Source}" identifier="${element.Identifier}" name="${element.PlayerName}" class="Oyuncu1">
                <h3>Source ${element.Source}</h3>
                <p>${element.PlayerName}</p>
            </div>`
        }
        $('.OyuncularGelecek').append(rtx)
    }
}


$(document).on('click','#BasMoruk',function(){
    $('.FaturaKesilecekMenusu').fadeOut(500)
    $('.OyuncularGelecek').html("");
    $('.Homelander').fadeOut(200);
    $('#YenileKardesim').html("");
    $.post('http://kibra-mechanics/FaturaKesMenusu', JSON.stringify({
        identifier: $(this).attr("identifier"),
        playerName: $(this).attr("name"),
        playerSource: $(this).attr("source"),
        mekanikID: mechanicId
    }));
})

$(document).on('click', '#TabloyuBaa', function(){
    $.post('http://kibra-mechanics/SilTabloyu', JSON.stringify({
        id: mechanicId
    }));
})

var menuNumber = 12000

RenkTabloUplaod = function(table, icon, modtype, backMenu, menuType, menuStringID){
    if(backMenu == null){backMenu = "back4"}

    if(backMenu == "tekerlekmenusu"){bck = "tekerlekmenusu"}else{bck = "ustrenkler"}
    $('.CarCustomize').html(`
    <div id="${backMenu}" style="top: 0.2vh;" class="XPoart">
        <center><i class="fa-solid fa-rotate-left"></i></center>
        <h3>Back</h3>
    </div>
    `);

    if(modtype == 1986){
        $('.CarCustomize').append(`
        <div id="neonIptal" style="top: 0.2vh;" class="XPoart">
            <center><i class="fa-brands fa-neos"></i></center>
            <h3>Neon Remove</h3>
        </div>`); 
    }
    let html = "";

    menuNumber = modtype

    if(menuNumber === 1300){
        for (let index = 0; index < table.length; index++) {
            const element = table[index];
            if(menuType == "AnaRenkMenusu"){
                html = `
                <div id="RenkSec" altID="${menuStringID}" backmenu="${bck}" modtype="${modtype}" secilenRenk="${element.index}" class="XPoart">
                    <center><i class="${icon}"></i></center>
                    <h3>${element.label}</h3>
                </div>`
            } else if(menuType == "AltRenkMenusu"){
                html = `
                <div id="RenkUpload" altID="${menuStringID}"  modtype="${modtype}" secilenRenk="${element.index}" renkFiyat="${subMenu[menuStringID].priceDefault}" class="XPoart">
                    <center><i class="${icon}"></i></center>
                    <h3>${element.label}</h3>
                    <p>$${subMenu[menuStringID].priceDefault}</p>
                </div>`;
            } else if(menuType == "RGBRenkler"){
                html = ` 
                <div id="RenkUpload" altID="${menuStringID}"  modtype="${modtype}" secilenRenk="${index+1}" renkFiyat="${subMenu[menuStringID].priceDefault}" class="XPoart">
                    <center><i class="${icon}"></i></center>
                    <h3>${element.label}</h3>
                    <p>$${subMenu[menuStringID].priceDefault}</p>
                </div>`;
            }
            $('.CarCustomize').append(html);
        }
    } else {
        $('.CarCustomize').append(`
        <div altID="${menuStringID}"  modtype="${modtype}" style="top: 0.2vh;" class="XPoart">
            <center><input class="rgba" type="color" id="renk" name="renk" value="#ff0000"></center>
            <h3>RGB Color</h3>
        </div>`); 
    
        const renkSelect = document.querySelector('#renk');
        const rgbP = document.querySelector("#rgb");
    
        renkSelect.addEventListener("input", function() {
            const renk = renkSelect.value;
            const rgb = hexToRgb(renk);
            // rgbP.textContent = `RGB: ${rgb.r}, ${rgb.g}, ${rgb.b}`;
            $.post('http://kibra-mechanics/RGBLoad', JSON.stringify({
                r: rgb.r,
                g: rgb.g,
                b: rgb.b,
                type: menuNumber,
                renkFiyat: $(this).attr('renkFiyat')
            }));
        });
        for (let index = 0; index < memati.length; index++) {
            const element = memati[index]
            if(menuType == "AnaRenkMenusu"){
                html = `
                <div id="RenkTypeSelect" typeMod="${modtype}" backmenu="${bck}" secilen="${element.id}" class="XPoart">
                    <center><i class="fa-duotone fa-paint-roller"></i></center>
                    <h3>${element.label}</h3>
                </div>`
            }
            $('.CarCustomize').append(html);
        }
    }
}

function hexToRgb(hex) {
    const r = parseInt(hex.substr(1, 2), 16);
    const g = parseInt(hex.substr(3, 2), 16);
    const b = parseInt(hex.substr(5, 2), 16);
    return { r, g, b };
}

$(document).on('click','#RenkUpload',function(){
    $.post('http://kibra-mechanics/RenkUpload', JSON.stringify({
        color: $(this).attr("secilenRenk"),
        modtype: $(this).attr("modtype"),
        
        renkFiyat: $(this).attr('renkFiyat')
    }));
})

$(document).on('click','#OdemeYap',function(){
    $('#YenileKardesim').html("");
    if(company){
        $.post('http://kibra-mechanics/FaturaKesilebilecekAdamlar', JSON.stringify({}));
    } else {
        $.post('http://kibra-mechanics/BireyselFatura', JSON.stringify({}));
    }
})

$(document).on('click','#ParaSalIslemlerKardes',function(){
   $('.AltMenu').fadeOut(500)
   $('.ParaIslem').fadeIn(500)
   $('.Calisanlar').html("");
   $('.Calisanlar').fadeOut(500);
})

$(document).on('click','#Calisanlarim',function(){
    $('.Calisanlar').html("");
    $('.AltMenu').fadeOut(500)
    $('.ParaIslem').fadeOut(500)
    $('.Calisanlar').fadeIn(500);
    CalisanlariYukle()
})

CalisanlariYukle = function(){
    $('.Calisanlar').html(`
    <div class="MechanicUnBox5">
        <p>${lang["RecruitNewStaff"]}</p>
        <div class="LanMal">
        <p style="font-size: 3vh;top: 4vh;">+ ${lang["AddEmployee"]}</p>
        </div>
        <button id="IseAl" data-fex="asd" style="left: 0.1vh;top: 2.9vh;" class="ButtonMini">${lang["AddEmployee"]}</button>
    </div>`);
    for (let index = 0; index < employees.length; index++) {
        const element = employees[index];
        let Permission = element.permission.toUpperCase();
        rtx = `
        <div class="MechanicUnBox5">
            <p>${element.name}</p>
            <div class="LanMal">
                <p>${Permission}</p>
            </div>
            <button id="Kov" data-fex="${element.identifier}" style="left: 0.1vh;width: 97%; top: 1vh;" class="ButtonMini">${lang["Fired"]}</button>
        </div>`
        $('.Calisanlar').append(rtx)
    }
}

AroundMePersons = function(data){
    $('.Calisanlar').html(`
    <div id="BackCalisanlar" class="MechanicUnBox5">
        <p>${lang["CancelRecruitingEmployees"]}</p>
        <div class="LanMal">
        <p style="font-size: 3vh;top: 4vh;">${lang["BackToEmployees"]}</p>
        </div>
        <button data-fex="asd" style="left: 0.1vh;top: 2.9vh;" class="ButtonMini">${lang["Back"]}</button>
    </div>`);
    for (let index = 0; index < data.length; index++) {
        const element = data[index];
        rtx = `
        <div class="MechanicUnBox5">
            <p>Source: ${element.Source}</p>
            <div class="LanMal">
                <p style="font-size: 4vh;">${element.PlayerName}</p>
            </div>
            <button id="AlIse" data-fex="${element.Source}" style="top: 1.7vh;  left:0.1vh;" class="ButtonMini">${lang["Hire"]}</button>
        </div>`
        $('.Calisanlar').append(rtx)
    }
}

$(document).on('click','#UpdateWage',function(){
    let YuzdeUnput = $('#YuzdeMiktar').val()
    if(YuzdeUnput < 100){
        $.post('http://kibra-mechanics/UpdateWage', JSON.stringify({
            yuzde: YuzdeUnput,
            mekanikID: mechanicId
        }));
    } else {
        Notification(lang["EnterA100DenKucuk"], "error")
    }
})

$(document).on('click','#RenkTypeSelect',function(){
    let zibidiGonzalez = $(this).attr("secilen")
    let letmenow = $(this).attr("typeMod")
    $.post('http://kibra-mechanics/LoadColorType', JSON.stringify({
        typeV1: zibidiGonzalez,
        type: letmenow
    }));
})

$(document).on('click','#UpdateMechanicName',function(){
    $.post('http://kibra-mechanics/MechanicNameUpdate', JSON.stringify({
        mekanikID: mechanicId,
        yazilanIsim: $('#MechanicNameX').val()
    }));
})

$(document).on('click','#BackCalisanlar',function(){
    $('.Calisanlar').html("");
    $('.AltMenu').fadeOut(500)
    $('.ParaIslem').fadeOut(500)
    $('.Calisanlar').fadeIn(500);
    CalisanlariYukle()
})

$(document).on('click','#UpdateRate',function(){
    $.post('http://kibra-mechanics/MechanicDiscountRate', JSON.stringify({
        mekanikID: mechanicId,
        yuzde: $('#MechanicRate').val()
    }));
})

$(document).on('click','#UpdateRepair',function(){
    $.post('http://kibra-mechanics/MechanicRepairFee', JSON.stringify({
        mekanikID: mechanicId,
        fee: $('#MechanicFixFee').val()
    }));
})


$(document).on('click','#AlIse',function(){
    $.post('http://kibra-mechanics/UsagiAlIse', JSON.stringify({
        source: $(this).attr("data-fex"),
        mekanikID: mechanicId,
    }));
})

$(document).on('click','#Kov',function(){
    $.post('http://kibra-mechanics/UsagiKov', JSON.stringify({
        ident: $(this).attr("data-fex"),
        mekanikID: mechanicId,
    }));
})

$(document).on('click','#IseAl',function(){
    $.post('http://kibra-mechanics/UsagiIseAl', JSON.stringify({
        mekanikID: mechanicId,
    }));
})

$(document).on('click','#Cek',function(){
    let YuzdeUnput = $('#CekilecekMiktar').val()
    $.post('http://kibra-mechanics/ParaIslemleri', JSON.stringify({
        cekilecekMiktar: YuzdeUnput,
        mekanikID: mechanicId,
        type: "cekBank"
    }));
    $('#CekilecekMiktar').val("")
})

$(document).on('click','#Yatir',function(){
    let YuzdeUnput = $('#YatirilacakMiktar').val()
    $.post('http://kibra-mechanics/ParaIslemleri', JSON.stringify({
        cekilecekMiktar: YuzdeUnput,
        mekanikID: mechanicId,
        type: "yatirBank"
    }));
    $('#YatirilacakMiktar').val("")
})

$(document).on('click','#RenkSec',function(){
    $.post('http://kibra-mechanics/AltRenkMenusuSec', JSON.stringify({
        color: $(this).attr("secilenRenk"),
        modtype: $(this).attr("modtype"),
        menuStringID: $(this).attr('altID'),
        backmenu: $(this).attr("backmenu")
    }));
})

var scrollDeger = 0
const rightBtn = document.querySelector('#SagaKaydir');
const leftBtn = document.querySelector('#SolaKaydir');

rightBtn.addEventListener("click", function(event) {
  const conent = document.querySelector('.CarCustomize');
  $(conent).animate( { scrollLeft: '+=490' }, 500);
  event.preventDefault();
});

leftBtn.addEventListener("click", function(event) {
  const conent = document.querySelector('.CarCustomize');
  $(conent).animate( { scrollLeft: '-=490' }, 500);
  event.preventDefault();
});

LoadOption = function(datax, icon, modtype, props, parcaid, tekerloc, back){
    if(back == null){back = "back"}
    $('.CarCustomize').html(`
    <div id="${back}" style="top: 0.2vh;" class="XPoart">
        <center><i class="fa-solid fa-rotate-left"></i></center>
        <h3>${lang["Back"]}</h3>
    </div>
    `);
    var xtext = "";
    if (modtype == 17){
        if (props["modTurbo"]){
            $('.CarCustomize').html(`
            <div id="back" style="top: 0vh;" class="XPoart">
                <center><i class="fa-solid fa-rotate-left"></i></center>
                <h3>${lang["Back"]}</h3>
            </div>
            `);
            xtext = 
            `<div style="top: 0vh; background-color: #ccc; color: #000;" class="XPoart">
                    <center><i class="${icon}"></i></center>
                <h3>${lang["Attached"]}</h3>
            </div>`
        } else {
            xtext = `
            <div data-parca="${parcaid}" id="modselect"  data-type="${true}" data-fiyat="${subMenu["turbo"].priceDefault}" data-modtype="${modtype}" class="XPoart">
                <center><i class="${icon}"></i></center>
                <h3>${lang["Level"]} 1</h3>
                <p>$${subMenu["turbo"].priceDefault}</p>
            </div>`;
        }
        $('.CarCustomize').append(xtext);
    } else if(modtype == 14){
        for(let i=-1;i<datax;i++){
            if(props[parcaid] == i){
                xtext = 
                `<div style="top: 0.2vh; background-color: #ccc; color: #000;" data-type="${i}" data-modtype="${datax}" class="XPoart">
                        <center><i class="${icon}"></i></center>
                    <h3>${lang["Attached"]}</h3>
                </div>`
            } else {
                xtext = `
                <div data-parca="${parcaid}" id="modselect"  data-type="${i}" data-fiyat="${subMenu["horn"].priceDefault}" data-modtype="${modtype}" class="XPoart">
                    <center><i class="${icon}"></i></center>
                    <h3>${GetHornName(i)}</h3>
                    <p>$${subMenu["horn"].priceDefault}</p>
                </div>`;
            }
            $('.CarCustomize').append(xtext);
        }
    } else if((modtype == 0) || (modtype == 1) || (modtype == 2) || (modtype == 3) || (modtype == 4) || (modtype == 6) || (modtype == 7) || (modtype == 10) || (modtype == 13) || (modtype == 36) || (modtype == 27)|| (modtype == 38) || (modtype == 29)){
        $('.CarCustomize').html(`
        <div id="${back}" style="top: 0.2vh;" class="XPoart">
            <center><i class="fa-solid fa-rotate-left"></i></center>
            <h3>${lang["Back"]}</h3>
        </div>
        `);
        for(let i=-1;i<datax;i++){
            var totalUcret = CreateTotalPrice(modtype, i)
            if(props[parcaid] == i){
                xtext = 
                `<div style="top: 0.2vh; background-color: #ccc; color: #000;" data-type="${i}" data-modtype="${datax}" class="XPoart">
                    <center><img class="mechaniclogo" src="${icon}"></center>
                    <h4>${lang["Attached"]}</h3>
                </div>`
            } else {
                xtext = `
                <div data-parca="${parcaid}"  id="modselect" data-type="${i}" data-fiyat="${Math.ceil(totalUcret)}" data-modtype="${modtype}" class="XPoart">
                    <center><img class="mechaniclogo" src="${icon}"></center>
                    <h4 style="top: -1.7vh;">${lang["Level"]} ${i+2}</h3>
                    <p style="top: -3.3vh;">$${Math.ceil(totalUcret)}</p>
                </div>`;
            }
            $('.CarCustomize').append(xtext);
        }
    } else if(modtype == 23){
        $('.CarCustomize').html(`
        <div id="back3" style="top: 0.2vh;" class="XPoart">
            <center><i class="fa-solid fa-rotate-left"></i></center>
            <h3>${lang["Back"]}</h3>
        </div>
        `);
        for(let i=0;i<datax;i++){
            var totalUcret = CreateTotalPrice(modtype, i)
            if(props[parcaid] == i){
                xtext = 
                `<div style="top: 0.2vh; background-color: #ccc; color: #000;" data-type="${i}" data-modtype="${datax}" class="XPoart">
                        <center><i class="${icon}"></i></center>
                    <h3>${lang["Attached"]}</h3>
                </div>`
            } else {
                xtext = `
                <div data-parca="${parcaid}"  id="modselect" data-type="${i}" data-fiyat="${Math.ceil(totalUcret)}" data-modtype="${modtype}" class="XPoart">
                    <center><i class="${icon}"></i></center>
                    <h3>${tekerloc[i].label}</h3>
                    <p>$${Math.ceil(totalUcret)}</p>
                </div>`;
            }
            $('.CarCustomize').append(xtext);
        }
    } else if(modtype == "plateIndex"){
        $('.CarCustomize').html(`
        <div id="back2" style="top: 0.2vh;" class="XPoart">
            <center><i class="fa-solid fa-rotate-left"></i></center>
            <h3>${lang["Back"]}</h3>
        </div>
        `);
        for (let index = 0; index < 5; index++) {
            var totalUcret = CreateTotalPrice(modtype, index);
            if(props[parcaid] == index){
                xtext = 
                `<div style="top: 0.2vh; background-color: #ccc; color: #000;" data-type="${index}" data-modtype="${datax}" class="XPoart">
                    <center><img class="mechaniclogo" src="${icon}"></center>
                    <h4>${lang["Attached"]}</h3>
                </div>`
            } else {
                xtext = `
                <div data-parca="${parcaid}"  id="modselect" data-type="${index}" data-fiyat="${Math.ceil(totalUcret)}" data-modtype="${modtype}" class="XPoart">
                    <center><img class="mechaniclogo" src="${icon}"></center>
                    <h4 style="font-size: 1.4vh;">${GetPlatesName(index)}</h3>
                    <p style="top: -5.8vh;">$${Math.ceil(totalUcret)}</p>
                </div>`;
            }
            $('.CarCustomize').append(xtext);
        }
    } else if(modtype == 15677){
        $('.CarCustomize').html(`
        <div id="back2" style="top: 0.2vh;" class="XPoart">
            <center><i class="fa-solid fa-rotate-left"></i></center>
            <h3>${lang["Back"]}</h3>
        </div>
        `);
        for (let index = 0; index < 5; index++) {
            var totalUcret = CreateTotalPrice(modtype, index);
            if(props[parcaid] == index){
                xtext = 
                `<div style="top: 0.2vh; background-color: #ccc; color: #000;" data-type="${index}" data-modtype="${datax}" class="XPoart">
                    <center><img class="mechaniclogo" src="${icon}"></center>
                    <h4>${lang["Attached"]}</h3>
                </div>`
            } else {
                xtext = `
                <div data-parca="${parcaid}"  id="modselect" data-type="${index}" data-fiyat="${Math.ceil(totalUcret)}" data-modtype="${modtype}" class="XPoart">
                    <center><img class="mechaniclogo" src="${icon}"></center>
                    <h4 style="font-size: 1.4vh;">${GetWindowName(index)}</h3>
                    <p style="top: -5.8vh;">$${Math.ceil(totalUcret)}</p>
                </div>`;
            }
            $('.CarCustomize').append(xtext);
        }
    } else if((modtype == 5) || (modtype == 8) || (modtype == 9)){
        $('.CarCustomize').html(`
        <div id="back2" style="top: 0.2vh;" class="XPoart">
            <center><i class="fa-solid fa-rotate-left"></i></center>
            <h3>${lang["Back"]}</h3>
        </div>
        `);
        for (let index = 0; index < datax; index++) {
            var totalUcret = CreateTotalPrice(modtype, index);
            if(props[parcaid] == index){
                xtext = 
                `<div style="top: 0.2vh; background-color: #ccc; color: #000;" data-type="${index}" data-modtype="${datax}" class="XPoart">
                    <center><img class="mechaniclogo" src="${icon}"></center>
                    <h4>${lang["Attached"]}</h3>
                </div>`
            } else {
                xtext = `
                <div data-parca="${parcaid}"  id="modselect" data-type="${index}" data-fiyat="${Math.ceil(totalUcret)}" data-modtype="${modtype}" class="XPoart">
                    <center><img class="mechaniclogo" src="${icon}"></center>
                    <h4 style="font-size: 1.4vh;">${tekerloc[index].label}</h3>
                    <p style="top: -5.8vh;">$${Math.ceil(totalUcret)}</p>
                </div>`;
            }
            $('.CarCustomize').append(xtext);
        }
    } else if(modtype == 49){
        $('.CarCustomize').html(`
        <div id="back2" style="top: 0.2vh;" class="XPoart">
            <center><i class="fa-solid fa-rotate-left"></i></center>
            <h3>${lang["Back"]}</h3>
        </div>
        `);
        for (let index = 0; index < 12; index++) {
            var totalUcret = CreateTotalPrice(modtype, index);
            if(props[parcaid] == index){
                xtext = 
                `<div style="top: 0.2vh; background-color: #ccc; color: #000;" data-type="${index}" data-modtype="${datax}" class="XPoart">
                    <center><img class="mechaniclogo" src="${icon}"></center>
                    <h4>${lang["Attached"]}</h3>
                </div>`
            } else {
                xtext = `
                <div data-parca="${parcaid}"  id="modselect" data-type="${index}" data-fiyat="${Math.ceil(totalUcret)}" data-modtype="${modtype}" class="XPoart">
                    <center><img class="mechaniclogo" src="${icon}"></center>
                    <h4 style="font-size: 1.4vh;">${GetHeadLightBarColorNames(index)}</h3>
                    <p style="top: -5.8vh;">$${Math.ceil(totalUcret)}</p>
                </div>`;
            }
            $('.CarCustomize').append(xtext);
        }
    } else {
        for(let i=-1;i<datax;i++){
            var totalUcret = CreateTotalPrice(modtype, i)
            if(props[parcaid] == i){
                xtext = 
                `<div style="top: 0.2vh; background-color: #ccc; color: #000;" data-type="${i}" data-modtype="${datax}" class="XPoart">
                        <center><i class="${icon}"></i></center>
                    <h3>${lang["Attached"]}</h3>
                </div>`
            } else {
                xtext = `
                <div data-parca="${parcaid}"  id="modselect" data-type="${i}" data-fiyat="${Math.ceil(totalUcret)}" data-modtype="${modtype}" class="XPoart">
                    <center><i class="${icon}"></i></center>
                    <h3>${lang["Level"]} ${i+2}</h3>
                    <p>$${Math.ceil(totalUcret)}</p>
                </div>`;
            }
            $('.CarCustomize').append(xtext);
        }
    } 
}

CreateTotalPrice = function(modtype, i){
    let xVan = null
    var totalPrice = 0
    if((i == i-1) || (modtype == 11)){
        xVan = subMenu["engine"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 12)){
        xVan = subMenu["brakes"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 38)){
        xVan = subMenu["modHydrolic"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 15)){
        xVan = subMenu["suspension"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 27)){
        xVan = subMenu["modTrimA"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 17)){
        xVan = subMenu["turbo"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 16)){
        xVan = subMenu["armor"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 23)){
        xVan = subMenu["wheels"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 48)){
        xVan = subMenu["livery"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 0)){
        xVan = subMenu["spoiler"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 13)){
        xVan = subMenu["transmission"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 49)){
        xVan = subMenu["headlight"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 1)){
        xVan = subMenu["frontbumper"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 2)){
        xVan = subMenu["rearbumper"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 3)){
        xVan = subMenu["skirt"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 4)){
        xVan = subMenu["exhaust"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 6)){
        xVan = subMenu["grille"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 36)){
        xVan = subMenu["speakers"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 7)){
        xVan = subMenu["hood"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 8)){
        xVan = subMenu["fender"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 9)){
        xVan = subMenu["rightfender"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 5)){
        xVan = subMenu["cage"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == -1) || (modtype == 10)){
        xVan = subMenu["roof"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == 0) || (modtype == 15677)){
        xVan = subMenu["windowTint"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == 0) || (modtype == "plateIndex")){
        xVan = subMenu["plate"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    } else if((i == 0) || (modtype == "wheelcolor")){
        xVan = subMenu["wheelcolor"]
        totalPrice = (xVan.priceDefault*i) * xVan.pluginLevelPriceIncreaseRate+xVan.priceDefault
        if(vehshop){
            totalPrice = (vehiclePrice/aracoran) + totalPrice
            totalPrice = (totalPrice/aracParcaOran) + aracParcaOran
        }
    }
    return Math.ceil(Math.abs(totalPrice))
}


$(document).on('click','#modselect',function(){
    $.post('http://kibra-mechanics/ModLoad', JSON.stringify({
        mod: $(this).attr("data-type"),
        modtype: $(this).attr("data-modtype"),
        modcengiz: $(this).attr("data-parca"),
        modprice: $(this).attr("data-fiyat"),
        
        neon: $(this).attr("neon"),
    }));
})


$(document).on('click','#neonIptal',function(){
    $.post('http://kibra-mechanics/NeonRemove', JSON.stringify({
        color: $(this).attr("renk"),
    }));
})

LoadMenu = function(mechanic){
    var mtext = ""
    for (let data = 0; data < mechanic.length; data++){
        const v = mechanic[data];
        if(v.menuImg){
            mtext = mtext + `
            <div id="menuButton"  data-modtype="${v.type}" class="XPoart">
                <center><img class="mechaniclogo" src="${v.menuIcon}"></center>
                <h4>${v.menuLabel}</h4>
            </div>`
        } else {
            mtext = mtext + `
            <div id="menuButton"  data-modtype="${v.type}" class="XPoart">
                <center><i class="${v.menuIcon}"></i></center>
                <h3>${v.menuLabel}</h3>
            </div>`
        }    
    }
    $('.CarCustomize').html(mtext)
}

LoadSubMenu = function(mechanic){
    var mtext = ""
    $('.CarCustomize').html(`
            <div id="back" style="top: 0.2vh;" class="XPoart">
                <center><i class="fa-solid fa-rotate-left"></i></center>
                <h3>${lang["Back"]}</h3>
            </div>
            `);
    for (let data = 0; data < mechanic.length; data++){
        const v = mechanic[data];
        if(v.menuImg){
            mtext = mtext + `
            <div id="menuButton"  data-modtype="${v.type}" class="XPoart">
                <center><img class="mechaniclogo" src="${v.menuIcon}"></center>
                <h4>${v.menuLabel}</h4>
            </div>`
        } else {
            mtext = mtext + `
            <div id="menuButton"  data-modtype="${v.type}" class="XPoart">
                <center><i class="${v.menuIcon}"></i></center>
                <h3>${v.menuLabel}</h3>
            </div>`
        }    
    }
    $('.CarCustomize').append(mtext)
}

LoadCar = function(vehicle){
    var makspeed = vehicle.CarInfo.maxspeed+vehicle.imdat
    var carweight = null 
    if(vehicle.CarInfo.carweight > 1000){
        carweight = vehicle.CarInfo.carweight/10
    } else {
        carweight = vehicle.CarInfo.carweight/3
    }
    $("#MaxSpeed").html(makspeed);
    $("#topspeed").css("width", vehicle.CarInfo.maxspeed);
    $("#vehicleweight").html(vehicle.CarInfo.carweight)
    $('#weightbar').css("width", carweight)
    $('#frenyuzde').html(vehicle.CarInfo.brake)
    $('#brakebar').css("width", vehicle.CarInfo.brake);
    $('#handlingyuzde').html(vehicle.CarInfo.handling);
    $('#accel').html(vehicle.CarInfo.accelerationx*2);
    $('#Accelerationbar').css("width", vehicle.CarInfo.accelerationx)
    $('#handlingbar').css("width", vehicle.CarInfo.handling);
    if(vehicle.data.modTurbo === false){
        $('#turbodurum').html(vehicle.cfg["Notinstalled"])
        $('#turbobar').css("width", "0%")
    } else {
 +       $('#turbodurum').html(vehicle.cfg["Attached"])
          $('#turbobar').css("width", "100%")
    }
}


Notification = (text,type) => {
    var notify = ""
    if(type == "error"){
        notify = notify + `
        <div style="border-color: rgb(243 0 0 / 43%);" class="Notify">
            <p><span style="color: rgb(255 0 0 / 63%);"><i style="font-size: 2vh;" class="fa-duotone fa-check"></i></span> ${text}</p>
        </div>`
    } else {
        notify = notify + `
        <div class="Notify">
            <p><span style="color: rgb(62 255 2 / 43%);"><i style="font-size: 2vh;" class="fa-duotone fa-check"></i></span> ${text}</p>
        </div>`
    }
    $(notify).appendTo('.orospular');
    setTimeout(() => {
        $('.Notify').fadeOut(700);
    }, 1500);

    return notify;
}

$(document).on('click','#MekanikSat',function(){
    $.post('http://kibra-mechanics/MekanikSell', JSON.stringify({
        mekanikId: mechanicId
    }));
})

document.onkeyup = function(data){
    if (data.which == 27){
        $('#mContainer').fadeOut(500);
        $('.senayritrende').html("");
        $('.Homelander').fadeOut(500);
        $('#bossMenuMain').fadeOut(500);
        $('.OdenecekTutarKutusu').html("");
        $('.Calisanlar').fadeOut(100);
        $('#BurayaGelecek').html("");
        $('#BurayaGelecek2').html("");
        $('.TowTrucksList').html("")
        $('#BurayaGelecek3').html("")
        $('#BurayaGelecek4').html("")
        $('.ParaIslem').fadeOut(500);
        $('.AltMenu').fadeIn(100);
        $('.Calisanlar').html("");
        $('.FaturaKesilecekMenusu').fadeOut(300);
        $('.OyuncularGelecek').html("");
        $('.FaturalandirmaPanel').fadeOut(500)
        $('.UrunSepeti').html("")
        $('.TowTruckMenu').fadeOut(500)
        employees = []
        if(bossmenugardas == true){
        $.post('http://kibra-mechanics/CloseBossMenu', JSON.stringify({}))
        } else {
        $.post('http://kibra-mechanics/CloseMechanic', JSON.stringify({}));
        }
    }
}

HerseyiKapat = function(){
    $('#mContainer').fadeOut(500);
        $('.senayritrende').html("");
        $('.Homelander').fadeOut(500);
        $('#bossMenuMain').fadeOut(500);
        $('.OdenecekTutarKutusu').html("");
        $('.Calisanlar').fadeOut(100);
        $('#BurayaGelecek').html("");
        $('#BurayaGelecek2').html("");
        $('.ParaIslem').fadeOut(500);
        $('.AltMenu').fadeIn(100);
        $('.Calisanlar').html("");
        $('.FaturaKesilecekMenusu').fadeOut(300);
        $('.OyuncularGelecek').html("");
        $('.FaturalandirmaPanel').fadeOut(500)
        $('.UrunSepeti').html("")
        employees = []
        $.post('http://kibra-mechanics/CloseBossMenu', JSON.stringify({}))
        $.post('http://kibra-mechanics/CloseMechanic', JSON.stringify({}));
}

HerseyiKapat5 = function(){
    $('#mContainer').fadeOut(500);
    $('.senayritrende').html("");
    $('.Homelander').fadeOut(500);
    $('#bossMenuMain').fadeOut(500);
    $('.OdenecekTutarKutusu').html("");
    $('.Calisanlar').fadeOut(100);
    $('#BurayaGelecek').html("");
    $('#BurayaGelecek2').html("");
    $('.ParaIslem').fadeOut(500);
    $('.AltMenu').fadeIn(100);
    $('.Calisanlar').html("");
    $('.FaturaKesilecekMenusu').fadeOut(300);
    $('.OyuncularGelecek').html("");
    $('.FaturalandirmaPanel').fadeOut(500)
    $('.UrunSepeti').html("")
    employees = []
    $.post('http://kibra-mechanics/Klose', JSON.stringify({}));
}

$(document).on('click','#AllOpenDoorsButton',function(){
    $.post('http://kibra-mechanics/OpenAllDoors', JSON.stringify({}));
})

$(document).on('click','#back',function(){
    $.post('http://kibra-mechanics/MenuBack', JSON.stringify({}));
})

$(document).on('click','#mainmenu',function(){
    $.post('http://kibra-mechanics/MenuBack', JSON.stringify({}));
})

$(document).on('click','#back2',function(){
    $.post('http://kibra-mechanics/MenuBack2', JSON.stringify({}));
})


$(document).on('click','#tekerlekmenusu',function(){
    $.post('http://kibra-mechanics/TekerlekMenusu', JSON.stringify({}));
})

$(document).on('click','#back3',function(){
    $.post('http://kibra-mechanics/MenuBack3', JSON.stringify({}));
})

$(document).on('click','#renkturleri',function(){
    $.post('http://kibra-mechanics/RenkTurleri', JSON.stringify({}));
})


$(document).on('click','#back4',function(){
    $.post('http://kibra-mechanics/MenuBack4', JSON.stringify({}));
})

$(document).on('click','#ustrenkler',function(){
    $.post('http://kibra-mechanics/UstRenkleriYukle', JSON.stringify({}));
})

$(document).on('click','#menuButton',function(){
    $.post('http://kibra-mechanics/LoadMenu', JSON.stringify({
        type: $(this).attr("data-modtype"),
        whtyp: $(this).attr("ikinci"),
        
    }));
})

// $(document).on('click','#MouseControl',function(){
//     $.post('http://kibra-mechanics/CursorActive', JSON.stringify({}));
// })

$(document).on('click','#plateaddbasket',function(){
    var input = $('#myInputPlate').val()
    input = input.toUpperCase();
    const normalizedStr = input.normalize('NFD').replace(/[\u0300-\u036f]/g, '');
    $.post('http://kibra-mechanics/ModLoad', JSON.stringify({
        mod: normalizedStr,
        modtype: "plate",
        modcengiz: "sarıpipi",
        modprice: platefiyat
    }));
    $('.senayritrende').html("");
    $('.Homelander').fadeOut(500);
})

$(document).on('click','#buttonplate',function(){
    $.post('http://kibra-mechanics/OpenPlate', JSON.stringify({}));
})


$(document).on('click','#iptal',function(){
    $('.senayritrende').html("");
    $('#plakatexti').val("")
    $('.Homelander').fadeOut(500);
})

$(document).on('click','#iptal',function(){
    $('.senayritrende').html("");
    $('.Homelander').fadeOut(500);
})

function alphaNumericOnly(event) {
    if(plateSpace == false){
        var key = event.key;
        var allowedChars = /^[0-9a-zA-Z]+$/;
        if (!key.match(allowedChars)) {
        event.preventDefault();
        return false;
        }
    }
}
  
function clearInput() {
    var input = document.getElementById("myInputPlate");
    input.value = "";
}

OpenPlateChange = function(plate){
    $('.Homelander').fadeIn(500);
    var text = ""
    text = text + `
        <div class="PlateBoard">
            <h1>${lang["EnterANewLicensePlate"]}</h1>
            <input id="myInputPlate" onkeydown="return alphaNumericOnly(event)" placeholder="${plate}" minlength="8" maxlength="8" id="plakatexti" type="text" class="plakatext">
            <div id="iptal" class="McButt"><p>${lang["Cancel"]}</p></div>
            <div onclick="clearInput()" class="McButt"><p><i class="fa-solid fa-delete-right"></i> ${lang["Clear"]}</p></div>
            <div id="plateaddbasket" class="McButt"><p><i class="fa-solid fa-cart-plus"></i> ${lang["AddToBasket"]}</p></div>
            
        </div>
        `
    $(text).appendTo('.senayritrende');
}
