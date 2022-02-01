Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA39C433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 15:40:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web08.49812.1643730014414386295
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 07:40:15 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 211FeC4a017171;
 Wed, 2 Feb 2022 00:40:12 +0900
X-Iguazu-Qid: 34tKV35Me63Sjmekds
X-Iguazu-QSIG: v=2; s=0; t=1643730011; q=34tKV35Me63Sjmekds;
 m=Gx6SkQujVQeix7urW9bLQtKHSog1i7hJeckL/eF+X8k=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1510) id 211FeAIk014055
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 2 Feb 2022 00:40:11 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        quirin.gylstorff@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        akihiro27.suzuki@toshiba.co.jp
Subject: [isar-cip-core v2 0/2] Add necessary steps to verify swupdate 
Date: Tue,  1 Feb 2022 21:05:00 +0530
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-Id: <20220201153502.14230-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
References: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Feb 2022 15:39:54.0402 (UTC)
 FILETIME=[F5795820:01D81781]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 15:40:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7558

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

The current isar-cip-core provides verification of successful swupdate
but lacks the recipe to verify swupdate-rollback feature, the below
patches provides the necessary script to verify swupdate-rollback. 

Shivanand Kunijadar (2):
  Add recipe to cause kernel panic during system boot
  README.swupdate.md: add readme file with steps to verify swupdate

 doc/README.swupdate.md                        | 208 ++++++++++++++++++
 kas/opt/kernel-panic.yml                      |  18 ++
 .../kernel-panic/files/sysrq-panic.service    |  10 +
 recipes-core/kernel-panic/kernel-panic.bb     |  24 ++
 4 files changed, 260 insertions(+)
 create mode 100644 doc/README.swupdate.md
 create mode 100644 kas/opt/kernel-panic.yml
 create mode 100644 recipes-core/kernel-panic/files/sysrq-panic.service
 create mode 100644 recipes-core/kernel-panic/kernel-panic.bb

-- 
2.20.1



