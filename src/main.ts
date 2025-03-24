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

// 检查必要的全局变量是否已加载
function checkDependencies() {
  const required = ['Vue', 'VueRouter', 'ElementPlus', 'Pinia']
  const missing = required.filter(name => !(window as any)[name])
  if (missing.length > 0) {
    console.error('Missing required dependencies:', missing)
    return false
  }
  return true
}

// 等待 DOM 加载完成
document.addEventListener('DOMContentLoaded', () => {
  // 检查依赖是否已加载
  if (!checkDependencies()) {
    console.error('Failed to initialize app: missing dependencies')
    return
  }

  try {
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
  } catch (error) {
    console.error('Failed to initialize app:', error)
  }
}) 