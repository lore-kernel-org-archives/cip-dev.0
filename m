Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EB8E7E653
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 16:40:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.24061.1695746425694761375
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Sep 2023 09:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38QGeNDf1802176; Wed, 27 Sep 2023 01:40:24 +0900
X-Iguazu-Qid: 2yAaEO0US2na3Qr3OC
X-Iguazu-QSIG: v=2; s=0; t=1695746423; q=2yAaEO0US2na3Qr3OC; m=wdy38m17WFwEyfxrx7Ww4x0jfGdKHSb92kk5f7XUJp8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 38QGeMpm1492082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 27 Sep 2023 01:40:23 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 0/2] Add dosfstools recipe
Date: Tue, 26 Sep 2023 22:10:19 +0530
X-TSB-HOP2: ON
Message-Id: <20230926164021.30185-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <e9aeb66d-91f3-40a3-8b5c-44b75bec3544@siemens.com>
References: <e9aeb66d-91f3-40a3-8b5c-44b75bec3544@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Sep 2023 16:40:20.0626 (UTC) FILETIME=[238CB720:01D9F098]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Sep 2023 16:40:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13231

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

This patch series add recipe that build custom dosfstools and use it for
creating reproducible DOS images.

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

 conf/distro/cip-core-common.inc               |   1 +
 .../dosfstools/dosfstools_latest.bb           |  28 +++
 ...Honor-the-SOURCE_DATE_EPOCH-variable.patch | 160 ++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 recipes-devtools/dosfstools/dosfstools_latest.bb
 create mode 100644 recipes-devtools/dosfstools/files/0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch

-- 
2.20.1



