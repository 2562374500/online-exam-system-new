import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'

const CDN = {
  externals: {
    vue: 'Vue',
    'vue-router': 'VueRouter',
    'element-plus': 'ElementPlus',
    pinia: 'Pinia'
  },
  css: [
    'https://cdn.jsdelivr.net/npm/element-plus@2.3.12/dist/index.css'
  ],
  js: [
    'https://cdn.jsdelivr.net/npm/vue@3.3.4/dist/vue.global.prod.js',
    'https://cdn.jsdelivr.net/npm/vue-router@4.2.4/dist/vue-router.global.prod.js',
    'https://cdn.jsdelivr.net/npm/element-plus@2.3.12/dist/index.full.min.js',
    'https://cdn.jsdelivr.net/npm/pinia@2.1.6/dist/pinia.iife.prod.js'
  ]
}

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  base: '/',
  build: {
    target: 'es2015',
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true,
        pure_funcs: ['console.log']
      }
    },
    rollupOptions: {
      external: Object.keys(CDN.externals),
      output: {
        manualChunks: (id) => {
          if (id.includes('node_modules')) {
            return 'vendor'
          }
        },
        chunkFileNames: 'assets/js/[name]-[hash].js',
        entryFileNames: 'assets/js/[name]-[hash].js',
        assetFileNames: 'assets/[ext]/[name]-[hash].[ext]'
      }
    },
    chunkSizeWarningLimit: 1500,
    cssCodeSplit: true,
    sourcemap: false,
    reportCompressedSize: false
  },
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, '')
      }
    }
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'src')
    }
  }
}) 