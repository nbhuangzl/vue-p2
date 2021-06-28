<template>
  <div id="app">
    <router-view/>
    <h1>helloworld</h1>
    <van-button type="primary">主要按钮</van-button>
    <van-button type="info">信息按钮</van-button>
    <van-button type="default">默认按钮</van-button>
    <van-button type="warning">警告按钮</van-button>
    <van-button type="danger">危险按钮</van-button>
    <div class="box">test</div>
  </div>
</template>

<script>
export default {
  name: 'app'
}
</script>
<style lang="less">
.box {
  margin:20px 90px 10px 90px;
  padding: 10px;
  width: 550px;
  height: 64px;
  background-color: pink;
}
</style>
