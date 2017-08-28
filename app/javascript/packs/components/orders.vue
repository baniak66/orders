<template>
  <div class="orders container-fluid">
    <div class="row">
      <div class="col-md-12">
        <h3>Active orders</h3>
        <div v-if="orders.length > 0" class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
          <order v-for="order in orders" :order="order" :key="order.id"></order>
        </div>
        <div v-else><h5>No active orders, start one...</h5></div>
      </div>
    </div>
    <div class="row">
      <order-form></order-form>
    </div>
    <div class="row">
      <div class="col-md-12">
        <h3>History</h3>
        <div v-if="closedOrders.length > 0" class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
          <order v-for="order in closedOrders" :order="order" :key="order.id"></order>
        </div>
        <div v-else><h4>History is empty</h4></div>
      </div>
    </div>
  </div>
</template>

<script>
  import Order from './order'
  import OrderForm from './order-form'
  import { mapGetters } from 'vuex'

  export default {
    name: 'orders',
    components: {
      Order, OrderForm
    },
    computed: mapGetters([
      'orders', 'notif', 'closedOrders'
    ]),
    mounted: function () {
      this.$store.dispatch('LOAD_ORDER_LIST')
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
