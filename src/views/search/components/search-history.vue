<template>
    <div class="search-history">
      <van-cell title="搜索历史">
        <div class="del-desc" v-if="isDelIconShow">
          <span>全部删除</span>
          &nbsp;&nbsp;
          <span @click="isDelIconShow = false">完成</span>
        </div>
        <van-icon v-else name="delete"
          @click="isDelIconShow = true"/>
      </van-cell>
      <van-cell
        v-for="(item, index) in searchHistories"
        :key="index"
        :title="item">
        <van-icon v-show="isDelIconShow" name="close" />
      </van-cell>
    </div>
</template>
<script>
export default {
  name: 'SearchHistory',
  components: {},
  props: {
    searchHistories: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      isDelIconShow: false
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
  }
}
</script>
<style lang="less" scoped>
// .del-desc span {
//   margin:30px;
// }
</style>
