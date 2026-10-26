import { Task } from '../model/Task'

/**
 * 任务内容编辑区。
 */
@Component
export struct TaskDetail {
  @ObjectLink task: Task
  onTasksChanged: () => void = () => {
  }

  build() {
    Column({ space: 16 }) {
      Column({ space: 8 }) {
        Text('任务名称')
          .fontSize(12)
          .fontColor($r('app.color.md_text_secondary'))
          .width('100%')
        TextInput({ text: this.task.title, placeholder: '输入任务名称' })
          .placeholderColor($r('app.color.md_text_secondary'))
          .placeholderFont({ size: 14 })
          .fontSize(15)
          .fontColor($r('app.color.md_text_primary'))
          .caretColor($r('app.color.md_primary'))
          .backgroundColor($r('app.color.md_background'))
          .borderRadius($r('app.float.md_card_radius'))
          .height(48)
          .width('100%')
          .padding({ left: 12, right: 12 })
          .maxLength(30)
          .onChange((value: string) => {
            this.task.title = value
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Column({ space: 8 }) {
        Text('补充说明')
          .fontSize(12)
          .fontColor($r('app.color.md_text_secondary'))
          .width('100%')
        TextArea({ text: this.task.note, placeholder: '联系人、注意事项或当前进度' })
          .placeholderColor($r('app.color.md_text_secondary'))
          .placeholderFont({ size: 13 })
          .fontSize(14)
          .fontColor($r('app.color.md_text_primary'))
          .caretColor($r('app.color.md_primary'))
          .backgroundColor($r('app.color.md_background'))
          .borderRadius($r('app.float.md_card_radius'))
          .height(110)
          .width('100%')
          .padding(10)
          .onChange((value: string) => {
            this.task.note = value
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Row({ space: 24 }) {
        Column({ space: 3 }) {
          Text('负责人')
            .fontSize(12)
            .fontColor($r('app.color.md_text_secondary'))
          Text(this.task.owner)
            .fontSize(14)
            .fontColor($r('app.color.md_text_primary'))
        }
        .alignItems(HorizontalAlign.Start)

        Column({ space: 3 }) {
          Text('截止时间')
            .fontSize(12)
            .fontColor($r('app.color.md_text_secondary'))
          Text(this.task.due)
            .fontSize(14)
            .fontColor($r('app.color.md_text_primary'))
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')

      Button(this.task.done ? '撤销完成' : '标记完成')
        .type(ButtonType.Normal)
        .width('100%')
        .height(46)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.task.done ? $r('app.color.md_text_primary') : $r('app.color.md_on_primary'))
        .borderRadius($r('app.float.md_button_radius'))
        .backgroundColor(this.task.done ? $r('app.color.md_avatar_bg') : $r('app.color.md_secondary'))
        .onClick(() => {
          this.task.done = !this.task.done
          this.onTasksChanged()
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
