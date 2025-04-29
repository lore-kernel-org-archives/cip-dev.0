Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6823EC3ABA9
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 04:29:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.7901.1745900984571216150
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 21:29:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 53T4Tg4U1109835; Tue, 29 Apr 2025 13:29:43 +0900
X-Iguazu-Qid: 2yAbJ3LJ44nDmb9i6M
X-Iguazu-QSIG: v=2; s=0; t=1745900982; q=2yAbJ3LJ44nDmb9i6M; m=aiX4MXzOqPlDjGdjIGlua1w5fTSOYh6LSK5yZ9NUAnI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 53T4Tfis2075800
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 13:29:42 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai.sathujoda@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 0/3] Enable secure boot keys mismatch
Date: Tue, 29 Apr 2025 09:50:25 +0530
X-TSB-HOP2: ON
Message-Id: <20250429042028.3579304-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Apr 2025 04:29:39.0959 (UTC) FILETIME=[527A9070:01DBB8BF]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 04:29:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18703

This patch series enables the secure boot keys mismatch scenario for
amd64 architecture.
In secure boot, the artifacts are signed using disto specific snakeoil keys. 
In this scenario, trixie version of OVMF keys are used to verify the artifacts 
which are signed using bookworm snakeoil keys during the build.

Shivanand Kunijadar (3):
  submit_lava.sh: Update script to prepare job for amd64 secure boot
    keys mismatch case
  scripts/submit_lava.sh: Remove passing readonly=on for amd64 OVMF VARS
    file
  .gitlab-ci.yml: Add job to verify amd64 secure boot keys mismatch case

 .gitlab-ci.yml         |  8 ++++++++
 scripts/submit_lava.sh | 16 +++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.39.2



