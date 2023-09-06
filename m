Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC0EB8FB3
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 04:56:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.1798.1693976209227570022
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 21:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3864ul982623412; Wed, 6 Sep 2023 13:56:47 +0900
X-Iguazu-Qid: 2rWgyA9oohD7W8F7m1
X-Iguazu-QSIG: v=2; s=0; t=1693976206; q=2rWgyA9oohD7W8F7m1; m=hSuTRnX1tjAcdfvyu4V6Aw/WqBpSO6NXIciac1LENaQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 3864uimT3853452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 6 Sep 2023 13:56:46 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/3] Enabling additional features in security image
Date: Wed,  6 Sep 2023 10:26:40 +0530
X-TSB-HOP2: ON
Message-Id: <20230906045643.2640096-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Sep 2023 04:56:43.0092 (UTC) FILETIME=[87AD4140:01D9E07E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 04:56:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12970

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

This series of patches enables additional IEC 62443-4-2 features  such as
data encryption, secureboot and swupdate features in the CIP security image.

This series also contains a patch which uploads only the disk image for the
targets including security extension.


Sai (3):
  Kconfig: Opt additional IEC 62443-4-2 features when security option is
    selected
  .gitlab-ci.yml: Added a new variable to control deployment
  security.yml: Add additional features to security image

 .gitlab-ci.yml             |  6 +++++-
 Kconfig                    |  3 +++
 kas/opt/security.yml       |  3 +++
 scripts/deploy-cip-core.sh | 31 +++++++++++++++++--------------
 4 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.30.2



