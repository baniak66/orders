<template>
  <div class="orders container">
    <ul>
      <li v-for="order in orders">{{order.restaurant}} {{order.user.name}}</li>
    </ul>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'orders',
    computed: mapGetters([
      'orders'
    ]),
    mounted: function () {
      this.$store.dispatch('LOAD_ORDER_LIST')
    }
  }
</script>
