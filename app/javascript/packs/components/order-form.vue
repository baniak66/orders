<template>
  <div class="col-md-12">
    <h3>Add new order</h3>
    <form v-on:submit="addOrder" class="form-inline">
      <div class="form-group">
        <input type="text" v-model="newOrder.restaurant" placeholder="Restaurant name" class="form-control"><br/>
      </div>
      <button type="submit" value="Submit" class="btn btn-info">Create</button>
    </form>
    <hr>
  </div>
</template>

<script>
  export default {
    name: 'order-form',
    data () {
      return {
        newOrder: {
          restaurant: ""
        }
      }
    },
    methods: {
      addOrder: function (e) {
        e.preventDefault()
        this.$store.dispatch('ADD_NEW_ORDER', {restaurant: this.newOrder.restaurant})
        this.newOrder.restaurant = ""
      }
    },
  }
</script>
