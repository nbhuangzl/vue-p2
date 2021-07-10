import Vue from 'vue'
import dayjs from 'dayjs'

// 加载中文语言包
import 'dayjs/locale/zh-cn'
import relativeTime from 'dayjs/plugin/relativeTime'

// 配置使用处理相对时间的插件
dayjs.extend(relativeTime)

// dayjs 默认英文 可全局配置为中文
dayjs.locale('zh-cn')

// 定义1个全局过滤器,然后 任一组件的模板中引入
// 参数1: 过滤器名称
// 参数2：过滤器函数
// 使用方法 {{ 表达式 | 过滤器名称 }}
// 管道符`|` 前面的表达式结果值 会传参到过滤器中
Vue.filter('relativeTime', value => {
  return dayjs().to(dayjs(value))
})
// dayjs() 是取得当前最新时间
