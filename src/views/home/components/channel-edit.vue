<template>
    <div class="channel-edit">
      <van-cell :border="false">
        <div slot="title">我的频道</div>
        <van-button
          class="edit-btn"
          type="danger"
          round
          plain
          size="mini"
          >
          编辑
        </van-button>
      </van-cell>
      <van-grid class="my-grid" :gutter="10" clickable>
        <van-grid-item
          icon="clear"
          class="grid-item"
          v-for="(channel, index) in myChannels"
          :key="index"
          :text="channel.name" />
      </van-grid>

      <van-cell :border="false">
        <div slot="title">频道推荐</div>
      </van-cell>
      <!-- clickable 起作用了 但是 与背景色相似 视觉看不出  -->
      <van-grid class="recommend-grid" :gutter="10" clickable>
        <van-grid-item
          clickable
          icon="plus"
          class="grid-item"
          v-for="value in 4"
          :key="value"
          text="文字111" />
      </van-grid>
    </div>
</template>
<script>
export default {
  name: 'ChannelEdit',
  components: {},
  props: {
    myChannels: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
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
.channel-edit {
  padding: 85px 0;
  .edit-btn {
    width: 104px;
    height: 48px;
    font-size: 26px;
    color: #f85959;
    border: 1px solid #f85959;
  }
  // 我的频道与频道推荐
  /deep/ .grid-item {
    width: 160px;
    height: 86px;
    .van-grid-item__content {
      text-overflow:ellipsis;
      background-color: #f6f4f4;
      .van-grid-item__text {
        font-size: 26px;
        color: #222;
        white-space: nowrap;
        margin-top: 0;
        // overflow: hidden; /*溢出的部分隐藏*/
        // text-overflow: clip; /*ellipsis:文本溢出显示省略号（...）；clip：不显示省略标记（...），而是简单的裁切*/
      }
    }
  }
  /deep/ .my-grid {
    .grid-item {
      .van-icon-clear {
        top: -10px;
        right: -10px;
        position: absolute;
        font-size: 30px;
        color: #cacaca;
        z-index: 2;
      }
    }
  }
  // 频道推荐
  /deep/ .recommend-grid {
    .grid-item {
      .van-grid-item__content {
        flex-direction: row;
        .van-icon-plus {
          font-size: 28px;
          align-items: center;
          margin-right: 6px;
        }
      }
    }
  }
}

</style>
