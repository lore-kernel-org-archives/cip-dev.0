From: wagi@monom.org (Daniel Wagner)
Date: Wed, 09 May 2018 18:51:06 +0200
Subject: [cip-dev] [ANNOUNCE] 4.4.126-cip22-rt17
Message-ID: <20180509165253.4C987500C4B@mail.monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello CIP RT Folks!

I'm pleased to announce the 4.4.126-cip22-rt17 stable release.

This release add the missing stable-rt patches from Sebastian. With
this the CIP -rt tree should contain all stable-rt patches. Let me
knonw if I missed anything.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux-cip-rt.git

  branch: linux-4.4.y-cip-rt
  Head SHA1: 1b874cc423e32f6b3bc6215d8b2cc85f4e874725

Enjoy!
   Daniel

Changes from v4.4.126-cip22-rt16:
---
Daniel Wagner (1):
      Linux 4.4.126-cip22-rt17

Sebastian Andrzej Siewior (2):
      alarmtimer: Prevent live lock in alarm_cancel()
      posix-timers: move the rcu head out of the union

---
 include/linux/posix-timers.h | 2 +-
 kernel/time/alarmtimer.c     | 2 +-
 kernel/time/posix-timers.c   | 4 ++--
 localversion-cip-rt          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 907f3fd191ac..e2e43c61f6a1 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -92,8 +92,8 @@ struct k_itimer {
 			struct alarm alarmtimer;
 			ktime_t interval;
 		} alarm;
-		struct rcu_head rcu;
 	} it;
+	struct rcu_head rcu;
 };
 
 struct k_clock {
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 6fcc367ad531..9d5eac2c9275 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -392,7 +392,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		cpu_relax();
+		hrtimer_wait_for_timer(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 48ca053dae2e..0808e2ae49bf 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -567,7 +567,7 @@ static struct k_itimer * alloc_posix_timer(void)
 
 static void k_itimer_rcu_free(struct rcu_head *head)
 {
-	struct k_itimer *tmr = container_of(head, struct k_itimer, it.rcu);
+	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
 
 	kmem_cache_free(posix_timers_cache, tmr);
 }
@@ -584,7 +584,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static struct k_clock *clockid_to_kclock(const clockid_t id)
diff --git a/localversion-cip-rt b/localversion-cip-rt
index 1199ebade17b..1e584b47c987 100644
--- a/localversion-cip-rt
+++ b/localversion-cip-rt
@@ -1 +1 @@
--rt16
+-rt17
