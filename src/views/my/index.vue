<template>
  <div class="my-container">
    <div v-if="user" class="header user-info">
      <div class="base-info">
        <div class="left">
          <van-image
            round
            fit="cover"
            class="avatar"
            :src="userInfo.photo"
          />
          <span class="name">{{userInfo.name}}</span>
        </div>
        <div class="right">
          <van-button size="mini" round>编辑资料</van-button>
        </div>
      </div>
      <div class="data-stats">
        <div class="data-item">
          <span class="count">{{userInfo.art_count}}</span>
          <span class="text">头条</span>
        </div>
        <div class="data-item">
          <span class="count">{{userInfo.follow_count}}</span>
          <span class="text">关注</span>
        </div>
        <div class="data-item">
          <span class="count">{{userInfo.fans_count}}</span>
          <span class="text">粉丝</span>
        </div>
        <div class="data-item">
          <span class="count">{{userInfo.like_count}}</span>
          <span class="text">获赞</span>
        </div>
      </div>
    </div>
    <div v-else class="header not-login">
      <div class="login-btn" @click="$router.push('/login')">
        <img round class="img-phone" src="~@/assets/seo.png" alt=/>
        <span class="text">登录 / 注册</span>
      </div>
    </div>
    <van-grid class="grid-nav" :column-num="2" clickable>
      <!--<van-grid-item icon="photo-o" text="文字" />
      <van-grid-item icon="photo-o" text="文字" /> -->
      <van-grid-item class="grid-item">
        <van-icon name="star-o" class="icon star"/>
        <span class="text">收藏</span>
      </van-grid-item>
      <van-grid-item  class="grid-item">
        <van-icon name="underway-o" class="icon history"/>
        <span class="text">历史</span>
      </van-grid-item>
    </van-grid>
    <van-cell-group>
      <van-cell title="消息通知" class="notice" is-link />
      <van-cell title="小智同学" class="stu" is-link />
    </van-cell-group>
    <van-cell v-if="user" title="退出登录" class="logout-cell" clickable @click="onLogout"/>
  </div>
</template>
<script>
// 容器数据
import { mapState } from 'vuex'
import { getUserInfo } from '@/api/user'

export default {
  name: 'MyIndex',
  components: {},
  props: {},
  data () {
    return {
      userInfo: {} // 用户信息
    }
  },
  watch: {},
  computed: {
    ...mapState(['user'])
  },
  created () {
    // 若用户已登录 则请求加载用户信息
    if (this.user) {
      this.loadUserInfo()
    }
  },
  mounted () {},
  methods: {
    onLogout () {
      // 退出提示
      // Dialog.confirm({ -- 组件中需要this.$dialog
      this.$dialog.confirm({
        title: '确认退出吗！'
        // message: '是否退出',
      }).then(() => {
        // on confirm
        // 清除登录状态 (容器中的user与本地存储中的user)
        this.$store.commit('setUser', null)
      }).catch(() => {
        console.log('xxx')
      })
    },
    async loadUserInfo () {
      try {
        const { data } = await getUserInfo(this.user.mobile)
        this.userInfo = data.data
      } catch (err) {
        this.$toast('获取数据失败, 稍后再试')
      }
    }
  }
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
          border: 5px solid #ff9d1d;
        }
        .name {
          font-size: 30px;
          color: black;
        }
      }
    }
    .data-stats {
      // height: 130px;
      display: flex;
      .data-item {
        flex: 1;
        height: 130px;
        display: flex; // flex 默认水平分布
        flex-direction: column; // 垂直分布
        justify-content: center;
        align-items: center;
        // color: #fff;
        .count {
          font-size: 36px;
        }
        .text {
          font-size: 23px;
        }
      }
    }
  }

  .grid-nav {
    .grid-item {
      height: 141px;
      .icon {
        font-size: 45px;
      }
      .star {
        color: #eb5253;
      }
      .history {
         color: #ff9d1d;
      }
      span.text {
        font-size: 28px;
      }
    }
  }
  .stu {
    margin-bottom:3px;
  }
  .logout-cell {
    text-align: center;
    color: #d86262
  }
}
</style>
