Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9C4C7EE2D
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:47 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20937.1684484491304088301
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963202"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:38 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 77192419EC47;
	Fri, 19 May 2023 17:21:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros, deprecate old ones
Date: Fri, 19 May 2023 09:20:49 +0100
Message-Id: <20230519082058.109760-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11546

From: Paul Cercueil <paul@crapouillou.net>

commit 1a3c7bb088266fa2db017be299f91f1c1894c857 upstream.

This commit introduces the following macros:

SYSTEM_SLEEP_PM_OPS()
LATE_SYSTEM_SLEEP_PM_OPS()
NOIRQ_SYSTEM_SLEEP_PM_OPS()
RUNTIME_PM_OPS()

These new macros are very similar to their SET_*_PM_OPS() equivalent.
They however differ in the fact that the callbacks they set will always
be seen as referenced by the compiler. This means that the callback
functions don't need to be wrapped with a #ifdef CONFIG_PM guard, or
tagged with __maybe_unused, to prevent the compiler from complaining
about unused static symbols. The compiler will then simply evaluate at
compile time whether or not these symbols are dead code.

The callbacks that are only useful with CONFIG_PM_SLEEP is enabled, are
now also wrapped with a new pm_sleep_ptr() macro, which is inspired from
pm_ptr(). This is needed for drivers that use different callbacks for
sleep and runtime PM, to handle the case where CONFIG_PM is set and
CONFIG_PM_SLEEP is not.

This commit also deprecates the following macros:

SIMPLE_DEV_PM_OPS()
UNIVERSAL_DEV_PM_OPS()

And introduces the following macros:

DEFINE_SIMPLE_DEV_PM_OPS()
DEFINE_UNIVERSAL_DEV_PM_OPS()

These macros are similar to the functions they were created to replace,
with the following differences:

 - They use the new macros introduced above, and as such always
   reference the provided callback functions.

 - They are not tagged with __maybe_unused. They are meant to be used
   with pm_ptr() or pm_sleep_ptr() for DEFINE_UNIVERSAL_DEV_PM_OPS()
   and DEFINE_SIMPLE_DEV_PM_OPS() respectively.

 - They declare the symbol static, since every driver seems to do that
   anyway; and if a non-static use-case is needed an indirection pointer
   could be used.

The point of this change, is to progressively switch from a code model
where PM callbacks are all protected behind CONFIG_PM guards, to a code
model where the PM callbacks are always seen by the compiler, but
discarded if not used.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/linux/pm.h | 74 +++++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 5ac2c9ba5baf..b4974dc83703 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -301,47 +301,59 @@ struct dev_pm_ops {
 	int (*runtime_idle)(struct device *dev);
 };
 
+#define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend = pm_sleep_ptr(suspend_fn), \
+	.resume = pm_sleep_ptr(resume_fn), \
+	.freeze = pm_sleep_ptr(suspend_fn), \
+	.thaw = pm_sleep_ptr(resume_fn), \
+	.poweroff = pm_sleep_ptr(suspend_fn), \
+	.restore = pm_sleep_ptr(resume_fn),
+
+#define LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend_late = pm_sleep_ptr(suspend_fn), \
+	.resume_early = pm_sleep_ptr(resume_fn), \
+	.freeze_late = pm_sleep_ptr(suspend_fn), \
+	.thaw_early = pm_sleep_ptr(resume_fn), \
+	.poweroff_late = pm_sleep_ptr(suspend_fn), \
+	.restore_early = pm_sleep_ptr(resume_fn),
+
+#define NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend_noirq = pm_sleep_ptr(suspend_fn), \
+	.resume_noirq = pm_sleep_ptr(resume_fn), \
+	.freeze_noirq = pm_sleep_ptr(suspend_fn), \
+	.thaw_noirq = pm_sleep_ptr(resume_fn), \
+	.poweroff_noirq = pm_sleep_ptr(suspend_fn), \
+	.restore_noirq = pm_sleep_ptr(resume_fn),
+
+#define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	.runtime_suspend = suspend_fn, \
+	.runtime_resume = resume_fn, \
+	.runtime_idle = idle_fn,
+
 #ifdef CONFIG_PM_SLEEP
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend = suspend_fn, \
-	.resume = resume_fn, \
-	.freeze = suspend_fn, \
-	.thaw = resume_fn, \
-	.poweroff = suspend_fn, \
-	.restore = resume_fn,
+	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #else
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
 #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend_late = suspend_fn, \
-	.resume_early = resume_fn, \
-	.freeze_late = suspend_fn, \
-	.thaw_early = resume_fn, \
-	.poweroff_late = suspend_fn, \
-	.restore_early = resume_fn,
+	LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #else
 #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
 #define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend_noirq = suspend_fn, \
-	.resume_noirq = resume_fn, \
-	.freeze_noirq = suspend_fn, \
-	.thaw_noirq = resume_fn, \
-	.poweroff_noirq = suspend_fn, \
-	.restore_noirq = resume_fn,
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #else
 #define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #endif
 
 #ifdef CONFIG_PM
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
-	.runtime_suspend = suspend_fn, \
-	.runtime_resume = resume_fn, \
-	.runtime_idle = idle_fn,
+	RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
 #else
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
 #endif
@@ -350,9 +362,9 @@ struct dev_pm_ops {
  * Use this if you want to use the same suspend and resume callbacks for suspend
  * to RAM and hibernation.
  */
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-const struct dev_pm_ops __maybe_unused name = { \
-	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+#define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+static const struct dev_pm_ops name = { \
+	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 }
 
 /*
@@ -368,6 +380,19 @@ const struct dev_pm_ops __maybe_unused name = { \
  * .resume_early(), to the same routines as .runtime_suspend() and
  * .runtime_resume(), respectively (and analogously for hibernation).
  */
+#define DEFINE_UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
+static const struct dev_pm_ops name = { \
+	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+}
+
+/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
+#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+const struct dev_pm_ops __maybe_unused name = { \
+	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+}
+
+/* Deprecated. Use DEFINE_UNIVERSAL_DEV_PM_OPS() instead. */
 #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
 const struct dev_pm_ops __maybe_unused name = { \
 	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
@@ -375,6 +400,7 @@ const struct dev_pm_ops __maybe_unused name = { \
 }
 
 #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
+#define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
 
 /*
  * PM_EVENT_ messages
-- 
2.25.1


