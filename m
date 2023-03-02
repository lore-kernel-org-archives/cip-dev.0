Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F872C7EE2F
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 15:31:00 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.18904.1677770861139122093
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 07:27:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=M+oPK4Vj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-202303021527393f98e5635d05ad2f47-xrfjsr@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202303021527393f98e5635d05ad2f47
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 16:27:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UMbJw3JZm4RUlfBTJ4DUQX0QLgYY8C2FV9u1vcuwSWw=;
 b=M+oPK4VjlVbhuCIWEpcjIxWTOcPIBHlvP48UwWlq0t/cLY1b4wdJELMKYqhjSiUa9S+sgL
 0FgheFLKEHckYVV9qHuSXr7dg10LMRREIqacRVsgA6TyQk9MmDCCfoDZjLSV5lztGWV+Wi4Q
 T44FiYW+TnkKfMed2sYb/YWKs0rck=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 3/9] refactor(u-boot): deploy via sstate-cache
Date: Thu,  2 Mar 2023 15:26:53 +0000
Message-Id: <20230302152659.2096307-4-felix.moessbauer@siemens.com>
In-Reply-To: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 15:31:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10878

This patch refactors how the firmware.bin is deployed to the
DEPLOY_DIR_IMAGE. Instead of directly copying, we now deploy via the
sstate cache. By that, the cleanup is automatically handled and
potential conflicts on the filename are reported.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-bsp/u-boot/u-boot-qemu-common.inc | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
index 0a9a15a..4d8b240 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -13,11 +13,21 @@ require recipes-bsp/u-boot/u-boot-common.inc
 
 U_BOOT_BIN = "u-boot.bin"
 
-do_deploy[dirs] = "${DEPLOY_DIR_IMAGE}"
+DEPLOYDIR_U_BOOT = "${WORKDIR}/deploy-u-boot"
+SSTATETASKS += "do_deploy"
+
+do_deploy[cleandirs] += "${DEPLOYDIR_U_BOOT}"
+do_deploy[sstate-inputdirs] = "${DEPLOYDIR_U_BOOT}"
+do_deploy[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
 do_deploy() {
     dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
-        > "${DEPLOY_DIR_IMAGE}/firmware.bin"
+        > "${DEPLOYDIR_U_BOOT}/firmware.bin"
+}
+
+python do_deploy_setscene () {
+    sstate_setscene(d)
 }
+addtask do_deploy_setscene
 
 addtask deploy after do_dpkg_build before do_deploy_deb
-- 
2.34.1


