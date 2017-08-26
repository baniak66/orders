<template>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" v-bind:id="'heading'+orderId">
      <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" v-bind:href="'#collapse'+orderId" aria-expanded="true" v-bind:aria-controls="'collapse'+orderId">
          <h4>
            {{order.restaurant}}
            <span class="badge">{{mealNumber}}</span>
            <span class="label label-primary">{{order.status}}</span>
          </h4>
        </a>
      </h4>
    </div>
    <div v-bind:id="'collapse'+orderId" class="panel-collapse collapse" role="tabpanel" v-bind:aria-labelledby="'heading'+orderId">
      <div class="panel-body">
        <ul class="media-list">
          <meal v-for="meal in order.meals" :meal="meal" :key="meal.id"></meal>
          <!-- <li v-for="meal in order.meals" class="media">
            <div class="media-left">
              <img class="media-object" v-bind:src="meal.user.image_url">
            </div>
            <div class="media-body">
              <h4 class="media-heading">{{meal.name}}</h4>
              price: {{meal.price}}
            </div>
          </li> -->
        </ul>
        <meal-form :order="order"></meal-form>
      </div>
    <div class="panel-footer">
      <small><em>Created {{order.created_at}} by: {{order.user.name}}</em></small>
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
      }
    },
  }
</script>
