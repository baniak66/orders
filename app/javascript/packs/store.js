import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    user: {},
    orders: []
  },
  actions: {
    CHECK_USER: function ({ commit }) {
      axios.get('/user').then((response) => {
        commit('SET_USER', { user: response.data })
      }, (err) => {
        commit('SET_USER', { user: {status: "no user"} })
      })
    },
    LOGOUT_USER: function ({ commit }) {
      commit('CLEAR_USER', { user: {status: "no user"} })
    },
    LOAD_ORDER_LIST: ({ commit }) => {
      axios.get('/orders').then((response) => {
        commit('SET_ORDER_LIST', { list: response.data })
      }, (err) => {
        console.log(err)
      })
    },
  },
  mutations: {
    SET_USER: (state, { user }) => {
      state.user = user
    },
    CLEAR_USER: (state, { user }) => {
      state.user = user
    },
    SET_ORDER_LIST: (state, { list }) => {
      state.orders = list
    },
  },
  getters: {
    current_user: state => {
      return state.user
    },
    orders: state => {
      return state.orders
    }
  }
})
export default store
