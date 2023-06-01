Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC4DC7EE29
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 07:35:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.25681.1685604901331585200
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 00:35:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 3517Ywog024886; Thu, 1 Jun 2023 16:34:59 +0900
X-Iguazu-Qid: 34ts1GHAeQ2Prz0lO7
X-Iguazu-QSIG: v=2; s=0; t=1685604898; q=34ts1GHAeQ2Prz0lO7; m=yEAyPtcsaN3AhH3pau4nhXJYkoQrzqw7di8Lr5v5yOI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 3517YvaL028069
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Jun 2023 16:34:58 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/3] Add ext4-fs image in reproducible checks
Date: Thu,  1 Jun 2023 13:04:51 +0530
X-TSB-HOP2: ON
Message-Id: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Jun 2023 07:34:55.0634 (UTC) FILETIME=[8F9A7720:01D9945B]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 07:35:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11716

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

This patch series enable ext4 file system images in reproducible check CI,
which is next step after tarball images are being reproducible, let's
see new issues in CI after integrating this patch and continue to fix
them.

Please provide your inputs.

Thanks,


venkata pyla (3):
  kas/opt/ext4-targz-img: option file to create ext4 and tar ball images
  .reproducible-check-ci.yml: use ext4 images in reproducible build
    checks
  scripts/repro-tests.sh: enable html output in diffoscope

 .reproducible-check-ci.yml |  9 ++++++++-
 kas/opt/ext4-targz-img.yml | 19 +++++++++++++++++++
 scripts/repro-tests.sh     |  4 +++-
 3 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 kas/opt/ext4-targz-img.yml

-- 
2.20.1



