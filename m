Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76215C61DA4
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 18:24:30 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.541.1675362267495437009
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 10:24:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=nbMU99s+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230202182424ccc64675f6cccc8e28-vojgtq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230202182424ccc64675f6cccc8e28
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Feb 2023 19:24:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Bd4bYdpomNULa6IQjS6DnVieRoOmVYP7cNuPp2rkJcQ=;
 b=nbMU99s+fEb8lqf2z/2C5wJPGS11UW+kj3ymKYgYOgZKYALvFteSsqOIbUY34kCzzNm11F
 qgurPNT70g2bLBp0OfRn1kpkCjCEYPZb2xftqL10b8n1j55v9cqwQSFEzbTm8RQfD8pNAeqR
 RHpy8VK4K6sohYnqr38raF0OTzFaU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: florian.bezdeka@siemens.com,
	cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] Patch ISAR to include the new repo non-free-firmware
Date: Thu,  2 Feb 2023 19:24:22 +0100
Message-Id: <20230202182422.839974-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230202150811.824615-1-Quirin.Gylstorff@siemens.com>
References: <20230202150811.824615-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 18:24:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10573

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This enables the bookworm build for hihope-rzg2m.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                                |  8 +++
 kas-cip.yml                                   |  4 ++
 ...ist-add-non-free-firmware-repository.patch | 54 +++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 patches/isar/0001-sources.list-add-non-free-firmware-repository.patch

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4c4796b..311702f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -307,6 +307,14 @@ build:iwg20m-bookworm:
     dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
     release: bookworm
 
+build:hihope-rzg2m-bookworm:
+  extends:
+    - .build_base
+  variables:
+    target: hihope-rzg2m
+    dtb: r8a774a1-hihope-rzg2m-ex.dtb
+    release: bookworm
+
 build:qemu-amd64-secure-boot-bookworm:
   extends:
     - .build_base
diff --git a/kas-cip.yml b/kas-cip.yml
index b970f39..dae9040 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -25,6 +25,10 @@ repos:
     refspec: fc4f004eb67237d9d09b1ffad0de1a19217fa94a
     layers:
       meta:
+    patches:
+      non-free-firmware:
+        repo: cip-core
+        path: patches/isar/0001-sources.list-add-non-free-firmware-repository.patch
 
 bblayers_conf_header:
   standard: |
diff --git a/patches/isar/0001-sources.list-add-non-free-firmware-repository.patch b/patches/isar/0001-sources.list-add-non-free-firmware-repository.patch
new file mode 100644
index 0000000..daee224
--- /dev/null
+++ b/patches/isar/0001-sources.list-add-non-free-firmware-repository.patch
@@ -0,0 +1,54 @@
+From 193e9204a220323ec474cdb2f2d5fd3cd36f19a2 Mon Sep 17 00:00:00 2001
+From: Felix Moessbauer <felix.moessbauer@siemens.com>
+Date: Thu, 2 Feb 2023 10:51:00 +0100
+Subject: [PATCH] sources.list: add non-free-firmware repository
+
+The Debian project has taken the decision in 2022-10 to
+create a new repository component non-free-firmware, and
+include its content on installation media for the upcoming
+Debian release bookworm. This has to be reflected in our
+sources.list from bookworm on.
+
+While the non-free-firmware repository contains only the
+firmware parts, we could remove non-free as the intention
+of adding non-free was just to get the non-free firmware
+packages. However, still many firmware packages are not in
+the correct repository, so better keep non-free for now.
+
+Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
+---
+ meta/conf/distro/debian-bookworm.list | 12 ++++++------
+ meta/conf/distro/debian-sid.list      |  4 ++--
+ 2 files changed, 8 insertions(+), 8 deletions(-)
+
+diff --git a/meta/conf/distro/debian-bookworm.list b/meta/conf/distro/debian-bookworm.list
+index f47e46ef..cbc0ca3b 100644
+--- a/meta/conf/distro/debian-bookworm.list
++++ b/meta/conf/distro/debian-bookworm.list
+@@ -1,8 +1,8 @@
+-deb	http://deb.debian.org/debian bookworm main contrib non-free
+-deb-src	http://deb.debian.org/debian bookworm main contrib non-free
++deb	http://deb.debian.org/debian bookworm main contrib non-free-firmware non-free
++deb-src	http://deb.debian.org/debian bookworm main contrib non-free-firmware non-free
+ 
+-deb	http://deb.debian.org/debian-security/ bookworm-security main contrib non-free
+-deb-src	http://deb.debian.org/debian-security/ bookworm-security main contrib non-free
++deb	http://deb.debian.org/debian-security/ bookworm-security main contrib non-free-firmware non-free
++deb-src	http://deb.debian.org/debian-security/ bookworm-security main contrib non-free-firmware non-free
+ 
+-deb	http://deb.debian.org/debian bookworm-updates main contrib non-free
+-deb-src	http://deb.debian.org/debian bookworm-updates main contrib non-free
++deb	http://deb.debian.org/debian bookworm-updates main contrib non-free-firmware non-free
++deb-src	http://deb.debian.org/debian bookworm-updates main contrib non-free-firmware non-free
+diff --git a/meta/conf/distro/debian-sid.list b/meta/conf/distro/debian-sid.list
+index 2b8158cc..ccddf87d 100644
+--- a/meta/conf/distro/debian-sid.list
++++ b/meta/conf/distro/debian-sid.list
+@@ -1,2 +1,2 @@
+-deb	http://deb.debian.org/debian sid main contrib non-free
+-deb-src	http://deb.debian.org/debian sid main contrib non-free
++deb	http://deb.debian.org/debian sid main contrib non-free-firmware non-free
++deb-src	http://deb.debian.org/debian sid main contrib non-free-firmware non-free
+-- 
+2.39.1
+
-- 
2.39.1


