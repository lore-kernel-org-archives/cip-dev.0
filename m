Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B9FCA0FE6
	for <webhook@archiver.kernel.org>; Fri,  1 Sep 2023 08:19:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.1816.1693556391572866694
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Sep 2023 01:19:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3818Jl9o3026390; Fri, 1 Sep 2023 17:19:48 +0900
X-Iguazu-Qid: 2rWgyA9ooYx6m4XOcr
X-Iguazu-QSIG: v=2; s=0; t=1693556387; q=2rWgyA9ooYx6m4XOcr; m=NN6jEh+EgwiFCIM6sZ0jEMUDMojaHMZer42LGIBKKMw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 3818Jj4p1130741
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 1 Sep 2023 17:19:46 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/2] README_version-release-policy.md: Rectify "y" incremental details in metadata version
Date: Fri,  1 Sep 2023 13:49:42 +0530
X-TSB-HOP2: ON
Message-Id: <20230901081943.1816811-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Sep 2023 08:19:43.0217 (UTC) FILETIME=[0F881610:01D9DCAD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Sep 2023 08:19:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12933

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

isar-cip-core regular releases are not triggered by Debian point releases. Details
regarding what the regular releases consist of are also added.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 doc/README_version-release-policy.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/README_version-release-policy.md b/doc/README_version-release-policy.md
index b0b8591..918e77a 100644
--- a/doc/README_version-release-policy.md
+++ b/doc/README_version-release-policy.md
@@ -16,7 +16,7 @@ The isar-cip-core metadata follows semantic versioning system i.e **x.y.z** form
 1. **z** is incremented only when critical bugs are fixed. If **z** is zero, it will be left out.
     * For example, if the latest release version is **2.2.5**, then the upcoming release version after fixing some critical bugs will be **2.2.6**.
 
-2. **y** is incremented for each Debian point release or in case of isar-cip-core regular release. When **y** is incremented, **z** is reset to 0.
+2. **y** is incremented in case of isar-cip-core regular release. When **y** is incremented, **z** is reset to 0. Regular releases include modifications in recipes, addition of new features, bringing changes when updates are announced in CIP Kernel and Debian releases.
     * Let us assume that the latest release version is **2.1.1**, then the upcoming regular release version will be **2.2**.
 
 3. **x** is incremented when significant changes are done other than **y** and **z**.
-- 
2.30.2



