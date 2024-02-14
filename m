Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F24C48BC1
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 15:34:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.43782.1707924848720382787
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 07:34:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 41EFY6qI2753987; Thu, 15 Feb 2024 00:34:06 +0900
X-Iguazu-Qid: 2rWgWcEMv0MxBS9rDk
X-Iguazu-QSIG: v=2; s=0; t=1707924846; q=2rWgWcEMv0MxBS9rDk; m=tK5A8WR1Kt8C0Bg5tuoLvd4A86mYiu50aic3YW7G2ZI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 41EFY5Zk4053241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 00:34:06 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/2] Upload .swu file and firmware for LAVA testing
Date: Wed, 14 Feb 2024 21:03:39 +0530
X-TSB-HOP2: ON
Message-Id: <20240214153341.3543690-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Feb 2024 15:33:41.0201 (UTC) FILETIME=[2FF3A410:01DA5F5B]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 15:34:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14976

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

This series of patches create v2 qemu security images and upload their .swu
artifacts to cip-core s3 bucket which are used in CIP LAVA software update
automation testing.
--
Changes:
1. Uploaded firmware after checking their existence in working tree.
2. Added consecutive build in a single job to re-use v1 artifacts.

Sai Sathujoda (2):
  deploy-cip-core.sh: Upload only .swu file for v2 QEMU security targets
  .gitlab-ci.yml: Add condition check in .build_base to build v2 image

 .gitlab-ci.yml             |  7 +++++++
 scripts/deploy-cip-core.sh | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.30.2



