Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC2EC77B7F
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 02:01:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.6003.1750816880709257629
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jun 2025 19:01:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=BaioWFcZ;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1750816844;x=1752026444;bh=qKhXi+SVOnEgEp9P7kPbiqpT672ZpGpgS/QYiom4R7E=;b=Bai
	oWFcZSLKB27D76l/KFLkQ2kyFoMl8bnxeVGmxD0xIC9QEpN1Dcrw9Nd+UMPjuOwLZCgFIN4L3zloY
	8ORXd1wdh91eaKC2C0gAOsHdNONXnm5OkvA64aO1dTK1Bp+NSR132fCClmrORa0dB3Oq3xppS6neu
	y8ScV2tdoMBmxYkuOERrI8X91C9HwnlO7d29y0fsHtytaf2Ct4ByxFG0fGfuHllMPNbFwYHFdRXcW
	hPn4C43ROE7+eNlkgXOMRBflPPLIe+orLaZLyBHkZOsOz4VbSFyteGHJTrnK8wtzBC4pQoKHiMWcO
	xn9+jPzl0mO5i9LfIw54YhEbWBmY2lg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 55P20i2Q3340290; Wed, 25 Jun 2025 11:00:44 +0900
X-Iguazu-Qid: 2rWhyCKR8R2QT014Gx
X-Iguazu-QSIG: v=2; s=0; t=1750816843; q=2rWhyCKR8R2QT014Gx; m=IkIEtXpU8JkOvTK9wIKnQteAHLCEJBNkJwQq7IxZBvw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 55P20eKm3781710
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 11:00:40 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, Ulrich Hecht <uli@fpond.eu>,
        Pavel Machek <pavel@denx.de>
Cc: Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>, Yi Zhang <yi.zhang@redhat.com>,
        stable@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 4.4] scsi: core: Remove the /proc/scsi/${proc_name} directory earlier
Date: Wed, 25 Jun 2025 11:00:26 +0900
X-TSB-HOP2: ON
Message-Id: <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jun 2025 02:01:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19229

From: Bart Van Assche <bvanassche@acm.org>

commit fc663711b94468f4e1427ebe289c9f05669699c9 upstream.

Remove the /proc/scsi/${proc_name} directory earlier to fix a race
condition between unloading and reloading kernel modules. This fixes a bug
introduced in 2009 by commit 77c019768f06 ("[SCSI] fix /proc memory leak in
the SCSI core").

Fix the following kernel warning:

proc_dir_entry 'scsi/scsi_debug' already registered
WARNING: CPU: 19 PID: 27986 at fs/proc/generic.c:376 proc_register+0x27d/0x2e0
Call Trace:
 proc_mkdir+0xb5/0xe0
 scsi_proc_hostdir_add+0xb5/0x170
 scsi_host_alloc+0x683/0x6c0
 sdebug_driver_probe+0x6b/0x2d0 [scsi_debug]
 really_probe+0x159/0x540
 __driver_probe_device+0xdc/0x230
 driver_probe_device+0x4f/0x120
 __device_attach_driver+0xef/0x180
 bus_for_each_drv+0xe5/0x130
 __device_attach+0x127/0x290
 device_initial_probe+0x17/0x20
 bus_probe_device+0x110/0x130
 device_add+0x673/0xc80
 device_register+0x1e/0x30
 sdebug_add_host_helper+0x1a7/0x3b0 [scsi_debug]
 scsi_debug_init+0x64f/0x1000 [scsi_debug]
 do_one_initcall+0xd7/0x470
 do_init_module+0xe7/0x330
 load_module+0x122a/0x12c0
 __do_sys_finit_module+0x124/0x1a0
 __x64_sys_finit_module+0x46/0x50
 do_syscall_64+0x38/0x80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Link: https://lore.kernel.org/r/20230210205200.36973-3-bvanassche@acm.org
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Yi Zhang <yi.zhang@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 77c019768f06 ("[SCSI] fix /proc memory leak in the SCSI core")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/scsi/hosts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index c59b3fd6b361..7ffdebdd9c54 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -173,6 +173,7 @@ void scsi_remove_host(struct Scsi_Host *shost)
 	scsi_forget_host(shost);
 	mutex_unlock(&shost->scan_mutex);
 	scsi_proc_host_rm(shost);
+	scsi_proc_hostdir_rm(shost->hostt);
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	if (scsi_host_set_state(shost, SHOST_DEL))
@@ -322,6 +323,7 @@ static void scsi_host_dev_release(struct device *dev)
 	struct request_queue *q;
 	void *queuedata;
 
+	/* In case scsi_remove_host() has not been called. */
 	scsi_proc_hostdir_rm(shost->hostt);
 
 	if (shost->tmf_work_q)
-- 
2.25.1



