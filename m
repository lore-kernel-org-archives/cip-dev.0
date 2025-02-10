Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB8DC021A9
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.45200.1739170601913271388
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=TVzKufVx;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170570;x=1740380170;bh=AmyIk
	v3DbnfgADTlpj58Tj6YoTuPHzz5Iun7nYljy4s=;b=TVzKufVxTtWXFrq1Pn3E2sGu5Whj7fODdMv
	w9nlOPRLscz6hDXNDpI0aJzamzuu43loo8rH1Y93bA/xHQb/UcWci9DLyY7UXMRd+1vN5mJ1bOuuG
	Qdj2Av+uO+M63QXCx3zwl1YeM+ip/f2EI163ZwIxIENlhlY2UVcppTcRRe3Eem0DeS29ZVQ57iq3K
	x6Q+olH1Eodj23NSoDgDyiGWXRg47mwgBmZ6aC1RWLyEcCZYchU/rDHlxwva1jqZvJqHl38RuikWX
	yeaMhQH9hQBQmJHN9nXeX1ELW7DGghEOljqhXUzZKPZ/XYHk1/Qy8Bu4/pEyqlS7Z/ET4I3blRCg=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 51A6uAQ3789407; Mon, 10 Feb 2025 15:56:10 +0900
X-Iguazu-Qid: 2yAbuzQy0kRcL2Dr8m
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbuzQy0kRcL2Dr8m; m=PWtZJNLikNyw9D52ik4dbAaTKCdwJGjcTITQQVEshYE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 51A6u73m1015855
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 07/17] ACPI: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:35 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-8-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17784

From: Thomas Gleixner <tglx@linutronix.de>

commit 9762b33dc31c67e34b36ba4e787e64084b3136ff upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Make the decision whether a pci root is hotplugged depend on SYSTEM_RUNNING
instead of !SYSTEM_BOOTING. It makes no sense to cover states greater than
SYSTEM_RUNNING as there are not hotplug events on reboot and poweroff.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Link: http://lkml.kernel.org/r/20170516184735.446455652@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4031ec8024ce..5c5ae92710eb 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -526,7 +526,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	struct acpi_pci_root *root;
 	acpi_handle handle = device->handle;
 	int no_aspm = 0;
-	bool hotadd = system_state != SYSTEM_BOOTING;
+	bool hotadd = system_state == SYSTEM_RUNNING;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
-- 
2.30.2



