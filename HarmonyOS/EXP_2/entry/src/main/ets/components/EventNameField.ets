/**
 * 活动名称输入。
 */
@Component
export struct EventNameField {
  @Link eventName: string

  build() {
    Column({ space: 8 }) {
      Text('活动名称')
        .fontSize(12)
        .fontColor($r('app.color.md_text_secondary'))
        .width('100%')
      TextInput({ text: this.eventName, placeholder: '输入活动名称' })
        .placeholderColor($r('app.color.md_text_secondary'))
        .placeholderFont({ size: 14 })
        .fontSize(16)
        .fontColor($r('app.color.md_text_primary'))
        .caretColor($r('app.color.md_primary'))
        .backgroundColor($r('app.color.md_background'))
        .borderRadius($r('app.float.md_card_radius'))
        .height(48)
        .width('100%')
        .padding({ left: 12, right: 12 })
        .maxLength(24)
        .onChange((value: string) => {
          this.eventName = value
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
