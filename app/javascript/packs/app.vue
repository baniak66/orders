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
  import store from './store'
  import Top from './components/top.vue.erb'

  export default {
    data: function () {
      return {
        message: "Hello Vue!"
      }
    },
    components: {
      Top
    },
    store
  }
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
