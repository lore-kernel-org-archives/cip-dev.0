Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C67C25B5E
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 11:51:30 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.14901.1714045884031289739
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 04:51:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=SPsrZZyh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240425115122c0dcf936a4c23cd21e-vj_ud_@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240425115122c0dcf936a4c23cd21e
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Apr 2024 13:51:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wPdEsy+RHXV4s6BGhtUdmK9gYW1y2CD4292j3IfUK5o=;
 b=SPsrZZyhkTDlfdK6dC5bsLw3t95WH5P5xRE1VuFs46Gb6ydPWKuXTWbidWFBbIiY48cfMK
 LeiRXLU4fqciFgXkAVw6hkqZ5tkHluM194QvUC5ETuNdA59UXh+nnQMm/jr0tWLLWMhqQQu0
 +qlwT36/GWHYH3bGCR/GyBaTeqLIs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 5/9] Rename encrypt-partitions to encrypt-data
Date: Thu, 25 Apr 2024 13:50:33 +0200
Message-ID: <20240425115119.813384-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
References: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15752

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This makes the purpose of this option more clear.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                                       | 2 +-
 Kconfig                                              | 2 +-
 doc/README.tpm2.encryption.md                        | 2 +-
 kas/opt/{encrypt-partitions.yml => encrypt-data.yml} | 0
 kas/opt/security.yml                                 | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename kas/opt/{encrypt-partitions.yml => encrypt-data.yml} (100%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bd34c82..aab55be 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -64,7 +64,7 @@ default:
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
     - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
-    - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
+    - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
     - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
diff --git a/Kconfig b/Kconfig
index 7c19640..9478a06 100644
--- a/Kconfig
+++ b/Kconfig
@@ -211,6 +211,6 @@ config IMAGE_DATA_ENCRYPTION
 
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
-	default "kas/opt/encrypt-partitions.yml" if IMAGE_DATA_ENCRYPTION
+	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
 
 endif
diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 69a18dd..c5ac6c4 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -27,7 +27,7 @@ An example for qemu-amd64 can be build with by selecting the option after callin
 or by adding using the following command line build:
 
 ```
-./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/encrypt-partitions.yml
+./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/encrypt-data.yml
 ```
 ## initramfs-crypt-hook configuration
 
diff --git a/kas/opt/encrypt-partitions.yml b/kas/opt/encrypt-data.yml
similarity index 100%
rename from kas/opt/encrypt-partitions.yml
rename to kas/opt/encrypt-data.yml
diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 000c522..4aa40e0 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -11,7 +11,7 @@
 header:
   version: 14
   includes:
-   - kas/opt/encrypt-partitions.yml
+   - kas/opt/encrypt-data.yml
    - kas/opt/ebg-secure-boot-snakeoil.yml
 
 target: cip-core-image-security
-- 
2.43.0


