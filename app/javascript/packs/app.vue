<template>
  <div id="app">
    <top></top>
    <div class="container">
      <orders></orders>
    </div>
    <notifications />
  </div>
</template>

<script>
  import store from './store'
  import Top from './components/top.vue'
  import Orders from './components/orders.vue'

  export default {
    components: {
      Top, Orders
    },
    store
  }
</script>

