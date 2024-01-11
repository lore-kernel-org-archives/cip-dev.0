Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6784C47077
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 20:00:26 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.2397.1705003220086386955
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 12:00:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=UMZC8/RH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2024011120001755f811117a0f5a980f-mtzne0@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024011120001755f811117a0f5a980f
        for <cip-dev@lists.cip-project.org>;
        Thu, 11 Jan 2024 21:00:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Q0uHH1rsokRJfkAP1QPz52XMfDYa8++Dsa4HU+HLW08=;
 b=UMZC8/RH1Slquhv0AJNXuftSXSUGqrM8N6RS8gcsMkwFev2l8Bf/jyZe7UKeUPqZpAUdbj
 koDEYwzSGIEToIME7VF1f/5/YxAM2khghCtJju7XPVETfh5pArPJESjcI7vYMImWM2N3rrlT
 Qb1w082tBHEHc3z5rTh96MvAo5k2w=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 3/7] efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
Date: Thu, 11 Jan 2024 20:59:47 +0100
Message-ID: <20240111200015.190376-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
References: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 20:00:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14345

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to add the signed ebg binary to a swu file for
updating the bootloader.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-efi.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 9bb6347..e82e990 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -66,6 +66,13 @@ class EfibootguardEFIPlugin(SourcePlugin):
             exit(1)
         creator.deploy_dir = deploy_dir
 
+        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
+        if not deploy_dir:
+            msger.error("DEPLOY_DIR_IMAGE not set, exiting\n")
+            exit(1)
+        creator.deploy_dir = deploy_dir
+
+        distro_arch = get_bitbake_var("DISTRO_ARCH")
         bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
                         libpath=libarch,
                         efiarch=efiarch)
@@ -86,6 +93,13 @@ class EfibootguardEFIPlugin(SourcePlugin):
                                               part_rootfs_dir,
                                               name)
         exec_cmd(cp_cmd, True)
+
+        cp_to_deploy_cmd = "cp %s/%s %s/%s" % (cr_workdir,
+                                               signed_bootloader,
+                                               deploy_dir,
+                                               name)
+        exec_cmd(cp_to_deploy_cmd, True)
+
         du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
         blocks = int(exec_cmd(du_cmd).split()[0])
 
-- 
2.43.0


