Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A54C46CC5
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 12:25:43 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.7069.1702297533273695063
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 04:25:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=b2/hiBKc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202312111225300e2348524158dc46c9-7tnyqp@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202312111225300e2348524158dc46c9
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Dec 2023 13:25:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=A3Gqt6yo23cHtLqklleCefNpTohs2KpADsdxYX/jHY8=;
 b=b2/hiBKcmjm/fwSCfkB7HBOJ80J6VcANVuuN6clGEY0CB4pRDBxoltsw0dzyfwhCIz1UJU
 f+lMmbJ3nMiYhc3p1vhX+v9/6uhoFMOg6K3wP2rgZfOWpqcQNjGhENvP748SdGZWzkj84Zdw
 vhqM2H22YzlnPadbetOAJ/aupb5vg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dec][isar-cip-core][RFC v2 1/3] efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
Date: Mon, 11 Dec 2023 13:19:19 +0100
Message-ID: <20231211122528.486786-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 12:25:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14020

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


