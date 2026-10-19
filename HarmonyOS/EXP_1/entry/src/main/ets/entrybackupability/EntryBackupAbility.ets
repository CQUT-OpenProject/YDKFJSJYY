import { hilog } from '@kit.PerformanceAnalysisKit';
import { BackupExtensionAbility, BundleVersion } from '@kit.CoreFileKit';

const DOMAIN = 0x0000;

/**
 * 数据备份恢复扩展：系统在备份/恢复应用数据时回调
 */
export default class EntryBackupAbility extends BackupExtensionAbility {
  // 备份数据时回调
  async onBackup() {
    hilog.info(DOMAIN, 'testTag', 'onBackup ok');
    await Promise.resolve();
  }

  // 恢复数据时回调，bundleVersion 为备份数据对应的应用版本
  async onRestore(bundleVersion: BundleVersion) {
    hilog.info(DOMAIN, 'testTag', 'onRestore ok %{public}s', JSON.stringify(bundleVersion));
    await Promise.resolve();
  }
}
