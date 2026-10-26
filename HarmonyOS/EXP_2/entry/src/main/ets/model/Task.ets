/**
 * 筹备任务。
 */
@Observed
export class Task {
  id: string = ''
  title: string = ''
  owner: string = ''
  due: string = ''
  note: string = ''
  done: boolean = false

  constructor(id: string, title: string, owner: string, due: string, note: string, done: boolean = false) {
    this.id = id
    this.title = title
    this.owner = owner
    this.due = due
    this.note = note
    this.done = done
  }
}
