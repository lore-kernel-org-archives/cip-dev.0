Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A24EC8724
	for <webhook@archiver.kernel.org>; Thu,  7 Sep 2023 12:52:20 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web11.12090.1694091130767668522
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Sep 2023 05:52:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-CSE-ConnectionGUID: W7TEsi0ITwGxdovh+Q/PgQ==
X-CSE-MsgGUID: HalL/tifSYebYhOCASheRw==
X-IronPort-AV: E=Sophos;i="6.02,235,1688457600"; 
   d="scan'208";a="16325442"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 07 Sep 2023 04:52:09 -0800
IronPort-SDR: RWLcCXerD5M9hdOYVp+DyKtrRHNdxN6+qjwKYABc76DVG2janCWHyJjYHHI9d6kDzQUKAA2bAR
 wE5XE+iq7rvpw4P+xVgkzPtHDtOWhA4t3pJU/EIrEhG7yD5xbBIj2SV9145UQ6GZnbTVHjtd82
 EfG44MrZh1JE+eLh/AS21PWRaOSB3MxlAPuCk/KoX4SVk3lUs9jJqSr/8Z0P66I4TsZr17AOot
 rtTcWZfxbAdUG75blRjBfeOaqYmw941KjLMsj5bDIPh1UJFSbdTWaK8f0ihDeGUQcAZbyd2d67
 noY=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [PATCH][isar-cip-core] secure-boot-secrets/files: remove unwanted link files
Date: Thu, 7 Sep 2023 18:21:48 +0530
Message-ID: <20230907125148.10628-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-11.mgc.mentorg.com (147.34.90.211) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Sep 2023 12:52:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13002

From: Srinuvasan A <srinuvasan.a@siemens.com>

We have soft link for all the codename to fetch the keys, observed some
unwanted link file available in buster folder, hence remove them.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 recipes-devtools/secure-boot-secrets/files/buster/bookworm | 1 -
 recipes-devtools/secure-boot-secrets/files/buster/bullseye | 1 -
 2 files changed, 2 deletions(-)
 delete mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bookworm
 delete mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bullseye

diff --git a/recipes-devtools/secure-boot-secrets/files/buster/bookworm b/recipes-devtools/secure-boot-secrets/files/buster/bookworm
deleted file mode 120000
index b7dbeb4..0000000
--- a/recipes-devtools/secure-boot-secrets/files/buster/bookworm
+++ /dev/null
@@ -1 +0,0 @@
-../../secure-boot-secrets/files/bookworm
\ No newline at end of file
diff --git a/recipes-devtools/secure-boot-secrets/files/buster/bullseye b/recipes-devtools/secure-boot-secrets/files/buster/bullseye
deleted file mode 120000
index 3c7fe4f..0000000
--- a/recipes-devtools/secure-boot-secrets/files/buster/bullseye
+++ /dev/null
@@ -1 +0,0 @@
-../../secure-boot-secrets/files/bullseye
\ No newline at end of file
-- 
2.34.1


