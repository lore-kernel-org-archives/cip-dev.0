Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCD4C48BC1
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 15:48:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.44692.1707925705240679169
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 07:48:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 41EFmNl72060892; Thu, 15 Feb 2024 00:48:23 +0900
X-Iguazu-Qid: 2yAamVQ9SIbCtqSy4O
X-Iguazu-QSIG: v=2; s=0; t=1707925703; q=2yAamVQ9SIbCtqSy4O; m=No7YqC7CiPQyaD6zC9e32xSChaK7fwA072e1woBCD2s=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 41EFmMUr3158658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 00:48:22 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 0/2] Upload .swu file and firmware for LAVA testing
Date: Wed, 14 Feb 2024 21:18:18 +0530
X-TSB-HOP2: ON
Message-Id: <20240214154820.3544080-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Feb 2024 15:48:20.0352 (UTC) FILETIME=[3BF77000:01DA5F5D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 15:48:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14980

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

This series of patches create v2 qemu security images and upload their .swu
artifacts to cip-core s3 bucket which are used in CIP LAVA software update
automation testing.
--
Major changes:
1. Uploaded firmware after checking their existence in working tree.
2. Added consecutive build in a single job to re-use v1 artifacts.
3. Add a variable to decide whether to build a v2 image for .swu for base targets.

Sai Sathujoda (2):
  deploy-cip-core.sh: Upload only .swu file for v2 QEMU security targets
  .gitlab-ci.yml: Add condition check in .build_base to build v2 image

 .gitlab-ci.yml             | 10 ++++++++++
 scripts/deploy-cip-core.sh | 13 ++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.30.2



