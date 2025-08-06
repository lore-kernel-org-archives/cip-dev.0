Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A433DC87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 07:27:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.19646.1754465221502381196
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 00:27:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=JxBQa2ov;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1754465220;x=1755674820;bh=bTfe2lz90w3vlDeNfP8hemMJDVqyfvAXcdPEqNwFh9k=;b=JxB
	Qa2ovjOR/6flH3mvv4/aWxi3d/52MwO2GZm0K4hJa4ZFRVBTYeJ7bWGa/RdQN5TYzYw+MXlsc8azP
	hDB2lIKRD+cByT07m4G3rp0Xw9AQgfqOxqOvQlMX1H05BsW1bpgs8fQoOO2+THra9uqUkcpQz+usl
	CaSWJhKLnGMkL9QV55A1fOvmJkF04ZUFhePzxfzov3fyVmkzBC1sGhSxn3U2rMnKin+b8vZHaGJhh
	sECQ+7RUTzpvH6I81Gjj8RPV4HxkWuizNaiPvqNasUKxntPGxqjBRdW/ldAerMHKRaJDPm9ZlzSll
	5RHi8Gfg7p8c8T/pHQZbiOqdSGQnMng==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5767QxOd3943169; Wed, 6 Aug 2025 16:27:00 +0900
X-Iguazu-Qid: 2rWhiV7hVZTh7dyZMs
X-Iguazu-QSIG: v=2; s=0; t=1754465218; q=2rWhiV7hVZTh7dyZMs; m=0oO5w5NgQMsOUxqhqsLQ0K+MXqY6smr4RSv/Ju7cPNc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 5767Qwls1690439
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 16:26:58 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH] .gitlab-ci.yml: Set 'release: trixie' to build:qemu-riscv64-test-nokernel pipeline
Date: Wed,  6 Aug 2025 16:26:55 +0900
X-TSB-HOP2: ON
Message-Id: <1754465215-9240-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 07:27:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19691

The riscv64 image can be built from 'trixie'. Therefore, set 'release: trixie'
in the build:qemu-riscv64-test-nokernel pipeline.

Fixes: 82dc61a44708 ("kas/opt: Add option for not install kernel"
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a494911..428f479 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -260,6 +260,7 @@ build:qemu-riscv64-test-nokernel:
     - .build_base
   variables:
     target:  qemu-riscv64
+    release: trixie
     extension: test
     no_kernel: enable
 
-- 
2.50.0



