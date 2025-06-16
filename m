Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C280C71136
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 18:44:43 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.4920.1750099476636326175
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 11:44:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=dScg/yVE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2025061618443266775b32ed4b5b9b66-mnynr1@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025061618443266775b32ed4b5b9b66
        for <cip-dev@lists.cip-project.org>;
        Mon, 16 Jun 2025 20:44:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=+RdnKhB7YlyXmkTBB8kRfzlGCfxNj6IPA43FDOklayQ=;
 b=dScg/yVEBa30fvSW7vYux2sVu8SkTbamt56+Y/kuTtbm7o7nzaiN6/HsKEAkjKNYE5VRuB
 tY+P1/x0gK0Dcjh+TC7fZatpakSWHRbEm0blpBgDPgHqgIga7yN9xH9WxJPtMGUQri6fbaHZ
 LwqWLd1Mfc4UjyDgH1xVV+J/NiFo9EcuQ/5Y5WHtAkflFJyRtqkQURXbrlJGJFkZCijdiyaN
 TdT/kJMe+MGBouLwpmaevYBOXN55+WDMyHew7KFZt29w1KMNgc5nq2fXhIPlrLpIecmiDOS6
 YZ/xC0qkpxYtU8ysTDT6HsLgSG3KUBgD+lT0Ncb3ZKbWpq9ddKzmfTfA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3] fix: Shutdown the TPM after disk are decrypted
Date: Mon, 16 Jun 2025 20:44:01 +0200
Message-ID: <20250616184432.2170407-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 18:44:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19111

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If an power failure occurs and the TPM was open/in-use the DA lockout
counter will be increased. If enough shutdowns occur the device will go
into lock down mode.

tpm2_shutdown is not available in Debian buster, therefore Debian buster
is still affected.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v3:
 - increase version to v0.8
 - exclude tpm2_shutdown for Debian Buster

Changes v2:
 - use tpm2_shutdown direct instead the wrapper command tpm2 shutdown

 .../initramfs-crypt-hook/files/local-top-complete            | 5 +++++
 ...itramfs-crypt-hook_0.7.bb => initramfs-crypt-hook_0.8.bb} | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.7.bb => initramfs-crypt-hook_0.8.bb} (96%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index ae0dcef..2b4bed0 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -293,6 +293,11 @@ for partition_set in $partition_sets; do
 	finalize_tpm2_encryption "$part_device"
 done
 
+if [ -x /usr/bin/tpm2_shutdown ]; then
+	# shutdown the TPM to avoid DA lockout due to powerfailure
+	tpm2_shutdown
+fi
+
 if [ -n "$watchdog_pid" ]; then
 	kill "$watchdog_pid"
 fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
similarity index 96%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
index 80a4755..f3b6c82 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
@@ -42,7 +42,7 @@ HOOK_ADD_MODULES = " \
 HOOK_COPY_EXECS = " \
     openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
     e2fsck resize2fs cryptsetup \
-    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
+    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
     /usr/lib/*/libgcc_s.so.1"
 
 HOOK_COPY_EXECS:append:clevis = " \
@@ -58,7 +58,7 @@ HOOK_COPY_EXECS:append:systemd = " \
 
 HOOK_COPY_EXECS:append:buster = " cryptsetup-reencrypt tpm2_pcrlist"
 HOOK_COPY_EXECS:remove:buster = " \
-    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
+    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
     clevis-luks-list clevis-luks-common-functions"
 HOOK_COPY_EXECS:append:bullseye = " cryptsetup-reencrypt"
 
-- 
2.47.0


