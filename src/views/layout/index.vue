<template>
  <div class="layout-container">
    <!-- 子路由出口 -->
    <router-view />
    <!-- 标签导航栏-->
    <!-- van-tabbar 需开启 路由功能
      van-tabbar标签添加route
      van-tabbar-item标签 to="" -->
    <!--<van-tabbar class="layout-tabbar" v-model="active" route>
      v-model="active"用以人工操作 -->
    <van-tabbar class="layout-tabbar" route>
      <van-tabbar-item class="text" icon="home-o" to="/">首页</van-tabbar-item>
      <van-tabbar-item class="text" icon="question-o" to="/qa">问答</van-tabbar-item>
      <van-tabbar-item class="text" icon="video-o" to="/video">视频</van-tabbar-item>
      <van-tabbar-item class="text" icon="user-o" to="/my">我的</van-tabbar-item>
    </van-tabbar>
  </div>
</template>
<script>
export default {
  name: 'LayoutIndex',
  components: {},
  props: {},
  data () {
    return {
      // active: 0
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
.layout-container {
  .layout-tabbar {
    .text {
        font-size: 30px;
    }
  }
}
</style>
