Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C1ECA0FE9
	for <webhook@archiver.kernel.org>; Fri,  1 Sep 2023 08:19:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.1815.1693556391529853680
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Sep 2023 01:19:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3818JlqL3026394; Fri, 1 Sep 2023 17:19:48 +0900
X-Iguazu-Qid: 2rWgoVec2GfYTQfmlm
X-Iguazu-QSIG: v=2; s=0; t=1693556387; q=2rWgoVec2GfYTQfmlm; m=4WwvCbirsHXVLzgfhulVf+4wa7nyXO96CX+s4kDn6XM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 3818JjcU1075786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 1 Sep 2023 17:19:46 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/2] README_version-release-policy.md: Add product description details
Date: Fri,  1 Sep 2023 13:49:43 +0530
X-TSB-HOP2: ON
Message-Id: <20230901081943.1816811-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230901081943.1816811-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230901081943.1816811-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Sep 2023 08:19:43.0311 (UTC) FILETIME=[0F966DF0:01D9DCAD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Sep 2023 08:19:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12932

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

The Debian releases, Kernel versions and image features supported
for repsective isar-cip-core release information is added.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 doc/README_version-release-policy.md | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/README_version-release-policy.md b/doc/README_version-release-policy.md
index 918e77a..f8dde38 100644
--- a/doc/README_version-release-policy.md
+++ b/doc/README_version-release-policy.md
@@ -4,6 +4,7 @@
 1. [Objective](#objective)
 2. [Versioning system](#versioningsystem)
 3. [Release policy](#releasepolicy)
+4. [Product Description for metadata release](#productdescription)
 
 ## Objective <a name="objective"></a>
 
@@ -28,3 +29,10 @@ The isar-cip-core metadata follows semantic versioning system i.e **x.y.z** form
 An approximate time gap of 3 months is taken between consecutive regular releases. During every release, CIP-Core plans to give out recipes (isar-cip-core metadata) using which the user can build the flavor of their choice.
 
 All the releases can be found [here](https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tags).
+
+## Product Description for metadata release <a name="productdescription></a>"
+
+| **Metadata version** | **Supported Debian versions**   | **Supported Kernel versions**                | **Features**                      |
+| -------------------- | --------------------------------| ---------------------------------------------| --------------------------------- |
+| v1.0                 |  Buster <br> Bullseye               |   4.4.x-cip <br> 4.19.x-cip <br> 5.10.x-cip <br> 6.1.x-mainline  | Flashable image <br> Security extensions <br> Testing extensions <br> SWupdate support for root partition <br> Secure boot <br> Encryption of data partitions  |
+| v1.1                 |  Buster <br> Bullseye <br> Bookworm | 4.4.x-cip <br> 4.19.x-cip <br> 5.10.x-cip <br> 6.1.x-cip | Flashable image <br> Security extensions <br> Testing extensions <br> SWupdate support for root partition <br> Secure boot <br> Encryption of data partitions  |
-- 
2.30.2



