Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED95C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 13:58:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.14172.1708005522522622330
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 05:58:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 41FDwe3p2192416; Thu, 15 Feb 2024 22:58:40 +0900
X-Iguazu-Qid: 2yAacku12ZZrKZpbRA
X-Iguazu-QSIG: v=2; s=0; t=1708005520; q=2yAacku12ZZrKZpbRA; m=nP5o/ByH0wqm41o1zdCOMdRXlJvQg7ywiDXBz5hadnI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 41FDwd0c375540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 22:58:39 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v4 0/2] Upload .swu file from v2 QEMU security image
Date: Thu, 15 Feb 2024 19:28:35 +0530
X-TSB-HOP2: ON
Message-Id: <20240215135837.3557922-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Feb 2024 13:58:37.0819 (UTC) FILETIME=[12E25CB0:01DA6017]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 13:58:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14997

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

This series of patches performs a consecutive build to the QEMU security target
to deploy the .swu file of the 2nd build. We use that .swu artifact in the LAVA
software update automation testing. The deploy script is called 2 times during
the job in which the first call makes sure to deploy defined artifacts except
.swu file. While the second call makes sure to deploy only the .swu file of
the v2.0 image.

Sai Sathujoda (2):
  deploy-cip-core.sh: Deploy .swu only if "swu" is passed from
    .gitlab-ci.yml
  .gitlab-ci.yml: Add condition check in .build_base to build v2 image

 .gitlab-ci.yml             | 13 ++++++++++++-
 scripts/deploy-cip-core.sh | 16 ++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.30.2



