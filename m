Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38039C531FA
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 10:51:25 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16735.1784890281576097190
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 03:51:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=MUsPODF9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20260724105118bddb5a2e7700020700-ablsvz@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260724105118bddb5a2e7700020700
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 12:51:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=goofUN47ZsnpBU+OFYeOt5ZeELarzCHQLr0AldhPOeE=;
 b=MUsPODF9N0NFep0BFNwXgjpivJqMjDjAdTSi17Wv6y9aatD1SK0CbgfIMO6zo1ffPjaGj7
 EHY3wsr6ISqCrICtQP1j2qHJsmqoiG89MGHBilKUnKdvPweoh3xRXzGJThKbar9eH5W17Dqj
 oWe1zKjhvDFkkpfp3C8oiFWvIo8mmJXDAirCg7PknFxcmgj/3cnYO0X4DAKOADEn0aAQbj8B
 bIUJTqXRtcxlZqbtGf9a/QAfdBYR9X+5XbQXELkhhmhMKsPcv1yAkO6R2jLwzlJ6DscjJ2jc
 SCsB+53TqeI7uv7MWEvcTTZcNqQkJBjFrOFh99hv6BfEEdkH2ro+Jong==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 3/4] use run_priviledged instead of sudo
Date: Fri, 24 Jul 2026 12:51:07 +0200
Message-ID: <20260724105116.3575045-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 10:51:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23732

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is in preparation to support rootless builds

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/image_uuid.bbclass       | 4 ++--
 classes-recipe/read-only-rootfs.bbclass | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/classes-recipe/image_uuid.bbclass b/classes-recipe/image_uuid.bbclass
index 2cd8459..da54625 100644
--- a/classes-recipe/image_uuid.bbclass
+++ b/classes-recipe/image_uuid.bbclass
@@ -45,9 +45,9 @@ do_generate_image_uuid[vardeps] += "IMAGE_UUID"
 do_generate_image_uuid[dirs] = "${DEPLOY_DIR_IMAGE}"
 do_generate_image_uuid[network] = "${TASK_USE_SUDO}"
 do_generate_image_uuid() {
-    sudo sed -i '/^IMAGE_UUID=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
+    run_privileged sed -i '/^IMAGE_UUID=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
     echo "IMAGE_UUID=\"${IMAGE_UUID}\"" | \
-        sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
+        run_privileged tee -a '${IMAGE_ROOTFS}/etc/os-release'
 
     echo "TARGET_IMAGE_UUID=\"${IMAGE_UUID}\"" \
         > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-only-rootfs.bbclass
index a67bb5f..1690ecb 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -44,15 +44,15 @@ IMMUTABLE_DATA_DIR ??= "/usr/share/immutable-data"
 
 copy_dpkg_state() {
     IMMUTABLE_VAR_LIB="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}/var/lib"
-    sudo mkdir -p "$IMMUTABLE_VAR_LIB"
-    sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
+    run_privileged mkdir -p "$IMMUTABLE_VAR_LIB"
+    run_privileged cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
 }
 
 ROOTFS_POSTPROCESS_COMMAND:append = " copy_home_to_immutable_data"
 ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part = " copy_home_to_immutable_data"
 copy_home_to_immutable_data() {
     IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}"
-    sudo -s <<EOSUDO
+    run_privileged_heredoc <<EOSUDO
         set -e
         mkdir -p "$IMMUTABLE_HOME_DIR"
         rm -rf "$IMMUTABLE_HOME_DIR/home"
@@ -70,7 +70,7 @@ EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
 SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
 
 image_configure_fstab() {
-    sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
+    run_privileged tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
 /dev/root	/		auto		defaults,ro			0	0
 LABEL=var	/var		auto		defaults			0	0
-- 
2.53.0


