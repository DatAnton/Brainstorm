<template>
  <div class="form-group form-check">
    <input :checked="selected" v-on:change="toggle()" type="checkbox" class="form-check-input">
    <label class="form-check-label" for="exampleCheck1">{{ answer.text }}</label>
  </div>
</template>

<script>
export default {
  data() {
    return {
      error: false,
      answer: this.input || {},
    }
  },
  props: {
    input: { type: Object },
  },
  computed: {
    selected() {
      return this.answer.selected;
    }
  },
  methods: {
    toggle () {
      const self = this;
      fetch(`/challenge/${this.answer.challenge_id}/answer/${this.answer.id}`, {
        body: JSON.stringify({ selected: !this.answer.selected }),
        method: 'PUT',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      })
        .then(res => {
          if (res.status !== 200) {
            throw res;
          }

          return res;
        })
        .then(res => res.json())
        .then(this.update.bind(this))
        .catch((res) => this.answer.selected = null);
    },
    update(answer) {
      if (answer.id) {
        this.answer = answer;
      }
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
