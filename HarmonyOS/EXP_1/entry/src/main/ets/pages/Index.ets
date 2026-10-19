import { common } from '@kit.AbilityKit'
import { router } from '@kit.ArkUI'
import { MdAppBar } from '../common/MdAppBar'
import { SystemBarUtil } from '../common/SystemBarUtil'
import { Student } from '../model/Student'

@Entry
@Component
struct Index {
  @State student: Student = new Student()
  @State onCampus: boolean = true
  @State statusHint: string = '允许通行'

  onPageShow(): void {
    SystemBarUtil.apply(getContext(this) as common.UIAbilityContext, SystemBarUtil.PRIMARY_APP_BAR)
  }

  private toggleCampusStatus(): void {
    this.onCampus = !this.onCampus
    this.statusHint = this.onCampus ? '允许通行' : '已离校，禁止通行'
  }

  @Builder
  StudentCard() {
    Row({ space: 16 }) {
      Column() {
        Text(this.student.getAvatarLabel())
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.md_primary'))
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .borderRadius(24)
      .backgroundColor($r('app.color.md_avatar_bg'))

      Column({ space: 4 }) {
        Text(this.student.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.md_text_primary'))
        Text(this.student.studentId)
          .fontSize(14)
          .fontColor($r('app.color.md_text_secondary'))
        Text(`${this.student.major} · ${this.student.clazz}`)
          .fontSize(12)
          .fontColor($r('app.color.md_text_secondary'))
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
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
    Column() {
      MdAppBar({
        title: '我的校园卡',
        subtitle: '通行与学籍'
      })

      Column({ space: 16 }) {
        this.StudentCard()

        Column({ space: 8 }) {
          Row() {
            Text(this.onCampus ? '在校' : '离校')
              .fontSize(12)
              .fontColor(this.onCampus ? $r('app.color.md_secondary') : $r('app.color.md_text_secondary'))
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(4)
              .backgroundColor(this.onCampus ? $r('app.color.md_success_soft') : '#EEEEEE')
            Blank()
          }
          .width('100%')

          Text('通行状态')
            .fontSize(12)
            .fontColor($r('app.color.md_text_secondary'))
            .width('100%')
          Text(this.statusHint)
            .fontSize(16)
            .fontColor(this.onCampus ? $r('app.color.md_text_primary') : $r('app.color.md_primary_dark'))
            .lineHeight(24)
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

        Button(this.onCampus ? '登记离校' : '恢复在校')
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius($r('app.float.md_button_radius'))
          .backgroundColor($r('app.color.md_secondary'))
          .onClick(() => {
            this.toggleCampusStatus()
          })

        Button('查看学籍详情')
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius($r('app.float.md_button_radius'))
          .backgroundColor($r('app.color.md_primary'))
          .onClick(() => {
            router.pushUrl({ url: 'pages/NextPage' })
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.md_background'))
  }
}
