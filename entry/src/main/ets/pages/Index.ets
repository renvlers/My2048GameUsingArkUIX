import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Column() {
      Column() {
        Text("2048")
          .fontSize(80)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width(256)
      .height(256)
      .margin({
        top: 80,
        bottom: 80
      })
      .backgroundColor("#edc22e")
      .borderRadius(32)
      Scroll() {
        Column() {
          Row() {
            Column() {
              Image($rawfile("play.svg"))
                .width(64)
                .height(64)
                .padding(12)
              Row()
                .layoutWeight(1)
              Text("开始游戏")
                .fontSize(24)
                .padding(16)
                .fontColor(Color.Black)
            }
            .backgroundColor("#99ccff")
            .height("100%")
            .alignItems(HorizontalAlign.Start)
            .borderRadius(16)
            .layoutWeight(1)
            .onClick(() => {
              router.pushUrl({
                url: "pages/GamePage"
              })
            })
          }
          .width("100%")
          .layoutWeight(1)
          Row()
            .height(16)
            .width("100%")
          Row() {
            Column() {
              Image($rawfile("rule.svg"))
                .width(64)
                .height(64)
                .padding(12)
              Row()
                .layoutWeight(1)
              Text("游戏规则")
                .fontSize(24)
                .padding(16)
                .fontColor(Color.Black)
            }
            .backgroundColor("#99ffcc")
            .height("100%")
            .alignItems(HorizontalAlign.Start)
            .borderRadius(16)
            .layoutWeight(1)
            .onClick(() => {
              promptAction.showDialog({
                title: "2048速通版游戏规则",
                message: "玩家在4x4的网格上滑动方块，每次滑动时所有方块向滑动方向移动，相同数字的方块在碰撞时合并成它们数值之和的新方块，目标是在尽可能短的时间内创建一个数值为2048的方块，游戏在获得2048或没有空间生成新方块时结束。",
                buttons: [
                  {
                    text: "确定",
                    color: "#0000ff"
                  }
                ]
              });
            })

            Column()
              .width(16)
              .height("100%")
            Column() {
              Image($rawfile("settings.svg"))
                .width(64)
                .height(64)
                .padding(12)
              Row()
                .layoutWeight(1)
              Text("游戏设置")
                .fontSize(24)
                .padding(16)
                .fontColor(Color.Black)
            }
            .backgroundColor("#ff99cc")
            .height("100%")
            .alignItems(HorizontalAlign.Start)
            .borderRadius(16)
            .layoutWeight(1)
            .onClick(() => {
              router.pushUrl({
                url: "pages/Settings"
              })
            })
          }
          .width("100%")
          .layoutWeight(1)
        }
        .width("100%")
        .height("100%")
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Center)
      }
      .width("100%")
      .height("auto")
      .layoutWeight(1)
      .margin({ bottom: 80 })
      .padding({left: 16, right: 16})
    }
    .width('100%')
    .height("100%")
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .margin(0)
    .padding(0)
    .backgroundColor("#ececec")
  }
}