<template>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" v-bind:id="'heading'+orderId">
      <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" v-bind:href="'#collapse'+orderId" aria-expanded="true" v-bind:aria-controls="'collapse'+orderId">
          <h4>
            {{order.restaurant}}
            <span class="badge">{{mealNumber}}</span>
            <span class="label label-primary">{{order.status}}</span>
            <div class="pull-right">Total value: {{sumPrices}}</div>
          </h4>
        </a>
      </h4>
    </div>
    <div v-bind:id="'collapse'+orderId" class="panel-collapse collapse" role="tabpanel" v-bind:aria-labelledby="'heading'+orderId">
      <div class="panel-body">
        <ul class="media-list">
          <meal v-for="meal in order.meals" :meal="meal" :key="meal.id"></meal>
        </ul>
        <meal-form :order="order"></meal-form>
      </div>
    <div class="panel-footer">
      <small><em>Created {{order.created_at}} by: {{order.user.name}}</em></small>
      <button v-on:click="deleteOrder(order)" class="btn btn-danger btn-sm">Delete order</button>
    </div>
    </div>
  </div>
</template>

<script>
  import MealForm from './meal-form'
  import Meal from './meal'

  export default {
    name: 'order',
    props: ['order'],
    components: {
      MealForm, Meal
    },
    computed: {
      orderId: function () {
        return this.order.id
      },
      mealNumber: function () {
        return this.order.meals.length
      },
      sumPrices: function () {
        var sum = 0
        for (var i = 0; i < this.order.meals.length; i++) {
          sum += Number(this.order.meals[i].price);
        }
        return sum.toFixed(2)
      }
    },
    methods: {
      deleteOrder: function (order) {
        this.$store.dispatch('DELETE_ORDER', order.id)
      }
    }
  }
</script>
