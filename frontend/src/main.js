import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import App from './App.vue'
import store from './store'
import Login from './components/Login.vue'
import Register from './components/Register.vue'
import Home from './components/Home.vue'
import BlogList from './components/BlogList.vue'
import CreateBlog from './components/CreateBlog.vue'
import DeletedBlogList from './components/DeletedBlogList.vue'

const routes = [
    { path: '/', redirect: '/login' },
    { path: '/login', component: Login },
    { path: '/register', component: Register },
    { path: '/home', component: Home },
    { path: '/blogs', component: BlogList },
    { path: '/blogs/:id', component: () => import('./components/BlogDetail.vue') },
    { path: '/blogs/create', component: CreateBlog },
    { path: '/user-management', component: () => import('./components/UserManagement.vue') },
    { 
        path: '/deleted-blogs',
        name: 'DeletedBlogList',
        component: DeletedBlogList,
        beforeEnter: (to, from, next) => {
            const user = JSON.parse(localStorage.getItem('user'));
            if (user && user.role === 'admin') {
                next();
            } else {
                next('/blogs');
            }
        }
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

router.beforeEach((to, from, next) => {
    if (to.path === '/user-management') {
        const user = JSON.parse(localStorage.getItem('user'))
        if (!user || user.role !== 'admin') {
            next('/home')
            return
        }
    }
    next()
})

const app = createApp(App)
app.use(router)
app.use(store)
app.use(ElementPlus)
app.mount('#app')