import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common['Accept'] = 'application/json'

let search = (arry, id) => {
  for (var i=0; i < arry.length; i++) {
    if (arry[i].id === id) { return i }
  }
}
let notif = (err) => {
  return { notif: { message: err, time: Date.now()}}
}

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    user: {},
    orders: [],
    notif: {}
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
    ADD_NEW_ORDER: ({ commit }, payload) => {
      axios.post('/orders', {order: payload}).then((response) => {
        commit('ADD_ORDER', { order: response.data })
      }, (err) => {
        commit('SET_NOTIF', notif(err.response.data.error))
      })
    },
    DELETE_ORDER: ({ commit }, payload) => {
      axios.delete('/orders/' + payload).then((response) => {
        commit('REMOVE_ORDER', { order: response.data })
      }, (err) => {
        commit('SET_NOTIF', notif(err.response.data.error))
      })
    },
    CHANGE_STATUS: ({commit}, payload) => {
      axios.put('/orders/' + payload.id, { status: payload.status}).then((response) => {
        commit('UPDATE_ORDER', { order: response.data })
      }, (err) => {
        commit('SET_NOTIF', notif(err.response.data.error))
      })
    },
    ADD_NEW_MEAL: ({ commit }, payload) => {
      axios.post('/orders/'+payload.id+'/meals', {meal: payload}).then((response) => {
        commit('ADD_MEAL', { meal: response.data })
      }, (err) => {
        commit('SET_NOTIF', notif(err.response.data.error))
      })
    },
    DELETE_MEAL: ({ commit }, payload) => {
      axios.delete('/orders/' + payload.order_id + '/meals/' + payload.meal_id).then((response) => {
        commit('REMOVE_MEAL', { meal: response.data })
      }, (err) => {
        commit('SET_NOTIF', notif(err.response.data.error))
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
    ADD_ORDER: (state, { order }) => {
      state.orders.push(order)
    },
    REMOVE_ORDER: (state, { order }) => {
      state.orders.splice(search(state.orders, order.id),1);
    },
    UPDATE_ORDER: (state, { order }) => {
      let updated = state.orders.filter((ord) => { return ord.id == order.id})[0]
      updated.status = order.status
    },
    ADD_MEAL: (state, { meal }) => {
      let meals = state.orders.filter((ord) => { return ord.id == meal.order_id})
      meals[0].meals.push(meal)
    },
    REMOVE_MEAL: (state, { meal }) => {
      let order_meals = state.orders.filter((ord) => { return ord.id == meal.order_id})[0]
      order_meals.meals.splice(search(order_meals.meals, meal.id),1);
    },
    SET_NOTIF: (state, { notif }) => {
      state.notif = notif
    },
  },
  getters: {
    current_user: state => {
      return state.user
    },
    orders: state => {
      return state.orders.filter(order => order.status == "active" )
    },
    notif: state => {
      return state.notif
    },
    closedOrders: state => {
      return state.orders.filter(order => order.status != "active" )
    }
  }
})
export default store
