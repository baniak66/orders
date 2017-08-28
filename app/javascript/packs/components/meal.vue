<template>
  <li class="media">
    <div class="media-left">
      <a v-bind:href="profileUrl" target="_blank">
        <img class="media-object" v-bind:src="meal.user.image_url">
      </a>
    </div>
    <div class="media-body">
      <h4 class="media-heading">
        {{meal.name}}
        <button v-if="(meal.user_id == user.id) && (orderStatus == 'active')" v-on:click="deleteMeal(meal)" class="btn btn-danger btn-sm">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </h4>
      price: {{priceFormated}}
    </div>
  </li>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'meal',
    props: ['meal', 'orderStatus'],
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
      }),
      priceFormated: function () {
        return Number(this.meal.price).toFixed(2)
      },
      profileUrl: function () {
        return this.meal.user.url
      }
    }
  }
</script>
