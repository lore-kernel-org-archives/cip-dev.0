Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FFECDB471
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 07:49:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15795.1782200992244863523
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 00:49:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 65N7nnfo4189006; Tue, 23 Jun 2026 16:49:50 +0900
X-Iguazu-Qid: 2rWhpSL4OuqxNHdbe9
X-Iguazu-QSIG: v=2; s=0; t=1782200989; q=2rWhpSL4OuqxNHdbe9; m=KyuqjO/UwpSVtT4sF8At5XQs/hLq0e4tuJw5sXPkm1Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gkxzx3vvTz1xnq; Tue, 23 Jun 2026 16:49:49 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v3 0/4] Enable Debian sid support
Date: Tue, 23 Jun 2026 13:06:37 +0530
X-TSB-HOP2: ON
Message-Id: <20260623073642.964019-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jun 2026 07:49:46.0856 (UTC) FILETIME=[DCA4A680:01DD02E4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 07:49:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23258

This enables the support to build Debian sid based images in the repository
including CI (scheduled jobs) which helps to detect the issues in advance.

I've confirmed the Sid image boot works for SWUpdate & Data encryption enabled images.

The scheduled job is created here https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipeline_schedules
and confirmed the jobs are getting triggered for "Weekly Debian Sid build
& tests". Once this series is merged we can change branch to "next" and
update the interval if required. please note that a new CI variable is
introduced for these builds (i.e CI_RUN_UNSTABLE_SID) and the same is
being used in the CI jobs.

For the sid, I selected IEC security image as build and test targets as it includes
all the features (swupdate, secure boot, data encryption, factory reset).
The idea is to have minimal jobs to test more feature. I understand that in the IEC jobs
we will not test swupdate, factory reset explicitly.
if required we can also add swupdate, secure boot job targets for sid as well,
please let me know your opinion.

At the moment, the security image build jobs are passing for amd64, arm64 & armhf archs.
The test jobs are failed as it needs some adjustments in the `submit-lava.sh` script
so I plan to handle it in a separate patch. I hope this is fine at the moment.
please let us know if you have any different opinion.

Shivanand Kunijadar (4):
  Enable Debian Sid support
  Add the default kernel verions in cip-core-common.inc with extra weak
  Add crypt library packages for Debian sid version
  Enable CI image build and test support for Sid

 .gitlab-ci.yml                                | 90 +++++++++++++++++++
 Kconfig                                       |  4 +
 conf/distro/cip-core-common.inc               |  3 +
 conf/distro/cip-core-sid.conf                 | 13 +++
 kas/opt/sid.yml                               | 15 ++++
 .../initramfs-crypt-hook_0.11.bb              |  2 +
 start-qemu.sh                                 |  2 +
 7 files changed, 129 insertions(+)
 create mode 100644 conf/distro/cip-core-sid.conf
 create mode 100644 kas/opt/sid.yml

-- 
2.39.5



