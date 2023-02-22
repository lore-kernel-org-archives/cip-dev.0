Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EABC6379F
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 11:43:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web11.6707.1677066217520997422
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 03:43:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.133, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 31MBhYol019771; Wed, 22 Feb 2023 20:43:35 +0900
X-Iguazu-Qid: 2wHHFCEuxdc7TJH4Xh
X-Iguazu-QSIG: v=2; s=0; t=1677066214; q=2wHHFCEuxdc7TJH4Xh; m=SwVDUGOojmP1kQaODaZCj4y/1hfsbQG7EU0+WrJTqq0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 31MBhX8o016207
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 20:43:34 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 0/2] ci for reproducible build check
Date: Wed, 22 Feb 2023 17:14:06 +0530
X-TSB-HOP2: ON
Message-Id: <20230222114408.32155-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
References: <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Feb 2023 11:43:31.0856 (UTC) FILETIME=[E3781100:01D946B2]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 11:43:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10778

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

The following patches add reproducible build check in ci.

Please review and provide your feedback

v3:
 - use immediate assignment for variable SOURCE_DATE_EPOCH

v2:
 - split gitlab-ci and add reproducible check ci jobs to another file
   '.reproducible-check-ci.yml'

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



