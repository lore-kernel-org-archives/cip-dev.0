Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810C4C87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 07:17:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.19509.1754464613614489362
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 00:16:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=vDHL0eKD;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1754464612;x=1755674212;bh=4Ch074LlTg3QPjT2mCuyEFv3qE8EtWsi99AT5k72kHE=;b=vDH
	L0eKDVmvc1sLWpBPqhiy4HO7gyesci/Okua38tKWsnSO0D296S6YI+TmAC1tKU8sXeFFvlmwzRU86
	idltTnKnSzPC1KdO0IOjfyxMPxOpsvbevE2qp+qpm14YJssyXwyeqGE5gsR3WXcDvXMwiOmaKNPr7
	KLVvGT0q/AzlEQwz7blmuNFFOLJ8Posbtk0yEn90zfcK9z7s+4Z5NCTL09EOOHVg+y9jc7eSL9xtP
	lsV46bsH22bStKmb/If9KAA7669fJbFF37Np+qFZhY0W3xQrToDoJqb3nGyZZ00+4UBvFe0HH6Xl5
	e8QDxXwOsHvdCnfp4nUEVVliQCCNAig==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 5767GqLa1680409; Wed, 6 Aug 2025 16:16:52 +0900
X-Iguazu-Qid: 2yAbyr8Usn7dWuS1jv
X-Iguazu-QSIG: v=2; s=0; t=1754464611; q=2yAbyr8Usn7dWuS1jv; m=aXNTSEz1fQsfueXjEYxOoZ2WYO5HYTtqfnj5FHgqgz0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 5767GpWZ2331125
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 16:16:51 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH] .gitlab-ci.yml: Add ${no_kernel} to deploy-cip-core.sh when building swu
Date: Wed,  6 Aug 2025 16:11:35 +0900
X-TSB-HOP2: ON
Message-Id: <1754464295-8426-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 07:17:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19688

CI fails because ${no_kernel} is missing from deploy-cip-core.sh when
building swu. Add ${no_kernel} to the arguments of deploy-cip-core.sh
to fix this issue.

Fixes: 228a7b17903c ("kas/opt: Add option for not install kernel")
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 496a56d..a494911 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -83,7 +83,7 @@ default:
           fi;
           echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb;
           kas build ${base_yaml}:kas/opt/delta-update.yml;
-          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
       fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
-- 
2.50.0



