<template>
  <div>
    <span>{{ minutes }}</span>:<span>{{ seconds }}</span>
  </div>
</template>

<script>
export default {
  props: {
    time: Number,
    off: Boolean,
    redirect_to: String,
  },
  mounted() {
    if (this.off) {
      this.expired();
      return;
    }

    this.tick = this.time;
    this.interval = this.off ? null : setInterval(this.timer.bind(this), 1000);
  },
  methods: {
    expired() {
      console.log("Expired!");
      clearInterval(this.interval);
      location.href = this.redirect_to;
    },
    timer() {
      if(this.tick <= 0) {
        this.expired();
        return;
      }

      this.tick -= 1;

      this.seconds = this.tick % 60;
      this.minutes = parseInt(this.tick / 60);
    }
  },
  data() {
    return {
      tick: this.time,
      seconds: this.time % 60,
      minutes: parseInt(this.time / 60),
    }
  },
}
</script>
