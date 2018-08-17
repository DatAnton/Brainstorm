<template>
  <div class="form-group form-check">
    <input v-on:change="alert(answer.id)" type="checkbox" class="form-check-input">
    <label class="form-check-label" for="exampleCheck1">{{ answer.text }}</label>
  </div>
</template>

<script>
export default {
  data: () => ({}),
  props: ['answer'],
  methods: {
    alert: (data) => alert(data || '!'),
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
