<template>
  <div id="app">
    <top></top>
    <div class="container">
      <div class="jumbotron">
        <p>{{ message }}</p>
      </div>

    </div>
  </div>
</template>

<script>
import Top from './components/top.vue'

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  components: {
    Top
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
