
# 观察者模式——单播实现

```js
const source = Rx.Observable.interval(1000).take(3);

const subject = {
 observers: [],
 subscribe(target) {
  this.observers.push(target);
 },
 next: function(value) {
  this.observers.forEach((next) => next(value))
 }
}

source.subscribe(subject);

subject.subscribe((value) => console.log('A ' + value))

setTimeout(() => {
 subject.subscribe((value) => console.log('B ' + value))
}, 1000)

// 链接：https://juejin.cn/post/6910943445569765384
```
