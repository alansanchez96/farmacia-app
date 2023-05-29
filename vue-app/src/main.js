import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import axios from 'axios'
import VueAxios from 'vue-axios'

import 'flowbite/dist/flowbite.min.css'

import './assets/main.css'

axios.defaults.baseURL = 'http://localhost:81/';

const app = createApp(App)
    .use(router)
    .use(VueAxios, axios)

app.mount('#app')
