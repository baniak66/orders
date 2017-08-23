<template>
  <div class="order">
  <li>{{order.restaurant}} {{order.user.name}}</li>
  </div>
</template>

<script>
  export default {
    name: 'order',
    props: ['order'],
  }
</script>
