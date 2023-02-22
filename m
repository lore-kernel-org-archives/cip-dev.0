Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9392C64EC4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 09:11:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.4640.1677057087676034220
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 01:11:28 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 31M9BPHs017518; Wed, 22 Feb 2023 18:11:25 +0900
X-Iguazu-Qid: 34trPsC3BOU2xAv5Sr
X-Iguazu-QSIG: v=2; s=0; t=1677057085; q=34trPsC3BOU2xAv5Sr; m=A/KOROJ9h8QIP806k52oiCy/AtFl8mugK51ulUJHBNY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 31M9BOHA013766
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 18:11:25 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/2] ci for reproducible build check
Date: Wed, 22 Feb 2023 14:41:57 +0530
X-TSB-HOP2: ON
Message-Id: <20230222091159.18216-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Feb 2023 09:11:23.0057 (UTC) FILETIME=[A247E210:01D9469D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 09:11:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10773

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

The following patches add reproducible build check in ci.

Please review and provide your feedback.

venkata pyla (2):
  kas/opt/reproducible.yml: Add kas file for reproducible builds target
  .reproducible-check-ci.yml: Add ci for reproducible build checks

 .gitlab-ci.yml             |  5 +++
 .reproducible-check-ci.yml | 91 ++++++++++++++++++++++++++++++++++++++
 kas/opt/reproducible.yml   | 17 +++++++
 3 files changed, 113 insertions(+)
 create mode 100644 .reproducible-check-ci.yml
 create mode 100644 kas/opt/reproducible.yml

-- 
2.20.1



