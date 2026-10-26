import { MdAppBar } from '../common/MdAppBar'
import { EventNameField } from '../components/EventNameField'
import { LeadPicker } from '../components/LeadPicker'
import { StagePicker } from '../components/StagePicker'

/**
 * 活动设置：名称、负责人、阶段与固定信息。
 */
@Component
export struct SettingsPage {
  @Link eventName: string
  @Link stage: string
  onBack: () => void = () => {
  }

  @Builder
  InfoRow(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(13)
        .fontColor($r('app.color.md_text_secondary'))
        .width(56)
      Text(value)
        .fontSize(13)
        .fontColor($r('app.color.md_text_primary'))
        .layoutWeight(1)
    }
    .width('100%')
    .padding({ top: 6, bottom: 6 })
    .alignItems(VerticalAlign.Top)
  }

  build() {
    NavDestination() {
      Column() {
        MdAppBar({
          title: '活动设置',
          subtitle: '名称、负责人与阶段',
          showBack: true,
          onBack: () => {
            this.onBack()
          }
        })

        Scroll() {
          Column({ space: 16 }) {
            Column({ space: 12 }) {
              Text('活动信息')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor($r('app.color.md_text_primary'))
                .width('100%')

              EventNameField({ eventName: this.eventName })

              Divider()
                .color($r('app.color.md_divider'))

              this.InfoRow('时间', '11 月 7 日（周六）14:00–18:00')
              this.InfoRow('地点', '中心广场')
              this.InfoRow('例会', '周四 19:00 · 图书馆研讨间 3')
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

            Column({ space: 12 }) {
              LeadPicker()
              Text('首页顶栏和分享卡发布人会同步更新。')
                .fontSize(12)
                .fontColor($r('app.color.md_text_secondary'))
                .lineHeight(18)
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

            Column({ space: 12 }) {
              Text('活动阶段')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor($r('app.color.md_text_primary'))
                .width('100%')

              StagePicker({ stage: this.stage })

              Text('切换阶段后，工作台的「本周重点」和「最近动态」会一起更新。')
                .fontSize(12)
                .fontColor($r('app.color.md_text_secondary'))
                .lineHeight(18)
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
