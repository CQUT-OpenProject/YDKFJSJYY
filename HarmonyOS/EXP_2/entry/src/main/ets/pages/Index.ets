import { common } from '@kit.AbilityKit'
import { SystemBarUtil } from '../common/SystemBarUtil'
import { EventHeader } from '../components/EventHeader'
import { TaskRow } from '../components/TaskRow'
import { Task } from '../model/Task'
import { SettingsPage } from './SettingsPage'
import { SharePage } from './SharePage'
import { TaskDetailPage } from './TaskDetailPage'
import { TaskListPage } from './TaskListPage'

@Entry
@Component
struct Index {
  @State eventName: string = '秋日市集'
  @Provide('eventLead') eventLead: string = '李明'
  @State @Watch('onStageChange') stage: string = '筹备中'
  @State stageFocus: string = '确认场地与用电，完成摊位招募和主视觉。'
  @State stageLogs: string[] = [
    '10 月 22 日 · 王芳完成主视觉海报',
    '10 月 20 日 · 创建活动，进入筹备阶段'
  ]
  @State tasks: Task[] = []
  @State currentTask: Task = new Task('', '', '', '', '')
  @State shareTitle: string = '秋日市集 · 11 月 7 日，中心广场见'
  private pageStack: NavPathStack = new NavPathStack()

  aboutToAppear(): void {
    const venue = new Task('t1', '确认场地与用电', '赵强', '10 月 28 日',
      '场地平面图已拿到，待确认音响功率和备用电源。')
    const visual = new Task('t2', '主视觉海报与指引牌', '王芳', '10 月 30 日',
      '海报终稿已上传群文件，指引牌等确认尺寸后打样。', true)
    const booths = new Task('t3', '招募 12 个学生摊位', '李明', '11 月 1 日',
      '已确认 8 家，咖啡和手作类还各差 2 家。')
    const push = new Task('t4', '发布报名推送', '王芳', '11 月 2 日',
      '等报名页上线后发公众号和班级群。')
    const signs = new Task('t5', '采购桌牌与指示牌', '赵强', '11 月 5 日',
      '已比价三家，预算控制在 300 元内。', true)
    this.tasks = [venue, visual, booths, push, signs]
    this.currentTask = venue
  }

  onPageShow(): void {
    SystemBarUtil.apply(getContext(this) as common.UIAbilityContext, SystemBarUtil.PRIMARY_APP_BAR)
  }

  private pad2(n: number): string {
    return n < 10 ? `0${n}` : `${n}`
  }

  private formatTime(date: Date): string {
    return `${this.pad2(date.getHours())}:${this.pad2(date.getMinutes())}`
  }

  private stageFocusFor(stage: string): string {
    if (stage === '报名中') {
      return '转发报名卡，跟进摊位确认和物料到货。'
    }
    if (stage === '进行中') {
      return '现场签到、摊位引导和收尾清场。'
    }
    if (stage === '已结束') {
      return '整理照片与账目，向摊主发送感谢。'
    }
    return '确认场地与用电，完成摊位招募和主视觉。'
  }

  onStageChange(): void {
    this.stageFocus = this.stageFocusFor(this.stage)
    const line = `今天 ${this.formatTime(new Date())} · 阶段调整为「${this.stage}」`
    const next: string[] = [line]
    this.stageLogs.forEach((item: string) => {
      next.push(item)
    })
    this.stageLogs = next
  }

  private eventLabel(): string {
    return this.eventName.length > 0 ? this.eventName : '未命名活动'
  }

  private pendingTasks(): Task[] {
    return this.tasks.filter((task: Task) => !task.done)
  }

  private completedCount(): number {
    return this.tasks.filter((task: Task) => task.done).length
  }

  private progressPercent(): number {
    if (this.tasks.length === 0) {
      return 0
    }
    return Math.round(this.completedCount() * 100 / this.tasks.length)
  }

  private latestLog(): string {
    return this.stageLogs.length > 0 ? this.stageLogs[0] : '暂无动态'
  }

  private manageSubtitle(pageName: string): string {
    if (pageName === 'tasks') {
      return `${this.pendingTasks().length} 项待处理 · ${this.completedCount()} 项已完成`
    }
    if (pageName === 'share') {
      return '分享卡预览与标题草稿'
    }
    return '名称、负责人与阶段'
  }

  private notifyTasksChanged(): void {
    this.tasks = this.tasks.slice()
  }

  private openTask(task: Task): void {
    this.currentTask = task
    this.pageStack.pushPath({ name: 'taskDetail' })
  }

  private openPage(name: string): void {
    this.pageStack.pushPath({ name: name })
  }

  @Builder
  PageMap(name: string) {
    if (name === 'settings') {
      SettingsPage({
        eventName: this.eventName,
        stage: this.stage,
        onBack: () => {
          this.pageStack.pop()
        }
      })
    } else if (name === 'tasks') {
      TaskListPage({
        tasks: this.tasks,
        onBack: () => {
          this.pageStack.pop()
        },
        onOpenTask: (task: Task) => {
          this.openTask(task)
        },
        onTasksChanged: () => {
          this.notifyTasksChanged()
        }
      })
    } else if (name === 'taskDetail') {
      TaskDetailPage({
        task: this.currentTask,
        onBack: () => {
          this.pageStack.pop()
        },
        onTasksChanged: () => {
          this.notifyTasksChanged()
        }
      })
    } else if (name === 'share') {
      SharePage({
        headline: this.shareTitle,
        onBack: () => {
          this.pageStack.pop()
        }
      })
    }
  }

  build() {
    Navigation(this.pageStack) {
      Column() {
        EventHeader({ eventName: this.eventName })

        Scroll() {
          Column({ space: 16 }) {
            this.HeroCard()
            this.FocusCard()
            this.NextTaskSection()
            this.ManageSection()
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
    .mode(NavigationMode.Stack)
    .navDestination(this.PageMap)
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.md_background'))
  }

  @Builder
  HeroCard() {
    Column({ space: 14 }) {
      Row() {
        Text('活动倒计时')
          .fontSize(12)
          .fontColor('rgba(255, 255, 255, 0.72)')
        Blank()
        Text(this.stage)
          .fontSize(12)
          .fontColor($r('app.color.md_on_primary'))
          .padding({ left: 9, right: 9, top: 4, bottom: 4 })
          .borderRadius(11)
          .backgroundColor('rgba(255, 255, 255, 0.18)')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row({ space: 8 }) {
        Text('14')
          .fontSize(46)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.md_on_primary'))
          .lineHeight(50)
        Column({ space: 2 }) {
          Text('天后开市')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('app.color.md_on_primary'))
          Text(`距离「${this.eventLabel()}」`)
            .fontSize(12)
            .fontColor('rgba(255, 255, 255, 0.72)')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .padding({ bottom: 6 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Bottom)

      Column({ space: 5 }) {
        Text('11 月 7 日（周六）14:00–18:00')
          .fontSize(13)
          .fontColor($r('app.color.md_on_primary'))
          .width('100%')
        Text(`中心广场 · 本周负责人 ${this.eventLead}`)
          .fontSize(12)
          .fontColor('rgba(255, 255, 255, 0.72)')
          .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Divider()
        .color('rgba(255, 255, 255, 0.18)')

      Column({ space: 7 }) {
        Row() {
          Text('筹备进度')
            .fontSize(11)
            .fontColor('rgba(255, 255, 255, 0.72)')
          Blank()
          Text(`${this.completedCount()} / ${this.tasks.length} · ${this.progressPercent()}%`)
            .fontSize(11)
            .fontColor($r('app.color.md_on_primary'))
        }
        .width('100%')

        Progress({
          value: this.completedCount(),
          total: this.tasks.length,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(4)
          .color($r('app.color.md_on_primary'))
          .backgroundColor('rgba(255, 255, 255, 0.24)')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(18)
    .alignItems(HorizontalAlign.Start)
    .borderRadius($r('app.float.md_card_radius'))
    .backgroundColor($r('app.color.md_primary_dark'))
    .shadow({
      radius: 10,
      color: 'rgba(21, 101, 192, 0.26)',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  FocusCard() {
    Column({ space: 12 }) {
      Row() {
        Row({ space: 8 }) {
          Text('')
            .width(3)
            .height(16)
            .borderRadius(2)
            .backgroundColor($r('app.color.md_primary'))
          Text('本周重点')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('app.color.md_text_primary'))
        }
        .alignItems(VerticalAlign.Center)

        Blank()

        Row({ space: 2 }) {
          Text('调整阶段')
            .fontSize(12)
            .fontColor($r('app.color.md_primary'))
          Text('›')
            .fontSize(15)
            .fontColor($r('app.color.md_primary'))
        }
        .padding({ left: 8, right: 4, top: 4, bottom: 4 })
        .onClick(() => {
          this.openPage('settings')
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.stageFocus)
        .fontSize(15)
        .fontColor($r('app.color.md_text_primary'))
        .lineHeight(23)
        .width('100%')

      Divider()
        .color($r('app.color.md_divider'))

      Column({ space: 3 }) {
        Text('最近动态')
          .fontSize(11)
          .fontColor($r('app.color.md_text_secondary'))
          .width('100%')
        Text(this.latestLog())
          .fontSize(13)
          .fontColor($r('app.color.md_text_primary'))
          .lineHeight(19)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
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

  @Builder
  NextTaskSection() {
    Column({ space: 10 }) {
      Row() {
        Text('接下来')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.md_text_primary'))
        Blank()
        Text(`${this.pendingTasks().length} 项待处理`)
          .fontSize(12)
          .fontColor($r('app.color.md_text_secondary'))
        Row({ space: 2 }) {
          Text('全部')
            .fontSize(12)
            .fontColor($r('app.color.md_primary'))
          Text('›')
            .fontSize(15)
            .fontColor($r('app.color.md_primary'))
        }
        .margin({ left: 12 })
        .padding({ top: 4, bottom: 4 })
        .onClick(() => {
          this.openPage('tasks')
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      if (this.pendingTasks().length === 0) {
        Text('筹备任务已全部完成。')
          .fontSize(13)
          .fontColor($r('app.color.md_text_secondary'))
          .width('100%')
          .padding({ top: 6, bottom: 6 })
      } else {
        ForEach(this.pendingTasks().slice(0, 2), (task: Task) => {
          TaskRow({
            task: task,
            onOpen: () => {
              this.openTask(task)
            },
            onToggle: () => {
              this.notifyTasksChanged()
            }
          })
        }, (task: Task) => task.id)
      }
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

  @Builder
  ManageRow(title: string, pageName: string) {
    Row({ space: 12 }) {
      Column({ space: 3 }) {
        Text(title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.md_text_primary'))
          .width('100%')
        Text(this.manageSubtitle(pageName))
          .fontSize(12)
          .fontColor($r('app.color.md_text_secondary'))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text('›')
        .fontSize(20)
        .fontColor($r('app.color.md_text_secondary'))
    }
    .width('100%')
    .padding({ left: 16, right: 12, top: 13, bottom: 13 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.openPage(pageName)
    })
  }

  @Builder
  ManageSection() {
    Column({ space: 10 }) {
      Text('活动管理')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.md_text_primary'))
        .width('100%')

      Column() {
        this.ManageRow('筹备清单', 'tasks')
        Divider()
          .color($r('app.color.md_divider'))
        this.ManageRow('邀请与分享', 'share')
        Divider()
          .color($r('app.color.md_divider'))
        this.ManageRow('活动设置', 'settings')
      }
      .width('100%')
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
    .alignItems(HorizontalAlign.Start)
  }
}
