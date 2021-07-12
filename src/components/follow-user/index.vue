<template>
  <!-- 已关注 未关注 切换 -->
  <van-button
    v-if="isFollowed"
    class="follow-btn"
    round
    size="small"
    @click="onFollow"
    :loading="loading"
  >已关注</van-button>
  <van-button
    v-else
    class="follow-btn"
    type="info"
    round
    color="#3296fa"
    icon="plus"
    size="small"
    @click="onFollow"
    :loading="loading"
  >关注</van-button>
</template>
<script>
import { deleteFollow, addFollow } from '@/api/user'
export default {
  name: '',
  components: {},
  // 自定义 v-model的数据名称
  // 对应views/article/index
  // <follow-user
  //   class="follow-btn"
  //   v-model="article.is_followed"
  //   :aut-id="article.aut_id"
  // />的is_followed
  model: {
    prop: 'isFollowed', // 默认名称为value
    event: 'update-is_followed' // 默认名称为input
  },
  props: {
    isFollowed: {
      type: Boolean,
      required: true
    },
    autId: {
      type: [String, Number, Object],
      required: true
    }
  },
  data () {
    return {
      loading: false
    }
  },
  watch: {
  },
  computed: {
  },
  created () {
  },
  mounted () {
  },
  methods: {
    async onFollow () {
      // 加载中
      this.loading = true
      try {
        if (this.isFollowed) {
          // 取消关注
          await deleteFollow(this.autId)
          // this.article.is_followed = false
        } else {
          // 关注
          await addFollow(this.autId)
          // this.article.is_followed = true
        }
        // this.article.is_followed = !this.article.is_followed
        // 这里是子组件 不能修改props里的属性[数组,对象 除外]
        // 所以 不能这样写 this.isFollowed = !this.isFollowed
        this.$emit('update-is_followed', !this.isFollowed)
      } catch (err) {
        // 后端限制 不能关注自己
        let message = '操作失败，请重试'
        if (err.response && err.response.status === 400) {
          message = '不能关注自己'
        }
        this.$toast(message)
      }
      this.loading = false
    }
  }
}
</script>
<style lang="less" scoped>

</style>
