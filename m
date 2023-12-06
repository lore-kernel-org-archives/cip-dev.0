Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C7EC10F05
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 14:35:38 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.33160.1701873332153731419
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Dec 2023 06:35:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=gJYrWv/s;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20231206143529544c5a827dcdc6fed4-fy_xtc@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20231206143529544c5a827dcdc6fed4
        for <cip-dev@lists.cip-project.org>;
        Wed, 06 Dec 2023 15:35:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=A3Gqt6yo23cHtLqklleCefNpTohs2KpADsdxYX/jHY8=;
 b=gJYrWv/sWJ8bEFXp8sq1uCHDRVUEqe7Bzo+H2qQ/lnWlO2TkmsO2qzE2lsjhs2+G7Uj6dm
 w3mxdvHoPDlC3DUITimuIS1r9YFnaAG1zsv+cwMK3+4BWBA7sNcyWpCdEh9S1KxorhjgsbkP
 rj1jytgxTLt6TqwjtX0oOS2VZNZO8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC 1/2] efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
Date: Wed,  6 Dec 2023 15:33:21 +0100
Message-ID: <20231206143528.1900797-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231206143528.1900797-1-Quirin.Gylstorff@siemens.com>
References: <20231206143528.1900797-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Dec 2023 14:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13800

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to add the signed ebg binary to a swu file for
updating the bootloader.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-efi.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 86a22e0..f40b706 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -68,6 +68,12 @@ class EfibootguardEFIPlugin(SourcePlugin):
             "riscv64": "riscv64-linux-gnu",
         }
 
+        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
+        if not deploy_dir:
+            msger.error("DEPLOY_DIR_IMAGE not set, exiting\n")
+            exit(1)
+        creator.deploy_dir = deploy_dir
+
         distro_arch = get_bitbake_var("DISTRO_ARCH")
         bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
             libpath=distro_to_lib_arch[distro_arch],
@@ -90,6 +96,13 @@ class EfibootguardEFIPlugin(SourcePlugin):
                                               part_rootfs_dir,
                                               name)
         exec_cmd(cp_cmd, True)
+        msger.debug("copy {signed_bootloader} to deploy")
+        cp_to_deploy_cmd = "cp %s/%s %s/%s" % (cr_workdir,
+                                               signed_bootloader,
+                                               deploy_dir,
+                                               name)
+        exec_cmd(cp_to_deploy_cmd, True)
+
         du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
         blocks = int(exec_cmd(du_cmd).split()[0])
 
-- 
2.42.0


