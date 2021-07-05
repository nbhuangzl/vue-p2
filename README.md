# vue-p2

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Run your tests
```
npm run test
```

### Lints and fixes files
```
npm run lint
```
// YApi接口管理
npm install -g yapi-cli --registry https://registry.npm.taobao.org
yapi server

http://127.0.0.1:9090/

时间库
Moment.js
Day.js

vant中通常组件本身就有左右边距

z-index 元素的堆叠顺序

$ 001-004
# 异常001 -- vue：无法加载文件 D:\vue_learn\vue.ps1，因为在此系统上禁止运行脚本
          get-ExecutionPolicy

          请为以下参数提供值:
          ExecutionPolicy: RemoteSigned
		  
# 异常002 -- package.json被删除
          执行 npm init -y 即可		

# 异常003 -- 版本兼容异常
          若版本兼容异常 则查看
          npm list vue-template-compiler -g
          D:\vue_learn
`         -- @vue/cli@3.10.0
  `       -- vue-jscodeshift-adapter@2.2.0
    `     -- vue-template-compiler@2.6.12
          npm list vue -g
	
          npm uninstall vue@2.6.10 -g
          npm install vue@2.6.12 -g		

# 异常004
C:\RailsInstaller\Git\cmd\git.EXE ls-remote -h -t ssh://git@github.com/sohee-lee7/Squire.git
应对： cnpm install
		  
# 异常005
  fatal: unable to access 'https://github.com/koking0/Algorithm.git/': 
  OpenSSL SSL_read: Connection was reset, errno 10054
  -- .git/cofig中的url里https改成http

# 开发手册
https://cli.vuejs.org
https://element.eleme.cn/#/zh-CN

# 快捷键
ctrl+enter 光标到下一行
字符串拼接 `xxx${xxx}`
注释： ctrl+k ctrl+c



# 技巧 101 - ...
101. src > api > login.js
     每个函数都独立export， 每次导入某一函数，其他函数不需要都导出

102. 模板文件中 只能有1个根元素 不限于<div> 也可以是其他元素

103. 非json对象的判断

export const getItem = key => {
  const data = window.localStorage.getItem(key)
  try {
    return JSON.parse(data)
  } catch (err) {
    return data
  }
}

104. vue模板
File/Preferences/User snippets

vue.json

{
	"Print to console": {
	"prefix": "vue",
	"body": [
		"<template>",
		"    <div>\n",
		"    </div>",
		"</template>",
		"<script>",
		"export default {",
		"  name: '',",
		"  components: {},",
		"  props: {},",
		"  data () {",
		"    return {",
		"    }",
		"  },",
		"  watch: {",
		"  },",
		"  computed: {",
		"  },",
		"  created () {",
		"  },",
		"  mounted () {",
		"  },",
		"  methods: {",
		"  }",
		"}",
		"</script>",
		"<style lang=\"less\" scoped>\n",
		"</style>",
		"$2"
	],
	"description": "Log output to console"
}
}

105. 相对路径快捷写法
    样式中 ~@/assets/xxx.png
	@/assets/xxx.png

106. 插入vant已有的图标 
      <van-icon
        slot="left"
        name="cross"
        // @click="$router.back()"
      />

107: computed与method
        
		computed其实是就是属性，之所以与data区分开，
        只不过为了防止文本插值中逻辑过重，会导致不易维护
		 
        computed是属性访问,而methods是函数调用
		computed带有缓存功能，而methods不是
		
		{{computedTest}} / {{methodTest()}}

108: 取数据
          局部, 模板中每用1个地方就需写1次
          $store.state.user 
          全局 模板中写1次 
          ...mapState(['user'])

109: 组件
          先定义模板
// 01. components/article-list.vue
<template>
    <div class="article-list">
        文章列表组件
    </div>
</template>
<script>
export default {
  name: '',
  components: {},
  props: {},
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

</style>

// 02.引入组件
<template>
  ...
    <article-list :channel="channel"/>
  ...
</template>
<script>
    import ArticleList from './components/article-list'
	export default {
	  name: 'HomeIndex',
	  components: {
      ArticleList
    },
    ...
</script>

110. Vue.js_devtools_5.1.0 开发者工具 > vue 
         -- 可 搜索 变量名称 用以验证
         -- 表单数据是否双向绑定等
		 
111. 若底部被遮挡 可以底部填充 padding-bottom等	
         填充*2	 
		 
112. 子元素填充不开 应查找父节点 是否max-width限制
     .van-nav-bar__title {
       max-width: unset;
     }
	 
113. style 为scoped时 仅作用于当前页 以及所引用组件的根节点  比如(vant）
		
	 可添加深度操作符【 >>> ; /deep/ 】：
	 /deep/ .channel-tabs {
	   .van-tab {
		 border-right: 1px solid #edeff3;
	   }
114. 若 样式宽度 已经进来 而页面宽未起作用
     查看父标签 是否 display:flex
	 父标签为 flex时 子标签 style=flex-basis: 会平分
	 可用 min-width
	 样式高度未生效 可查看父标签的高度

115. 样式最高级 !important


116. es6语法
     const { xxx } = this.state;
	 相当于
	 const xxx = this.state.xxx

117. 遍历 object类型的list
     <van-cell v-for="(item, index) in list" :key="index" :title="item.title" />

118. this.list.push(...变量名)
     this.list.push(...[{ title: 'aa你好', name: 'aa' }, { title: 'bb你好', name: 'bb' }])
     console.log('测试', this.list_test_test)
	 + 逐个取出 元素1 { title: 'aa你好', name: 'aa' } 元素2 { title: 'bb你好', name: 'bb' }
	   放入list中

     +  ... 为数组的展开操作符, 它会把数组元素1个1个拿出来
	 
119. 错误提示
     vant语法 > List列表
	 
     :error.sync="error"
     error-text="请求失败，点击重新加载"
	 
	 
120. 内容被遮挡 可以找到根节点 设置padding-top

121. 黏贴到console 
     function findScroller(element) {
		element.onscroll = function() { console.log(element) }
		Array.from(element.children).forEach(findScroller)
	 }
	 findScroller(document.body)

122. vant移动端 记住列表各自滚动的位置
     // css3中新增了1种视口单位 vw和vh 是依据浏览器窗口大小的单位,不受父元素影响
     寻找到 列表公用的组件 样式设置为：
	 <style lang="less" scoped>
      .article-list {
        height: 82vh;
        overflow-y: auto;
      }
     </style>
	 
123. 第3方图片链接 403
     设置请求中的refer
	 public/index.html:
	 <meta name="referrer" content="no-referrer" />
	
124. 文本超出显示省略号
<p class="index__Feature-list-itemlist-title newline">
   {{item.name| ellipsis}}
</p>
export default {
       name: '',
       filters: {
         ellipsis (value) {
           if (!value) return ''
           if (value.length > 32) {
             return value.slice(0,32) + '...'
           }
           return value
       }
     },	
	 
1.0 npm操作

1.1 node环境安装
    http://nodejs.cn/
    验证：node -v; npm -v

1.2 脚手架 用以新建项目; cnpm来替代npm 速度快点
    cnpm install -g vue-cli 
    npm install vue-cli -g

1.2.1 
     搭建新项目, 1些回车与yes
     vue init webpack vue01(项目名称)

1.2.2 
      cd 到project目录 初始化
      方式1：npm init   
      方式2：npm init -y  则无需手动确认
      用以生成 package.json
	  
     项目依赖  
     1. cd到项目目录 依照 vue01/package.json 进行install
     2. 部分npm资源被屏蔽 或者 国外资源， 
        可cnpm [npm的国内镜像]
     3. npm install 下载较慢
        所以 npm install --registry=http://registry.npm.taobao.org
1.2.3 
     构建测试环境
     npm run build:stage

1.2.4 
     构建生产环境
     npm run build:prod
	 
1.3 nodejs下载 > 选择LTS 为稳定版本 基本无bug
    https://nodejs.org/en/download/

1.4 全局安装cnpm 
    npm install -g cnpm --registry=https://registry.npm.taobao.org

1.4.1 设置 全局目录
      比如，npm config set prefix "D:\3.vue"
1.4.2 
      查看 全局目录
      npm root -g
1.4.3 
      查看 全局目录前缀
      npm config get prefix


1.4.4 安装vue模块 /**可项目重启下*/
      npm install vue@2.6.10

1.4.5 
     安装时 若 npm err! Erro: connect ECONNEFUSED 127.0.0.1:8087
     解决方法 执行如下命令
     npm config set proxy null

1.4.6 全局目录查看
      比如 C:\Program Files\nodejs\node_modules
      npm root -g

1.4.7 全局目录修改
      比如 修改到D:\npm
      npm config set prefix "D:\3.vue"

1.4.8 模块查看
      -- 全局中已安装模块
      npm list -g
      -- 当前项目已安装模块
      npm list
      -- 查看单个模块
      npm list <Module Name>
      -- 查看 指定模快<已安装>的 最新版本
      npm view <Module Name> version
      -- 查看 指定模块<已安装>的 所有版本
      npm view <Module Name> versions

# 卸载模块
## 局部即本地
## npm uninstall <Module Name> 
## 全部
## npm uninstall -g <Module Name> 

# 查看 当前 镜像地址
npm get registry
## 配置淘宝镜像地址 用以加速
npm config set registry https://registry.npm.taobao.org
## 安装下载模块
npm install <Module Name>
### 还原 默认镜像地址
npm config set registry https://registry.npmjs.org/

1.5 依赖的版本
    npm install <Module Name>版本号

1.5.1 ~3.3.x  固定 大版本号与次版本号的最新版本 
      npm install <Module Name>~版本号

1.5.2 ^3.x.x 固定 大版本号的最新版本
      npm install <Module Name>^版本号 

1.5.3 指定版本号进行安装
      npm install <module name>[@版本号] 

1.5.4 版本号定义：大版本.次版本.小版本
      大版本：项目改动非常大
      次版本：增加新功能与特性等
      小版本：bug修复,打补丁等

1.5.5 本地与全局
      本地安装 即安装到当前目录
      npm install <Module Name>[@版本号]
      全局安装 即安装到全局目录
      npm install <Module Name>[@版本号] -g


      
2.0 git 操作

2.1.0 克隆项目
    git clone https://github.com/niaobulashi/ruoyi 
	
2.1.1 代理操作
      git config --global http.proxy 'socks5://127.0.0.1:1080'
      git config --global https.proxy 'socks5://127.0.0.1:1080'

2.1.2 取消http代理
      git config --global --unset http.proxy
      git config --global --unset https.proxy

2.2 git下载
    https://git-scm.com/
    //  查看环境变量D:\window_D\Git\cmd
    ctrl + , 打开settings.json > 编辑 Git: Path 路径 > git.exe路径

2.3 git管理
    项目父级目录 > 右键 git bash here > 输入 git init
    // 添加到暂存区
    git add .
	// 提交到本地
    git commit -m "注释内容"
	//
    git log
	// 查看操作信息
    git status
    // 未 git add . 时  可以checkout 撤销未提交的修改
    git checkout src/com/jay/example/testforgit/MainActivity.java
    // 添加远程仓库地址
    // 通常定义为 origin; 可以写为其他名称
    git remote add origin git@github.com:nbhuangzl/vue-p1.git
    // 查看远程仓库是否添加
    git remote -v
    /* 首次push时 需要写全 
       语法 git push --set-upstream origin 分支1:分支2
       若 本地分支1与远程分支2同名 可仅写 1个分支名称
       比如 git push --set-upstream origin master:master */
    git push --set-upstream origin master
    // 经过首次push 指定仓库之后 后续git push 则是到第1次指定仓库
    git push
   

7. 安装git之后 命令行开启 可bash模式 


 

/**
 *  git上下载的项目 node_modules依赖包未附带 
 *  所以 npm 安装时 依据 package.json 进行依赖下载
 */

# 生产环境 与 开发环境的依赖安装
/**
 *  一些依赖包 仅 开发环境使用，
 * 生产环境用不到 则 进行 开发环境安装就好
 * 默认为 生产环境安装
 *
 * 生产环境方式：npm install <Module Name> [--save| -S]
 * 
 * 开发环境方式：npm install <Module Name> [--save-dev| -D]
 *
 * 比如 npm install eslint -D
 * 仅开发环境即可 检查空格之类
 *
 */

// 注意：开发与生产环境 為process.env.NODE_ENV 非process.env.MODE_ENV
Vue.config.productionTip = process.env.NODE_ENV === 'production';


环境变量

# vs插件安装
1. open in browser
    快捷键 
              alt+B 使用默认浏览器打开当前html页面 
              shift+alt+B 选择其他浏览器

2. vue 2 Snippets  ：快捷键提示
3. Vetur 高亮插件 -- 语法高亮, 智能感知，emmet等
4. Auto Rename Tag  -- 自动完成另1侧标签的同步修改
5. Path Intellisense  -- 自动路径补全
6. HTML CSS Support -- 让html标签上写class智能提示当前项目所支持的样式，安装之后有快捷键提示




# 8项目开发 (启动：npm run serve)

## 8.1 基于Vue-Cli3.x 创建项目

1. npm uninstall vue-cli -g
 
2. vue/cli 安装与卸载
   npm install -g @vue/cli
   
   npm uninstall -g @vue/cli
   
   npm install -g @vue/cli@3.0.4  

3. vue安装于 全局目录(命令：npm config get prefix)
   需配置环境变量
   
4. vue版本

   vue -V  或者 vue --version

5. vue项目创建 [在自定义目录下进行]
   vue create <Project Name> //文件名 不支持驼峰（含大写字母）
   Babel 兼容低版本浏览器 es6转es5
   Router 管理项目路由
   Vuex 管理共享的数据
   css Pre-processors css预处理器 后面的步骤中会要求选择具体的处理器
   linter / formatter

   router：方式1, history模式{url简洁，但是兼容性不好} 方式2，hash模式
   css 预处理器 选择 LESS
   eslint + standard config 
   选择 lint on save  且 lint and fix on commit
   
   对于lint等配置是独立文件中 还是 package.json中：我们选择独立文件即可 方便些
  


8. 在线图标 https://www.iconfont.cn/
   资源管理 > 我的项目 > 右上新建项目 
   参考视频 E:\BaiduNetdiskDownload\8-1 项目初始化\585 项目初始化-导入图标素材

9. app端引入vant网址：youzan.github.io/vant/#/zh-CN/button 

10. 设置rem基准值,且 px转为rem
    ###rem基准值
    -- npm i amfe-flexible
	-- main.js中 import 'amfe-flexible'
	###px转rem
	###npm i postcss-pxtorem@5.1.1 
	-- npm i postcss-pxtorem -D
	-- 创建文件.postcssrc.js
	   加入：
module.exports = {
    plugins: {
      // vuecli内部已经配置 
      // 'autoprefixer': {
      //   browsers: ['Android >= 4.0', 'iOS >= 8']
      // },
      'postcss-pxtorem': {
        // lib-flexible的rem适配方案：1行分10份,每份 10分之1
        // 所以 rootValue应该设置为设计稿宽度的10分之1
        // 而 vant 基于 37.5  自己的样式 则基于设计稿的像素 
        // 比如750： 750 / 10 = 75 
        // rootValue: 37.5,
        rootValue ({ file }) {
          return file.indexOf('vant') !== -1 ? 37.5 : 75
        },
        propList: ['*']
      }
    }
  }

11 初始化配置
   根目录下 增加vue.config.js
   自定义：
   module.exports = {
    devServer: {
        port: 8888,
        host:"localhost",
        https: false, // 协议
        open: true, // 启动服务时自动打开浏览器访问
    },
    lintOnSave: false, //关闭格式校验
    productionSourceMap: false,// 打包时不生成.map文件, 加速打包
}

12 封装请求模块

12.1 第3方库安装

     异步请求：npm i -S axios
     父子组件以及非父子组件的通信: npm i -S pubsub-js
     // https://element.eleme.cn/#/zh-CN
     // ElementUI插件( Element UI Snippet)安装 用以语法提示
     element-ui: npm i element-ui -S
   
12.2 封装Axios封装
     // npm i axios

     1. 数据模拟
        public目录下 新建 > db.json 
        [{"id":1,"name":"小萌"},
         {"id":2,"name":"小萌"},
	     {"id":3,"name":"小萌"}]
   
     2. 创建 src/utils/request.js:
	 
        import axios from 'axios'
        //  /db.json中  '/' -> 默认为 public目录 
        /* -- 默认方式
		   axios.get('/db.json').then(response => {
             const data = response.data
             console.log("axio調用"+data)
           }) */
        /*自定义 axios属性*/
        const request = axios.create({  
	      baseURL: '/',
	      timeout: 5000 //请求超时 5000毫秒
        })
        /* 请求拦截器 */
        request.interceptors.request.use(config => {
	        return config
        }, error => {
	        return Promise.reject(error);
        })
        /* 响应拦截器 */
        request.interceptors.response.use(response => {
	        return response
        }, error => {
	        return Promise.reject(error);
        })
        export default request // 导出自定义创建的axios对象
   
   src目录下 新建 > api > test.js:
   import request from '@/utils/request'
   // @表示src目錄
   /* 01. 固定方式 不动态 仅用以理解
     request.get('/db.json').then(response => {
      console.log(response.data)
   })*/
   // 02. 动态方式
   /* request({
     method:'get',
     url: '/db.json'
   }).then(response => {
     console.log(response.data)
   })*/
   // 03. 解耦 這裡用以調用接口
   export default {
     getList() {
        const req = request({
            method: 'get',
            url: '/db.json'
        })
        return req
    }
}
   
   // 其他页面引入 比如 HelloWorld.
<script>   
   import testApi from "@/api/test"
   export default {
   // 勾子函數
   created() {
     this.fetchData();
   },
   methods: {
     fetchData() {
       testApi.getList().then((response) => {
         console.log(response.data);
       });
     },
   },
   name: "HelloWorld",
   props: {
     msg: String,
   },
 };
</script>
 

13. 路由与布局
13.1 route.js
     import Vue from 'vue'
     import Router from 'vue-router'
     
     Vue.use(Router)
     // 路由表
     const  routes = [
         {
           path: '/login',
           name: 'login',
           /* component: () => import('@/views/login/index.vue')
              自动加载目录下的index.vue
            */
           component: () => import('@/views/login')
         }
       ]
     
     const router = new Router({
       routes
     })
     export default router
13.2 views/login/index.vue
     <template>
       <div class="login-container">登录页面</div>
     </template>
     
     <script>
     export default {
         name:'LoginIndex',
         components:{},
         props: {},
         data () {
             return {}
         },
         computed: {},
         watch: {},
         created () {
     
         },
         mounted () {
     
         },
         methods:{
     
         }
     
     }
     </script>

     <style scoped lang="less">

     </style>

13.3 布局

14 表单数据绑定验证
   谷歌-管理扩展程序 添加 Vue.js_devtools_5.1.0 
   vue项目运行之后 开发者工具 

15 Vuex容器+本地存储
// store/index.js
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)
const TOKEN_KEY = 'MY_USER'
// 设置state 与 mutations之后 进入views/login/index.js模块代码编写
export default new Vuex.Store({
  state: {
    // 存储当前登录用户信息(token等)
    user: JSON.parse(window.localStorage.getItem(TOKEN_KEY))
  },
  mutations: {
    setUser (state, data) {
      state.user = data
      // 防刷新丢失 数据备份本地
      window.localStorage.setItem(TOKEN_KEY, JSON.stringify(state.user))
    }
  },
  actions: {

  },
  modules: {

  }
})

// api/login/index.vue 
onsubmit方法中 加入 this.$store.commit('setUser', data.data)

16. 本地存储封装
/**
 * 存数据
 */
export const setItem = (key, value) => {
  // 数组或者对象类型的数据 转换为 JSON格式字符串
  if (typeof value === 'object') {
    value = JSON.stringify(value)
  }
  window.localStorage.setItem(key, value)
}
/**
 * 取数据1
 */
export const getItem = key => {
  const data = window.localStorage.getItem(key)
  try {
    return JSON.parse(data)
  } catch (err) {
    return data
  }
}
/**
 * 删除数据
 */
export const removeItem = key => {
  window.localStorage.removeItem(key)
}

17. token过期

refresh_token技术

18. 子路由模式
参考 views/layout/index 与 route.js

19. axios拦截器 utils/request.js
// github.com/axios/axios
import axios from 'axios'
import store from '@/store'

const request = axios.create({
  baseURL: 'http://localhost:8081',
  timeout: 5000 // 请求超时 5000毫秒
})

// Add a request interceptor
request.interceptors.request.use(config => {
  // config 请求配置对象
  const { user } = store.state
  if (user && user.token) {
    config.headers.Authorization = `Bearer ${user.token}`
  }
  console.log(config)
  return config
}, error => {
  return Promise.reject(error)
})
// Add a response interceptor
request.interceptors.response.use(response => {
  return response
}, error => {
  return Promise.reject(error)
})
export default request // 导出自定义创建的axios对象



9. 跨域演示

## 01.utils目录下 request.js
import axios from 'axios'

 /*自定义 axios属性*/
 const request = axios.create({  
    // 这里的/api 用以vue.config.js里代理配置对应的key值 跨域时
    baseURL: '/dev-api',
    timeout: 5000 //请求超时 5000毫秒
 })
 /* 请求拦截器 */
 /* request.interceptors.request.use(config => {
     return config
 }, error => {
     return Promise.reject(error);
 }) */
    /* 响应拦截器 */
 /*request.interceptors.response.use(response => {
     return response
 }, error => {
     return Promise.reject(error);
 }) */
 export default request // 导出自定义创建的axios对象
 
## 02. 自定义目录api下 定义的test.js  
### 接口调用的集合 解耦合 
import request from '@/utils/request'
// @表示src目錄
/* request.get('/db.json').then(response => {
    console.log(response.data)
}) */
/* request({
    method:'get',
    url: '/db.json'
}).then(response => {
    console.log(response.data)
}) */
// 解耦 這裡用以調用接口
export default {
    getList() {
        const req = request({
            method: 'get',
            url: '/db.json'
        })
        return req
    }
}

## 03. vue.config.js
### 配置环境代理
// const isPro = Object.is(process.env.NODE_ENV, 'production')
// const isPro = true
module.exports = {
    devServer: {
        port: 8888,
        host:"localhost",
        https: false, // 协议
        open: true, // 启动服务时自动打开浏览器访问
		/* 代理配置 */
        proxy: { 
            '/dev-api': {
                // 目標服務器地址， 代理訪問這個地址
                target: 'http://localhost:8001',
                changeOrigin: true, // 開啟代理服務器
                pathRewrite: {
                    /*
                      轉發時 /dev-api 被替換為空
                      進而發出為 http://localhost:8001/db.json
                     */
                    '^/dev-api': '',
                }

            }
        }
    },
    lintOnSave: false, //关闭格式校验
    productionSourceMap: false,// 打包时不生成.map文件, 加速打包
}

## 04. 页面使用
import testApi from "@/api/test";

export default {
  // 勾子函數
  created() {
    this.fetchData();
  },
  methods: {
    fetchData() {
      testApi.getList().then((response) => {
        console.log("8001",response.data);
      });
    },
  },
  name: "HelloWorld",
  props: {
    msg: String,
  },
};
</script>

10. 开发环境与生产环境配置
根目录下:
         .env.development
		 .env.production
		 
# 需以 VUE_APP_ 起始 使用时 process.env.XXXX
VUE_APP_SERVICE_URL = 'http://localhost:8001'
引入方式：
01：const BASE_URI = process.env.VUE_APP_BASE_API
02：[process.env.VUE_APP_BASE_API]

11. 路由配置
## 01. router目录下的index.js
import Vue from "vue";
import Router from "vue-router";
// import Login from "../views/login/index.vue";
// 简化方式 login目录下index.vue会被自动导入 其他命名则不会自动导入
import Login from "../views/login";
// 使用Vue的路由
Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/login',
      name: 'login',// 路由名称
      component: Login // 组件对象
    }
  ]
})
## 02. src目录下的App.vue
<template>
  <div id="app">
    <!-- 组件渲染出口 -->
    <router-view></router-view>
  </div>
</template>
## 03. src目录下的main.js
import Vue from "vue";
// 在Vue之下 引入ElementUI组件
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

import App from "./App.vue";
import router from "./router";

// 使用ElementUI
Vue.use(ElementUI);
// 生产与开发环境 动态配置
// Vue.config.productionTip = false;
// 注意：為process.env.NODE_ENV 非process.env.MODE_ENV
Vue.config.productionTip = process.env.NODE_ENV === 'production';
console.log(process.env.VUE_APP_SERVICE_URL)
new Vue({
  router,
  render: (h) => h(App),
}).$mount("#app");
## 04. public目录下的index.html
<!DOCTYPE html>
<html lang="">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="icon" href="<%= BASE_URL %>favicon.ico">
    <title>会员系统</title>
  </head>
  <body>
    <noscript>
      <strong>We're sorry but <%= htmlWebpackPlugin.options.title %> doesn't work properly without JavaScript enabled. Please enable it to continue.</strong>
    </noscript>
    // main.js找到App.vue App.vue里渲染的模板【依据url路由到的模板】 会替换public目录下index.html里 <div id="app"></div> -->
    <div id="app"></div>
    <!-- built files will be auto injected -->
  </body>
</html>

12. 接口模拟 easymock
https://mock.mengxuegu.com/project/60b0a2211d22662b1b574d12

13. 模板文件中 只能有1个根元素 不限于<div> 也可以是其他元素
## 01. 路由开启
    <!-- default-active：默认选中菜单 所对应的index -->
    <!-- :router=true 开启路由模式 开启之后 index对应值为请求路径 -->
    
14. 组件提取
引用方 components>appMain>index.vue

<template>
  <div class="main">
    <app-link v-show="$route.path !== '/home'"></app-link>
    <!-- 作为Layout的出口 -->
    <router-view></router-view>
  </div>
</template>

<script>
import AppLink from "./Link.vue";
export default {
  components: { AppLink },
};
</script>

代码提取：components>appMain>Link.vue
<template>
     <el-breadcrumb separator="/">
      <el-breadcrumb-item class="line" :to="{ path: $route.path }">
        {{ $route.meta.title }}
      </el-breadcrumb-item>
    </el-breadcrumb>
</template>

<style scoped>
.el-breadcrumb {
  height: 10px;
  padding: 20px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
.line {
  border-left: 3px solid #31c17b;
  padding-left:10px;
}
</style>
