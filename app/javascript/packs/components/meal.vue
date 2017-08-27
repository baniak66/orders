<template>
  <li class="media">
    <div class="media-left">
      <img class="media-object" v-bind:src="meal.user.image_url">
    </div>
    <div class="media-body">
      <h4 class="media-heading">
        {{meal.name}}
        <button v-if="meal.user_id == user.id" v-on:click="deleteMeal(meal)" class="btn btn-danger btn-sm">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </h4>
      price: {{meal.price}}
    </div>
  </li>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'meal',
    props: ['meal'],
    methods: {
      deleteMeal: function (meal) {
        this.$store.dispatch('DELETE_MEAL', {
            order_id: meal.order_id,
            meal_id: meal.id
        })
      },
    },
    computed: {
      ...mapGetters({
        user: 'current_user'
      })
    }
  }
</script>
