<template>
  <div class="panel" v-bind:class="panelStyle">
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
        <ul v-if="order.meals.length > 0" class="media-list">
          <meal v-for="meal in order.meals" :meal="meal" :orderStatus="order.status" :key="meal.id"></meal>
        </ul>
        <div v-else class="panel-body">No meals added yet, add one if you want...</div>
        <meal-form v-if="order.status == 'active'" :order="order"></meal-form>
      </div>
      <div class="panel-footer">
        <small><em>Created {{order.created_at}} by: {{order.user.name}}</em></small>
        <div v-if="order.user_id == user.id" class="pull-right">
          <button v-if="order.status == 'active'" v-on:click="changeStatus(order, 'finalized')" class="btn btn-success btn-sm">Finalize</button>
          <button v-else-if="order.status == 'finalized'" v-on:click="changeStatus(order, 'ordered')" class="btn btn-success btn-sm">Ordered</button>
          <button v-else-if="order.status == 'ordered'" v-on:click="changeStatus(order, 'delivered')" class="btn btn-success btn-sm">Delivered</button>
          <button v-on:click="deleteOrder(order)" class="btn btn-danger btn-sm">Delete order</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import MealForm from './meal-form'
  import Meal from './meal'

  export default {
    name: 'order',
    props: ['order'],
    components: {
      MealForm, Meal
    },
    computed: {
      ...mapGetters({
        user: 'current_user'
      }),
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
      },
      panelStyle: function () {
        if (this.order.status == 'active') {
          return 'panel-success'
        } else {
          return 'panel-default'
        }
      }
    },
    methods: {
      deleteOrder: function (order) {
        this.$store.dispatch('DELETE_ORDER', order.id)
      },
      changeStatus: function (order, status) {
        this.$store.dispatch('CHANGE_STATUS', {id: order.id, status: status})
      }
    }
  }
</script>

