Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6563DEE4993
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 14:05:37 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.12301.1692799526125115952
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Aug 2023 07:05:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=By3zqWmw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20230823140522529adb9e0c07474715-9j_oy5@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230823140522529adb9e0c07474715
        for <cip-dev@lists.cip-project.org>;
        Wed, 23 Aug 2023 16:05:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=hqhC9DaBwAs02s+t3Jxgr0+q6CjkBMtIOlWT7jDigcM=;
 b=By3zqWmwmPMTW7HuO2bnaltpKfbB9V0s/4dzGP4tVwqd+QNxdgN5ImSH6iFuPqYLRUVt4H
 cEIBwpj+v4qQKGK0rWC9ykteuS4y7R2TViGoGQ0uo+zYIlMbsU9GbJpIFip6RTZoFhCdvdF5
 Jaziisj7w90VyEsSl55JWGjZxTjHE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] initramfs-abrootfs-hook: Ensure sync on rebuild
Date: Wed, 23 Aug 2023 16:05:21 +0200
Message-Id: <20230823140521.1013898-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 14:05:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12841

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Disable the timestamp of the do_install() task to
re-execute when ever a dependency on do_install
is executed.

Without this change the sstate needs to be clean for
every rebuild.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
index 17c60da..d16d06e 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
@@ -32,6 +32,9 @@ do_install[cleandirs] += " \
     ${D}/usr/share/abrootfs \
     ${D}/usr/share/initramfs-tools/scripts/local-top"
 
+# Ensure IMAGE_UUID_ENV_FILE  is updated also when rebuilding initramfs-abrootfs-hook
+do_install[nostamp] = "1"
+
 do_install() {
     if [ -f "${IMAGE_UUID_ENV_FILE}" ]; then
         install -m 0600 "${IMAGE_UUID_ENV_FILE}" "${D}/usr/share/abrootfs/image-uuid.env"
-- 
2.40.1


