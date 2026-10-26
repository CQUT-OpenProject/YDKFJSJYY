import { Task } from '../model/Task'

/**
 * 筹备任务行。
 */
@Component
export struct TaskRow {
  @ObjectLink task: Task
  onOpen: () => void = () => {
  }
  onToggle: () => void = () => {
  }

  build() {
    Row({ space: 10 }) {
      Stack() {
        if (this.task.done) {
          Text('✓')
            .fontSize(13)
            .fontColor($r('app.color.md_on_primary'))
        }
      }
      .width(22)
      .height(22)
      .alignContent(Alignment.Center)
      .borderRadius(11)
      .backgroundColor(this.task.done ? $r('app.color.md_secondary') : $r('app.color.md_surface'))
      .border({
        width: 1,
        color: this.task.done ? $r('app.color.md_secondary') : $r('app.color.md_divider')
      })
      .onClick(() => {
        this.task.done = !this.task.done
        this.onToggle()
      })

      Column({ space: 3 }) {
        Text(this.task.title.length > 0 ? this.task.title : '未命名任务')
          .fontSize(15)
          .fontWeight(this.task.done ? FontWeight.Regular : FontWeight.Medium)
          .fontColor(this.task.done ? $r('app.color.md_text_secondary') : $r('app.color.md_text_primary'))
          .decoration({
            type: this.task.done ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: $r('app.color.md_text_secondary')
          })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
        Text(`${this.task.owner} · ${this.task.due}`)
          .fontSize(12)
          .fontColor($r('app.color.md_text_secondary'))
          .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .onClick(() => {
        this.onOpen()
      })

      Text(this.task.done ? '已完成' : '待处理')
        .fontSize(11)
        .fontColor(this.task.done ? $r('app.color.md_secondary') : $r('app.color.md_text_secondary'))
        .padding({ left: 8, right: 8, top: 3, bottom: 3 })
        .borderRadius(3)
        .backgroundColor(this.task.done ? $r('app.color.md_success_soft') : $r('app.color.md_surface'))

      Text('›')
        .fontSize(20)
        .fontColor($r('app.color.md_text_secondary'))
        .margin({ left: 2 })
        .padding({ left: 2, right: 2 })
        .onClick(() => {
          this.onOpen()
        })
    }
    .width('100%')
    .padding({ left: 12, right: 10, top: 11, bottom: 11 })
    .alignItems(VerticalAlign.Center)
    .borderRadius($r('app.float.md_card_radius'))
    .backgroundColor($r('app.color.md_background'))
  }
}
