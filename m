Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF49EC021A8
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.45197.1739170601346245481
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=PCDxFuqW;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170571;x=1740380171;bh=LacjT
	pN6fdSgOV/NnhQm9cOx14rxFw1BSnWAXKHY99I=;b=PCDxFuqWCez+GJb9W3bm1Ld9MckiRtHX/n1
	fa6oq339F+WSzPFy5sDQDE41zPod8eIh2LfYuTlqQxMu+GHqZxDmBkrVEoRxCcQMcv61DxZWR9ZL5
	/IqWgcMF+JeZHWQ4+477b8/Y9f/ZIBQphYeZ68KCVPAhzxb5y47gPueGEWe6SLOWB4CNZ87a5ctO6
	vSRAwSr0/SqdbhBg8sHD7UuhytHZrV9+L0T2PHewsyD/de0t+GtGoOPhokdGlIDvQ4VsO1aicGzXX
	og5SB8vlK0n+d2VVHZvo+QZqXIfAK1dVIw8PRD6Yk6NDjx9CjXDpxjwIJEbydacJan2DdhJS/n6w=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 51A6uA5C789405; Mon, 10 Feb 2025 15:56:10 +0900
X-Iguazu-Qid: 2yAbpfLvFIKSbpKASb
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbpfLvFIKSbpKASb; m=Reug4TbvHHwhrFEIwyFoQhcztFgDCGfAzKkgoFM+1PQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 51A6u6OO977772
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:06 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 02/17] arm: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:30 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17780

From: Thomas Gleixner <tglx@linutronix.de>

commit 5976a66913a8bf42465d96776fd37fb5631edc19 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in ipi_cpu_stop() to handle the extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20170516184735.020718977@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 arch/arm/kernel/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ffa533a4ef57..7b32330185bc 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -587,8 +587,7 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
  */
 static void ipi_cpu_stop(unsigned int cpu)
 {
-	if (system_state == SYSTEM_BOOTING ||
-	    system_state == SYSTEM_RUNNING) {
+	if (system_state <= SYSTEM_RUNNING) {
 		raw_spin_lock(&stop_lock);
 		pr_crit("CPU%u: stopping\n", cpu);
 		dump_stack();
-- 
2.30.2



