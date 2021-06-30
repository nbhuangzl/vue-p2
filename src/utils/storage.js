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
