Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E7EC02196
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 15:26:02 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.21432.1738337157534066047
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jan 2025 07:25:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=YsP3Q71S;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20250131152555f6dc902eb78023d794-a9elyf@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250131152555f6dc902eb78023d794
        for <cip-dev@lists.cip-project.org>;
        Fri, 31 Jan 2025 16:25:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=kvBxFGNKavrI+wbyUNiG7zXSi5d1HhnJXlbwN9o04S8=;
 b=YsP3Q71S94xP0w0WsKXvEQn5fE/zSCCfdVK8xaey0WV+r40O74SEmRACpBWvxPB1Ow51/q
 n/WSqO28ICpvxaZclT5IpRi29wlZA4xfWD0FUse1dFpnj3EAJpWA5ImN72onPd4etEngyDJX
 KwqibatLYlKWFuQ8YEFJNxMpeUnqJoLZPa3RSlIeODQGUjEhBxUCj02I7gJ8xcs5/3us34Ly
 eWg3X9QHJDzZZV68haQVOEnFckKkSSSV1zRPHwyciM5t4KTVpGz49UUudD3yP+FIItglPn/V
 Vy8f9sWy7KHudra0eGOotSMxqP8hl5SZVfPZhixD3xkelH2kmLJSa6Xg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 4/4] .gitlab-ci.yml: Remove unused build jobs
Date: Fri, 31 Jan 2025 16:25:32 +0100
Message-ID: <20250131152553.270393-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
References: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 15:26:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17725

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

These jobs are not used for further testing. qemu-<arch>-base
builds similar targets as the used security extensions contains
secure boot and disk encryption.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 44 --------------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d7055f2..36f14db 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -221,28 +221,6 @@ build:qemu-arm-test:
     target:  qemu-arm
     extension: test
 
-# secure boot images
-build:qemu-amd64-secure-boot:
-  extends:
-    - .build_base
-  variables:
-    target: qemu-amd64
-    extension: ebg-secure-boot-snakeoil
-    use_rt: disable
-    targz: disable
-    deploy: disable
-
-build:qemu-amd64-secure-boot-encrypt:
-  extends:
-    - .build_base
-  variables:
-    target: qemu-amd64
-    extension: ebg-secure-boot-snakeoil
-    use_rt: disable
-    targz: disable
-    deploy: disable
-    encrypt: enable
-
 build:x86-uefi-secure-boot:
   extends:
     - .build_base
@@ -264,28 +242,6 @@ build:qemu-amd64-swupdate:
     targz: disable
     deploy: disable
 
-# secure boot images arm64
-build:qemu-arm64-secure-boot:
-  extends:
-    - .build_base
-  variables:
-    target: qemu-arm64
-    extension: ebg-secure-boot-snakeoil
-    use_rt: disable
-    targz: disable
-    deploy: disable
-
-# secure boot images arm
-build:qemu-arm-secure-boot:
-  extends:
-    - .build_base
-  variables:
-    target: qemu-arm
-    extension: ebg-secure-boot-snakeoil
-    use_rt: disable
-    targz: disable
-    deploy: disable
-
 # bullseye images
 build:iwg20m-bullseye:
   extends:
-- 
2.47.0


