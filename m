Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EC6CE7B00
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 06:44:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.8327.1695883481039303193
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Sep 2023 23:44:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38S6idjr2377412; Thu, 28 Sep 2023 15:44:39 +0900
X-Iguazu-Qid: 2yAbXiQ0szmMLd8UlN
X-Iguazu-QSIG: v=2; s=0; t=1695883479; q=2yAbXiQ0szmMLd8UlN; m=avg3z4lUnfrq0aGtdAFjGNhzRuCWaXaU+NJENNNwZSE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 38S6icdu629764
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 28 Sep 2023 15:44:38 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v4 0/2] Add dosfstools recipe
Date: Thu, 28 Sep 2023 12:14:35 +0530
X-TSB-HOP2: ON
Message-Id: <20230928064437.12654-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1788B037A0B186C6.25332@lists.cip-project.org>
References: <1788B037A0B186C6.25332@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Sep 2023 06:44:36.0308 (UTC) FILETIME=[3F1A2140:01D9F1D7]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Sep 2023 06:44:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13241

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

This patch series add recipe that build custom dosfstools and use it for
creating reproducible DOS images.

v4 changes:
  - dosfstools: Add recipe to build it locally
	(No change)
  - distro: Set dosfstools as build dependency
	Removed dependency for buster release

v3 changes:
  - dosfstools: Add recipe to build it locally
     (Remove dosfstools dependency from reproucible option)
  - distro: Set dosfstools as build dependency
     (new commit)

v2 changes:
  dosfstools: Add recipe to build it locally
     (modified from `dpkg-gbp` to `apt://`)
  images: Add dosfstools as DEPENDENCY to all images
     (new commit)

 conf/distro/cip-core-common.inc               |   3 +
 .../dosfstools/dosfstools_latest.bb           |  28 +++
 ...Honor-the-SOURCE_DATE_EPOCH-variable.patch | 160 ++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 recipes-devtools/dosfstools/dosfstools_latest.bb
 create mode 100644 recipes-devtools/dosfstools/files/0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch

-- 
2.20.1



