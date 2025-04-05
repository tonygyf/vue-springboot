import { createStore } from 'vuex'

export default createStore({
  state: {
    user: {
      id: 1,  // 暂时硬编码用户ID
      username: '测试用户',
      role: '普通用户',
      avatar: 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'
    }
  },
  getters: {
    currentUser: state => state.user
  },
  mutations: {
    setUser(state, user) {
      state.user = user
    }
  },
  actions: {
    updateUser({ commit }, user) {
      commit('setUser', user)
    }
  }
})