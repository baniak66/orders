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
    computed: mapGetters([
      'orders'
    ]),
    mounted: function () {
      this.$store.dispatch('LOAD_ORDER_LIST')
    }
  }
</script>
