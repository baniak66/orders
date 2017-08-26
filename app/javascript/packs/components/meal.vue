<template>
  <li class="media">
    <div class="media-left">
      <img class="media-object" v-bind:src="meal.user.image_url">
    </div>
    <div class="media-body">
      <h4 class="media-heading">{{meal.name}}</h4>
      price: {{meal.price}}
    </div>
  </li>
</template>

<script>
  export default {
    name: 'meal',
    props: ['meal']
  }
</script>
