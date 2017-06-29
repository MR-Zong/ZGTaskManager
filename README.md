# ZGTaskManager

#计时任务管理器：

##应用场景：
####可以给那些用于计时的应用，如抢购啊，倒计时活动等，
####抢购，一般做电子商务的都会用到的
####首页里显示距离公司某个活动还有多少天等等
####适用于有一个或多个界面都要用到倒计时

##特色：
####1，计时任务管理器采用单例模式，这样只会有一个Timer,节省内存
####2，当所有任务执行完时候Timer会被释放
####3，使用简单，提供一个addTaskWithBlock方法，要用到倒计时的地方，直接调用此方法，把你的操作代码放进block即可

#效果展示
![时间任务管理展示]{https://github.com/MR-Zong/ZGTaskManager/blob/master/ZGTaskManager/ZGTaskManager/taskManagerShow.png}
