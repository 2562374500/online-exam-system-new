declare const VueRouter: any

const { createRouter, createWebHistory } = VueRouter

const router = createRouter({
  history: createWebHistory('/'),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('../views/HomeView.vue')
    },
    {
      path: '/exam-list',
      name: 'exam-list',
      component: () => import('../views/exam/ExamList.vue')
    },
    {
      path: '/paper-list',
      name: 'paper-list',
      component: () => import('../views/paper/PaperList.vue')
    },
    {
      path: '/question-list',
      name: 'question-list',
      component: () => import('../views/question/QuestionList.vue')
    }
  ]
})

export default router 