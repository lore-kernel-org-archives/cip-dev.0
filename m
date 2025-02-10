Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6298DC021A2
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.45357.1739170599363545677
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=knnD/rSR;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170573;x=1740380173;bh=r2bGS
	QuW3OUidgcECmo0HgSV1D5FG/L2Ld2WCzZKiPg=;b=knnD/rSRtEjokv4nwpdZLTt24aAMsPdzs30
	OcZ6S48JJdY/JH8RrWYc+VapW96fUUfmO9pwBuSwy6Z81o9Bo7JuS7ovppPkUG+gTH/mlRg3+dBnl
	GDZM03E3lWJDfnU/rBAG6SmfvNQbrJIfDkF8+PUgC6r4RdQVl1fkmoe2OyAaAxohC1jU+GVinBcTU
	ilZt8iMKavIFJkjofP0PrO92gSlN0bILFlVMnOcMIt1XqmDAJCruup0n5Y3Sm5OTi74UG+73/mZcg
	uHlD7VTjpywQ0fFNnvcyGH4yr6wleFw74zKQGqQEMjUoxK/qaiXOSkwJ/5TP1Rhk7Ocg4HNahWww=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51A6uDGN3387803; Mon, 10 Feb 2025 15:56:13 +0900
X-Iguazu-Qid: 2yAbAvUQLMDymhsI13
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbAvUQLMDymhsI13; m=cJHL28zEPBgbgE/lC5o0LDRLsvlwWkSeNef5Mf90hzM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 51A6u8Qw4036156
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:08 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 13/17] printk: Adjust system_state checks
Date: Mon, 10 Feb 2025 15:55:41 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-14-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17779

From: Thomas Gleixner <tglx@linutronix.de>

commit ff48cd26fc4889b9deb5f9333d3c61746e450b7f upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in boot_delay_msec() to handle the extra
states.

Conflicts: kernel/printk/printk.c
cf775444 replace the third condition that boot_delay_msec() returns
immediately with suppress_message_printing(). This does not affect
system_state check.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170516184736.027534895@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d8e0790f56cb..8d1e081bf9fc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1077,7 +1077,7 @@ static void boot_delay_msec(int level)
 	unsigned long long k;
 	unsigned long timeout;
 
-	if ((boot_delay == 0 || system_state != SYSTEM_BOOTING)
+	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
 		|| (level >= console_loglevel && !ignore_loglevel)) {
 		return;
 	}
-- 
2.30.2



