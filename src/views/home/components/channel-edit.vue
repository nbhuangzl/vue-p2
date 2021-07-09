<template>
    <div class="channel-edit">
      <van-cell :border="false">
        <div slot="title">我的频道</div>
        <van-button
          class="edit-btn"
          type="primary"
          round
          plain
          size="mini"
          @click="isEdit = !isEdit"
          >
          {{ isEdit ? '完成' : '编辑'}}
        </van-button>
      </van-cell>
      <van-grid class="my-grid" :gutter="10" clickable>
        <van-grid-item
          class="grid-item"
          v-for="(channel, index) in myChannels"
          :key="index"
          @click="onMyChannelClick(channel, index)">
          <!--
            v-bind:class 语法
            1个对象中 key表示要作用的css类名
            对象那个中的value要计算出布尔值
            true 则添加 key 到 class属性中 <class="text active ">
            false 不类名
               -->
          <van-icon
            slot="icon"
            name="clear"
            v-show="isEdit && !fixedChannels.includes(channel.id)"
            >
            </van-icon>
          <span
            class="text"
            :class="{ active: index === active }"
            slot="text">
            {{channel.name}}
          </span>
        </van-grid-item>
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
          v-for="(channel, index) in recommendChannels"
          :key="index"
          :text="channel.name"
          @click="onAddChannel(channel)"/>
      </van-grid>
    </div>
</template>
<script>
import {
  getAllChannels,
  addUserChannel,
  deleteUserChannel
} from '@/api/channel'
import { mapState } from 'vuex'
import { setItem } from '@/utils/storage'

export default {
  name: 'ChannelEdit',
  components: {},
  // props属性 用以接受外部传入数据
  props: {
    myChannels: {
      type: Array,
      required: true
    },
    active: {
      type: Number,
      required: true
    }
  },
  data () {
    return {
      allChannels: [], // 所有频道
      isEdit: false, // 控制编辑状态
      fixedChannels: [1] // 我的频道中 预留固定的频道
    }
  },
  watch: {
  },
  // 计算属性 存有缓存
  // 计算属性 会观测 内部依赖数据的变化
  // 若 以来的数据发生变化 则 计算属性 会重新执行
  computed: {
    // 将vuex容器中user对象 映射到 当前页
    ...mapState(['user']),
    // 方式2
    recommendChannels () {
      return this.allChannels.filter(channel => {
        return !this.myChannels.find(myChannel => {
          return myChannel.id === channel.id
        })
      })
    }
    // 方式1
    // recommendChannels () {
    //   const channels = []
    //   this.allChannels.forEach(channel => {
    //     const ret = this.myChannels.find(myChannel => {
    //       return myChannel.id === channel.id
    //     })
    //     if (!ret) {
    //       channels.push(channel)
    //     }
    //   })
    //   return channels
    // }
  },
  created () {
    this.loadAllChannels()
  },
  mounted () {
  },
  methods: {
    async loadAllChannels () {
      try {
        const { data } = await getAllChannels()
        this.allChannels = data.data.channels
      } catch (err) {
        this.$toast('数据加载失败')
      }
    },
    async onAddChannel (channel) {
      this.myChannels.push(channel)
      // 数据持久化
      if (this.user) {
        try {
          // 已登录 数据库存储
          await addUserChannel({
            id: channel.id,
            seq: this.myChannels.length // 序号
          })
        } catch (err) {
          this.$toast('保存失败, 请稍后重试')
        }
      } else {
        // 未登录 将数据存储到本地
        setItem('TOUTIAO_CHANNELS', this.myChannels)
      }
    },
    onMyChannelClick (channel, index) {
      // 编辑状态, 执行删除频道
      if (this.isEdit) {
        // 如果是固定频道 则不删除
        if (this.fixedChannels.includes(channel.id)) {
          return
        }
        // 2. 删除频道
        this.myChannels.splice(index, 1)
        // 若是 删除 标红频道之前的频道
        if (index < this.active) {
          // 让激活频道的索引 -1
          this.$emit('update-active', this.active - 1, true)
        }
        // 持久化
        this.deleteChannel(channel)
      } else {
        // 非编辑状态, 执行切换频道
        // 父子通信, 子组件告知父组件
        this.$emit('update-active', index, false)
      }
    },
    async deleteChannel (channel) {
      try {
        if (this.user) {
          // 已登录 则将数据更新到线上
          await deleteUserChannel(channel.id)
          console.log(this.user)
        } else {
          // 未登录 将数据更新到本地
          setItem('TOUTIAO_CHANNELS', this.myChannels)
        }
      } catch (err) {
        this.$toast('操作失败, 请稍后重试')
      }
    }
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
      .van-grid-item__text, .text {
        font-size: 26px;
        color: #222;
        white-space: nowrap;
        margin-top: 0;
        // overflow: hidden; /*溢出的部分隐藏*/
        // text-overflow: clip; /*ellipsis:文本溢出显示省略号（...）；clip：不显示省略标记（...），而是简单的裁切*/
      }
      .active {
        color: red;
      }
      .van-grid-item__icon-wrapper {
        position: unset;
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
