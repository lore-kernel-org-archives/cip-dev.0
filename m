Return-Path: <ubely@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56045C433EF
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 09:42:43 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web11.31680.1644831761504937264
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Feb 2022 01:42:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: ubely@ilbers.de)
Received: from baighyz.m.ilbers.de
 (host-80-81-17-52.static.customer.m-online.net [80.81.17.52])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8) with ESMTPSA id 21E9gbdw015308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Feb 2022 10:42:38 +0100
From: Uladzimir Bely <ubely@ilbers.de>
To: ubely@ilbers.de, cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/1] Deploy efibootguardx64.efi and bg_setenv
 from .deb package
Date: Mon, 14 Feb 2022 10:42:37 +0100
Message-Id: <20220214094237.16369-2-ubely@ilbers.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220214094237.16369-1-ubely@ilbers.de>
References: <20220214094237.16369-1-ubely@ilbers.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Feb 2022 09:42:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7593

This patch makes efibootguardx64.efi binary to be included in .deb package.
Also, files are now deployed from .deb package, not from ${S} directory.

Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
---
 recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb  | 10 ++++++++--
 .../efibootguard/files/debian/efibootguard.install     |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
index 2817e5b..2028ac6 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
@@ -41,6 +41,12 @@ do_prepare_build() {
 
 dpkg_runbuild_append() {
     install -m 0755 -d ${DEPLOY_DIR_IMAGE}
-    install -m 0755 ${S}/efibootguardx64.efi ${DEPLOY_DIR_IMAGE}/bootx64.efi
-    install -m 0755 ${S}/bg_setenv ${DEPLOY_DIR_IMAGE}/bg_setenv
+    dpkg --fsys-tarfile ${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb | \
+        tar xOf - ./usr/lib/efibootguardx64.efi \
+        > ${DEPLOY_DIR_IMAGE}/bootx64.efi
+    chmod 755 ${DEPLOY_DIR_IMAGE}/bootx64.efi
+    dpkg --fsys-tarfile ${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb | \
+        tar xOf - ./usr/bin/bg_setenv \
+        > ${DEPLOY_DIR_IMAGE}/bg_setenv
+    chmod 755 ${DEPLOY_DIR_IMAGE}/bg_setenv
 }
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
index 8a8d9d3..d0c3ee3 100644
--- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
+++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
@@ -1,2 +1,3 @@
 bg_setenv usr/bin
 bg_printenv usr/bin
+efibootguardx64.efi usr/lib
-- 
2.20.1


