import { MdAppBar } from '../common/MdAppBar'
import { TaskDetail } from '../components/TaskDetail'
import { Task } from '../model/Task'

/**
 * 任务详情：查看任务概要并编辑内容。
 */
@Component
export struct TaskDetailPage {
  @ObjectLink task: Task
  onBack: () => void = () => {
  }
  onTasksChanged: () => void = () => {
  }

  build() {
    NavDestination() {
      Column() {
        MdAppBar({
          title: '任务详情',
          subtitle: `负责人 · ${this.task.owner}`,
          showBack: true,
          onBack: () => {
            this.onBack()
          }
        })

        Scroll() {
          Column({ space: 16 }) {
            Column({ space: 10 }) {
              Row() {
                Text(this.task.done ? '已完成' : '待处理')
                  .fontSize(12)
                  .fontColor(this.task.done ? $r('app.color.md_secondary') : $r('app.color.md_primary'))
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .borderRadius(4)
                  .backgroundColor(this.task.done ? $r('app.color.md_success_soft') : $r('app.color.md_avatar_bg'))
                Blank()
                Text(`截止 ${this.task.due}`)
                  .fontSize(12)
                  .fontColor($r('app.color.md_text_secondary'))
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              Text(this.task.title.length > 0 ? this.task.title : '未命名任务')
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor($r('app.color.md_text_primary'))
                .lineHeight(30)
                .width('100%')

              Text(`负责人 · ${this.task.owner}`)
                .fontSize(13)
                .fontColor($r('app.color.md_text_secondary'))
                .width('100%')
            }
            .width('100%')
            .padding(16)
            .alignItems(HorizontalAlign.Start)
            .borderRadius($r('app.float.md_card_radius'))
            .backgroundColor($r('app.color.md_surface'))
            .shadow({
              radius: 8,
              color: 'rgba(0, 0, 0, 0.12)',
              offsetX: 0,
              offsetY: 2
            })

            Column({ space: 14 }) {
              Text('编辑内容')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor($r('app.color.md_text_primary'))
                .width('100%')

              TaskDetail({
                task: this.task,
                onTasksChanged: () => {
                  this.onTasksChanged()
                }
              })
            }
            .width('100%')
            .padding(16)
            .alignItems(HorizontalAlign.Start)
            .borderRadius($r('app.float.md_card_radius'))
            .backgroundColor($r('app.color.md_surface'))
            .shadow({
              radius: 8,
              color: 'rgba(0, 0, 0, 0.12)',
              offsetX: 0,
              offsetY: 2
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 24 })
        }
        .layoutWeight(1)
        .align(Alignment.Top)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.md_background'))
    }
    .hideTitleBar(true)
    .backgroundColor($r('app.color.md_background'))
  }
}
