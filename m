Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22545C87FDA
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 02:46:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.42099.1754534757082842244
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 19:45:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=hzGqM97i;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1754534755;x=1755744355;bh=JQo4
	NBPGj/ZR+LGvZyR2iZYjRG8qyAHeKMzDM/aQjC8=;b=hzGqM97iFD4dG3Eefs12U8Hf8r4sBOqZ+C
	35gqDfoU842XKBT4QVDBtc/LreI1iTgIxU4zIl3eGaktwiWt0/rerjZ2m7yXu5PkWMT8VyTcpJ1oU
	2TB3VU+Ei+KZazUIiMoDlVtohnuZfsIdsAq5CirJ0Nx2jkhehH22WUlz5c3Ehl8om0/pnm1Qj3UFx
	3lGB9fViey71V/I3xOfJkOuzpJVdm0N7RBwhNF1fpfPqqU3+AJ21UzEjNHFtOaEkMNK2YGSAv8Flk
	PK518+lXrEQ0YMJPMixwvdYawgR+HLINU6PwVyMgpFUz5ue47hJ2HwMxFZ/Wk5BD5/Qcci/Q5qacQ
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5772jsE8761421; Thu, 7 Aug 2025 11:45:55 +0900
X-Iguazu-Qid: 2rWhiV7hVaqV6mK2J0
X-Iguazu-QSIG: v=2; s=0; t=1754534754; q=2rWhiV7hVaqV6mK2J0; m=4/BmWOW3LoSelqmBMs3OQz6R+A38r7QMzk/I0zzsQoI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 5772jqBA108870
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 11:45:53 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH v5 3/3] .gitlab-ci.yml: Drop build:qemu-*-test
Date: Thu,  7 Aug 2025 11:45:49 +0900
X-TSB-HOP2: ON
Message-Id: <1754534749-19754-3-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1754534749-19754-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1754534749-19754-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Aug 2025 02:46:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19700

The image for kernel testing is created with build:qemu-*-test-nokernel.
Therefore, build:qemu-*-test for the duplicate image creation pipelines
are unnecessary. This drops build:qemu-*-test pipelines.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---

v5:
  new commit.

 .gitlab-ci.yml | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3a4ba73..d1b21f5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -210,27 +210,6 @@ build:hihope-rzg2m-test:
     extension: test
     dtb: r8a774a1-hihope-rzg2m-ex.dtb
 
-build:qemu-amd64-test:
-  extends:
-    - .build_base
-  variables:
-    target:  qemu-amd64
-    extension: test
-
-build:qemu-arm64-test:
-  extends:
-    - .build_base
-  variables:
-    target:  qemu-arm64
-    extension: test
-
-build:qemu-arm-test:
-  extends:
-    - .build_base
-  variables:
-    target:  qemu-arm
-    extension: test
-
 build:qemu-amd64-test-nokernel:
   extends:
     - .build_base
-- 
2.50.0



