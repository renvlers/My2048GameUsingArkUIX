import Game from "../Game"
import GameMode from '../GameMode';
import MyNavigation from '../MyNavigation';
import Time from '../Time';


@Entry
@Component
struct GamePage {
  @State game: Game = new Game(GameMode.value);
  @State time: Time = this.game.time

  build() {
    Column() {
      MyNavigation({ title: "我的2048", showBack: true })

      Column() {
        Column()
          .height(16)

        Row() {
          Column() {
            Text("目标方块")
              .textAlign(TextAlign.Center)
              .width("100%")
              .fontColor(Color.Black)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
            Column() {
              if (this.game.getDisplayMsg(2048) === "PRC") {
                Image($rawfile("PRC.png"))
                  .width(75)
                  .height(75)
                  .borderRadius(8)
              } else {
                Text(this.game.getDisplayMsg(2048))
                  .fontSize(26)
                  .fontColor(Color.White)
                  .fontWeight(FontWeight.Bold)
                  .width(75)
                  .height(75)
                  .backgroundColor(this.game.getColor(2048))
                  .borderRadius(8)
                  .textAlign(TextAlign.Center)
              }
            }
            .width("100%")
            .layoutWeight(1)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .width(156)
          .height(156)
          .backgroundColor("#fff1dab0")
          .padding(12)
          .borderRadius(12)

          Column()
            .width(6)

          Column() {
            Text("已用时间")
              .textAlign(TextAlign.Center)
              .width("100%")
              .fontColor(Color.Black)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)

            Text(this.time.getString())
              .textAlign(TextAlign.Center)
              .width("100%")
              .layoutWeight(1)
              .fontColor(Color.Black)
              .fontSize(26)
          }
          .width(156)
          .height(156)
          .backgroundColor("#fff1dab0")
          .padding(12)
          .borderRadius(12)
        }
        .width(330)
        .height(165)
        .backgroundColor(Color.White)
        .margin({
          bottom: 32
        })
        .borderRadius(16)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Stack() {
          Grid(null, { regularSize: [4, 4] }) {
            ForEach(this.game.board, (item: number) => {
              GridItem() {
                if (this.game.getDisplayMsg(item) === "PRC") {
                  Image($rawfile("PRC.png"))
                    .width("100%")
                    .height("100%")
                    .borderRadius(8)
                } else if (this.game.getDisplayMsg(item) === "ROC") {
                  Image($rawfile("ROC.png"))
                    .width("100%")
                    .height("100%")
                    .borderRadius(8)
                } else {
                  Text(this.game.getDisplayMsg(item))
                    .fontColor(Color.White)
                    .fontSize(26)
                    .fontWeight(FontWeight.Bold)
                    .textAlign(TextAlign.Center)
                    .width("100%")
                    .height("100%")
                    .textAlign(TextAlign.Center)
                }
              }
              .width(75)
              .height(75)
              .backgroundColor(this.game.getColor(item))
              .borderRadius(8)
              .gesture(PanGesture({
                direction: PanDirection.Horizontal,
                fingers: 1,
                distance: 37
              }).onActionStart((event) => {
                if (event.offsetX >= 0) {
                  this.game.slideRight();
                } else {
                  this.game.slideLeft();
                }
              }))
              .gesture(PanGesture({
                direction: PanDirection.Vertical,
                fingers: 1,
                distance: 37
              }).onActionStart((event) => {
                if (event.offsetY >= 0) {
                  this.game.slideDown();
                } else {
                  this.game.slideUp();
                }
              }))
            })
          }
          .padding(6)
          .columnsGap(6)
          .rowsGap(6)
          .backgroundColor(Color.White)
          .width(330)
          .height(330)
          .borderRadius(10)
          .gesture(PanGesture({
            direction: PanDirection.Horizontal,
            fingers: 1,
            distance: 37
          }).onActionStart((event) => {
            if (event.offsetX >= 0) {
              this.game.slideRight();
            } else {
              this.game.slideLeft();
            }
          }))
          .gesture(PanGesture({
            direction: PanDirection.Vertical,
            fingers: 1,
            distance: 37
          }).onActionStart((event) => {
            if (event.offsetY >= 0) {
              this.game.slideDown();
            } else {
              this.game.slideUp();
            }
          }))

          if (this.game.isEnd) {
            Column() {
              Text(this.game.getOverTitle())
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
                .fontSize(24)
                .margin({
                  bottom: 16
                })

              Text(this.game.getOverMsg())
                .fontColor(Color.Black)
                .fontSize(16)
                .margin({
                  bottom: 16
                })

              Button("重新开始")
                .backgroundColor("#ee7733")
                .fontColor(Color.White)
                .onClick(() => {
                  this.game.initialize();
                })
            }
            .width(330)
            .height(330)
            .backgroundColor("#66FFFFFF")
            .borderRadius(16)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
        }
      }
      .width("100%")
      .height("100%")
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)

    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor("#ececec")
  }
}