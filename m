Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF2C433EF
	for <webhook@archiver.kernel.org>; Fri, 22 Oct 2021 17:40:52 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.782.1634924450638543919
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Oct 2021 10:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 19MHelnF023449
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 22 Oct 2021 19:40:47 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.72.144])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19MHelRF014474;
	Fri, 22 Oct 2021 19:40:47 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] Update to kas 2.6
Date: Fri, 22 Oct 2021 19:40:45 +0200
Message-Id: 
 <3fdce4db1a4e9f69140bc9fa7f5bfbfee2ccd306.1634924446.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634924446.git.jan.kiszka@siemens.com>
References: <cover.1634924446.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Oct 2021 17:40:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6837

From: Jan Kiszka <jan.kiszka@siemens.com>

Include paths are now repo-relative, adjust this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                       | 2 +-
 README.md                            | 2 +-
 kas/opt/ebg-secure-boot-base.yml     | 2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
 kas/opt/ebg-snakeoil-swu.yml         | 4 ++--
 kas/opt/ebg-swu.yml                  | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 40bf7f5..b23090b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,4 +1,4 @@
-image: ghcr.io/siemens/kas/kas-isar:2.5
+image: ghcr.io/siemens/kas/kas-isar:2.6
 
 variables:
   GIT_STRATEGY: clone
diff --git a/README.md b/README.md
index 32812a2..537a615 100644
--- a/README.md
+++ b/README.md
@@ -12,7 +12,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/2.5/kas-container
+    wget https://raw.githubusercontent.com/siemens/kas/2.6/kas-container
     chmod a+x kas-container
 
 Furthermore, install docker and make sure you have required permissions to
diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
index 8182bd8..8f769b6 100644
--- a/kas/opt/ebg-secure-boot-base.yml
+++ b/kas/opt/ebg-secure-boot-base.yml
@@ -12,7 +12,7 @@
 header:
   version: 10
   includes:
-   - efibootguard.yml
+   - kas/opt/efibootguard.yml
 
 local_conf_header:
   initramfs: |
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index c0ed1a2..2f45bde 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -12,7 +12,7 @@
 header:
   version: 10
   includes:
-   - ebg-secure-boot-base.yml
+   - kas/opt/ebg-secure-boot-base.yml
 
 
 local_conf_header:
diff --git a/kas/opt/ebg-snakeoil-swu.yml b/kas/opt/ebg-snakeoil-swu.yml
index d613532..2f15c0e 100644
--- a/kas/opt/ebg-snakeoil-swu.yml
+++ b/kas/opt/ebg-snakeoil-swu.yml
@@ -12,5 +12,5 @@
 header:
   version: 10
   includes:
-   - ebg-secure-boot-snakeoil.yml
-   - swupdate.yml
+   - kas/opt/ebg-secure-boot-snakeoil.yml
+   - kas/opt/swupdate.yml
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 8c56182..e708d0a 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -12,5 +12,5 @@
 header:
   version: 10
   includes:
-   - efibootguard.yml
-   - swupdate.yml
+   - kas/opt/efibootguard.yml
+   - kas/opt/swupdate.yml
-- 
2.31.1


