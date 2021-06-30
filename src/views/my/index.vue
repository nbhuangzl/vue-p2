<template>
  <div class="my-container">
    <div class="header not-login">
      <div class="login-btn" @click="$router.push('/login')">
        <img round class="img-phone" src="~@/assets/seo.png" alt=/>
        <span class="text">登录 / 注册</span>
      </div>
    </div>
    <div class="header user-info">
      <div class="base-info">hello</div>
      <div class="data-stats">hi</div>
    </div>
  </div>

</template>
<script>
export default {
  name: 'MyIndex',
  components: {},
  props: {},
  data () {
    return {
    }
  },
  watch: {},
  computed: {},
  created () {},
  mounted () {},
  methods: {}
}
</script>
<style lang="less" scoped>
.my-container {
  .header {
    height: 371px;
    background: url("~@/assets/fly.png");
    background-size: cover;
  }
  .not-login {
    display: flex;
    justify-content: center;
    align-items: center;
    .login-btn {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      .img-phone {
        width: 132px;
        height: 132px;
      }
      .text {
        font-size: 28px;
        color: brown;
      }
    }
  }

  .user-info {
    .base-info {
      height: 231px;
      background-color: green;
      padding: 76px 32px 23px;
      box-sizing: border-box;
    }
    .data-stats {
      height: 130px;
      background-color: yellowgreen;
    }
  }
}
</style>
