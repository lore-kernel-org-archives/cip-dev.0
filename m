Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B27C61DA3
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 15:41:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web10.45104.1676994068842031254
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 07:41:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.133, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 31LFf5nW030450; Wed, 22 Feb 2023 00:41:06 +0900
X-Iguazu-Qid: 2wHH8MjPYOeYPpeao7
X-Iguazu-QSIG: v=2; s=0; t=1676994065; q=2wHH8MjPYOeYPpeao7; m=FXOg7ArlYgqXORpRrQHDtddxzH6+BM+kBH2DcPvPHmE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 31LFf4SN039147
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 00:41:05 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/2] CI for reproducible build check
Date: Tue, 21 Feb 2023 21:11:36 +0530
X-TSB-HOP2: ON
Message-Id: <20230221154138.15146-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Feb 2023 15:41:01.0801 (UTC) FILETIME=[E6AF5D90:01D9460A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 15:41:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10759

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

The following patches add reproducible build check support in CI.

The reproducible check is added only for scheduled CI's in order to reduce
burden on regular commit pushes and monitor only reproducible checks on
specified intervals like bi-weekly or monthly.

A kas file (reproducible.yml) is added for sending "SOURCE_DATE_EPOCH"
value to build environment which will be used in artifacts to have
deterministic timestamps and etc.


venkata pyla (2):
  kas/opt/reproducible.yml: Add kas file for reproducible builds target
  .gitlab-ci.yml: Add ci for reproducible build checks

 .gitlab-ci.yml           | 134 +++++++++++++++++++++++++++++++++++++++
 kas/opt/reproducible.yml |  17 +++++
 2 files changed, 151 insertions(+)
 create mode 100644 kas/opt/reproducible.yml

-- 
2.20.1



