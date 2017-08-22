import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    user: {}
  },
  actions: {
    CHECK_USER: function ({ commit }) {
      axios.get('/user').then((response) => {
        commit('SET_USER', { user: response.data })
      }, (err) => {
        commit('SET_USER', { user: {status: "no user"} })
      })
    }
  },
  mutations: {
    SET_USER: (state, { user }) => {
      state.user = user
    }
  },
  getters: {
    current_user: state => {
      return state.user
    }
  }
})
export default store
