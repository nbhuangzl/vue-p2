<template>
  <van-button
    :icon="isLiked === 1 ? 'good-job' : 'good-job-o'"
    :class="{
      liked: isLiked === 1
    }"
    @click="onLike"
    :loading="loading"
  />
</template>
<script>
export default {
  name: 'ArticleLike',
  model: {
    prop: 'isLiked', // 默认名称为value
    event: 'update-is_liked' // 默认名称为input
  },
  components: {},
  props: {
    isLiked: {
      type: Number,
      required: true
    },
    artId: {
      type: [Number, String, Object],
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
    onLike () {
      // 加载中
      this.loading = true
      let goodJob = 1
      try {
        if (this.isLiked === 1) {
          // 取消点赞
          goodJob = -1
        } else {
          // 点赞
          goodJob = 1
        }
        this.$emit('update-is_liked', goodJob)
        console.log(goodJob)
      } catch (err) {
        // 后端限制 不能关注自己
        const message = '操作失败，请重试'
        // if (err.response && err.response.status === 400) {
        //   message = '不能关注自己'
        // }
        this.$toast(message)
      }
      this.loading = false
      console.log('123')
    }
  }
}
</script>
<style lang="less" scoped>
  .liked {
    .van-icon {
      color: #e5645f;
    }
  }
</style>
