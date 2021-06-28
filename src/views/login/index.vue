<template>
  <div class="login-container">
    <!-- 导航栏 -->
    <van-nav-bar title="登录" />
    <!-- 登录表单 -->
    <van-form @submit="onSubmit">
      <van-field
        name="手机号"
        placeholder="请输入手机号"
        :rules="[{ required: true, message: '请填写用户名' }]"
      />
      <van-field
        type="password"
        name="验证码"
        placeholder="请输入验证码"
        :rules="[{ required: true, message: '请填写密码' }]"
      />
      <div style="margin: 16px">
        <van-button round block type="info" native-type="submit"
          >提交</van-button
        >
      </div>
    </van-form>
  </div>
</template>

<script>
export default {
  name: 'LoginIndex',
  components: {},
  props: {},
  data () {
    return {
      // username: "",
      // password: ""
    }
  },
  computed: {},
  watch: {},
  created () {},
  mounted () {},
  methods: {
    onSubmit (values) {
      console.log('submit', values)
    }
  }
}
</script>

<style scoped lang="less">
</style>
