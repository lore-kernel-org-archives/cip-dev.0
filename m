Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A1C61DD2
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 06:23:06 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30126.1787811781931936004
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 23:23:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=lXi+wK7f;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20260827062259e440bb2294000207fc-pkmmyf@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260827062259e440bb2294000207fc
        for <cip-dev@lists.cip-project.org>;
        Thu, 27 Aug 2026 08:22:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/CKpVWL6xFI9nehVxp8oYPbMyLSBnD1uUhrhlkJftVg=;
 b=lXi+wK7fgNMlnrRd41KS2lLaW8QfdMDIAbyTaYnILjzDpY0IzymE1iGeZfEMCjqWzE7ysd
 Zg6+B85G875pPMzm6dASrR20vcslPh4jG2L23VKgHzK1pDpnbKtO1q3ox8KYCzxgZdtSVCrm
 lDRJ4IqiwZSwqDIXatOJGD5i4azT4S6zdXFLXn3hLJQ0sBV2zr2k1Bprv7+YWZXovogcWOeG
 WiX9Aym1wUzhvssKl6eXHBNzO6ezBK6d92kjCGpgCeHqn458iqw1yUmCaVy9AJ8GHWOGLA1X
 OyB2zld8buhuk277N/w2PdMOh+PEspJAS1tKavk00nRk4TF4uSHXERdQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Michael Adler <michael.adler@siemens.com>
Subject: [isar-cip-core][PATCH v3 3/5] switch to isar-rootless
Date: Thu, 27 Aug 2026 08:22:55 +0200
Message-ID: <f2c31a72ff6e97696af43e19783d02d9cd0f0292.1787811777.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787811777.git.jan.kiszka@siemens.com>
References: <cover.1787811777.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Aug 2026 06:23:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24037

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .reproducible-check-ci.yml | 3 +--
 Kconfig                    | 2 +-
 kas-cip.yml                | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 1246a641..4f4649ee 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -39,8 +39,7 @@
     # Deploy .wic, .swu and wic partitions for build1
     - deploy_rb_artifacts build1
     # clean
-    - sudo rm -rf build/tmp
-    - sudo rm -rf build/sstate-cache
+    - kas purge --isar-rootless ${base_yaml}
     # Build 2nd time
     - !reference [.build_base, script]
     # Deploy .wic, .swu and wic partitions for build2
diff --git a/Kconfig b/Kconfig
index 3a9444db..7575d89c 100644
--- a/Kconfig
+++ b/Kconfig
@@ -17,7 +17,7 @@ config KAS_INCLUDE_MAIN
 
 config KAS_BUILD_SYSTEM
 	string
-	default "isar-privileged"
+	default "isar-rootless"
 
 config ARCH_AMD64
 	bool
diff --git a/kas-cip.yml b/kas-cip.yml
index 61cc9225..43aeb2d6 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -15,7 +15,7 @@ header:
 distro: cip-core-trixie
 target: cip-core-image
 
-build_system: isar-privileged
+build_system: isar-rootless
 
 repos:
   cip-core:
-- 
2.47.3


