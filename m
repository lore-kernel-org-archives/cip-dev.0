Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E2DC41513
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 08:17:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.19709.1719908264156149986
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jul 2024 01:17:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4628Hfrv3218038; Tue, 2 Jul 2024 17:17:42 +0900
X-Iguazu-Qid: 2rWgf1P1H9BPBOdr2H
X-Iguazu-QSIG: v=2; s=0; t=1719908261; q=2rWgf1P1H9BPBOdr2H; m=6MqV+lqKxV3STVueypjPfxwbeEB6ADdMIwlfk+iJjfc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 4628He731005280
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 17:17:41 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 0/1] Set size for rootfs partition in .wks file for reproducibility
Date: Tue,  2 Jul 2024 13:47:06 +0530
X-TSB-HOP2: ON
Message-Id: <20240702081708.3339644-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 02 Jul 2024 08:17:38.0758 (UTC) FILETIME=[4D56E660:01DACC58]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jul 2024 08:17:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16357

In the case where no size parameter is set in the wks file, wic estimates 
the rootfs size from the rootfs directory in WORKDIR, See [1]. 

Sometimes the ROOTFS_SIZE variable is not the same between builds, although 
the rootfs contents are identical. For the calculation of ROOTFS_SIZE, See [2]

This can lead to different partition images (in terms of number of blocks in 
each partiton image in case of an ext filesystem) which makes the partition 
images non-reproducible.

Although this patch doesn't fix the core problem, as in fixing the cause for the 
ROOTFS_SIZE changing between builds (probably a discussion for the ISAR ML), 
I feel that setting a reasonable size to the rootfs partition would not cause 
any harm and also help with reproducibility.

[1] https://github.com/ilbers/isar/blob/master/scripts/lib/wic/partition.py#L242
[2] https://github.com/ilbers/isar/blob/master/meta/classes/image.bbclass#L87


Adithya Balakumar (1):
  wic: Set size for rootfs partition

 wic/bbb.wks            | 2 +-
 wic/x86_64-generic.wks | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.2



