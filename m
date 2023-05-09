Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D86EC7EE22
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 12:25:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.30746.1683635118642460007
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 May 2023 05:25:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 349CPGlH005610; Tue, 9 May 2023 21:25:17 +0900
X-Iguazu-Qid: 34trPsC3DTscnAqYjp
X-Iguazu-QSIG: v=2; s=0; t=1683635116; q=34trPsC3DTscnAqYjp; m=fiST5FO+IY2NAPOhV3T2OAw4XOZJGHcMO6wMj6aha6E=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 349CPFwx005820
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 9 May 2023 21:25:16 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v3] README_cip-core-version-release-policy.md : To define the versioning and release policy
Date: Tue,  9 May 2023 17:55:05 +0530
X-TSB-HOP2: ON
Message-Id: <20230509122505.3405-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 May 2023 12:25:08.0181 (UTC) FILETIME=[4ACA0850:01D98271]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 12:25:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11426

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

This document explains the versioning style used for isar-cip-core
metadata releases, frequency of the releases and their policies.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
Added original commit message and version to the patch.

 doc/README_cip-core-version-release-policy.md | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 doc/README_cip-core-version-release-policy.md

diff --git a/doc/README_cip-core-version-release-policy.md b/doc/README_cip-core-version-release-policy.md
new file mode 100644
index 0000000..6577df4
--- /dev/null
+++ b/doc/README_cip-core-version-release-policy.md
@@ -0,0 +1,31 @@
+# CIP metadata versioning and Release policy
+
+## Table of contents
+1. [Objective](#objective)
+2. [Versioning system](#versioningsystem)
+3. [Release policy](#releasepolicy)
+
+## Objective <a name="objective"></a>
+
+The primary objective is to document the release process, it’s frequency and version changing for isar-cip-core metadata. This metadata can be used by CIP users to create various flavors of images like **security-hardened image, testing image, partition-encrypted image** etc. in architectures like **x86_64, arm64, armhf, riscv64**.
+
+## Versioning system <a name="versioningsystem"></a>
+
+The isar-cip-core metadata follows semantic versioning system i.e **x.y.z** format which is explained below:
+
+1. **z** is incremented only when critical bugs are fixed.
+    * For example, if the latest release version is **2.2.5**, then the upcoming release version after fixing some critical bugs will be **2.2.6**.
+
+2. **y** is incremented for each Debian point release or in case of isar-cip-core regular release. When **y** is incremented, **z** is reset to 0.
+    * Let us assume that the latest release version is **2.1.1**, then the upcoming regular release version will be **2.2.0**.
+
+3. **x** is incremented when significant changes are done other than **y** and **z**.
+    * In cases where recipes are broken fundamentally, or support for an older Debian version is dropped then the value of x is incremented by 1.
+    * Let us assume that the latest release version is **1.0.1**. If changes similar to the one mentioned above are done, then the next release will be **2.0**. When **x** is incremented, **y** & **z** are reset to 0.
+
+## Release policy <a name="releasepolicy"></a>
+
+An approximate time gap of 3 months is taken between consecutive regular releases. During every release, CIP-Core plans to give out recipes (isar-cip-core metadata) using which the user can build the flavor of their choice.
+
+All the releases can be found [here](https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tags).
+
-- 
2.20.1



