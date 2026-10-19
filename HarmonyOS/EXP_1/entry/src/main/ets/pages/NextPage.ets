import { common } from '@kit.AbilityKit'
import { router } from '@kit.ArkUI'
import { MdAppBar } from '../common/MdAppBar'
import { SystemBarUtil } from '../common/SystemBarUtil'
import { Student } from '../model/Student'

@Entry
@Component
struct NextPage {
  @State student: Student = new Student()

  onPageShow(): void {
    SystemBarUtil.apply(getContext(this) as common.UIAbilityContext, SystemBarUtil.PRIMARY_APP_BAR)
  }

  @Builder
  InfoRow(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(14)
        .fontColor($r('app.color.md_text_secondary'))
        .width('28%')
      Text(value)
        .fontSize(14)
        .fontColor($r('app.color.md_text_primary'))
        .layoutWeight(1)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
  }

  build() {
    Column() {
      MdAppBar({
        title: '学籍详情',
        showBack: true,
        onBack: () => {
          router.back()
        }
      })

      Column({ space: 16 }) {
        Column() {
          this.InfoRow('姓名', this.student.name)
          Divider().color($r('app.color.md_divider'))
          this.InfoRow('学号', this.student.studentId)
          Divider().color($r('app.color.md_divider'))
          this.InfoRow('专业', this.student.major)
          Divider().color($r('app.color.md_divider'))
          this.InfoRow('班级', this.student.clazz)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .borderRadius($r('app.float.md_card_radius'))
        .backgroundColor($r('app.color.md_surface'))
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.12)',
          offsetX: 0,
          offsetY: 2
        })

        Button('返回校园卡')
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius($r('app.float.md_button_radius'))
          .backgroundColor($r('app.color.md_primary'))
          .onClick(() => {
            router.back()
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.md_background'))
  }
}
