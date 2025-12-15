Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A30ED5B853
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 16:28:46 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53132.1765816116055325617
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 08:28:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=b5bqtwr+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2025121516283328c60cf0100002071e-kg0sub@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025121516283328c60cf0100002071e
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Dec 2025 17:28:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/M39Al12U8rs/bFWH5Sf589PsDdd40F0oOC/h5IlSIQ=;
 b=b5bqtwr+aEgM1mchO3vn1ma9kCLoeDpN8RmOAL7iKImUzVbyrYsGyvU9HK7JK8TmdhTt6S
 T4RbW4fmSamQkzFuW/tiPAlpXuTAWVjCpRYzlL2IBzSEwOoatHSkJfUOC8OMvr6uIqQsR3Cd
 +SjirXu25Ce0mudbrMIspi/ix7l0e+12hQRZ4sJTmT3wNmMfUZAXH2fYvdbZDcpL0hfiEwB8
 tGQs0V1QxAT6GtgbtYDpi9BE8KKt4G2f7wcSUUVm5YjeTCooxCzvOm9NvVy9xMFQnoNQlli2
 gdPmamez34pQBNRPyxsGrNjCqGJeeQfoECiuVVgUlVIZA9aIPhP3CmSg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 2/4] fix: initramfs-hook do_prepare_build is executed after do_install
Date: Mon, 15 Dec 2025 17:28:01 +0100
Message-ID: <20251215162823.308471-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251215162823.308471-1-Quirin.Gylstorff@siemens.com>
References: <20251215162823.308471-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 16:28:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21069

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an issue where the initramfs does not contain the
factory-reset script.

Fixes: 7c89ecb (initramfs-factory-reset: de-duplicate code between local-top and local-bottom)
Fixes: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-factory-reset-hook_0.3.bb                   | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
index ed8484d..b689ec1 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
@@ -40,14 +40,10 @@ HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
 
 HOOK_ADD_MODULES = "efivarfs"
 
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


