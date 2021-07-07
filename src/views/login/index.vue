<template>
  <div class="login-container">
    <!-- 导航栏 -->
    <van-nav-bar title="登录">
      <!-- 关闭图标 -->
      <van-icon
        slot="left"
        name="cross"
        color="black"
        @click="$router.back()"
      />
    </van-nav-bar>
    <!-- 登录表单 -->
    <!--  type="number" 输入框仅能输入数字-->
    <!-- 倒计时结束监听 用以隐藏 @finish="isCountDownShow = false"-->
    <van-form ref="loginForm" @submit="onSubmit">
      <van-field
        left-icon="phone-o"
        name="mobile"
        v-model="user.mobile"
        placeholder="请输入手机号"
        :rules="userFormRules.mobile"
        type="number"
        maxlength="11"
      />
      <van-field
        left-icon="like-o"
        name="code"
        v-model="user.code"
        placeholder="请输入验证码"
        :rules="userFormRules.code"
      >
        <template #button>
          <van-count-down
            v-if="isCountDownShow"
            :time="1000*3"
            format="ss s"
            @finish="isCountDownShow = false"
          />
          <van-button
            v-else
            native-type="button"
            class="send-msg-btn"
            round
            size="small"
            type="default"
            @click="onSendSms"
            >发送验证码</van-button
          >
        </template>
      </van-field>
      <div class="login-btn-wrap">
        <van-button class="login-btn" block type="info" native-type="submit"
          >提交</van-button>
      </div>
    </van-form>
  </div>
</template>

<script>
import { login, sendSms } from '@/api/user'
export default {
  name: 'LoginIndex',
  components: {},
  props: {},
  data () {
    return {
      user: {
        mobile: '',
        code: ''
      },
      userFormRules: {
        mobile: [{
          required: true,
          message: '请输入手机号不为空'
        },
        {
          pattern: /1[3|5|7|8]\d{9}/,
          message: '手机号格式错误'
        }],
        code: [{
          required: true,
          message: '验证码不为空'
        },
        {
          pattern: /\d{6}/,
          message: '验证码格式不符'
        }]
      },
      isCountDownShow: false
    }
  },
  computed: {},
  watch: {},
  created () {},
  mounted () {},
  methods: {
    async onSubmit () {
      // 1.取得表单数据
      const user = this.user
      // 2.表单验证
      this.$toast.loading({
        message: '加载中...',
        forbidClick: true, // 禁用背景点击
        duration: 0 // 持续时间 默认2s  为0表示为持续
      })
      // 3.提交表单 请求登录
      try {
        const { data } = await login(user)
        this.$store.commit('setUser', data.data)
        this.$toast.success('登录成功')
        // 功能不严谨 待优化
        this.$router.back()
      } catch (err) {
        if (err.response.status === 400) {
          this.$toast.fail('手机号或者验证码错误')
        } else {
          this.$toast.fail('登录失败 稍后再试')
        }
      }
      // 4. 依据请求响应结果处理后续操作
    },
    async onSendSms () {
      // 1.校验手机号
      try {
        await this.$refs.loginForm.validate('mobile')
        this.$toast('发送成功')
      } catch (err) {
        return console.log('验证失败', err)
      }
      // 2.验证通过,显示倒计时
      this.isCountDownShow = true
      // 3.请求发送验证码
      try {
        await sendSms(this.user.mobile)
      } catch (err) {
        if (err.response.status === 429) {
          this.$toast('发送频繁, 稍后重试')
        } else {
          this.$toast('发送失败')
        }
        console.log('发送失败', err)
      }
    }

  }
}
</script>

<style scoped lang="less">
.send-msg-btn {
  width: 156px;
  height: 46px;
  line-height: 46px;
  font-size: 20px;
  color: #666;
  background-color: #ededed;
}
.login-btn-wrap {
  padding: 53px 33px;
  .login-btn {
    background-color: #6db4fb;
    border: none;
  }
}
</style>
