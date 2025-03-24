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

// 等待 DOM 加载完成
document.addEventListener('DOMContentLoaded', () => {
  const { createApp } = window.Vue
  const { createPinia } = window.Pinia

  const app = createApp(App)
  const pinia = createPinia()

  // 使用 requestIdleCallback 在空闲时初始化应用
  if ('requestIdleCallback' in window) {
    window.requestIdleCallback(() => {
      app.use(pinia)
      app.use(router)
      app.use(window.ElementPlus)
      app.mount('#app')
    }, { timeout: 2000 })
  } else {
    // 降级处理
    setTimeout(() => {
      app.use(pinia)
      app.use(router)
      app.use(window.ElementPlus)
      app.mount('#app')
    }, 0)
  }
}) 