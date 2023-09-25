Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DF4CE7AA5
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 16:58:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.66331.1695661118179289853
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Sep 2023 09:58:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 38PGwaG94000753; Tue, 26 Sep 2023 01:58:36 +0900
X-Iguazu-Qid: 2rWgJRkMWWH76r3ZNh
X-Iguazu-QSIG: v=2; s=0; t=1695661115; q=2rWgJRkMWWH76r3ZNh; m=jV6lYwdJgER5TfxkijomcXfpC2gia80nju5Eb8L8Qqo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 38PGwYSw4010749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Sep 2023 01:58:35 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/2] Add dosfstools recipe
Date: Mon, 25 Sep 2023 22:28:31 +0530
X-TSB-HOP2: ON
Message-Id: <20230925165833.2696-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
References: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 25 Sep 2023 16:58:32.0529 (UTC) FILETIME=[83F62410:01D9EFD1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Sep 2023 16:58:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13219

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi Jan,

I modified the commits as per your feedback comments in v1, also added
new commit to add `dosfstools` as a dependency to all images, is that
what expecting?

v2:
  dosfstools: Add recipe to build it locally
     (modified from `dpkg-gbp` to `apt://`)
  images: Add dosfstools as DEPENDENCY to all images
     (new commit)

Kindly provide your feedback.

 kas/opt/reproducible.yml                      |   1 +
 .../images/cip-core-image-kernelci.bb         |   1 +
 .../images/cip-core-image-security.bb         |   1 +
 recipes-core/images/cip-core-image.bb         |   1 +
 recipes-core/images/common-image.inc          |  13 ++
 .../dosfstools/dosfstools_latest.bb           |  28 +++
 ...Honor-the-SOURCE_DATE_EPOCH-variable.patch | 160 ++++++++++++++++++
 7 files changed, 205 insertions(+)
 create mode 100644 recipes-core/images/common-image.inc
 create mode 100644 recipes-devtools/dosfstools/dosfstools_latest.bb
 create mode 100644 recipes-devtools/dosfstools/files/0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch

-- 
2.20.1



