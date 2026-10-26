import { MdAppBar } from '../common/MdAppBar'
import { ShareCard } from '../components/ShareCard'

/**
 * 邀请与分享：分享卡预览和标题草稿。
 */
@Component
export struct SharePage {
  @Link headline: string
  onBack: () => void = () => {
  }

  build() {
    NavDestination() {
      Column() {
        MdAppBar({
          title: '邀请与分享',
          subtitle: '分享卡预览与标题',
          showBack: true,
          onBack: () => {
            this.onBack()
          }
        })

        Scroll() {
          Column({ space: 16 }) {
            Column() {
              ShareCard({
                draft: this.headline,
                headline: this.headline,
                onApply: (value: string) => {
                  this.headline = value
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

            Column({ space: 6 }) {
              Text('分享小贴士')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor($r('app.color.md_text_primary'))
                .width('100%')
              Text('把分享卡发给班级群和摊位主，报名页上线后附上链接即可。')
                .fontSize(12)
                .fontColor($r('app.color.md_text_secondary'))
                .lineHeight(19)
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
