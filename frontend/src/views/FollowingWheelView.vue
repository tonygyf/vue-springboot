<template>
  <div class="following-wheel-view">
    <h2>我的关注</h2>
    <FollowingWheel />
  </div>
</template>

<script>
import FollowingWheel from '../components/FollowingWheel.vue';

export default {
  name: 'FollowingWheelView',
  components: {
    FollowingWheel
  }
};
</script>

<style scoped>
.following-wheel-view {
  padding: 20px;
  text-align: center;
}

h2 {
  color: #fff;
  margin-bottom: 30px;
}
</style>