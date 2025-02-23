import { createPinia } from 'pinia';
import { createApp } from 'vue'
import App from './App.vue'
import "./global.scss";
import $ from "jquery";
import 'animate.css';
import "./styles/item.scss";

import Vue3ColorPicker from "vue3-colorpicker";
import "vue3-colorpicker/style.css";

createApp(App)
    .use(createPinia())
    .use(Vue3ColorPicker)
    .mount('#app');

if (import.meta.env.DEV) {
    $("body").css({
        'backgroundColor': 'rgb(15,15,15)',
        // 'background-image': 'url(./bg_test.png)'
    })
}