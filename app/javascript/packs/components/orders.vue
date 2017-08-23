<template>
  <div class="orders container">
    <ul>
      <order v-for="order in orders" :order="order" :key="order.id"></order>
    </ul>
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
