Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4373C021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 16:49:35 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.27873.1740156574553141210
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2025 08:49:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: sjL3m2TkSeqR+4AMCbWTBw==
X-CSE-MsgGUID: r3l+iU4jR9qUkubJwEn7pQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Feb 2025 01:49:32 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.173])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1E193403AC3F;
	Sat, 22 Feb 2025 01:49:30 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Ulrich Hecht <uli@kernel.org>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 4.4.y-st] posix-clock: Fix backported timespec64 check
Date: Fri, 21 Feb 2025 16:49:29 +0000
Message-ID: <20250221164929.357460-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2025 16:49:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17878

The backported check calls timespec64_valid_strict(ts), but in
linux-4.4.y-st the `ts` argument is not a timespec64 instance. This
leads to the following warning:

    kernel/time/posix-clock.c: In function 'pc_clock_settime':
    kernel/time/posix-clock.c:345:31: warning: passing argument 1 of 'timespec64_valid_strict' from incompatible pointer type [-Wincompatible-pointer-types]
      if (!timespec64_valid_strict(ts))
                                   ^~
    In file included from include/linux/time.h:7:0,
                     from include/linux/ktime.h:24,
                     from include/linux/rcupdate.h:47,
                     from include/linux/idr.h:18,
                     from include/linux/kernfs.h:14,
                     from include/linux/sysfs.h:15,
                     from include/linux/kobject.h:21,
                     from include/linux/device.h:17,
                     from kernel/time/posix-clock.c:20:
    include/linux/time64.h:181:20: note: expected 'const struct timespec64 *' but argument is of type 'const struct timespec *'
     static inline bool timespec64_valid_strict(const struct timespec64 *ts)
                        ^~~~~~~~~~~~~~~~~~~~~~~

As struct timespec64 is larger than struct timespec, this could result
in out-of-bounds memory access.

Fix this by passing the converted timespec64 instance to
timespec64_valid_strict().

Fixes: 40ec979c6d01 ("posix-clock: Fix missing timespec64 check in pc_clock_settime()")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---

This patch has been tested on RZ/G1M using the linux-4.4.y-cip tree, but
I'm sending it for linux-4.4.y-st as the issue is also present there. I
currently have no way to test the -st tree without the corresponding
cip patches.

 kernel/time/posix-clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 74468c1dd74c..bd78bfa48666 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -342,7 +342,7 @@ static int pc_clock_settime(clockid_t id, const struct timespec *ts)
 	struct posix_clock_desc cd;
 	int err;
 
-	if (!timespec64_valid_strict(ts))
+	if (!timespec64_valid_strict(&ts64))
 		return -EINVAL;
 
 	err = get_clock_desc(id, &cd);
-- 
2.43.0


