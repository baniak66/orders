<template>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" v-bind:id="'heading'+order_id">
      <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" v-bind:href="'#collapse'+order_id" aria-expanded="true" v-bind:aria-controls="'collapse'+order_id">
          <h4>{{order.restaurant}} <small>added by: {{order.user.name}}</small></h4>
        </a>
      </h4>
    </div>
    <div v-bind:id="'collapse'+order_id" class="panel-collapse collapse" role="tabpanel" v-bind:aria-labelledby="'heading'+order_id">
      <div class="panel-body">
        List of items here...
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'order',
    props: ['order'],
    computed: {
      order_id: function () {
        return this.order.id
      }
    },
  }
</script>
