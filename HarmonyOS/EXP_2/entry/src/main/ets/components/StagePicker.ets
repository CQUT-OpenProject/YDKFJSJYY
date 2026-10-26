/**
 * 活动阶段选择。
 */
@Component
export struct StagePicker {
  @Link stage: string
  private options: string[] = ['筹备中', '报名中', '进行中', '已结束']

  build() {
    Column({ space: 8 }) {
      ForEach(this.options, (label: string) => {
        Row({ space: 10 }) {
          Stack() {
            if (this.stage === label) {
              Text('✓')
                .fontSize(12)
                .fontColor($r('app.color.md_on_primary'))
            }
          }
          .width(20)
          .height(20)
          .alignContent(Alignment.Center)
          .borderRadius(10)
          .backgroundColor(this.stage === label ? $r('app.color.md_primary') : $r('app.color.md_surface'))
          .border({
            width: 1,
            color: this.stage === label ? $r('app.color.md_primary') : $r('app.color.md_divider')
          })

          Text(label)
            .fontSize(14)
            .fontWeight(this.stage === label ? FontWeight.Medium : FontWeight.Regular)
            .fontColor(this.stage === label ? $r('app.color.md_primary') : $r('app.color.md_text_primary'))
            .layoutWeight(1)

          if (this.stage === label) {
            Text('当前')
              .fontSize(11)
              .fontColor($r('app.color.md_primary'))
          }
        }
        .width('100%')
        .height(44)
        .padding({ left: 12, right: 12 })
        .borderRadius($r('app.float.md_card_radius'))
        .backgroundColor(this.stage === label ? $r('app.color.md_avatar_bg') : $r('app.color.md_background'))
        .onClick(() => {
          this.stage = label
        })
      }, (label: string) => label)
    }
    .width('100%')
  }
}
