import router from '@ohos.router'

@Component
export default struct MyNavigation {
  @Prop title: string
  @Prop showBack: boolean

  build() {
    Row() {
      Button({ type: ButtonType.Normal }) {
        Image($rawfile("back.svg"))
          .width("50%")
          .height("50%")
      }
      .width(44)
      .height(44)
      .backgroundColor(Color.Transparent)
      .fontColor(Color.Black)
      .fontWeight(FontWeight.Bold)
      .borderRadius(8)
      .onClick(() => {
        router.back()
      })

      Text(this.title)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Column()
        .width(44)
        .height(44)
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .width("100%")
    .height(44)
    .backgroundColor("#ececec")
  }
}