import App from './App.vue'
import router from './router'

declare global {
  interface Window {
    Vue: any
    VueRouter: any
    ElementPlus: any
    Pinia: any
  }
}

const { createApp } = window.Vue
const { createPinia } = window.Pinia

const app = createApp(App)
const pinia = createPinia()

app.use(pinia)
app.use(router)
app.use(window.ElementPlus)

app.mount('#app') 