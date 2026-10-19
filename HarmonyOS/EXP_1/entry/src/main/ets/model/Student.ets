/**
 * 自定义类
 */
@Observed
export class Student {
  name: string = '李明'
  studentId: string = '2024001001'
  major: string = '软件工程'
  clazz: string = '计科 2401 班'

  getAvatarLabel(): string {
    return this.name.length > 0 ? this.name.substring(0, 1) : '?'
  }
}
