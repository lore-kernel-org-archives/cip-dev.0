Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA11C48BC3
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 12:28:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.40412.1707913696606244282
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 04:28:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 41ECSCOl2581022; Wed, 14 Feb 2024 21:28:14 +0900
X-Iguazu-Qid: 2rWgWcEMv09Llq2Im9
X-Iguazu-QSIG: v=2; s=0; t=1707913692; q=2rWgWcEMv09Llq2Im9; m=qPIzGKzW6oVOMWE3kL2Ddbax90BTPPzgOqMDcuu+69Q=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 41ECSBnr3970160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Feb 2024 21:28:12 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/2] Upload .swu file and firmware for LAVA testing
Date: Wed, 14 Feb 2024 17:58:07 +0530
X-TSB-HOP2: ON
Message-Id: <20240214122809.3541505-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Feb 2024 12:28:09.0880 (UTC) FILETIME=[452AD980:01DA5F41]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 12:28:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14964

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

This series of patches create v2 qemu security images and upload their .swu
artifacts to cip-core s3 bucket which are used in CIP LAVA software update
automation testing. U-boot firmware binaries are also uploaded which are used
to boot qemu arm64 and armhf security images for all software update, secure boot and
IEC layer automation testing in LAVA.

Sai Sathujoda (2):
  deploy-cip-core.sh: Upload only .swu file for v2 QEMU security targets
  .gitlab-ci.yml: Add v2 QEMU security targets for swupdate testing

 .gitlab-ci.yml             | 40 +++++++++++++++++++++++++++++++++++++-
 scripts/deploy-cip-core.sh | 12 +++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.30.2



