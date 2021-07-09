<template>
    <div class="search-history">
      <van-cell title="搜索历史">
        <div class="del-desc" v-if="isDelIconShow">
          <!-- @click="searchHistories = []" 不能这样写 props有解说-->
          <span  @click="$emit('clear-search-histories')">全部删除</span>
          &nbsp;&nbsp;
          <span @click="isDelIconShow = false">完成</span>
        </div>
        <van-icon v-else name="delete"
          @click="isDelIconShow = true"/>
      </van-cell>
      <van-cell
        v-for="(item, index) in searchHistories"
        :key="index"
        :title="item"
        @click="onSearchItemClick(item, index)" >
        <van-icon v-show="isDelIconShow" name="close"/>
      </van-cell>
    </div>
</template>
<script>

export default {
  name: 'SearchHistory',
  components: {},
  props: {
    // props数据
    // 01.为数字 字符串 布尔值时 绝对不能在 子组件修改
    //    因为 父组件中 对应的属性 依然未被改变
    // 02. 若是引用类型数据(数组, 对象)
    //     可以 数组.push(xxx) 对象.属性=xxx
    //     不能重新赋值 比如 数组 = []
    //      可 子组件 @click="$emit{'...'}" 告知父组件 由父组件进行相关操作
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
    onSearchItemClick (item, index) {
      if (this.isDelIconShow) {
        // 删除历史记录
        this.searchHistories.splice(index, 1)
        // 不写这里，直接写于父组件
        // setItem('TOUTIAO_SEARCH_HISTORIES', this.searchHistories)
      } else {
        // 搜索
        this.$emit('search', item)
      }
    }
  }
}
</script>
<style lang="less" scoped>
// .del-desc span {
//   margin:30px;
// }
</style>
