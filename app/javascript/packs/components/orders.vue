<template>
  <div class="orders container-fluid">
    <div class="row">
      <div class="col-md-12">
        <h3>Active orders</h3>
        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
          <order v-for="order in orders" :order="order" :key="order.id"></order>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <h3>Add new order</h3>
        <form v-on:submit="addOrder" class="form-inline">
          <div class="form-group">

            <input type="text" v-model="newOrder.restaurant" placeholder="Restaurant name" class="form-control"><br/>
          </div>
          <button type="submit" value="Submit" class="btn btn-info">Create</button>
        </form>
        <hr>
      </div>
    </div>
  </div>
</template>

<script>
  import Order from './order'
  import { mapGetters } from 'vuex'

  export default {
    name: 'orders',
    components: {
      Order
    },
    data () {
      return {
        newOrder: {
          restaurant: ""
        }
      }
    },
    computed: mapGetters([
      'orders', 'notif'
    ]),
    mounted: function () {
      this.$store.dispatch('LOAD_ORDER_LIST')
    },
    methods: {
      addOrder: function (e) {
        e.preventDefault()
        this.$store.dispatch('ADD_NEW_ORDER', {restaurant: this.newOrder.restaurant})
        this.newOrder.restaurant = ""
      }
    },
    watch: {
      'notif': function () {
        this.$notify({
          text: this.notif.message,
        })
      }
    }
  }
</script>
