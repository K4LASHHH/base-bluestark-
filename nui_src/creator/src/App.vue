<template>
  <div v-if="closeable" class="bluestark_creator">
    <div class="rotate" id="rotate" @mousedown="onMouseDown"></div>
    <div class="left-side">
      <div class="header">
        <h1>Création <span>Personnage</span></h1>
        <p>Voici le menu de création de personnage</p>
      </div>

      <div class="nav-bar">
        <button class="selection-field" @click="current_category = index, zoom(index)"
          v-for="(category, index) in categories" :key="index" :class="current_category === index ? 'selected' : ''">
          <Icon class="icon" :icon="category.icon" height='30px' />
        </button>
      </div>
      <button class="action-save" @click="submit()">
        <p>Sauvegarder
          <Icon icon="material-symbols:save" :inline="true" />
        </p>
      </button>
      <!--<button class="action-shuffle" @click="shuffle">
        <p>Zufällig <Icon icon="tabler:arrows-shuffle" :inline="true" /></p>
      </button>-->
    </div>

    <div class="right_side" v-if="data">
      <!--<div class="promocode-frame">
        <h1>promocode <span>mit bonus</span></h1>
        <p>Lorem ipsum dolor sit amet consectetur.</p>

        <div class="input-frame">
          <input placeholder="promocode">
          <Icon class="icon" icon="material-symbols:check-circle-rounded" color="#B0FF4D"/>
        </div>
      </div>-->

      <div v-if="current_category === 'identity'">
        <div class="name-frame">
          <h1>Identité <span>de ton personnage</span></h1>
          <p>remplis les deux formulaires ci-dessous.</p>
          <div class="input-frames">
            <div class="input-frame">
              <input placeholder="Prénom" v-model="firstname">
              <Icon class="icon" icon="material-symbols:check-circle-rounded" color="#B0FF4D"
                v-if="checkFirstname() && firstname != ''" />
              <Icon class="icon" icon="material-symbols:error-rounded" color="#FF3434"
                v-else-if="!checkFirstname() && firstname != ''" />
            </div>
            <div class="input-frame">
              <input placeholder="Nom de famille" v-model="lastname">
              <Icon class="icon" icon="material-symbols:check-circle-rounded" color="#B0FF4D"
                v-if="checkLastname() && lastname != ''" />
              <Icon class="icon" icon="material-symbols:error-rounded" color="#FF3434"
                v-else-if="!checkLastname() && lastname != ''" />
            </div>
          </div>
        </div>

        <div class="gender-frame">
          <h1>Séléctionner <span>sexe</span></h1>
          <p>Choisis une option parmi deux.</p>
          <div class="selection-frame">
            <button class="selection-field" @click="data['sex'].value = '0', changeValue('sex', '0')"
              :class="data['sex'].value === '0' ? 'selected' : ''">
              <Icon class="icon" icon="ion:male" />
            </button>
            <button class="selection-field" @click="data['sex'].value = '1', changeValue('sex', '1')"
              :class="data['sex'].value === '1' ? 'selected' : ''">
              <Icon class="icon" icon="ion:female" />
            </button>
          </div>
        </div>

        <div class="dateofbirth-frame">
          <h1>Date de naissance <span>de ton personnage</span></h1>
          <p>entrez une date valide.</p>
          <div class="input-frame">
            <input type="date" v-model="date">
          </div>
        </div>

        <div class="heigth-frame">
          <div class="header">
            <div class="main">
              <h1><span>Taille</span> de ton personnage</h1>
              <p>fais glisser le curseur jusqu'à la valeur souhaitée.</p>
            </div>
            <p class="state">{{ height.value }}cm</p>
          </div>

          <div class="input-frame">
            <input type="range" :min="height.min" :max="height.max" v-model="height.value">
          </div>
        </div>

        <div class="parents-frame">
          <h1>parents <span>sélectionner</span></h1>
          <p>choisis ta mère et ton père</p>
          <div class="selection-frame">
            <button class="selection-field" @click="selected_parent = 'mom'"
              :class="selected_parent === 'mom' ? 'selected' : ''">
              <p>Mère</p>
            </button>
            <button class="selection-field" @click="selected_parent = 'dad'"
              :class="selected_parent === 'dad' ? 'selected' : ''">
              <p>Père</p>
            </button>
          </div>

          <div class="selection-frame-two">
            <div class="selection-list-frame">
              <button class="selection-field" v-for="(index, value) in parents[selected_parent]" :key="value"
                @click="data[selected_parent].value = value, changeValue(selected_parent, value)"
                :class="value === data[selected_parent].value ? 'selected' : ''">
                <img :src="require('@/assets/' + index.toLowerCase() + '.webp')">
              </button>
            </div>
          </div>
        </div>

        <div class="slider-frame">
          <div class="header">
            <div class="main">
              <h1>similitude <span>sélectionner</span></h1>
              <p>fais glisser le curseur jusqu'à la valeur souhaitée.</p>
            </div>
            <p class="state">{{ data['face_md_weight'].value }} / <span>{{ data['face_md_weight'].max }}</span></p>
          </div>

          <div class="input-frame">
            <input type="range" :min="data['face_md_weight'].min" :max="data['face_md_weight'].max"
              v-model="data['face_md_weight'].value" @input="changeValue('face_md_weight', data['face_md_weight'].value)">
          </div>
        </div>

        <div class="slider-frame">
          <div class="header">
            <div class="main">
              <h1>couleur de la peau <span>sélectionner</span></h1>
              <p>fais glisser le curseur jusqu'à la valeur souhaitée.</p>
            </div>
            <p class="state">{{ data['skin_md_weight'].value }} / <span>{{ data['skin_md_weight'].max }}</span></p>
          </div>

          <div class="input-frame">
            <input type="range" :min="data['skin_md_weight'].min" :max="data['skin_md_weight'].max"
              v-model="data['skin_md_weight'].value" @input="changeValue('skin_md_weight', data['skin_md_weight'].value)">
          </div>
        </div>
      </div>

      <div v-else>
        <div class="slider-frame" v-for="component in this.categories[current_category].components" :key="component">
          <div class="header">
            <div class="main">
              <h1><span>{{ data[component].label }}</span></h1>
              <p>fais glisser le curseur jusqu'à la valeur souhaitée.</p>
            </div>
            <p class="state">{{ data[component].value }} / <span>{{ data[component].max }}</span></p>
          </div>

          <div class="input-frame">
            <input type="range" :min="data[component].min" :max="data[component].max" v-model="data[component].value"
              @input="changeValue(component, data[component].value)">
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Icon } from '@iconify/vue';

export default {
  name: 'bluestark_creator',
  components: {
    Icon
  },
  data() {
    return {
      categories: {
        'identity': {
          icon: ''
        }
      },
      current_category: 'identity',
      data: null,
      closeable: false,

      firstname: '',
      lastname: '',
      date: null,
      height: {
        min: '150',
        max: '200',
        value: '150'
      },

      currentMousePositionX: null,

      selected_parent: 'mom',
      parents: {
        ['dad']: {
          ['0']: 'Benjamin',
          ['1']: 'Daniel',
          ['2']: 'Joshua',
          ['3']: 'Noah',
          ['4']: 'Andrew',
          ['5']: 'Juan',
          ['6']: 'Alex',
          ['7']: 'Isaac',
          ['8']: 'Evan',
          ['9']: 'Ethan',
          ['10']: 'Vincent',
          ['11']: 'Angel',
          ['12']: 'Diego',
          ['13']: 'Adrian',
          ['14']: 'Gabriel',
          ['15']: 'Michael',
          ['16']: 'Santiago',
          ['17']: 'Kevin',
          ['18']: 'Louis',
          ['19']: 'Samuel',
          ['20']: 'Anthony',
          ['42']: 'John',
          ['43']: 'Niko',
          ['44']: 'Claude',
        },
        ['mom']: {
          ['21']: 'Hannah',
          ['22']: 'Audrey',
          ['23']: 'Jasmine',
          ['24']: 'Giselle',
          ['25']: 'Amelia',
          ['26']: 'Isabella',
          ['27']: 'Zoe',
          ['28']: 'Ava',
          ['29']: 'Camila',
          ['30']: 'Violet',
          ['31']: 'Sophia',
          ['32']: 'Evelyn',
          ['33']: 'Nicole',
          ['34']: 'Ashley',
          ['35']: 'Grace',
          ['36']: 'Briana',
          ['37']: 'Natalie',
          ['38']: 'Olivia',
          ['39']: 'Elizabeth',
          ['40']: 'Charlotte',
          ['41']: 'Emma',
          ['45']: 'Misty',
        }
      },
    }
  },

  methods: {
    changeValue(key, value) {
      fetch("https://bluestark_creator/change", { method: "post", body: JSON.stringify({ key: key, value: value }) })
    },
    zoom(slot) {
      fetch("https://bluestark_creator/zoom", { method: "post", body: JSON.stringify({ slot: slot }) })
    },
    checkFirstname() {
      if (/\d/.test(this.firstname)) return false
      if (this.firstname === '') return false
      if (this.firstname.indexOf(' ') >= 0) return false

      return true
    },
    checkLastname() {
      if (/\d/.test(this.lastname)) return false
      if (this.lastname === '') return false
      if (this.lastname.indexOf(' ') >= 0) return false

      return true
    },
    shuffle() {
      for (let categorie of Object.keys(this.categories)) {
        if (this.categories[categorie].components) {
          for (let component of Object.entries(this.categories[categorie].components)) {
            let min = parseInt(this.data[component[1]].min)
            let max = parseInt(this.data[component[1]].max)
            let random = Math.floor(Math.random() * (max - min + 1) + min)

            if (component[1] === 'hair_2') random = 0

            this.data[component[1]].value = random.toString()

            fetch("https://bluestark_creator/change", { method: "post", body: JSON.stringify({ key: component[1], value: this.data[component[1]].value }) })
          }
        }
      }

      let random = Math.floor(Math.random() * (20 - 0 + 1) + 0)
      this.data['dad'].value = random.toString()
      fetch("https://bluestark_creator/change", { method: "post", body: JSON.stringify({ key: 'dad', value: this.data['dad'].value }) })

      let random_2 = Math.floor(Math.random() * (41 - 21 + 1) + 21)
      this.data['mom'].value = random_2.toString()
      fetch("https://bluestark_creator/change", { method: "post", body: JSON.stringify({ key: 'mom', value: this.data['mom'].value }) })
    },
    submit() {
      if (this.checkFirstname() && this.checkLastname() && this.date) {

        fetch("https://bluestark_creator/submit", {
          method: "post",
          body: JSON.stringify({
            firstname: this.firstname,
            lastname: this.lastname,
            height: this.height.value,
            sex: this.data['sex'].value,
            date: this.date
          })
        })
      } else {
        fetch("https://bluestark_creator/error", {
          method: "post",
          body: JSON.stringify({})
        })
      }
    },
    onMouseMove(evt) {
      let x = evt.clientX,
        start = this.currentMousePositionX,
        offset = ((start - x) * -1),
        normalOffset = (offset / 5) // makes everything a little bit smoother!

      if (x < 0) return

      if (normalOffset > 90) return

      if (normalOffset < -90) return

      fetch("https://bluestark_creator/moveCam", {
        method: "post",
        body: JSON.stringify({
          slot: this.current_category,
          offset: Math.ceil(normalOffset)
        })
      })
    },

    onMouseDown(evt) {
      var element = document.getElementById('rotate')
      element.classList.add('grabbed')

      document.addEventListener('mousemove', this.onMouseMove)

      this.currentMousePositionX = evt.clientX
    },

    onMouseUp() {
      var element = document.getElementById('rotate')
      element.classList.remove('grabbed')

      document.removeEventListener('mousemove', this.onMouseMove)

      this.currentMousePositionX = null
    },
    message(evt) {
      let event = evt.data;

      if (event.action === "setdata") {
        this.data = JSON.parse(event.data)
      } else if (event.action === "pushpages") {
        this.closeable = true
      } else if (event.action === "setCategories") {
        this.categories = JSON.parse(event.categories)
      } else if (event.action === "refreshComponent") {
        this.data[event.component] = JSON.parse(event.data)
      } else {
        this.closeable = false
      }
    }
  },
  mounted() {
    window.addEventListener('message', this.message)
    document.addEventListener('mouseup', this.onMouseUp)
  },
  unmounted() {
    window.removeEventListener('message', this.message)
    document.removeEventListener('mouseup', this.onMouseUp)
  }
}
</script>

<style scoped>
@import url('https://fonts.cdnfonts.com/css/akrobat');
@import url('https://fonts.cdnfonts.com/css/gilroy-bold');
@import url('https://fonts.cdnfonts.com/css/montserrat');
@import url('https://fonts.cdnfonts.com/css/monument-extended');
@import url('https://fonts.cdnfonts.com/css/sf-pro-display');
@import url('https://fonts.cdnfonts.com/css/work-sans');

body {
  overflow: hidden;
  -webkit-touch-callout: none;
  -webkit-user-select: none;
  -khtml-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  /*background-image: url(https://cdn.discordapp.com/attachments/807304395032756284/1046147360805355610/image.png);*/
}

.bluestark_creator {
  overflow: hidden;
  position: absolute;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  background: radial-gradient(44% 80% at 50% 50%, rgba(10, 12, 16, 0) 0%, rgba(10, 12, 16, 0.95) 100%);
}

.left-side {
  position: absolute;
  left: 8.52vh;
  height: 90%;
  width: fit-content;
}

.left-side .header {
  position: relative;
  margin: auto;
  width: 22.25vh;
}

.left-side .header h1,
.left-side .header p {
  position: relative;
  transform: matrix(1, -0.08, 0, 1, 0, 0);
}

.left-side .header h1 {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 800;
  font-size: 3.35vh;
  line-height: 100%;
  text-transform: uppercase;
  color: #4DB4FF;
}

.left-side .header h1 span {
  color: #fff;
}

.left-side .header p {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 500;
  font-size: 1.11vh;
  text-transform: uppercase;
  color: rgba(255, 255, 255, 0.55);
}

.left-side .nav-bar {
  position: relative;
  display: grid;
  grid-template-columns: 1fr 1fr;
  margin-top: 3.89vh;
  grid-gap: 0.93vh 0.93vh;
  width: fit-content;

  transition: .2s;
}

.left-side .nav-bar .selection-field {
  position: relative;
  width: 8.43vh;
  height: 8.43vh;
  background: linear-gradient(21.15deg, rgba(255, 255, 255, 0.07) -15.44%, rgba(255, 255, 255, 0) 109.36%);
  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  cursor: pointer;
}

.left-side .nav-bar .selection-field .icon {
  color: #FFFFFF25;
}

.left-side .nav-bar .selected {
  background: radial-gradient(77% 77% at 50% 50%, rgba(77, 180, 255, 0.25) 0%, rgba(77, 180, 255, 0) 100%);
  border: 0.09vh solid #4db5ff98;
}

.left-side .nav-bar .selected .icon {
  color: #4db5ff;
}

.left-side .action-save {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 1.85vh;
  width: 17.96vh;
  height: 5.93vh;
  background: linear-gradient(21.15deg, rgba(255, 255, 255, 0.07) -15.44%, rgba(255, 255, 255, 0) 109.36%);
  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  cursor: pointer;
}

.left-side .action-save p {
  position: absolute;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 500;
  font-size: 1.57vh;
  text-transform: uppercase;
  color: #FFFFFF;
}

.left-side .action-shuffle {
  position: absolute;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 0.93vh;
  width: 17.96vh;
  height: 4.26vh;
  background: linear-gradient(21.15deg, rgba(255, 255, 255, 0.07) -15.44%, rgba(255, 255, 255, 0) 109.36%);
  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  cursor: pointer;
}

.left-side .action-shuffle p {
  position: absolute;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 500;
  font-size: 1.57vh;
  text-transform: uppercase;
  color: #FFFFFF;
}

.right_side {
  position: absolute;
  right: 0;
  width: 24.54vh;
  gap: 1.48vh;
}

.promocode-frame {
  position: relative;
  width: 24.54vh;
  height: fit-content;
}

.promocode-frame h1 {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 800;
  font-size: 1.85vh;
  line-height: 100%;

  text-transform: uppercase;

  color: #4DB4FF;
}

.promocode-frame h1 span {
  color: #FFFFFF;
}

.promocode-frame p {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 300;
  font-size: 1.11vh;
  text-align: left;
  text-transform: uppercase;
  margin-top: 0.28vh;
  color: rgba(255, 255, 255, 0.55);
}

.promocode-frame .input-frame {
  position: relative;
  display: flex;
  align-items: center;
  width: 24.54vh;
  height: 3.15vh;

  background: linear-gradient(73.23deg, rgba(255, 255, 255, 0.07) 10.18%, rgba(255, 255, 255, 0) 87.53%);

  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  border-right: none;
}

.promocode-frame .input-frame input {
  position: relative;
  margin-left: 0.46vh;
  height: 100%;
  width: 80%;
  background: transparent;
  border: none;
  outline: none;

  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 500;
  font-size: 1.2vh;
  line-height: 100%;

  text-transform: uppercase;

  color: white;
}

.promocode-frame .input-frame .icon {
  position: absolute;
  right: 1.85vh;
  font-size: 1.85vh;
}

.gender-frame {
  position: relative;
  width: 24.54vh;
  height: fit-content;
  margin-top: 1.57vh;
}

.gender-frame h1 {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 800;
  font-size: 1.85vh;
  line-height: 100%;

  text-transform: uppercase;

  color: #4DB4FF;
}

.gender-frame h1 span {
  color: #FFFFFF;
}

.gender-frame p {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 300;
  font-size: 1.11vh;
  text-align: left;
  text-transform: uppercase;
  margin-top: 0.28vh;
  color: rgba(255, 255, 255, 0.55);
}

.gender-frame .selection-frame {
  position: relative;
  display: flex;
  align-items: center;
  width: 24.54vh;
  height: 3.46vh;
  padding: 0.8vh;
  background: linear-gradient(73.23deg, rgba(255, 255, 255, 0.07) 10.18%, rgba(255, 255, 255, 0) 87.53%);
  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  border-right: none;
  gap: 0.8vh;

  transition: .2s;

  margin-top: 1.48vh;
}

.gender-frame .selection-frame .selection-field {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 3.8vh;
  height: 3.8vh;
  background: linear-gradient(21.15deg, rgba(255, 255, 255, 0.07) -15.44%, rgba(255, 255, 255, 0) 109.36%);
  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  cursor: pointer;
}

.gender-frame .selection-frame .selection-field .icon {
  color: rgba(255, 255, 255, 0.25);
  font-size: 1.5vh;
}

.gender-frame .selection-frame .selected {
  background: radial-gradient(77% 77% at 50% 50%, rgba(77, 180, 255, 0.15) 0%, rgba(77, 180, 255, 0) 100%);
  border: 0.09vh solid #4db5ff96;
  transition: .2s;
}

.gender-frame .selection-frame .selected .icon {
  color: #4db5ff !important;
  transition: .2s;
}

.name-frame {
  position: relative;
  width: 24.54vh;
  height: fit-content;
}

.name-frame h1 {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 800;
  font-size: 1.85vh;
  line-height: 100%;

  text-transform: uppercase;

  color: #4DB4FF;
}

.name-frame h1 span {
  color: #FFFFFF;
}

.name-frame p {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 300;
  font-size: 1.11vh;
  text-align: left;
  text-transform: uppercase;
  margin-top: 0.28vh;
  color: rgba(255, 255, 255, 0.55);
}

.name-frame .input-frames {
  position: relative;
  display: grid;
  gap: 0.65vh;
  margin-top: 1.48vh;
}

.name-frame .input-frame {
  position: relative;
  display: flex;
  align-items: center;
  width: 24.54vh;
  height: 5.19vh;

  background: linear-gradient(73.23deg, rgba(255, 255, 255, 0.07) 10.18%, rgba(255, 255, 255, 0) 87.53%);

  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  border-right: none;
}

.name-frame .input-frame input {
  position: relative;
  margin-left: 0.93vh;
  height: 100%;
  width: 80%;
  background: transparent;
  border: none;
  outline: none;

  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 500;
  font-size: 1.2vh;
  line-height: 100%;

  color: white;
}

.name-frame .input-frame .icon {
  position: absolute;
  right: 1.85vh;
  font-size: 1.85vh;
}

.dateofbirth-frame {
  position: relative;
  width: 24.54vh;
  height: fit-content;
  margin-top: 1.57vh;
}

.dateofbirth-frame h1 {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 800;
  font-size: 1.85vh;
  line-height: 100%;

  text-transform: uppercase;

  color: #4DB4FF;
}

.dateofbirth-frame h1 span {
  color: #FFFFFF;
}

.dateofbirth-frame p {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 300;
  font-size: 1.11vh;
  text-align: left;
  text-transform: uppercase;
  margin-top: 0.28vh;
  color: rgba(255, 255, 255, 0.55);
}

.dateofbirth-frame .input-frame {
  position: relative;
  width: 24.54vh;
  height: 4.26vh;

  background: linear-gradient(73.23deg, rgba(255, 255, 255, 0.07) 10.18%, rgba(255, 255, 255, 0) 87.53%);

  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  outline: none;
  margin-top: 1.48vh;
}

.dateofbirth-frame .input-frame input {
  position: relative;
  background: transparent;
  outline: none;
  border: none;
  height: 100%;
  width: 90%;
  margin-left: 0.93vh;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 500;
  font-size: 1.2vh;
  line-height: 100%;

  color: white;
}

.dateofbirth-frame .input-frame input[type="date"]::-webkit-calendar-picker-indicator {
  color-scheme: dark;
}

.heigth-frame {
  position: relative;
  width: 24.54vh;
  height: fit-content;
  margin-top: 1.57vh;
}

.heigth-frame .header {
  position: relative;
  display: flex;
  align-items: center;
  height: fit-content;
  width: 100%;
}

.heigth-frame .header .state {
  position: absolute;
  right: 0.93vh;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 600;
  font-size: 1.39vh;
  text-transform: uppercase;
  color: #FFFFFF;
}

.heigth-frame .header .state span {
  color: rgba(255, 255, 255, 0.25);
}

.heigth-frame .header .main h1 {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 800;
  font-size: 1.85vh;
  line-height: 100%;

  text-transform: uppercase;

  color: #4DB4FF;
}

.heigth-frame .header .main h1 span {
  color: #FFFFFF;
}

.heigth-frame .header .main p {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 300;
  font-size: 1.11vh;
  text-align: left;
  text-transform: uppercase;
  margin-top: 0.28vh;
  color: rgba(255, 255, 255, 0.55);
}

.heigth-frame .input-frame {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24.54vh;
  height: 2.96vh;

  background: linear-gradient(73.23deg, rgba(255, 255, 255, 0.07) 10.18%, rgba(255, 255, 255, 0) 87.53%);
  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  margin-top: 0.93vh;
  gap: 0.46vh;
}

.heigth-frame .input-frame input[type="range"] {
  position: relative;
  -webkit-appearance: none;
  width: 90%;
  height: 0.27777777777777773vh;
  top: 0.09vh;
  background: rgba(255, 255, 255, 0.15);
}

.heigth-frame .input-frame input[type="range"]::-webkit-slider-thumb {
  -webkit-appearance: none;
  height: 0.6481481481481481vh;
  width: 0.6481481481481481vh;
  border-radius: 0.09259259259259259vh;
  background: white;
  cursor: pointer;
}

.heigth-frame .input-frame input[type=range]::-webkit-slider-runnable-track {
  -webkit-appearance: none;
  box-shadow: none;
  border: none;
  background: transparent;
}

.parents-frame {
  position: relative;
  width: 24.54vh;
  height: fit-content;
  margin-top: 1.48vh;
}

.parents-frame h1 {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 800;
  font-size: 1.85vh;
  line-height: 100%;

  text-transform: uppercase;

  color: #4DB4FF;
}

.parents-frame h1 span {
  color: #FFFFFF;
}

.parents-frame p {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 300;
  font-size: 1.11vh;
  text-align: left;
  text-transform: uppercase;
  margin-top: 0.28vh;
  color: rgba(255, 255, 255, 0.55);
}

.parents-frame .selection-frame {
  position: relative;
  display: flex;
  align-items: center;
  gap: 0.93vh;
  width: 24.54vh;
  height: fit-content;
  padding: 0.93vh;

  background: linear-gradient(73.23deg, rgba(255, 255, 255, 0.07) 10.18%, rgba(255, 255, 255, 0) 87.53%);
  border: 0.09vh solid rgba(255, 255, 255, 0.11);

  margin-top: 1.57vh;
}

.parents-frame .selection-field {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 9.26vh;
  height: 3.15vh;

  background: linear-gradient(73.23deg, rgba(255, 255, 255, 0.07) 10.18%, rgba(255, 255, 255, 0) 87.53%);
  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  cursor: pointer;
  transition: .2s;
}

.parents-frame .selected {
  background: radial-gradient(77% 77% at 50% 50%, rgba(77, 180, 255, 0.15) 0%, rgba(77, 180, 255, 0) 100%);
  border: 0.09vh solid #4db5ff96;
  transition: .2s;
}

.parents-frame .selection-field p {
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 300;
  font-size: 1.3vh;

  text-align: center;
  text-transform: uppercase;

  color: rgba(255, 255, 255, 0.55);
  margin-top: 0;
}

.parents-frame .selected p {
  color: #ffffff !important;
}

.selection-frame-two {
  position: relative;
  display: flex;
  justify-content: center;
  width: 24.54vh;
  height: 13.98vh;
  direction: rtl;
  overflow-x: hidden;
  overflow-y: scroll;
  margin-top: 1.02vh;
}

.selection-frame-two::-webkit-scrollbar {
  position: absolute;
  width: 0.09259259259259259vh;
}

.selection-frame-two::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.15);
}

.selection-frame-two::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.55);
}

.selection-frame-two .selection-list-frame {
  position: relative;
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  width: fit-content;
  height: fit-content;
  grid-gap: 1.02vh 1.02vh;
  direction: ltr;
}

.selection-frame-two .selection-list-frame .selection-field {
  position: relative;
  width: 6.48vh;
  height: 6.48vh;
  background: linear-gradient(73.23deg, rgba(255, 255, 255, 0.07) 10.18%, rgba(255, 255, 255, 0) 87.53%);
  overflow: hidden;
}

.selection-frame-two .selection-list-frame .selection-field p {
  position: absolute;
  bottom: 3px;
}

.selection-frame-two .selection-list-frame .selection-field img {
  position: absolute;
  width: 100%;
  height: 100%;
}

.selection-frame-two .selection-list-frame .selected {
  background: radial-gradient(77% 77% at 50% 50%, rgba(77, 180, 255, 0.15) 0%, rgba(77, 180, 255, 0) 100%);
  border: 0.09vh solid #4db5ff96;
}

.slider-frame {
  position: relative;
  width: 24.54vh;
  height: fit-content;
  margin-top: 1.57vh;
}

.slider-frame .header {
  position: relative;
  display: flex;
  align-items: center;
  height: fit-content;
  width: 100%;
}

.slider-frame .header .state {
  position: absolute;
  right: 0.93vh;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 600;
  font-size: 1.39vh;
  text-transform: uppercase;
  color: #FFFFFF;
}

.slider-frame .header .state span {
  color: rgba(255, 255, 255, 0.25);
}

.slider-frame .header .main h1 {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 800;
  font-size: 1.85vh;
  line-height: 100%;

  text-transform: uppercase;

  color: #4DB4FF;
}

.slider-frame .header .main h1 span {
  color: #FFFFFF;
}

.slider-frame .header .main p {
  position: relative;
  margin: 0;
  padding: 0;
  font-family: 'Akrobat';
  font-style: normal;
  font-weight: 300;
  font-size: 1.11vh;
  text-align: left;
  text-transform: uppercase;
  margin-top: 0.28vh;
  color: rgba(255, 255, 255, 0.55);
}

.slider-frame .input-frame {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24.54vh;
  height: 2.96vh;

  background: linear-gradient(73.23deg, rgba(255, 255, 255, 0.07) 10.18%, rgba(255, 255, 255, 0) 87.53%);
  border: 0.09vh solid rgba(255, 255, 255, 0.11);
  margin-top: 0.93vh;
  gap: 0.46vh;
}

.slider-frame .input-frame input[type="range"] {
  position: relative;
  -webkit-appearance: none;
  width: 90%;
  height: 0.27777777777777773vh;
  top: 0.09vh;
  background: rgba(255, 255, 255, 0.15);
}

.slider-frame .input-frame input[type="range"]::-webkit-slider-thumb {
  -webkit-appearance: none;
  height: 0.6481481481481481vh;
  width: 0.6481481481481481vh;
  border-radius: 0.09259259259259259vh;
  background: white;
  cursor: pointer;
}

.slider-frame .input-frame input[type=range]::-webkit-slider-runnable-track {
  -webkit-appearance: none;
  box-shadow: none;
  border: none;
  background: transparent;
}

.rotate {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.grabbed {
  cursor: grab;
}
</style>