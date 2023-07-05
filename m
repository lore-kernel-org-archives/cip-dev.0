Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FE7EB64DD
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 07:34:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.11735.1688542451560389006
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 00:34:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3657Y9Uq2228957; Wed, 5 Jul 2023 16:34:09 +0900
X-Iguazu-Qid: 2rWhW3wiOAoUtIlh0D
X-Iguazu-QSIG: v=2; s=0; t=1688542449; q=2rWhW3wiOAoUtIlh0D; m=mX9FwIqXnkYKNXXZTfIAaV8xhvnFTqs+GleGRx1HwHU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 3657Y8CM1441248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 5 Jul 2023 16:34:09 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/2] Modifying security customizations due to deprecation of libpam-cracklib from bookworm
Date: Wed,  5 Jul 2023 13:03:56 +0530
X-TSB-HOP2: ON
Message-Id: <20230705073358.16663-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2023 07:34:00.0626 (UTC) FILETIME=[10DC6920:01D9AF13]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 07:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12228

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

When compared to previous version, this v2 series of patches has the correct order
of patches. An extra change to display the latest password at the image login is
also added in patch[1/2].

Sai (2):
  kas/opt/security.yml : Change password to fit pam_passwdqc policy
  cip-core-image-security.bb : Add pam-passwdqc package for bookworm

 kas/opt/security.yml                          |  2 +-
 .../images/cip-core-image-security.bb         |  9 ++++++---
 .../security-customizations/files/postinst    | 19 +++++++++++++++----
 3 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.20.1



