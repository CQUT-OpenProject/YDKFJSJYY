/**
 * 本周负责人选择。
 */
@Component
export struct LeadPicker {
  @Consume('eventLead') eventLead: string
  private members: string[] = ['李明', '王芳', '赵强']

  build() {
    Column({ space: 8 }) {
      Text('本周负责人')
        .fontSize(12)
        .fontColor($r('app.color.md_text_secondary'))
        .width('100%')
      Row({ space: 8 }) {
        ForEach(this.members, (name: string) => {
          Button(name)
            .type(ButtonType.Normal)
            .layoutWeight(1)
            .height(38)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.eventLead === name ? $r('app.color.md_on_primary') : $r('app.color.md_text_primary'))
            .borderRadius($r('app.float.md_button_radius'))
            .backgroundColor(this.eventLead === name ? $r('app.color.md_primary') : $r('app.color.md_background'))
            .onClick(() => {
              this.eventLead = name
            })
        }, (name: string) => name)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
