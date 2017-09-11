<template>
  <nav class="navbar navbar-default">
    <div class="container">
      <div class="navbar-header">
        <div class="navbar-brand">
          Orders
        </div>
      </div>
      <div id="navbar">
        <ul v-if="user.status != 'no user'" class="nav navbar-nav navbar-right">
          <li><a href="#">{{user.name}}</a></li>
          <li><img :src="imgUrl"></li>
          <li><a href="/logout" v-on:click="logout" data-method="delete">Logout</a></li>
        </ul>
        <ul v-if="user.status == 'no user'" class="nav navbar-nav navbar-right">
          <li><a href="/auth/facebook">Login with Facebook</a></li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'top',
    data () {
      return {

      }
    },
    computed: {
      ...mapGetters({
        user: 'current_user'
      }),
      imgUrl: function () {
        return this.user.image_url
      }
    },
    mounted: function () {
      this.$store.dispatch('CHECK_USER')
    },
    methods: {
      logout: function (e) {
        e.preventDefault()
        this.$store.dispatch('LOGOUT_USER')
      }
    }
  }
</script>
