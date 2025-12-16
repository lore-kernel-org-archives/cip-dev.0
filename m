Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1889D5C0DA
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 08:26:13 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17471.1765873563272578037
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 00:26:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=G1Xyya6Y;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2025121608260005aba6ca2400020790-xi1vmf@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025121608260005aba6ca2400020790
        for <cip-dev@lists.cip-project.org>;
        Tue, 16 Dec 2025 09:26:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5SezvpizuPDFp9LUR3IGixT9AzhRflCgTiGv87kheWk=;
 b=G1Xyya6YgtrwQM25WqmYvBmsbD0gyHBpPTujYOyTRc2zcpn/+JKzzVlbm2Ouix138c0P/r
 BE4v+nz0bZn8SyZ6o19aRKrn8pnuq8HJFEh2Asd7EfChl1+h0ph9ufp0RI/QRdRjnTu4YTPO
 QGJXukakg/Wx0fnboTkZid9LCeM96Rv8zW4VOWkNjOR23vg/y6Itmy5bbIhRt1pcP6mFviui
 iT5cpxRgtMdR4uwySzX0ywUJmkz0mWqjY/U4k9W3z+bQeXA870BwBkA5ty18hvkZwtRFXZlU
 QeGPwdJLn1nIKGWixa0TzfaOwHrFd4QFvKc/jWgV9xteESpjopk1p3ew==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 3/4] fix: ensure that the partitions are available
Date: Tue, 16 Dec 2025 09:25:45 +0100
Message-ID: <20251216082559.327416-4-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21075

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Check if all factory-reset partitions are available. This fixes an issue
on Debian Trixie where the factory-reset cannot find any partition to
reset.

Fixes
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/factory-reset-script.tmpl            | 18 ++++++++++++++++++
 .../initramfs-factory-reset-hook_0.3.bb        |  7 +++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
index a6c622f..f0ad40c 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
@@ -9,8 +9,26 @@
 #
 . /usr/share/factory-reset/reset-env
 
+. /scripts/cip-initramfs-functions
+
+check_partitions()
+{
+    found=0
+    for partition in ${INITRAMFS_FACTORY_RESET_DEVICES}; do
+        if blkid | grep -q "$(basename $partition)"; then
+            found=$((found + 1))
+        fi
+    done
+    if [ "$found" -eq "$(awk -v var="${INITRAMFS_FACTORY_RESET_DEVICES}" 'BEGIN{n=split(var,a," "); print n}')" ]; then
+        return 0
+    fi
+    return 1
+}
+
 target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
 
+wait_30sec_for_condition check_partitions
+
 if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
     log_begin_msg "Factory Reset"
     for target in ${target_devices}; do
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
index b689ec1..7dc04eb 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
@@ -30,8 +30,11 @@ TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
                    INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
                    INITRAMFS_FACTORY_RESET_CLEAR_TPM"
 
-RDEPENDS = "factory-reset-helper"
-DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, factory-reset-helper, findutils"
+RDEPENDS = "factory-reset-helper \
+            initramfs-cip-functions"
+
+DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, \
+                    factory-reset-helper, findutils, initramfs-cip-functions"
 DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
 HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
                    mke2fs mkfs.btrfs awk blkid rm get-factory-reset.sh \
-- 
2.51.2


