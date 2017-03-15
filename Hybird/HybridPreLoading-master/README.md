# HybridPreLoading
iOS webview Hybrid开发预加载

虽然NSURLCache可以实现80%的缓存功能，但是这也需要首次登录加载数据后下次访问才能访问缓存，对于现在许多加载第三方和图片资源的webapp访问速度还是很大的考验，很多第三方和图片资源都是以后长期不会改变的，那有没有办法可以将这些资源预先打包在APP中，通过拦截网络请求，将读取本地存在的资源，没有的再读取服务器上的，从而增快加载速度

使用方法很简单

    
```
#import "HybridPreLoading.h"

//需要的地方加这段代码注册
[NSURLProtocol registerClass:[HybridPreLoading class]];

//取消注册
[NSURLProtocol unregisterClass:[HybridPreLoading class]];
```

![demo](https://github.com/linushao/HybridPreLoading/blob/master/demo.png)

新建www文件夹，里面再新建css、img、js文件夹，将需要预先加载的文件分别放在对应的文件夹即可，简单快捷方便吧~~

