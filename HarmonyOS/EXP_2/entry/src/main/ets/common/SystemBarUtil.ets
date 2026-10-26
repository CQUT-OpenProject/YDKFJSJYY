import { common } from '@kit.AbilityKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { window } from '@kit.ArkUI'

/** 系统栏（状态栏 / 导航栏）配色项 */
export interface SystemBarStyle {
  statusBarColor: string
  statusBarContentColor: string
  navigationBarColor: string
  navigationBarContentColor: string
}

/**
 * 按页面主题设置系统栏颜色，使状态栏与 MD2 AppBar 一致
 */
export class SystemBarUtil {
  /** MD2 主色 AppBar：蓝色顶栏 + 浅色状态栏图标 */
  static readonly PRIMARY_APP_BAR: SystemBarStyle = {
    statusBarColor: '#1976D2',
    statusBarContentColor: '#FFFFFF',
    navigationBarColor: '#FAFAFA',
    navigationBarContentColor: '#DE000000'
  }

  /** MD2 浅色顶栏（备用） */
  static readonly LIGHT_SURFACE: SystemBarStyle = {
    statusBarColor: '#FFFFFF',
    statusBarContentColor: '#DE000000',
    navigationBarColor: '#FAFAFA',
    navigationBarContentColor: '#DE000000'
  }

  static apply(context: common.UIAbilityContext, style: SystemBarStyle): void {
    window.getLastWindow(context).then((mainWindow: window.Window) => {
      mainWindow.setWindowSystemBarProperties({
        statusBarColor: style.statusBarColor,
        statusBarContentColor: style.statusBarContentColor,
        navigationBarColor: style.navigationBarColor,
        navigationBarContentColor: style.navigationBarContentColor
      }).catch((err: BusinessError) => {
        console.error(`设置系统栏失败: ${JSON.stringify(err)}`)
      })
    }).catch((err: BusinessError) => {
      console.error(`获取主窗口失败: ${JSON.stringify(err)}`)
    })
  }
}
