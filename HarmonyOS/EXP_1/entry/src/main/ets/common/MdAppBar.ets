/**
 * MD2 风格顶栏（Primary Toolbar）
 */
@Component
export struct MdAppBar {
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop showBack: boolean = false
  onBack: () => void = () => {
  }

  build() {
    Column() {
      Row() {
        if (this.showBack) {
          Text('←')
            .fontSize(22)
            .fontColor($r('app.color.md_on_primary'))
            .width(48)
            .height($r('app.float.md_app_bar_height'))
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.onBack()
            })
        }

        Column({ space: 2 }) {
          if (this.subtitle.length > 0) {
            Text(this.subtitle)
              .fontSize(12)
              .fontColor('rgba(255, 255, 255, 0.7)')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          Text(this.title)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('app.color.md_on_primary'))
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .padding({ left: this.showBack ? 0 : 16, right: 16 })
      }
      .width('100%')
      .height($r('app.float.md_app_bar_height'))
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor($r('app.color.md_primary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
  }
}
