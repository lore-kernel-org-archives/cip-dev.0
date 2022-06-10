Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29262C43334
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 11:33:09 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.25994.1654860786493836589
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jun 2022 04:33:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=ZGySWb3w;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-51332-20220610113303bcb70e4a5cd9accd4e-69h3_j@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20220610113303bcb70e4a5cd9accd4e
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Jun 2022 13:33:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=F8OziEcnYI1VFMaC+yl4m0xb8+wx10N4xoHcMhYe8ns=;
 b=ZGySWb3w62T0SjTUdsmx/1l72kdKrpNRqsXJM9SYuLImt5D+mGP2v6ZELDLpG4faAXte+d
 9FsGJIgRQq+mpeKUy6hetCB58vBoczNivC++8syUCSaAVS0tOhsOEhgKtsnwLfRd/naQCf1k
 bLImABMOmpgV3pkVauIiC7chL9uXs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	adriaan.schmidt@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v3 2/5] u-boot-qemu-arm64: Adapt to 'Do
 not use shell environment'
Date: Fri, 10 Jun 2022 13:32:59 +0200
Message-Id: <20220610113302.1225351-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220610113302.1225351-1-Quirin.Gylstorff@siemens.com>
References: <20220607100806.133889-1-Quirin.Gylstorff@siemens.com>
 <20220610113302.1225351-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 11:33:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8534

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The variables U_BOOT_CONFIG and U_BOOT_BIN are added by
template variables[1].

[1]: https://github.com/ilbers/isar/commit/48dd7969e3c977e7e39b235be71c1f06d912b336

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-bsp/u-boot/files/{rules => rules.tmpl}  | 2 +-
 recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)
 rename recipes-bsp/u-boot/files/{rules => rules.tmpl} (96%)

diff --git a/recipes-bsp/u-boot/files/rules b/recipes-bsp/u-boot/files/rules.tmpl
similarity index 96%
rename from recipes-bsp/u-boot/files/rules
rename to recipes-bsp/u-boot/files/rules.tmpl
index 36e1e1b..c697cdb 100755
--- a/recipes-bsp/u-boot/files/rules
+++ b/recipes-bsp/u-boot/files/rules.tmpl
@@ -19,7 +19,7 @@ override_dh_auto_build:
 		tools/efivar.py set -i ubootefi.var -n KEK -d secure-boot.esl -t file; \
 		tools/efivar.py set -i ubootefi.var -n db -d secure-boot.esl -t file; \
 	fi
-	$(MAKE) $(PARALLEL_MAKE) $(U_BOOT_CONFIG)
+	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_CONFIG}
 	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_BIN}
 	$(MAKE) -n u-boot-initial-env >/dev/null 2>&1; if [ $$? -ne 2 ]; then \
 		$(MAKE) $(PARALLEL_MAKE) u-boot-initial-env; \
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb
index e462258..b026dd6 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb
@@ -14,7 +14,7 @@ require recipes-bsp/u-boot/u-boot-custom.inc
 SRC_URI += " \
     https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
     file://0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch \
-    file://rules"
+    file://rules.tmpl;subdir=debian"
 SRC_URI[sha256sum] = "68e065413926778e276ec3abd28bb32fa82abaa4a6898d570c1f48fbdb08bcd0"
 
 SRC_URI_append_secureboot = " \
@@ -31,10 +31,6 @@ DEPENDS_append_secureboot = " secure-boot-secrets"
 U_BOOT_CONFIG = "qemu_arm64_defconfig"
 U_BOOT_BIN = "u-boot.bin"
 
-do_prepare_build_append() {
-    cp ${WORKDIR}/rules ${S}/debian/rules
-}
-
 do_prepare_build_append_secureboot() {
     sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
     cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
-- 
2.35.1


