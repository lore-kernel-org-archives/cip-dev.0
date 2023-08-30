Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90131C83F19
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 04:41:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.7099.1693370481556347173
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Aug 2023 21:41:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 37U4fJZ83197203; Wed, 30 Aug 2023 13:41:19 +0900
X-Iguazu-Qid: 2rWgfb3IaxAz7QwyKA
X-Iguazu-QSIG: v=2; s=0; t=1693370478; q=2rWgfb3IaxAz7QwyKA; m=ksh/QZ6io6btJBbwNBoBFuqqNnm88jlW/e1abJDQYGw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 37U4fHj4554021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 30 Aug 2023 13:41:18 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/3] Enabling additional features in security image
Date: Wed, 30 Aug 2023 10:11:12 +0530
X-TSB-HOP2: ON
Message-Id: <20230830044115.1112349-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Aug 2023 04:41:16.0009 (UTC) FILETIME=[36335D90:01D9DAFC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 04:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12904

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

This series of patches enables additional IEC 62443-4-2 features  such as
data encryption, secureboot and swupdate features in the CIP security image.
This also fixes the CI failure while deploying the initrd in the base image.

Sai (3):
  Kconfig: Opt additional IEC 62443-4-2 features when security option is
    selected
  deploy-cip-core.sh: Workaround to search for swupdate initrd image
    name
  security.yml: Add additional features to security image

 Kconfig                    | 3 +++
 kas/opt/security.yml       | 3 +++
 scripts/deploy-cip-core.sh | 9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.30.2



