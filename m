Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384ADC77B75
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20937.1684484491304088301
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963194"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:35 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C5ED8419EC47;
	Fri, 19 May 2023 17:21:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 13/23] PM: core: Redefine pm_ptr() macro
Date: Fri, 19 May 2023 09:20:48 +0100
Message-Id: <20230519082058.109760-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11545

From: Paul Cercueil <paul@crapouillou.net>

commit c06ef740d401d0f4ab188882bf6f8d9cf0f75eaf upstream.

The pm_ptr() macro was previously conditionally defined, according to
the value of the CONFIG_PM option. This meant that the pointed structure
was either referenced (if CONFIG_PM was set), or never referenced (if
CONFIG_PM was not set), causing it to be detected as unused by the
compiler.

This worked fine, but required the __maybe_unused compiler attribute to
be used to every symbol pointed to by a pointer wrapped with pm_ptr().

We can do better. With this change, the pm_ptr() is now defined the
same, independently of the value of CONFIG_PM. It now uses the (?:)
ternary operator to conditionally resolve to its argument. Since the
condition is known at compile time, the compiler will then choose to
discard the unused symbols, which won't need to be tagged with
__maybe_unused anymore.

This pm_ptr() macro is usually used with pointers to dev_pm_ops
structures created with SIMPLE_DEV_PM_OPS() or similar macros. These do
use a __maybe_unused flag, which is now useless with this change, so it
later can be removed. However in the meantime it causes no harm, and all
the drivers still compile fine with the new pm_ptr() macro.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/linux/pm.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 52d9724db9dc..5ac2c9ba5baf 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -374,11 +374,7 @@ const struct dev_pm_ops __maybe_unused name = { \
 	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 }
 
-#ifdef CONFIG_PM
-#define pm_ptr(_ptr) (_ptr)
-#else
-#define pm_ptr(_ptr) NULL
-#endif
+#define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
 
 /*
  * PM_EVENT_ messages
-- 
2.25.1


