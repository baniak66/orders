<template>
  <form v-on:submit="addMeal" class="form-inline">
    <div class="form-group">
      <input type="text" v-model="newMeal.name" placeholder="Meal name" class="form-control"><br/>
    </div>
    <div class="form-group">
      <input type="text" v-model="newMeal.price" placeholder="Price" class="form-control"><br/>
    </div>
    <button type="submit" value="Submit" class="btn btn-info">Add</button>
  </form>
</template>

<script>
  export default {
    name: 'meal-form',
    props: ['order'],
    data () {
      return {
        newMeal: {
          name: "",
          price: "0.00",
          id: this.order.id
        }
      }
    },
    methods: {
      addMeal: function (e) {
        e.preventDefault()
        this.$store.dispatch('ADD_NEW_MEAL', {
          name: this.newMeal.name,
          price: this.newMeal.price,
          id: this.order.id
        })
        this.newMeal.name = ""
        this.newMeal.price = "0.00"
      },
    },
  }
</script>
