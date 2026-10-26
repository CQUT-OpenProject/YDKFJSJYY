import { MdAppBar } from '../common/MdAppBar'
import { TaskRow } from '../components/TaskRow'
import { Task } from '../model/Task'

/**
 * 筹备清单：按状态分组展示全部任务。
 */
@Component
export struct TaskListPage {
  @Link tasks: Task[]
  onBack: () => void = () => {
  }
  onOpenTask: (task: Task) => void = () => {
  }
  onTasksChanged: () => void = () => {
  }

  private pendingTasks(): Task[] {
    return this.tasks.filter((task: Task) => !task.done)
  }

  private doneTasks(): Task[] {
    return this.tasks.filter((task: Task) => task.done)
  }

  private tasksFor(done: boolean): Task[] {
    return this.tasks.filter((task: Task) => task.done === done)
  }

  private progressPercent(): number {
    if (this.tasks.length === 0) {
      return 0
    }
    return Math.round(this.doneTasks().length * 100 / this.tasks.length)
  }

  @Builder
  TaskGroup(title: string, done: boolean) {
    Column({ space: 8 }) {
      Row() {
        Text(title)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.md_text_secondary'))
        Blank()
        Text(`${this.tasksFor(done).length} 项`)
          .fontSize(12)
          .fontColor($r('app.color.md_text_secondary'))
      }
      .width('100%')
      .padding({ left: 4, right: 4 })

      ForEach(this.tasksFor(done), (task: Task) => {
        TaskRow({
          task: task,
          onOpen: () => {
            this.onOpenTask(task)
          },
          onToggle: () => {
            this.onTasksChanged()
          }
        })
      }, (task: Task) => `${done ? 'done' : 'pending'}-${task.id}`)
    }
    .width('100%')
    .padding(12)
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

  build() {
    NavDestination() {
      Column() {
        MdAppBar({
          title: '筹备清单',
          subtitle: `${this.doneTasks().length} 项已完成 · ${this.pendingTasks().length} 项待处理`,
          showBack: true,
          onBack: () => {
            this.onBack()
          }
        })

        Scroll() {
          Column({ space: 16 }) {
            Column({ space: 14 }) {
              Row() {
                Column({ space: 2 }) {
                  Text(`${this.progressPercent()}%`)
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.md_primary'))
                  Text('整体进度')
                    .fontSize(12)
                    .fontColor($r('app.color.md_text_secondary'))
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column({ space: 8 }) {
                  Row({ space: 6 }) {
                    Text('')
                      .width(8)
                      .height(8)
                      .borderRadius(4)
                      .backgroundColor($r('app.color.md_secondary'))
                    Text(`已完成 ${this.doneTasks().length} 项`)
                      .fontSize(12)
                      .fontColor($r('app.color.md_text_primary'))
                  }
                  .alignItems(VerticalAlign.Center)

                  Row({ space: 6 }) {
                    Text('')
                      .width(8)
                      .height(8)
                      .borderRadius(4)
                      .backgroundColor($r('app.color.md_divider'))
                    Text(`待处理 ${this.pendingTasks().length} 项`)
                      .fontSize(12)
                      .fontColor($r('app.color.md_text_primary'))
                  }
                  .alignItems(VerticalAlign.Center)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')

              Progress({
                value: this.doneTasks().length,
                total: this.tasks.length,
                type: ProgressType.Linear
              })
                .width('100%')
                .height(6)
                .color($r('app.color.md_primary'))
                .backgroundColor($r('app.color.md_background'))
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

            if (this.pendingTasks().length > 0) {
              this.TaskGroup('待处理', false)
            }

            if (this.doneTasks().length > 0) {
              this.TaskGroup('已完成', true)
            }
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
