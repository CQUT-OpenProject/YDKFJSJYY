/**
 * 分享卡标题编辑与预览。
 */
@Component
export struct ShareCard {
  @Prop draft: string = ''
  @Prop headline: string = ''
  @Consume('eventLead') eventLead: string
  onApply: (value: string) => void = () => {
  }

  build() {
    Column({ space: 12 }) {
      Column({ space: 8 }) {
        Text('邀请你参加')
          .fontSize(11)
          .fontColor('rgba(255, 255, 255, 0.7)')
          .width('100%')
        Text(this.headline.length > 0 ? this.headline : '秋日市集')
          .fontSize(21)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.md_on_primary'))
          .lineHeight(29)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
        Text('11 月 7 日（周六）14:00–18:00')
          .fontSize(12)
          .fontColor('rgba(255, 255, 255, 0.82)')
          .width('100%')
        Text(`中心广场 · 发布人 ${this.eventLead}`)
          .fontSize(12)
          .fontColor('rgba(255, 255, 255, 0.82)')
          .width('100%')
      }
      .width('100%')
      .padding(18)
      .alignItems(HorizontalAlign.Start)
      .borderRadius($r('app.float.md_card_radius'))
      .backgroundColor($r('app.color.md_primary'))

      Column({ space: 8 }) {
        Text('分享标题')
          .fontSize(12)
          .fontColor($r('app.color.md_text_secondary'))
          .width('100%')
        TextInput({ text: this.draft, placeholder: '输入分享标题' })
          .placeholderColor($r('app.color.md_text_secondary'))
          .placeholderFont({ size: 14 })
          .fontSize(14)
          .fontColor($r('app.color.md_text_primary'))
          .caretColor($r('app.color.md_primary'))
          .backgroundColor($r('app.color.md_background'))
          .borderRadius($r('app.float.md_card_radius'))
          .height(48)
          .width('100%')
          .padding({ left: 12, right: 12 })
          .maxLength(32)
          .onChange((value: string) => {
            this.draft = value
          })
        Text('点击更新后，预览会使用新的标题。')
          .fontSize(11)
          .fontColor($r('app.color.md_text_secondary'))
          .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Button('更新分享卡')
        .type(ButtonType.Normal)
        .width('100%')
        .height(44)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.md_on_primary'))
        .borderRadius($r('app.float.md_button_radius'))
        .backgroundColor($r('app.color.md_primary'))
        .onClick(() => {
          this.onApply(this.draft)
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
