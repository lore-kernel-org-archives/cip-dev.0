Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91085D59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:37:33 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44856.1765791450645540428
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:37:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=UShAh3Fu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20251215093727d6132ccaaf0002074f-fpfmwt@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251215093727d6132ccaaf0002074f
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Dec 2025 10:37:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=v7BObTRYG0E9VbI9h6g6KvQMIx/heBWufxRN489Pe8U=;
 b=UShAh3FuvGFFB1/MbAPhK/mjoMV24IeNKHaAW+aM+50sJ+n4jXrTiPhvZwno7h8VbFsO8g
 4Ewvrh3mWA1ievF757NRNOKhhEpc1aF7rLN3OjyYPp/J60IrMRFMgoOYivZ8AaRM43V8LEvF
 TQf9GlxvVmsG4efhDPgzTaJ4kOSNnqlJ6W9sP5RLx0TqkLq+O+j3eyvEPhvHtWYpW6AYfrxv
 hfqR/G9glSwUn5XrLdZN83sKGnADq6n+Rg/qUNJkNeCXgPgpE3/zntQ+HlSZRkUSxtJ4cWl2
 AfAcafUHgew0AcfTxZe9IruLX+4CO8+RAgH9FwLHibZVPIAJbPb31IwA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 1/3] fix: initramfs-hook do_prepare_build is executed after do_install
Date: Mon, 15 Dec 2025 10:35:52 +0100
Message-ID: <20251215093719.323668-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
References: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:37:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21034

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an issue where the initramfs does not contain the
factory-reset script.

Fixes: 7c89ecb (initramfs-factory-reset: de-duplicate code between local-top and local-bottom)
Fixes: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...et-hook_0.2.bb => initramfs-factory-reset-hook_0.3.bb} | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.2.bb => initramfs-factory-reset-hook_0.3.bb} (95%)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
similarity index 95%
rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
index 30ceb23..16784d8 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
@@ -38,14 +38,10 @@ HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
                    chattr grep find"
 HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
 
-# provide the script under the required name
-do_prepare_build:append() {
-    rm -f ${WORKDIR}/local-top ${WORKDIR}/local-bottom
-    ln -sf ${WORKDIR}/factory-reset-script ${WORKDIR}/${FACTORY_RESET_HOOK_TARGET}
-}
-
 do_install[cleandirs] += "${D}/usr/share/factory-reset/"
 do_install:prepend() {
+    rm -f ${WORKDIR}/local-top ${WORKDIR}/local-bottom
+    ln -sf ${WORKDIR}/factory-reset-script ${WORKDIR}/${FACTORY_RESET_HOOK_TARGET}
     install -m 0755 "${WORKDIR}/reset-env" \
         "${D}/usr/share/factory-reset/reset-env"
 }
-- 
2.51.2


