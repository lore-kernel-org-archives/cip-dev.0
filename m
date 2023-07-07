Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5616AC001B0
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 14:16:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.13303.1688739358532128330
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 07:15:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 367EFucV1236546; Fri, 7 Jul 2023 23:15:56 +0900
X-Iguazu-Qid: 2yAbeDFf7rQIeXeVXs
X-Iguazu-QSIG: v=2; s=0; t=1688739356; q=2yAbeDFf7rQIeXeVXs; m=sZh24S884Ul6F7dASEFV+7SW7K6syHr7YEfqD3bQFmQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 367EFtg31901357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jul 2023 23:15:56 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 0/8] Enable swupdate in reproducible check
Date: Fri,  7 Jul 2023 19:45:42 +0530
X-TSB-HOP2: ON
Message-Id: <20230707141550.27805-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176E5CF032D87010.7887@lists.cip-project.org>
References: <176E5CF032D87010.7887@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jul 2023 14:15:54.0157 (UTC) FILETIME=[8A78BDD0:01D9B0DD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 14:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12264

From: venkata pyla <venkata.pyla@toshiba-tsip.com>


Hi,

The following patch series enables swupdate in reproducible check CI,
and also it include fixes for the reproducible build failures #68 and
#69.

with this patch series the reproducible builds are getting passed in amd64
and arm64 architectures considering following artifacts.
 - vmlinux
 - initrd
 - rootfs tarball
 - squashfs image
 - swu file

armhf is not reproducible yet due to this issue #70 - WIP

filesystem images and disk partition tables are yet to add to the
reproducible check - WIP.

v3 changes:
 - fix indentation issue in squashfs.bbclass (dd241fbd)
 - Use bookworm for reproducible checks
 - Update isar refernce to bring reproducible fixes

v2 changes:
 - Include swupdate feature in base image itself instead of separate
   targets
 - Added commit to fix file timestamps are not reproducible in squashfs
   image and swu file.

venkata pyla (8):
  .reproducible-check-ci.yml: Include swupdate artifacts in reproducible
    check
  .reproducible-check-ci.yml: Drop 'base' in job names
  .reproducible-check-ci.yml: Include only files required for RB check
  repro-tests.sh: Enable html output in diffoscope
  squashfs.bbclass: Fix file timestamps are not reproducible in squashfs
    image
  swupdate.bbclass: Fix file timestamps are not reproducible in swu file
  .reproducible-check-ci.yml: Enable reproudicble check on bookworm
  kas-cip.yml: Update isar reference

 .reproducible-check-ci.yml | 37 +++++++++++++++++++++++++------------
 classes/squashfs.bbclass   |  6 ++++++
 classes/swupdate.bbclass   | 10 +++++++++-
 kas-cip.yml                |  2 +-
 scripts/repro-tests.sh     |  2 ++
 5 files changed, 43 insertions(+), 14 deletions(-)

-- 
2.20.1



