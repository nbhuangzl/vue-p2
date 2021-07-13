<template>
  <van-button
    :icon="isCollected ? 'star' : 'star-o'"
    :class="{
      collected: isCollected
    }"
    @click="onCollect"
    :loading="loading"
  />
</template>
<script>
import { deleteCollect, addCollect } from '@/api/article'
// import { deleteCollect } from '@/api/article'
export default {
  name: 'ArticleCollect',
  model: {
    prop: 'isCollected', // 默认名称为value
    event: 'update-is_collected' // 默认名称为input
  },
  components: {},
  props: {
    isCollected: {
      type: Boolean,
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
    async onCollect () {
      // 加载中
      this.loading = true
      try {
        if (this.isCollected) {
          // 取消收藏
          await deleteCollect(this.artId)
        } else {
          // 收藏
          await addCollect(this.artId)
        }
        this.$emit('update-is_collected', !this.isCollected)
      } catch (err) {
        // 后端限制 不能关注自己
        const message = '操作失败，请重试'
        // if (err.response && err.response.status === 400) {
        //   message = '不能关注自己'
        // }
        this.$toast(message)
      }
      this.loading = false
    }
  }
}
</script>
<style lang="less" scoped>
  .collected {
    .van-icon {
      color: #ffa500;
    }
  }
</style>
