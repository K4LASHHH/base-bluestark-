<script>
import { Icon } from '@iconify/vue';

export default {
  name: 'App',
  components: {
    Icon
  },
  data() {
    return {
      isOpen: false,

      onlinePlayers: 0,
      maxPlayers: 0,
      playerID: 0,

      money: {
        money: 0,
        bank: 0,
        black_money: 0,
      },
      custombars: true,
      DataPosition: "right",
      data: [
        {
          name: "food",
          isActive: true,
          int: 0,
          color: "#FFB533",
        },
        {
          name: "drink",
          isActive: true,
          int: 0,
          color: "#0065d8",
        },
      ],

      Ammunation: {
        isActive: false,
        Ammunation: 0,
        maxAmmunation: 0
      },

      VoiceContent: {
        VoiceInt: 33,
        isTalkin: 0,
        muted: false,
        RadioActive: false,
      },

      timerFuel: null,
      alarm: false,
      playmusic: 0,
      activeColor: "white",

      inVeh: false,

      VehStates: {
        maxFuel: 0,
        currentFuel: 0,

        kmh: 0,
        maxkmh: 300,

        needleRotation: 147,
        progressOffset: 576,
        fuelOffset: 786,

        locked: false,
        light: false,
        seatbelt: false,
        engine: false
      },

      location: {
        street: "Ave Street",
        zone: "Timesquare street 24",
      },


      ServerName: "BlueStark",

      time: "21:22",
      date: "22.12.24",

      top_left_middle_content: []

    }
  },
  mounted() {
    this.timerFuel = setInterval(this.alarmFuel, 1000)

    this.listener = (evt) => {
      var event = evt.data;
      if (event.action == "open") {
        this.isOpen = true
      } else if (event.action == "close") {
        this.isOpen = false
      } else if (event.action === "updateVoiceLevel") {
        if (event.TalkingStage == 1) {
          this.VoiceContent.VoiceInt = 33
        } else if (event.TalkingStage == 2) {
          this.VoiceContent.VoiceInt = 66
        } else if (event.TalkingStage == 3) {
          this.VoiceContent.VoiceInt = 100
        }

      } else if (event.action === "updateMicrophone") {
        this.VoiceContent.isTalkin = event.microphone

      } else if (event.action === "setMoney") {
        this.money.money = event.data;

      } else if (event.action === "setBank") {
        this.money.bank = event.data;

      } else if (event.action === "setBlackMoney") {
        this.money.black_money = event.data;

      } else if (event.action === "setidentifier") {
        this.playerID = event.data
      } else if (event.action === 'setPosition') {
        this.location.street = event.street
        this.location.zone = event.zone
        this.setFuelProgress(this.VehStates.currentFuel)
      } else if (event.action === "customBars") {
        this.custombars = true;
        this.DataPosition = event.DataPosition
        if (event.type === "onlyfood") {
          this.data[0].int = event.foodInt
          this.data[1].int = event.drinkInt
        } else {
          this.data = [];
        }

      } else if ("WeaponEquiped" == event.action) {
        if (event.type == "waffe") {
          this.Ammunation.isActive = true;
          this.Ammunation.Ammunation = event.ammoClip;
          this.Ammunation.maxAmmunation = event.ammoRemaining;

        } else {
          this.Ammunation.isActive = false;
        }
      } else if (event.action === "setplayers") {
        this.onlinePlayers = event.players
        if (event.maxPlayers != 0) {
          this.maxPlayers = event.maxPlayers
        }
      } else if (event.action === "setmaxPlayers") {
        this.maxPlayers = event.maxPlayers
      } else if (event.action === 'setInVeh') {
        this.inVeh = event.state;
      } else if (event.action === 'setSpeed') {
        this.VehStates.kmh = event.speed
        this.VehStates.maxkmh = event.maxkmh
        this.setSpeedoProgress(this.VehStates.kmh);
      } else if (event.action === 'setVehStates') {
        this.VehStates.locked = event.locked
        this.VehStates.light = event.light
        this.VehStates.engine = event.engine
        this.VehStates.seatbelt = event.seatbelt
      } else if (event.action === 'setVehFuel') {
        this.VehStates.currentFuel = event.fuel
        this.VehStates.maxFuel = event.max
        this.setFuelProgress(this.VehStates.currentFuel)
      }
    }
    window.addEventListener('message', this.listener);
  },
  created() {
    let that = this
    setInterval(that.getNow, 1000);
  },
  unmounted() {
    window.removeEventListener('message', this.listener);
  },
  methods: {
    setSpeedoProgress(current) {
      const max = this.VehStates.maxkmh;
      let speedRatio = max / current;
      let speedOffset = 100 / speedRatio;
      let offsetSpeed = 226 + (350 - speedOffset / 100 * 350);
      let maxOffsetSpeed = 576;

      if (offsetSpeed < maxOffsetSpeed) {
        this.VehStates.progressOffset = offsetSpeed;

        if (offsetSpeed < 235) {
          this.VehStates.progressOffset = 235;
        }
      } else {
        this.VehStates.progressOffset = maxOffsetSpeed;
      }

      const rotationPerKmH = 212 / max;
      const maxRotation = 359;
      let rotation = 147 + (current * rotationPerKmH);
      let needleRotation = rotation > maxRotation ? maxRotation : rotation;

      this.VehStates.needleRotation = needleRotation;
    },
    alarmFuel() {
      if (this.VehStates.currentFuel <= this.VehStates.maxFuel / 10 && this.VehStates.engine == true) {
        if (this.activeColor == "white") {
          this.activeColor = "red"
          this.playmusic++
        } else if (this.activeColor == "red") {
          this.activeColor = "white"
        }
      }
      else {
        this.playmusic = 0
        this.activeColor = "white"
      }
    },
    setFuelProgress(current) {
      const max = this.VehStates.maxFuel;
      const currentFuel = current;
      const fullOffset = 580;
      const emptyOffset = 785;

      let fuelRatio = currentFuel / max;
      let offsetRange = emptyOffset - fullOffset;
      let fuelOffset = emptyOffset - offsetRange * fuelRatio;

      if (fuelOffset < fullOffset) {
        fuelOffset = fullOffset;
      } else if (fuelOffset > emptyOffset) {
        fuelOffset = emptyOffset;
      }

      this.VehStates.fuelOffset = fuelOffset;


    },
    formatnumbers(number) {
      // Konvertieren Sie die Zahl in einen String
      let strNumber = number.toString();

      // Überprüfen Sie, ob die Zahl kürzer als 4 ist, wenn ja, geben Sie sie unformatiert zurück
      if (strNumber.length < 4) {
        return strNumber;
      }

      // Verwenden Sie eine Reguläre Ausdruck um die Zahl nach jeder dritten Stelle mit einem Punkt zu formatieren
      return strNumber.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    },
    getNow() {
      const today = new Date();
      let dd = "00"
      let mm = "00"
      let yyyy = "0000"


      if (today.getDate() < 10) {
        dd = '0' + today.getDate()
      } else {
        dd = today.getDate();
      }

      if (today.getMonth() + 1 < 10) {
        mm = '0' + (today.getMonth() + 1);
      } else {
        mm = today.getMonth() + 1;
      }

      yyyy = today.getFullYear();

      if (today.getHours() < 10) {
        this.time = "0" + today.getHours() + ":" + today.getMinutes();

        if (today.getMinutes() < 10) {
          this.time = "0" + today.getHours() + ":0" + today.getMinutes();
        } else {
          this.time = "0" + today.getHours() + ":" + today.getMinutes();
        }

      } else {

        if (today.getMinutes() < 10) {
          this.time = today.getHours() + ":0" + today.getMinutes();
        } else {
          this.time = today.getHours() + ":" + today.getMinutes();
        }

      }

      this.date = dd + '.' + mm + '.' + yyyy;
    }
  }
}
</script>

<template>
  <div v-if="isOpen" class="hud">
    <div class="blur"></div>
    <div class="blur-bottom-right"></div>
    <div class="blur-top-left"></div>

    <div class="top-right">
      <div class="time">
        <span>
          <Icon class="icon" icon="mdi:clock" />
          <p>{{ time }} / <span style="opacity: .5">{{ date }}</span></p>
        </span>
      </div>

      <div class="player">
        <span>
          <Icon class="icon" icon="mdi:account" />
          <p># {{ playerID }}</p>
        </span>
      </div>

      <div class="onlineplayers">
        <span>
          <Icon class="icon" icon="material-symbols:group" width="1.6vh" height="1.6vh" />
          <p>{{ onlinePlayers }} / {{ maxPlayers }}</p>
        </span>
      </div>
      <div class="logo">
        <img :src="require('@/assets/logo.png')" alt="">
      </div>
    </div>
    <div class="top-right-middle">
      <div class="cash">
        $ {{ money.money }}
      </div>
      <div class="bank">
        $ {{ money.bank }}
      </div>
      <div class="black_money">
        $ {{ money.black_money }}
      </div>
      <div class="ammunation" :class="Ammunation.isActive ? 'ammunationin' : 'ammunationout'">
        <span>
          <svg class="icon" width="1vh" height="1.4vh" viewBox="0 0 10 14" fill="none" xmlns="http://www.w3.org/2000/svg">
            <g clip-path="url(#clip0_142_3073)">
              <path
                d="M4.2424 12.1337V5.13371C4.2424 5.00467 4.14758 4.90039 4.03029 4.90039H0.21211C0.0947963 4.90039 0 5.00469 0 5.13371V12.1337C0 12.2627 0.0948216 12.367 0.21211 12.367V12.6003C0.0947963 12.6003 0 12.7046 0 12.8337V13.767C0 13.896 0.0948216 14.0003 0.21211 14.0003H4.03029C4.1476 14.0003 4.2424 13.896 4.2424 13.767V12.8337C4.2424 12.7047 4.14758 12.6004 4.03029 12.6004V12.3671C4.14758 12.367 4.2424 12.2627 4.2424 12.1337Z"
                fill="white" />
              <path
                d="M0.424049 4.43337H3.81798C3.9353 4.43337 4.03009 4.32906 4.03009 4.20005V3.96672C4.03009 2.43281 3.36382 0.96747 2.24827 0.0467239C2.17276 -0.0155746 2.06925 -0.0155746 1.99373 0.0467239C0.878191 0.96747 0.211914 2.43278 0.211914 3.96672V4.20005C0.211939 4.32906 0.306736 4.43337 0.424049 4.43337Z"
                fill="white" />
              <path
                d="M9.69699 12.1337V5.13371C9.69699 5.00467 9.60217 4.90039 9.48488 4.90039H5.6667C5.54939 4.90039 5.45459 5.00469 5.45459 5.13371V12.1337C5.45459 12.2627 5.54941 12.367 5.6667 12.367V12.6003C5.54939 12.6003 5.45459 12.7046 5.45459 12.8337V13.767C5.45459 13.896 5.54941 14.0003 5.6667 14.0003H9.48488C9.60219 14.0003 9.69699 13.896 9.69699 13.767V12.8337C9.69699 12.7047 9.60217 12.6004 9.48488 12.6004V12.3671C9.60217 12.367 9.69699 12.2627 9.69699 12.1337Z"
                fill="white" />
              <path
                d="M5.87864 4.43337H9.27257C9.38989 4.43337 9.48468 4.32906 9.48468 4.20005V3.96672C9.48468 2.43281 8.81841 0.96747 7.70286 0.0467239C7.62735 -0.0155746 7.52384 -0.0155746 7.44832 0.0467239C6.33278 0.96747 5.6665 2.43278 5.6665 3.96672V4.20005C5.66653 4.32906 5.76133 4.43337 5.87864 4.43337Z"
                fill="white" />
            </g>
            <defs>
              <clipPath id="clip0_142_3073">
                <rect width="10" height="14" fill="white" />
              </clipPath>
            </defs>
          </svg>
          {{ Ammunation.Ammunation }} / {{ Ammunation.maxAmmunation }}
        </span>
      </div>
    </div>

    <audio v-for="x in playmusic" utoplay="true" v-bind:key="x" visibility="invisible" currentTime="0" autoplay controls
      type="audio/ogg" preload="auto"
      src="data:audio/ogg;base64,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" />

    <div class="bottom-right" :class="inVeh == 1 ? 'join' : 'remove'">

      <div class="speedometer">
        <svg width="19.2vh" height="19.2vh" viewBox="0 0 192 192" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path
            d="M91.8122 172.886C91.7221 174.54 90.3071 175.814 88.6572 175.662C85.9318 175.411 83.2211 175.02 80.5358 174.491C78.9102 174.171 77.9128 172.549 78.2938 170.937L80.0713 163.414C80.4523 161.801 82.0673 160.81 83.6954 161.118C85.5857 161.475 87.4907 161.75 89.4049 161.941C91.0535 162.106 92.3227 163.513 92.2326 165.168L91.8122 172.886Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 0) ? '0.35' : '0.15'" />
          <path
            d="M75.8939 170.329C75.4612 171.928 73.812 172.879 72.23 172.387C69.6166 171.574 67.0467 170.627 64.5305 169.55C63.0072 168.899 62.3694 167.105 63.0778 165.607L66.3827 158.619C67.0911 157.122 68.8772 156.488 70.4055 157.128C72.18 157.871 73.986 158.537 75.8184 159.122C77.3966 159.627 78.3449 161.268 77.9123 162.867L75.8939 170.329Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 1) ? '0.35' : '0.15'" />
          <path
            d="M61.0911 164.632C60.3399 166.109 58.5307 166.702 57.0831 165.896C54.6918 164.565 52.3705 163.112 50.1282 161.542C48.7707 160.592 48.514 158.706 49.5143 157.385L54.1809 151.222C55.1811 149.902 57.059 149.648 58.4238 150.587C60.0084 151.678 61.6398 152.699 63.3133 153.648C64.7546 154.465 65.3466 156.266 64.5955 157.742L61.0911 164.632Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 2) ? '0.35' : '0.15'" />
          <path
            d="M47.755 156.012C46.7168 157.303 44.8244 157.513 43.5729 156.427C41.5056 154.633 39.5317 152.735 37.659 150.739C36.5253 149.53 36.6611 147.631 37.911 146.544L43.7424 141.47C44.9923 140.382 46.8824 140.519 48.0254 141.718C49.3526 143.111 50.7398 144.445 52.183 145.717C53.426 146.813 53.6363 148.696 52.5981 149.987L47.755 156.012Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 3) ? '0.35' : '0.15'" />
          <path
            d="M36.5283 144.909C35.2486 145.962 33.3532 145.781 32.3495 144.463C30.6916 142.285 29.1464 140.024 27.7202 137.688C26.8568 136.274 27.3771 134.442 28.8226 133.632L35.5663 129.855C37.0118 129.045 38.8342 129.564 39.7086 130.972C40.7238 132.606 41.8096 134.195 42.9631 135.734C43.9565 137.06 43.7782 138.947 42.4985 139.999L36.5283 144.909Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 4) ? '0.35' : '0.15'" />
          <path
            d="M27.961 132.051C26.4969 132.827 24.6758 132.271 23.9555 130.779C22.7657 128.314 21.7031 125.79 20.772 123.217C20.2083 121.659 21.0837 119.968 22.6618 119.463L30.024 117.108C31.6021 116.603 33.2841 117.475 33.8598 119.029C34.5284 120.833 35.2751 122.607 36.098 124.346C36.8067 125.843 36.2553 127.656 34.7912 128.432L27.961 132.051Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 5) ? '0.35' : '0.15'" />
          <path
            d="M22.1804 117.901C20.592 118.373 18.9165 117.468 18.5051 115.863C17.8256 113.212 17.2825 110.528 16.8781 107.821C16.6333 106.182 17.8255 104.698 19.4722 104.514L27.1546 103.66C28.8013 103.476 30.2778 104.664 30.5353 106.301C30.8343 108.201 31.216 110.088 31.6791 111.955C32.078 113.563 31.1794 115.231 29.591 115.703L22.1804 117.901Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 6) ? '0.35' : '0.15'" />
          <path
            d="M19.2968 102.754C17.6463 102.899 16.1846 101.679 16.1013 100.024C15.9636 97.2906 15.9663 94.5519 16.1093 91.8187C16.1959 90.1641 17.66 88.9469 19.3102 89.0955L27.0089 89.7886C28.6591 89.9371 29.8692 91.3954 29.7955 93.0506C29.7099 94.9724 29.708 96.8971 29.7898 98.8192C29.8603 100.475 28.6473 101.93 26.9968 102.076L19.2968 102.754Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 7) ? '0.35' : '0.15'" />
          <path
            d="M19.4822 87.3962C17.8357 87.2111 16.6453 85.7251 16.892 84.0867C17.2996 81.3803 17.8458 78.6966 18.5284 76.0462C18.9417 74.4417 20.6182 73.5392 22.2061 74.0123L29.6141 76.2196C31.2019 76.6927 32.0986 78.3621 31.6978 79.9698C31.2325 81.8364 30.8486 83.7225 30.5474 85.6225C30.2879 87.2589 28.8101 88.445 27.1636 88.2599L19.4822 87.3962Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 8) ? '0.35' : '0.15'" />
          <path
            d="M22.6534 72.5632C21.0752 72.0589 20.1991 70.3685 20.7623 68.8102C21.6925 66.2362 22.7542 63.7116 23.9431 61.2465C24.6629 59.7541 26.4838 59.1978 27.9481 59.973L34.7797 63.5897C36.244 64.3649 36.796 66.1777 36.0879 67.6756C35.2656 69.4148 34.5195 71.189 33.8516 72.9931C33.2764 74.5469 31.5947 75.4203 30.0165 74.916L22.6534 72.5632Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 9) ? '0.35' : '0.15'" />
          <path
            d="M28.5675 58.8266C27.1166 58.0267 26.5838 56.1988 27.4375 54.7788C28.8478 52.4332 30.3775 50.1614 32.0206 47.9726C33.0153 46.6475 34.9093 46.4537 36.1962 47.4974L42.1997 52.3664C43.4866 53.4101 43.6778 55.2954 42.6934 56.6281C41.5505 58.1756 40.4755 59.7721 39.4714 61.4131C38.6067 62.8264 36.7879 63.3582 35.3369 62.5583L28.5675 58.8266Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 10) ? '0.35' : '0.15'" />
          <path
            d="M37.1803 46.3085C35.9147 45.2392 35.7513 43.3423 36.8672 42.1176C38.7106 40.0946 40.6566 38.1675 42.6976 36.3439C43.9331 35.24 45.8284 35.4219 46.8852 36.6979L51.8157 42.6511C52.8725 43.9271 52.6898 45.8133 51.4629 46.9268C50.0383 48.2197 48.6707 49.574 47.364 50.9858C46.2386 52.2018 44.3507 52.3661 43.0851 51.2969L37.1803 46.3085Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 12) ? '0.35' : '0.15'" />
          <path
            d="M48.0159 35.7794C46.9834 34.4836 47.1935 32.5912 48.5271 31.608C50.7301 29.9839 53.0149 28.4739 55.3727 27.084C56.8 26.2425 58.6232 26.7911 59.4106 28.2489L63.0837 35.0502C63.871 36.5081 63.3235 38.3222 61.9027 39.1747C60.2531 40.1645 58.6474 41.2257 57.0901 42.3552C55.7489 43.328 53.8654 43.1206 52.8329 41.8248L48.0159 35.7794Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 12) ? '0.35' : '0.15'" />
          <path
            d="M60.9964 27.4161C60.2432 25.9404 60.8267 24.128 62.3296 23.4307C64.8124 22.2788 67.3526 21.255 69.9402 20.3635C71.5067 19.8237 73.1839 20.725 73.6645 22.3106L75.9067 29.7081C76.3873 31.2937 75.4888 32.9621 73.9265 33.514C72.1126 34.1548 70.3274 34.8742 68.5761 35.6703C67.0678 36.356 65.2635 35.7768 64.5103 34.3011L60.9964 27.4161Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 13) ? '0.35' : '0.15'" />
          <path
            d="M75.1654 21.8723C74.7171 20.2772 75.6456 18.615 77.2563 18.2268C79.9171 17.5855 82.609 17.0812 85.3214 16.7159C86.9635 16.4947 88.4307 17.7082 88.5901 19.3574L89.334 27.0513C89.4934 28.7005 88.2844 30.1597 86.6441 30.3936C84.7396 30.6652 82.8478 31.0196 80.9742 31.4557C79.3605 31.8314 77.7053 30.9088 77.2569 29.3138L75.1654 21.8723Z"
            fill="white" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 14) ? '0.35' : '0.15'" />
          <path
            d="M90.096 19.2267C89.969 17.5747 91.2052 16.1266 92.8608 16.0616C95.5956 15.9542 98.3341 15.9872 101.066 16.1605C102.719 16.2654 103.92 17.7429 103.753 19.3913L102.975 27.0819C102.808 28.7303 101.337 29.9243 99.6822 29.8322C97.7614 29.7253 95.8369 29.7021 93.9141 29.7627C92.258 29.8148 90.8157 28.5857 90.6887 26.9337L90.096 19.2267Z"
            fill="#D73737" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 15) ? '0.55' : '0.37'" />
          <path
            d="M105.197 19.5512C105.395 17.9062 106.89 16.7273 108.526 16.9867C111.229 17.4153 113.909 17.9823 116.554 18.6854C118.155 19.1111 119.044 20.7946 118.559 22.3787L116.294 29.7694C115.809 31.3535 114.133 32.2373 112.528 31.824C110.665 31.3442 108.782 30.9458 106.885 30.6298C105.25 30.3577 104.076 28.8707 104.273 27.2257L105.197 19.5512Z"
            fill="#D73737" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 16) ? '0.55' : '0.37'" />
          <path
            d="M119.973 22.827C120.489 21.2525 122.186 20.3889 123.74 20.9634C126.307 21.9124 128.824 22.9926 131.28 24.1995C132.767 24.9302 133.31 26.7552 132.524 28.2138L128.858 35.0186C128.072 36.4772 126.255 37.016 124.762 36.2969C123.029 35.4619 121.261 34.7028 119.461 34.0218C117.912 33.4352 117.051 31.7472 117.567 30.1727L119.973 22.827Z"
            fill="#D73737" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 17) ? '0.55' : '0.37'" />
          <path
            d="M133.931 28.9906C134.747 27.5487 136.581 27.0366 137.991 27.9063C140.321 29.3429 142.575 30.898 144.745 32.5657C146.059 33.5752 146.231 35.4714 145.173 36.7464L140.237 42.6947C139.179 43.9697 137.291 44.1396 135.97 43.1403C134.435 41.98 132.851 40.8871 131.222 39.8647C129.818 38.9841 129.307 37.1594 130.123 35.7175L133.931 28.9906Z"
            fill="#D73737" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 18) ? '0.55' : '0.37'" />
          <path
            d="M146.398 37.7847C147.483 36.5321 149.381 36.3916 150.593 37.5222C152.593 39.3899 154.497 41.3591 156.295 43.4219C157.384 44.6706 157.18 46.5636 155.891 47.6049L149.879 52.4632C148.59 53.5045 146.706 53.299 145.607 52.0587C144.332 50.6187 142.994 49.2348 141.598 47.9111C140.396 46.7711 140.254 44.8814 141.339 43.6288L146.398 37.7847Z"
            fill="#D73737" :fill-opacity="this.VehStates.kmh >= (this.VehStates.maxkmh / 20 * 19) ? '0.55' : '0.37'" />
          <path class="speedometer-bg"
            d="M166.13 39.4038C168.658 37.364 169.067 33.6476 166.876 31.2495C157.583 21.0777 146.193 13.0074 133.465 7.61257C118.93 1.45134 103.1 -1.03007 87.3761 0.38814C71.6526 1.80636 56.5216 7.08042 43.3232 15.7432C30.1249 24.4059 19.2667 36.1899 11.7104 50.0514C4.15416 63.9129 0.133027 79.424 0.00324394 95.2108C-0.12654 110.998 3.63903 126.573 10.9664 140.557C18.2938 154.54 28.9568 166.501 42.0109 175.38C53.4411 183.154 66.3957 188.355 79.9801 190.654C83.1826 191.196 86.0849 188.839 86.4298 185.609V185.609C86.7748 182.38 84.4306 179.503 81.2328 178.933C69.5716 176.857 58.4563 172.34 48.6259 165.654C37.1712 157.863 27.8147 147.368 21.3851 135.097C14.9555 122.827 11.6513 109.16 11.7652 95.3075C11.8791 81.455 15.4075 67.8444 22.038 55.6813C28.6684 43.5181 38.1962 33.1779 49.7774 25.5766C61.3586 17.9753 74.6358 13.3474 88.4327 12.1029C102.23 10.8585 116.121 13.0359 128.875 18.4422C139.821 23.0819 149.64 29.9769 157.703 38.6531C159.915 41.0323 163.603 41.4437 166.13 39.4038V39.4038Z"
            fill="white" fill-opacity="0.25" />
          <circle class="speedometer-progress" :style="{ strokeDashoffset: VehStates.progressOffset }" r="90" cx="96.5"
            cy="96"></circle>
        </svg>

        <div class="needle">
          <div class="inside" :style="{ transform: 'rotate(' + VehStates.needleRotation + 'deg)' }"></div>
          <div class="circle"></div>
        </div>

        <h1 v-if="VehStates.kmh === 0"><span>000</span></h1>
        <h1 v-else-if="VehStates.kmh < 10"><span>00</span>{{ VehStates.kmh }}</h1>
        <h1 v-else-if="VehStates.kmh < 100"><span>0</span>{{ VehStates.kmh }}</h1>
        <h1 v-else>{{ VehStates.kmh }}</h1>
        <p>km/h</p>

        <div class="vehicle-states">
          <Icon class="icon" icon="mdi:motor" :class="VehStates.engine ? 'active' : ''" />
          <Icon class="icon" icon="mdi:seatbelt" :class="VehStates.seatbelt ? 'active' : ''" />
          <Icon class="icon" icon="mdi:car-door-lock" :class="VehStates.locked ? 'active' : ''" />
          <Icon class="icon" icon="mdi:car-light-high" :class="VehStates.light ? 'active' : ''" />
        </div>
      </div>

      <div class="fuelometer">
        <svg class="progress-ring" viewBox="0 0 350 350">
          <circle class="fuelometer-progress" :style="{ strokeDashoffset: VehStates.fuelOffset }" r="124" cx="164"
            cy="98"></circle>
        </svg>
        <svg width="5.3vh" height="17.8vh" viewBox="0 0 53 178" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path
            d="M37.358 176.642C35.8944 178.106 33.5165 178.11 32.0999 176.6C21.2053 164.994 12.7517 151.301 7.25754 136.333C1.33252 120.192 -1.00874 102.954 0.396269 85.8171C1.80128 68.68 6.91891 52.0539 15.3939 37.0929C23.2526 23.22 33.8236 11.0869 46.4632 1.40991C48.1067 0.151611 50.4521 0.542831 51.6578 2.22534C52.8635 3.90784 52.4727 6.2442 50.8318 7.50601C39.075 16.5471 29.2386 27.861 21.916 40.7875C13.9771 54.8021 9.18318 70.3765 7.86704 86.4296C6.55091 102.483 8.74407 118.63 14.2943 133.75C19.4136 147.697 27.2759 160.462 37.4032 171.297C38.8166 172.81 38.8217 175.178 37.358 176.642Z"
            fill="white" fill-opacity="0.25" />
        </svg>

        <Icon class="icon" icon="mdi:fuel-pump" />
        <p v-bind:style="{ color: activeColor }"> {{ VehStates.currentFuel }} / {{ VehStates.maxFuel }} L</p>
      </div>
    </div>

    <div v-show="custombars" :class="[
      { 'right-middle-content': DataPosition.toLowerCase() === 'right' },
      { 'left-middle-content': DataPosition.toLowerCase() === 'left' },
      { 'bottom-middle-content': DataPosition.toLowerCase() !== 'left' && DataPosition !== 'right' }
    ]">
      <TransitionGroup name="list" appear>
        <div v-for="content in data" :key="content">
          <div v-show="content.isActive" class="content-boxes" :class="[content.int <= 15 ? content.name : '']">
            <div class="outer-contet">
              <svg id="circle-content"
                :style="{ 'stroke': content.color, 'transform': 'rotate(270deg)', '--percent': content.int }" width="4vh"
                height="4vh" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path
                  d="M39 20C39 22.4951 38.5086 24.9658 37.5537 27.271C36.5989 29.5762 35.1993 31.6707 33.435 33.435C31.6707 35.1993 29.5762 36.5989 27.271 37.5537C24.9658 38.5086 22.4951 39 20 39C17.5049 39 15.0342 38.5086 12.729 37.5537C10.4238 36.5989 8.32928 35.1993 6.56497 33.435C4.80066 31.6707 3.40113 29.5762 2.44629 27.271C1.49145 24.9658 1 22.4951 1 20C1 17.5049 1.49145 15.0342 2.44629 12.729C3.40113 10.4238 4.80066 8.32928 6.56497 6.56497C8.32929 4.80066 10.4238 3.40113 12.729 2.44629C15.0342 1.49145 17.5049 1 20 1C22.4951 1 24.9658 1.49145 27.271 2.44629C29.5762 3.40113 31.6707 4.80066 33.435 6.56497C35.1993 8.32929 36.5989 10.4238 37.5537 12.729C38.5086 15.0342 39 17.5049 39 20L39 20Z" />
              </svg>

            </div>
            <div class="inner-content">
              <Icon class="icon" :style="{ 'color': content.color }" icon="mdi:cup-water"
                v-if="content.name === 'drink'" />
              <Icon class="icon" :style="{ 'color': content.color }" icon="mdi:food"
                v-else-if="content.name === 'food'" />
            </div>
          </div>
        </div>
      </TransitionGroup>
    </div>

    <div class="bottom-left">
      <div class="VoiceContent">
        <div class="microphone">
          <div class="outer-contet">
            <svg v-if="VoiceContent.isTalkin === 1" id="circle-content"
              :style="{ 'stroke': '#74B96E', 'transform': 'rotate(270deg)', '--percent': VoiceContent.VoiceInt }"
              width="4vh" height="4vh" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M39 20C39 22.4951 38.5086 24.9658 37.5537 27.271C36.5989 29.5762 35.1993 31.6707 33.435 33.435C31.6707 35.1993 29.5762 36.5989 27.271 37.5537C24.9658 38.5086 22.4951 39 20 39C17.5049 39 15.0342 38.5086 12.729 37.5537C10.4238 36.5989 8.32928 35.1993 6.56497 33.435C4.80066 31.6707 3.40113 29.5762 2.44629 27.271C1.49145 24.9658 1 22.4951 1 20C1 17.5049 1.49145 15.0342 2.44629 12.729C3.40113 10.4238 4.80066 8.32928 6.56497 6.56497C8.32929 4.80066 10.4238 3.40113 12.729 2.44629C15.0342 1.49145 17.5049 1 20 1C22.4951 1 24.9658 1.49145 27.271 2.44629C29.5762 3.40113 31.6707 4.80066 33.435 6.56497C35.1993 8.32929 36.5989 10.4238 37.5537 12.729C38.5086 15.0342 39 17.5049 39 20L39 20Z" />
            </svg>
            <svg v-else-if="VoiceContent.muted" id="circle-content"
              :style="{ 'stroke': '#d80032', 'transform': 'rotate(270deg)', '--percent': VoiceContent.VoiceInt }"
              width="4vh" height="4vh" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M39 20C39 22.4951 38.5086 24.9658 37.5537 27.271C36.5989 29.5762 35.1993 31.6707 33.435 33.435C31.6707 35.1993 29.5762 36.5989 27.271 37.5537C24.9658 38.5086 22.4951 39 20 39C17.5049 39 15.0342 38.5086 12.729 37.5537C10.4238 36.5989 8.32928 35.1993 6.56497 33.435C4.80066 31.6707 3.40113 29.5762 2.44629 27.271C1.49145 24.9658 1 22.4951 1 20C1 17.5049 1.49145 15.0342 2.44629 12.729C3.40113 10.4238 4.80066 8.32928 6.56497 6.56497C8.32929 4.80066 10.4238 3.40113 12.729 2.44629C15.0342 1.49145 17.5049 1 20 1C22.4951 1 24.9658 1.49145 27.271 2.44629C29.5762 3.40113 31.6707 4.80066 33.435 6.56497C35.1993 8.32929 36.5989 10.4238 37.5537 12.729C38.5086 15.0342 39 17.5049 39 20L39 20Z" />
            </svg>
            <svg v-else id="circle-content"
              :style="{ 'stroke': '#ffffff', 'transform': 'rotate(270deg)', '--percent': VoiceContent.VoiceInt }"
              width="4vh" height="4vh" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M39 20C39 22.4951 38.5086 24.9658 37.5537 27.271C36.5989 29.5762 35.1993 31.6707 33.435 33.435C31.6707 35.1993 29.5762 36.5989 27.271 37.5537C24.9658 38.5086 22.4951 39 20 39C17.5049 39 15.0342 38.5086 12.729 37.5537C10.4238 36.5989 8.32928 35.1993 6.56497 33.435C4.80066 31.6707 3.40113 29.5762 2.44629 27.271C1.49145 24.9658 1 22.4951 1 20C1 17.5049 1.49145 15.0342 2.44629 12.729C3.40113 10.4238 4.80066 8.32928 6.56497 6.56497C8.32929 4.80066 10.4238 3.40113 12.729 2.44629C15.0342 1.49145 17.5049 1 20 1C22.4951 1 24.9658 1.49145 27.271 2.44629C29.5762 3.40113 31.6707 4.80066 33.435 6.56497C35.1993 8.32929 36.5989 10.4238 37.5537 12.729C38.5086 15.0342 39 17.5049 39 20L39 20Z" />
            </svg>

            <div class="inner-content" :class="{
              'VoiceActive': VoiceContent.isTalkin === 1,
              'VoiceContentMuted': VoiceContent.muted,
            }">
              <Icon class="icon" icon="mdi:microphone" color="white" />
            </div>
          </div>
        </div>
        <div class="radio">
          <div class="outer-contet">
            <svg id="circle-content" :style="{ 'transform': 'rotate(270deg)', '--percent': 100 }" width="4vh" height="4vh"
              viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg"
              :class="VoiceContent.RadioActive == 2 ? 'VoiceActiveStroke' : 'VoiceInActiveStroke'">
              <path
                d="M39 20C39 22.4951 38.5086 24.9658 37.5537 27.271C36.5989 29.5762 35.1993 31.6707 33.435 33.435C31.6707 35.1993 29.5762 36.5989 27.271 37.5537C24.9658 38.5086 22.4951 39 20 39C17.5049 39 15.0342 38.5086 12.729 37.5537C10.4238 36.5989 8.32928 35.1993 6.56497 33.435C4.80066 31.6707 3.40113 29.5762 2.44629 27.271C1.49145 24.9658 1 22.4951 1 20C1 17.5049 1.49145 15.0342 2.44629 12.729C3.40113 10.4238 4.80066 8.32928 6.56497 6.56497C8.32929 4.80066 10.4238 3.40113 12.729 2.44629C15.0342 1.49145 17.5049 1 20 1C22.4951 1 24.9658 1.49145 27.271 2.44629C29.5762 3.40113 31.6707 4.80066 33.435 6.56497C35.1993 8.32929 36.5989 10.4238 37.5537 12.729C38.5086 15.0342 39 17.5049 39 20L39 20Z" />
            </svg>

            <div class="inner-content" :class="VoiceContent.RadioActive ? 'VoiceActive' : 'VoiceInactive'">
              <svg class="icon" width="2.7vh" height="2.8vh" viewBox="0 0 22 22" fill="none"
                xmlns="http://www.w3.org/2000/svg">
                <path
                  d="M7.61609 1.2627C7.56022 1.26248 7.50486 1.27334 7.4532 1.29462C7.40154 1.3159 7.35461 1.34717 7.3151 1.38668C7.2756 1.42619 7.24431 1.47312 7.22303 1.52478C7.20175 1.57644 7.19091 1.63179 7.19113 1.68765V5.4966C6.72857 5.4966 6.34451 5.88067 6.34451 6.34322V7.26922C5.85441 7.44569 5.49707 7.91185 5.49707 8.45892V19.465C5.49707 20.1613 6.07313 20.7365 6.76947 20.7365H15.234C15.9303 20.7365 16.5031 20.1613 16.5031 19.465V8.45892C16.5031 7.76258 15.9303 7.19067 15.234 7.19067V6.34322C15.234 5.88067 14.8499 5.4966 14.3874 5.4966H12.2716C11.8091 5.4966 11.425 5.88067 11.425 6.34322V7.19067H8.88436V6.34322C8.88436 5.88067 8.5003 5.4966 8.03774 5.4966V1.68765C8.03796 1.63206 8.02723 1.57697 8.00616 1.52553C7.98509 1.47409 7.95409 1.42733 7.91493 1.38787C7.87578 1.34841 7.82924 1.31704 7.77796 1.29557C7.72668 1.27409 7.67168 1.26292 7.61609 1.2627ZM7.19113 6.34322H7.61609H8.03774V7.19067H7.19113V6.34322ZM12.2716 6.34322H14.3874V7.19067H12.2716V6.34322ZM7.61609 8.88059H14.3874C14.4432 8.88037 14.4986 8.89122 14.5502 8.9125C14.6019 8.93378 14.6488 8.96506 14.6883 9.00457C14.7278 9.04407 14.7591 9.09101 14.7804 9.14266C14.8017 9.19432 14.8125 9.24967 14.8123 9.30554V10.9996C14.8119 11.1119 14.7668 11.2194 14.6872 11.2984C14.6075 11.3775 14.4996 11.4217 14.3874 11.4213H7.61609C7.50382 11.4217 7.39598 11.3775 7.31629 11.2984C7.2366 11.2194 7.19158 11.1119 7.19113 10.9996V9.30554C7.19091 9.24967 7.20176 9.19432 7.22304 9.14266C7.24432 9.09101 7.27562 9.04407 7.31512 9.00457C7.35463 8.96506 7.40156 8.93378 7.45321 8.9125C7.50487 8.89122 7.56022 8.88037 7.61609 8.88059ZM8.03774 9.72721V10.5747H13.9657V9.72721H8.03774ZM10.5784 13.1153H11.8467C11.9026 13.1151 11.9579 13.126 12.0096 13.1472C12.0612 13.1685 12.1082 13.1998 12.1477 13.2393C12.1872 13.2788 12.2185 13.3257 12.2397 13.3774C12.261 13.4291 12.2719 13.4844 12.2716 13.5403C12.2714 13.5959 12.2603 13.6509 12.2388 13.7022C12.2173 13.7534 12.186 13.8 12.1465 13.8391C12.107 13.8783 12.0602 13.9093 12.0088 13.9303C11.9574 13.9514 11.9023 13.9622 11.8467 13.9619H10.5784C10.5228 13.9622 10.4677 13.9514 10.4163 13.9303C10.3649 13.9093 10.3181 13.8783 10.2786 13.8391C10.2391 13.8 10.2078 13.7534 10.1863 13.7022C10.1648 13.6509 10.1537 13.5959 10.1535 13.5403C10.1532 13.4844 10.1641 13.4291 10.1854 13.3774C10.2066 13.3257 10.2379 13.2788 10.2774 13.2393C10.3169 13.1998 10.3639 13.1685 10.4155 13.1472C10.4672 13.126 10.5226 13.1151 10.5784 13.1153ZM13.1191 13.1153H14.3874C14.4432 13.1151 14.4986 13.126 14.5502 13.1472C14.6019 13.1685 14.6488 13.1998 14.6883 13.2393C14.7278 13.2788 14.7591 13.3257 14.7804 13.3774C14.8017 13.4291 14.8125 13.4844 14.8123 13.5403C14.8121 13.5959 14.8009 13.6509 14.7795 13.7022C14.758 13.7534 14.7266 13.8 14.6872 13.8391C14.6477 13.8783 14.6009 13.9093 14.5495 13.9303C14.498 13.9514 14.4429 13.9622 14.3874 13.9619H13.1191C13.0635 13.9622 13.0084 13.9514 12.957 13.9303C12.9055 13.9093 12.8587 13.8783 12.8193 13.8391C12.7798 13.8 12.7485 13.7534 12.727 13.7022C12.7055 13.6509 12.6943 13.5959 12.6941 13.5403C12.6939 13.4844 12.7048 13.4291 12.726 13.3774C12.7473 13.3257 12.7786 13.2788 12.8181 13.2393C12.8576 13.1998 12.9046 13.1685 12.9562 13.1472C13.0079 13.126 13.0632 13.1151 13.1191 13.1153ZM7.59707 13.7776C7.70891 13.7778 7.81612 13.8222 7.89528 13.9012C7.97444 13.9802 8.01911 14.0874 8.01955 14.1992C8.01977 14.2549 8.00901 14.31 7.98789 14.3615C7.96677 14.413 7.93569 14.4598 7.89645 14.4993C7.85721 14.5388 7.81057 14.5701 7.7592 14.5916C7.70783 14.613 7.65273 14.6241 7.59707 14.6242C7.5412 14.6244 7.48585 14.6136 7.43419 14.5923C7.38253 14.571 7.33559 14.5397 7.29609 14.5002C7.25658 14.4607 7.22529 14.4137 7.20401 14.3621C7.18273 14.3104 7.17189 14.2551 7.17211 14.1992C7.17255 14.0869 7.21757 13.9794 7.29727 13.9004C7.37696 13.8213 7.48481 13.7771 7.59707 13.7776ZM8.86617 13.7776C8.97786 13.778 9.08486 13.8226 9.16384 13.9016C9.24282 13.9805 9.28739 14.0875 9.28782 14.1992C9.28804 14.2548 9.27731 14.3099 9.25624 14.3613C9.23517 14.4128 9.20417 14.4596 9.16501 14.499C9.12586 14.5385 9.07932 14.5698 9.02804 14.5913C8.97676 14.6128 8.92176 14.624 8.86617 14.6242C8.8103 14.6244 8.75494 14.6136 8.70328 14.5923C8.65163 14.571 8.60469 14.5397 8.56519 14.5002C8.52568 14.4607 8.49439 14.4137 8.47311 14.3621C8.45183 14.3104 8.44099 14.2551 8.44121 14.1992C8.44165 14.0869 8.48667 13.9794 8.56636 13.9004C8.64606 13.8213 8.7539 13.7771 8.86617 13.7776ZM10.5784 14.8086H11.8467C11.9023 14.8083 11.9574 14.819 12.0088 14.8401C12.0602 14.8612 12.107 14.8922 12.1465 14.9314C12.186 14.9705 12.2173 15.0171 12.2388 15.0683C12.2603 15.1196 12.2714 15.1746 12.2716 15.2302C12.2719 15.2861 12.261 15.3414 12.2397 15.3931C12.2185 15.4448 12.1872 15.4917 12.1477 15.5312C12.1082 15.5707 12.0612 15.602 12.0096 15.6233C11.9579 15.6445 11.9026 15.6554 11.8467 15.6552H10.5784C10.5225 15.6554 10.4672 15.6445 10.4155 15.6233C10.3639 15.602 10.3169 15.5707 10.2774 15.5312C10.2379 15.4917 10.2066 15.4448 10.1854 15.3931C10.1641 15.3414 10.1532 15.2861 10.1535 15.2302C10.1537 15.1746 10.1648 15.1196 10.1863 15.0683C10.2078 15.0171 10.2391 14.9705 10.2786 14.9314C10.3181 14.8922 10.3649 14.8612 10.4163 14.8401C10.4677 14.819 10.5228 14.8083 10.5784 14.8086ZM13.1191 14.8086H14.3874C14.4429 14.8083 14.498 14.819 14.5495 14.8401C14.6009 14.8612 14.6477 14.8922 14.6872 14.9314C14.7266 14.9705 14.758 15.0171 14.7795 15.0683C14.8009 15.1196 14.8121 15.1746 14.8123 15.2302C14.8125 15.2861 14.8017 15.3414 14.7804 15.3931C14.7591 15.4448 14.7278 15.4917 14.6883 15.5312C14.6488 15.5707 14.6019 15.602 14.5502 15.6233C14.4986 15.6445 14.4432 15.6554 14.3874 15.6552H13.1191C13.0632 15.6554 13.0079 15.6445 12.9562 15.6233C12.9045 15.602 12.8576 15.5707 12.8181 15.5312C12.7786 15.4917 12.7473 15.4448 12.726 15.3931C12.7048 15.3414 12.6939 15.2861 12.6941 15.2302C12.6943 15.1746 12.7055 15.1196 12.727 15.0683C12.7485 15.0171 12.7798 14.9705 12.8193 14.9314C12.8587 14.8922 12.9055 14.8612 12.957 14.8401C13.0084 14.819 13.0635 14.8083 13.1191 14.8086ZM7.57227 15.0119C7.62786 15.0121 7.68287 15.0233 7.73414 15.0448C7.78542 15.0663 7.83196 15.0976 7.87112 15.1371C7.91027 15.1766 7.94127 15.2233 7.96234 15.2748C7.98341 15.3262 7.99414 15.3813 7.99393 15.4369C7.99349 15.5486 7.94892 15.6556 7.86994 15.7346C7.79096 15.8135 7.68397 15.8581 7.57227 15.8585C7.46 15.859 7.35216 15.8148 7.27246 15.7357C7.19277 15.6567 7.14775 15.5492 7.14731 15.4369C7.14709 15.381 7.15793 15.3257 7.17921 15.274C7.20049 15.2223 7.23178 15.1754 7.27129 15.1359C7.31079 15.0964 7.35773 15.0651 7.40938 15.0438C7.46104 15.0226 7.5164 15.0117 7.57227 15.0119ZM8.88436 15.0119C8.94023 15.0117 8.99559 15.0226 9.04725 15.0438C9.0989 15.0651 9.14584 15.0964 9.18534 15.1359C9.22485 15.1754 9.25614 15.2223 9.27742 15.274C9.2987 15.3257 9.30954 15.381 9.30932 15.4369C9.30888 15.5492 9.26386 15.6567 9.18417 15.7357C9.10447 15.8148 8.99663 15.859 8.88436 15.8585C8.77266 15.8581 8.66567 15.8135 8.58669 15.7346C8.50771 15.6556 8.46314 15.5486 8.4627 15.4369C8.46249 15.3813 8.47322 15.3262 8.49429 15.2748C8.51536 15.2233 8.54636 15.1766 8.58551 15.1371C8.62467 15.0976 8.67121 15.0663 8.72249 15.0448C8.77376 15.0233 8.82877 15.0121 8.88436 15.0119ZM7.59707 16.3182C7.70891 16.3184 7.81612 16.3629 7.89528 16.4419C7.97444 16.5209 8.01912 16.6281 8.01955 16.7399C8.01911 16.8517 7.97444 16.9589 7.89528 17.0379C7.81612 17.1169 7.70891 17.1613 7.59707 17.1616C7.48481 17.162 7.37696 17.1178 7.29727 17.0387C7.21757 16.9597 7.17255 16.8522 7.17211 16.7399C7.17233 16.6843 7.18349 16.6293 7.20497 16.578C7.22644 16.5267 7.2578 16.4802 7.29726 16.4411C7.33672 16.4019 7.38351 16.3709 7.43495 16.3498C7.4864 16.3288 7.54148 16.318 7.59707 16.3182ZM8.86617 16.3182C8.97787 16.3187 9.08486 16.3632 9.16385 16.4422C9.24283 16.5212 9.28739 16.6282 9.28782 16.7399C9.28739 16.8516 9.24282 16.9586 9.16384 17.0376C9.08486 17.1166 8.97786 17.1611 8.86617 17.1616C8.7539 17.162 8.64606 17.1178 8.56636 17.0387C8.48667 16.9597 8.44165 16.8522 8.44121 16.7399C8.44142 16.6843 8.45259 16.6293 8.47406 16.578C8.49553 16.5267 8.5269 16.4802 8.56636 16.4411C8.60582 16.4019 8.65261 16.3709 8.70405 16.3498C8.75549 16.3288 8.81058 16.318 8.86617 16.3182ZM10.5784 16.5018H11.8467C11.9023 16.5015 11.9575 16.5123 12.009 16.5334C12.0605 16.5546 12.1073 16.5856 12.1468 16.6249C12.1863 16.6641 12.2176 16.7108 12.239 16.7621C12.2605 16.8135 12.2715 16.8686 12.2716 16.9243C12.2719 16.9801 12.261 17.0355 12.2397 17.0871C12.2185 17.1388 12.1872 17.1857 12.1477 17.2252C12.1082 17.2647 12.0612 17.2961 12.0096 17.3173C11.9579 17.3386 11.9026 17.3494 11.8467 17.3492H10.5784C10.5225 17.3494 10.4672 17.3386 10.4155 17.3173C10.3639 17.2961 10.3169 17.2647 10.2774 17.2252C10.2379 17.1857 10.2066 17.1388 10.1854 17.0871C10.1641 17.0355 10.1532 16.9801 10.1535 16.9243C10.1536 16.8686 10.1646 16.8135 10.1861 16.7621C10.2075 16.7108 10.2388 16.6641 10.2783 16.6249C10.3178 16.5856 10.3646 16.5546 10.4161 16.5334C10.4676 16.5123 10.5228 16.5015 10.5784 16.5018ZM13.1191 16.5018H14.3874C14.443 16.5015 14.4982 16.5123 14.5497 16.5334C14.6012 16.5546 14.648 16.5856 14.6875 16.6249C14.7269 16.6641 14.7583 16.7108 14.7797 16.7621C14.8011 16.8135 14.8122 16.8686 14.8123 16.9243C14.8125 16.9801 14.8017 17.0355 14.7804 17.0871C14.7591 17.1388 14.7278 17.1857 14.6883 17.2252C14.6488 17.2647 14.6019 17.2961 14.5502 17.3173C14.4986 17.3386 14.4432 17.3494 14.3874 17.3492H13.1191C13.0632 17.3494 13.0079 17.3386 12.9562 17.3173C12.9045 17.2961 12.8576 17.2647 12.8181 17.2252C12.7786 17.1857 12.7473 17.1388 12.726 17.0871C12.7048 17.0355 12.6939 16.9801 12.6941 16.9243C12.6942 16.8686 12.7053 16.8135 12.7267 16.7621C12.7482 16.7108 12.7795 16.6641 12.819 16.6249C12.8585 16.5856 12.9053 16.5546 12.9568 16.5334C13.0083 16.5123 13.0634 16.5015 13.1191 16.5018Z"
                  fill="white" />
              </svg>
            </div>
          </div>
        </div>
      </div>

      <div class="location">
        <Icon class="icon" icon="material-symbols:location-on" />
        <p>
          {{ location.street }}
          <br>
          <span>
            {{ location.zone }}
          </span>
        </p>
      </div>
    </div>
  </div>
</template>



<style>
@import url('https://fonts.cdnfonts.com/css/pf-dindisplay-pro');
@import url("https://fonts.googleapis.com/css2?family=Montserrat:wght@600&display=swap");


@keyframes unscale {
  0% {
    scale: 1;
  }

  30% {
    scale: 1.1;
  }

  100% {
    scale: 0;
  }
}

.list-enter-to {
  scale: 0;
  animation: unscale .6s linear reverse;
}

.list-leave-to {
  animation: unscale .3s linear forwards;
}

.join {
  animation: unscale .6s linear reverse;
}

.remove {
  animation: unscale .3s linear forwards;
}

.hud {
  position: absolute;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
  overflow: hidden;
  /* background-color: black; */
}

.top-left {
  position: absolute;
  width: fit-content;
  height: fit-content;
  top: 1vh;
  left: 1vh;
}

.top-right {
  position: absolute;
  width: fit-content;
  height: fit-content;
  top: 2vh;
  right: 1vh;
  display: flex;
  gap: .5vh;
}

.time {
  position: relative;
  width: fit-content;
  height: fit-content;
  padding: 0vh;
  margin: 0vh;
  display: inline-block;
}

.time .icon {
  position: relative;
  color: white;
  vertical-align: middle;
  height: 2vh;
  width: 1.6vh;

}



.time p {
  position: relative;
  color: rgb(255, 255, 255);
  padding: .3vh;
  margin: 0vh;

  font-family: "Montserrat";
  font-style: normal;
  font-weight: 700;
  font-size: 1.4vh;
  line-height: 100%;
  /* identical to box height */
  /* text-align: right; */
  float: right;

}

.player {
  position: relative;
  width: fit-content;
  height: fit-content;
  padding: 0vh;
  margin: 0vh;
  display: inline-block;
}

.player .icon {
  position: relative;
  color: white;
  vertical-align: middle;
  height: 2vh;
  width: 1.6vh;

}

.player p {
  position: relative;
  color: rgb(255, 255, 255);
  padding: .3vh;
  margin: 0vh;

  font-family: "Montserrat";
  font-style: normal;
  font-weight: 700;
  font-size: 1.4vh;
  line-height: 100%;
  float: right;

}

.logo img {
  position: relative;
  width: fit-content;
  height: fit-content;
  padding: 0vh;
  margin: 0vh;
  display: inline-block;
  top: -1.5vh;
  width: 5.2vh;
  height: 5.2vh;
}

.onlineplayers {
  position: relative;
  width: fit-content;
  height: fit-content;
  padding: 0vh;
  margin: 0vh;
  display: inline-block;
}

.onlineplayers .icon {
  position: relative;
  color: white;
  height: 2vh;
  width: 1.6vh;
  vertical-align: middle;

}

.onlineplayers p {
  position: relative;
  color: rgb(255, 255, 255);
  padding: .3vh;
  margin: 0vh;

  font-family: "Montserrat";
  font-style: normal;
  font-weight: 700;
  font-size: 1.4vh;
  line-height: 100%;
  /* identical to box height */
  float: right;
}

.top-right-middle {
  position: absolute;
  width: fit-content;
  height: fit-content;
  top: 8vh;
  right: 1vh;
  /* border: 2px solid; */
}

.cash {
  font-family: "Montserrat";
  font-style: normal;
  font-weight: 700;
  font-size: 2.4vh;
  line-height: 100%;
  text-align: right;
  color: #ffffff;
  margin-bottom: 0.5vh;
}

.bank {
  font-family: "Montserrat";
  font-style: normal;
  font-weight: 700;
  font-size: 2.4vh;
  line-height: 100%;

  text-align: right;

  color: rgba(0, 162, 255, 0.85);
  margin-bottom: 0.5vh;
}

.black_money {
  font-family: "Montserrat";
  font-style: normal;
  font-weight: 700;
  font-size: 2.4vh;
  line-height: 100%;

  text-align: right;

  color: rgba(255, 107, 107, 0.65);
  margin-bottom: 0.5vh;
}

.ammunation {
  margin-top: .4vh;
  width: fit-content;
  background: linear-gradient(0deg, rgba(255, 255, 255, 0.15), rgba(255, 255, 255, 0.15)), radial-gradient(65.26% 65.26% at 50% 50%, rgba(180, 180, 180, 0.07) 0%, rgba(255, 255, 255, 0) 100%);
  border: .1vh solid rgba(255, 255, 255, 0.65);
  padding: .3vh;
  border-radius: 1vh;
  float: right;

}

.ammunation span .icon {
  position: relative;
  color: rgb(255, 255, 255);
  height: 2vh;
  width: 1.6vh;
  padding: .3vh;
  display: flex;
  align-items: center;
  justify-content: right;
}

.ammunation span {
  position: relative;
  height: 100%;
  font-family: sans-serif;
  font-style: normal;
  font-weight: 500;
  font-size: 1.4vh;
  line-height: 100%;
  color: #FFFFFF;
  display: flex;
  align-items: center;
  justify-content: right;
}

.ammunationin {
  animation: ammunationin 0.2s forwards linear;
}

.ammunationout {
  animation: ammunationout 0.2s forwards linear;
}

@keyframes ammunationout {
  to {
    margin-right: -10vh;
  }
}

@keyframes ammunationin {
  from {
    margin-right: -10vh;
  }

  to {
    margin-right: 0vh;
  }
}

@keyframes width {
  from {
    width: 0%
  }

  to {
    width: 100%
  }
}

.bottom-left {
  position: absolute;

  max-width: 30vh;
  height: fit-content;

  left: 30vh;
  bottom: 1.88vh;
}

.VoiceContent {
  display: flex;
}

.microphone {
  position: relative;
  width: 4vh;
  height: 4vh;
  margin: 0.53vh;
}

.radio {
  position: relative;
  width: 4vh;
  height: 4vh;
  margin: 0.53vh;
}

.inner-content {
  position: absolute;
  width: 3.2vh;
  height: 3.2vh;
  transform: translate(-50%, -50%);
  left: 50%;
  top: 50%;
  border-radius: 100%;
  background: rgba(255, 255, 255, 0.24);
}

.inner-content .icon {
  position: absolute;
  width: 2.8vh;
  height: 2.2vh;
  transform: translate(-50%, -50%);
  left: 50%;
  top: 50%;
  color: white;
}

.outer-contet {
  position: absolute;
  display: flex;
  justify-content: center;
  align-items: center;
  transform: translate(-50%, -50%);
  left: 50%;
  top: 50%;
}

.VoiceActive {
  background: linear-gradient(0deg, rgba(116, 185, 110, 0.25), rgba(116, 185, 110, 0.25)), rgba(255, 255, 255, 0.15);
}

.VoiceActiveStroke {
  stroke: #74B96E;
}

.VoiceInactive {
  background: rgba(255, 255, 255, 0.24);
}

.VoiceInActiveStroke {
  stroke: #ffffff;
}

.VoiceContentMuted {
  background: linear-gradient(0deg, rgba(185, 110, 110, 0.25), rgba(185, 110, 110, 0.25)), rgba(255, 255, 255, 0.15);
}

.VoiceMuted {
  background: #ff3232;
}

#circle-content {
  stroke-opacity: 0.8;
  stroke-width: .2vh;
  stroke-linecap: round;
  stroke-dasharray: 232;
  stroke-dashoffset: calc(232 - (232 * var(--percent)) / 198);
  transition: .5s;

}

.location {
  position: relative;
  width: fit-content;
  height: 4.1vh;
  right: 0;
  margin-top: .5vh;

}

.location .icon {
  position: relative;
  width: 2.4vh;
  height: 3vh;
  margin-right: .5vh;
  margin-left: .5vh;
  color: rgba(255, 255, 255, 0.8);
  filter: drop-shadow(0vh 0vh .8vh rgba(255, 255, 255, 0.836));
}

.location p {
  position: relative;

  margin-top: 0;
  margin-right: 0;

  font-family: "Montserrat";
  font-style: normal;
  font-weight: 700;
  font-size: 1.6vh;
  line-height: 100%;
  color: rgb(255, 255, 255);

  float: right;
}

.location span {
  position: relative;

  margin-top: 0;
  margin-right: 0;

  font-family: "Montserrat";
  font-style: normal;
  font-weight: 500;
  font-size: 1.2vh;
  line-height: 100%;

  color: rgba(255, 255, 255, 0.65);

  float: left;
}


.bottom-right {
  position: absolute;
  width: 25vh;
  height: 19.2vh;
  right: 5.3vh;
  bottom: 1.88vh;
}

.speedometer {
  position: relative;
  margin: auto;
  left: 10vh;
  bottom: 0;
}

.speedometer-progress {
  stroke-dasharray: 576;
  stroke-dashoffset: 576;

  stroke: #2375ef;
  stroke-opacity: 0.8;
  stroke-linecap: round;
  stroke-width: 7;
  transform-origin: center;
  transform: rotate(100deg);
  transition: .5s;
}

.needle {
  position: absolute;
  width: 19.2vh;
  height: 19.2vh;
  top: 2.8vh;
  right: 1.6vh;
  transform: rotate(45deg);

}

.needle .inside {
  width: .4vh;
  height: 7vh;
  background: #377cd7;
  border-bottom-left-radius: .5vh;
  border-bottom-right-radius: .5vh;
  border-top-left-radius: 100%;
  border-top-right-radius: 100%;
  display: inline-block;
  left: 5vh;
  position: absolute;
  top: 3.5vh;
  transform-origin: bottom;
  transform: rotate(199deg);
  transition: .5s;
}

.needle .circle {
  position: absolute;
  width: 1vh;
  height: 1vh;
  left: 4.6vh;
  top: 9.7vh;
  border: 0.2vh solid #ffffffa1;
  border-radius: 100%;
  background: #ffffff;

}

.fuelometer {
  position: absolute;
  margin: auto;

  left: 8.5vh;
  bottom: 0vh;
}

.fuelometer .icon {
  position: relative;
  width: 1.8vh;
  height: 1.8vh;
  left: -1.4vh;
  bottom: -1.7vh;
  font-size: 1.8vh;
  opacity: 0.5;
  color: #ffffff;
}

.fuelometer p {
  position: relative;
  font-family: "Montserrat";
  font-style: normal;
  font-weight: 700;
  font-size: 1.4vh;
  line-height: 100%;
  text-align: right;
  color: #ffffff;
  height: 1vh;
  margin: 0;
  padding: 0;
  margin-top: auto;
  bottom: .3vh;
  left: -3.4vh;
}

.fuelprog {
  position: absolute;
  left: 0;
  bottom: 0;
}

.progress-ring {
  position: absolute;
  width: 18.229167vw;
  height: 18.229167vw;
  left: -10vh;
  bottom: -2vh;
}

.fuelometer-progress {
  fill: none;
  stroke: #ffffff;
  stroke-opacity: 0.8;
  stroke-linecap: round;
  stroke-width: .5vh;
  stroke-dasharray: 785.3981;
  stroke-dashoffset: 785.3981;
  transform-origin: center;
  transform: rotate(137deg);
  transition: .5s;
}

.speedometer h1 {
  position: absolute;
  transform: translate(-50%, -50%);
  left: 58%;
  top: 55%;
  font-family: "Montserrat";
  font-style: normal;
  font-weight: 600;
  font-size: 3.56vh;
  margin: 0;
  padding: 0;
  background: radial-gradient(58.97% 58.97% at 50% 50%, #e6e6e6 0%, rgba(232, 245, 255, 0.404) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;

  -webkit-text-stroke: .09vh #fafafa;

}

.speedometer h1 span {
  font-family: "Montserrat";
  font-style: normal;
  font-weight: 600;
  font-size: 3.56vh;

  color: rgb(0, 0, 0, 0.37);
  background: none;

}

.speedometer p {
  position: absolute;
  transform: translate(-50%, -50%);
  left: 58%;
  top: 66%;
  font-family: "Montserrat";

  font-style: normal;
  font-weight: 600;
  font-size: 1.39vh;

  color: #FFFFFF;
  text-transform: uppercase;

  margin: 0;
  padding: 0;
}

.vehicle-states {
  position: absolute;
  width: 5vh;
  height: 5vh;
  top: 14vh;
  left: 12.5vh;
}

.vehicle-states .icon {
  position: relative;
  top: 0;
  left: 0;
  font-size: 2vh;
  margin-right: .5vh;

  color: #ffffff3b;
}

.vehicle-states .active {
  color: #ffffff;
}

.bottom-middle-content {
  position: absolute;
  transform: translate(-50%, -50%);
  left: 50%;
  bottom: -3.82vh;
  display: flex;
}

.right-middle-content {
  position: absolute;
  transform: translate(-50%, -50%);
  /* display: flex; */

  left: 98%;
  top: 50%;
}

.left-middle-content {
  position: absolute;
  transform: translate(-50%, -50%);
  display: flex;
  left: 8.5%;
  top: 77%;
}

.content-boxes {
  position: relative;
  width: 4vh;
  height: 4vh;
  margin: 1.63vh;
}

.inner-content {
  position: absolute;
  width: 3vh;
  height: 3vh;
  transform: translate(-50%, -50%);
  left: 50%;
  top: 50%;
  border-radius: 100%;
  background: rgba(0, 0, 0, 0.42);
}

.inner-content .icon {
  position: absolute;
  width: 2.5vh;
  height: 2.5vh;
  transform: translate(-50%, -50%);
  left: 50%;
  top: 50%;
  color: white;
}

.inner-content .outer-contet {
  position: absolute;
  display: flex;
  justify-content: center;
  align-items: center;
  transform: translate(-50%, -50%);
  left: 50%;
  top: 50%;
}

audio {
  display: none;
}

.blur {
  position: absolute;
  width: 28vh;
  height: 19vh;
  background: rgba(0, 0, 0, 0.089);
  top: 0;
  right: 0;
  border-bottom-left-radius: 100%;
  filter: blur(1.5vh);
}


.blur-top-left {
  position: absolute;
  width: 15vh;
  height: 10vh;
  background: rgba(0, 0, 0, 0.089);
  top: 0;
  left: 0;
  border-top-left-radius: 100%;
  filter: blur(1.5vh);
  /* border: 2px solid; */
}

.blur-bottom-right {
  position: absolute;
  width: 28vh;
  height: 27vh;
  background: rgba(0, 0, 0, 0.089);
  bottom: 0;
  right: 0;
  border-top-left-radius: 100%;
  filter: blur(1.5vh);
  /* border: 2px solid; */
}

.drink {
  animation: drink 1s 0s ease infinite;
}

.food {
  animation: food 1s 0s ease infinite;
}

@keyframes drink {

  0%,
  100% {
    filter: drop-shadow(0vh 0vh .5vh #0065d88a)
  }

  50% {
    filter: drop-shadow(0vh 0vh 1vh rgb(36, 36, 36))
  }
}



@keyframes food {

  0%,
  100% {
    filter: drop-shadow(0vh 0vh .5vh #cad8008e)
  }

  50% {
    filter: drop-shadow(0vh 0vh 1vh rgb(36, 36, 36))
  }
}
</style>