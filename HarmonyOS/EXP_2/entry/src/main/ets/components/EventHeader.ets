import { MdAppBar } from '../common/MdAppBar'

/**
 * 活动页顶栏，显示活动名称。
 */
@Component
export struct EventHeader {
  @Prop eventName: string = ''

  build() {
    MdAppBar({
      title: this.eventName.length > 0 ? this.eventName : '未命名活动'
    })
  }
}
