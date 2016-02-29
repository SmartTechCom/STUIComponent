# STUIComponent
Foundation project for quick develop

## Component catalogue（目录）

- LoopPage
- LineSpacingLabel
- test3


## Component Usage（用法）
```
Wiki填写模板
### 名称(v最新版本号) 
1. 作用
2. 用法
  - 
  - 
  - 
3. 使用代码举例
(4. 其他)
From:维护人
```

###LoopPage(v0.0.2)
1. 作用：轮播图控件
2. 用法：
  - 使用```init(frame: CGRect, timeInter: NSTimeInterval, countClosur: LoopPageCountClosure, pageClosure: LoopPageCurrentViewClosure, actionClosure: LoopPageTapActionClosure)```的便捷构造方法创造LoopPage对象
  - 通过闭包设置数据源和每个轮播图的点击事件
  - timeInterval设置为0时，不启用自动轮播
3. 使用代码举例：
```Swift
lazy var loopPage : LoopPage = {
        
        let page = LoopPage(frame: CGRect(x: 0,y: 0,width: 375,height: 100), timeInter: 0, countClosur: { () -> Int in
            return 5
            }, pageClosure: { (pageIndex) -> UIView in
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                label.text = "pageIndex：\(pageIndex)"
                label.textAlignment = NSTextAlignment.Center
                
                return label
            }, actionClosure: { (pageIndex) -> Void in
                print("\(pageIndex)")
        })
        return page
    }()
```
From：Azen.Xu

### LineSpacingLabel(v0.0.3) 
1. 作用：带行间距的Label
2. 用法
  - 直接在XIB上更改Label控件的类名为LineSpacingLabel即可
  - 通过"lineSpacing"属性设置行距，默认为5
3. 使用代码举例
```Swift
@IBOutlet weak var testLabel: LineSpacingLabel!
```
From:Azen.Xu
