<template>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" v-bind:id="'heading'+orderId">
      <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" v-bind:href="'#collapse'+orderId" aria-expanded="true" v-bind:aria-controls="'collapse'+orderId">
          <h5>{{order.restaurant}} <span class="badge">{{mealNumber}}</span> <span class="label label-primary">{{order.status}}</span>
</h5>
        </a>
      </h4>
    </div>
    <div v-bind:id="'collapse'+orderId" class="panel-collapse collapse" role="tabpanel" v-bind:aria-labelledby="'heading'+orderId">
      <div class="panel-body">
        <ul>
          <li v-for="meal in order.meals">{{meal.name}} - {{meal.price}}</li>
        </ul>
      </div>
    <div class="panel-footer">
      <small><em>Created {{order.created_at}} by: {{order.user.name}}</em></small>
    </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'order',
    props: ['order'],
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
