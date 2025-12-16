Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E825CD5C0EA
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 08:26:13 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17473.1765873563272763089
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 00:26:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=WyT9/e/G;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20251216082600b804b5bd0300020708-_t_q0w@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251216082600b804b5bd0300020708
        for <cip-dev@lists.cip-project.org>;
        Tue, 16 Dec 2025 09:26:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=2aw9tdCNV8olUaxeyj0p47FQ8Lxi1TBHC6sJ3MwWZPI=;
 b=WyT9/e/GM0PXSOkTriG4IfTQ9W1qLCMGayoCSiDmpqlnt6GauMIdTgI0FPRRS1xLtGZmNp
 zNNlukvUrpT+TgscEjVhNbI372mXlDdIc2rOlH6wbTwCfajsD804NfT2u2nXDZ+qiweh/qKX
 Ank5r+Cy2nweXq3Cn0es0Sq4zQ9NRET8UFRmuVUC0nsc1BAWBlzR9YN1RoyGGszjML4xrLIW
 EnxiUvPu1dRdAGFjbGo1bh1ljqGOm9Viq8aF2OZ5Hi6Ortj3NVrqve5mgGKzbohtcBdV+BWV
 r86ndlXVuwiFr0/M4Y2Z2t733c7PZUThEWdtbMxe8WVk/RsI1Nee5uLA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 1/4] fix: Add missing efivarfs hook
Date: Tue, 16 Dec 2025 09:25:43 +0100
Message-ID: <20251216082559.327416-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251216082559.327416-1-Quirin.Gylstorff@siemens.com>
References: <20251216082559.327416-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 08:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21076

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The kernel efivarfs is necessary to check if the factory-reset was
requested.

Fixes: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...ry-reset-hook_0.2.bb => initramfs-factory-reset-hook_0.3.bb} | 2 ++
 1 file changed, 2 insertions(+)
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.2.bb => initramfs-factory-reset-hook_0.3.bb} (98%)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
similarity index 98%
rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
index 30ceb23..ed8484d 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
@@ -38,6 +38,8 @@ HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
                    chattr grep find"
 HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
 
+HOOK_ADD_MODULES = "efivarfs"
+
 # provide the script under the required name
 do_prepare_build:append() {
     rm -f ${WORKDIR}/local-top ${WORKDIR}/local-bottom
-- 
2.51.2


