<template>
  <div class="my-container">
    <div class="header not-login">
      <div class="login-btn" @click="$router.push('/login')">
        <img round class="img-phone" src="~@/assets/seo.png" alt=/>
        <span class="text">登录 / 注册</span>
      </div>
    </div>
    <div class="header user-info">
      <div class="base-info">
        <div class="left">
          <van-image
            round
            fit="cover"
            class="avatar"
            src="https://img01.yzcdn.cn/vant/cat.jpeg"
          />
          <span class="name">头条新闻</span>
        </div>
        <div class="right">
          <van-button size="mini" round>编辑资料</van-button>
        </div>
      </div>
      <div class="data-stats">
        <div class="data-item">
          <span class="count">10</span>
          <span class="text">头条</span>
        </div>
        <div class="data-item">
          <span class="count">10</span>
          <span class="text">头条</span>
        </div>
        <div class="data-item">
          <span class="count">10</span>
          <span class="text">头条</span>
        </div>
        <div class="data-item">
          <span class="count">10</span>
          <span class="text">头条</span>
        </div>
      </div>
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
      padding: 76px 32px 23px;
      box-sizing: border-box;
      display: flex;
      // 撑到内容的边缘
      justify-content: space-between;
      align-items: center;
      .left {
        display: flex;
        align-items: center;
        .avatar {
          margin-right: 23px;
          width: 132px;
          height: 132px;
        }
        .name {
          font-size: 30px;
          color: black;
        }
      }
    }
    .data-stats {
      // height: 130px;
      background-color: yellowgreen;
      display: flex;
      .data-item {
        flex: 1;
        height: 130px;
        display: flex; // flex 默认水平分布
        flex-direction: column; // 垂直分布
        justify-content: center;
        align-items: center;
      }
    }
  }
}
</style>
