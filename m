Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9143EE9A77D
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 12:30:36 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18223.1774355432977811123
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 05:30:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Gkk9r/xa;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202603241230290cedbbce56000207f8-dzkg5r@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202603241230290cedbbce56000207f8
        for <cip-dev@lists.cip-project.org>;
        Tue, 24 Mar 2026 13:30:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=U9BY3UrO0rtfm0pQD/5vCOQyO1nMV6kxl8vnTjGjFs8=;
 b=Gkk9r/xabnK1OX8jmFjPJFLd+i8cre0DQHkOlc0vpAK7rOh9AnIsN3KVJGzjxSPWpvoJjW
 JHIFwRUv4lkmBRRHSrMeb0yqbLu8cWjXSA7CaXZ6jmx5ksj6e9M0rGOphZYn4tUgnzdMq0qb
 o8AmIv1zG4cfctIZdPbMlLZ2JaxuyyXew4plO2n2tpXuVHZDMEwsidV07NOIh8NPznEAecTU
 2zj8dEr24WIS5zcNf3PsGIpeXHuIjGfTg1y+bjF6eGox05LjaJjix1vRU+FoyAYDhoe0ZDo3
 Fa8dpqE3ReOxk+ZzBpyDXCnScD3V/jKOE+HLi8H+Fed0kP8GWC8tvzgQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] chore: Add maintainer to all package recipes
Date: Tue, 24 Mar 2026 13:29:56 +0100
Message-ID: <20260324123028.3459200-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 12:30:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22551

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids the warning introduced with https://github.com/ilbers/isar/commit/712a62478d0ad34b7364f2892f485b7a014610c9
```
WARNING:  do_prepare_build: MAINTAINER contains '@example.com'. Please set a valid maintainer.
```

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../hss-payload-generator/hss-payload-generator_2025.07.bb      | 2 ++
 recipes-core/change-root-homedir/change-root-homedir_0.2.bb     | 2 ++
 recipes-core/customizations/common.inc                          | 2 ++
 recipes-core/home-fs/home-fs_0.1.bb                             | 2 ++
 recipes-core/journald-config/journald-config_0.1.bb             | 2 ++
 recipes-core/kernel-panic/kernel-panic.bb                       | 2 ++
 recipes-core/ltp/ltp.inc                                        | 2 ++
 recipes-core/move-homedir-var/move-homedir-var_0.1.bb           | 2 ++
 recipes-core/security-customizations/security-customizations.bb | 2 ++
 recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb     | 2 ++
 recipes-core/swupdate-config/swupdate-config_0.2.bb             | 2 ++
 .../swupdate-handler-roundrobin_0.1.bb                          | 2 ++
 recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb          | 2 ++
 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb            | 2 ++
 recipes-core/swupdate/swupdate_2023.12.bb                       | 2 ++
 recipes-core/tmp-fs/tmp-fs_0.2.bb                               | 2 ++
 recipes-devtools/dosfstools/dosfstools_latest.bb                | 2 ++
 .../ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb        | 2 ++
 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc    | 2 ++
 .../swupdate-certificates/swupdate-certificates-key.inc         | 2 ++
 .../swupdate-certificates/swupdate-certificates.inc             | 2 ++
 recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb     | 2 ++
 recipes-devtools/swupdate-signer/swupdate-signer-empty.bb       | 2 ++
 .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb      | 2 ++
 .../initramfs-cip-functions/initramfs-cip-functions_0.1.bb      | 2 ++
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb           | 2 ++
 .../initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb            | 2 ++
 .../initramfs-factory-reset-hook_0.3.bb                         | 2 ++
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb        | 2 ++
 .../initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb      | 2 ++
 .../initramfs-verity-hook/initramfs-verity-hook_0.3.bb          | 2 ++
 recipes-python/shtab/python-shtab_1.5.5-4.bb                    | 2 ++
 recipes-security/fail2ban-config/fail2ban-config.bb             | 2 ++
 recipes-support/factory-reset-helper/factory-reset-helper.inc   | 2 ++
 34 files changed, 68 insertions(+)

diff --git a/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb b/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
index fa86094..cfb821f 100644
--- a/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
+++ b/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
@@ -11,6 +11,8 @@
 
 inherit dpkg
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 SRC_URI = " \
     https://github.com/polarfire-soc/hart-software-services/archive/refs/tags/v${PV}.tar.gz;downloadfilename=hart-software-services-v${PV}.tar.gz \
     file://rules"
diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
index a0725c1..702e518 100644
--- a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
+++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
 
 SRC_URI = "file://postinst"
diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index c4d201f..81a36ed 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 FILESPATH:append := ":${FILE_DIRNAME}/files"
 
 SRC_URI = " \
diff --git a/recipes-core/home-fs/home-fs_0.1.bb b/recipes-core/home-fs/home-fs_0.1.bb
index fb9e351..fd88f21 100644
--- a/recipes-core/home-fs/home-fs_0.1.bb
+++ b/recipes-core/home-fs/home-fs_0.1.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 SRC_URI = "file://postinst \
            file://home.mount"
 
diff --git a/recipes-core/journald-config/journald-config_0.1.bb b/recipes-core/journald-config/journald-config_0.1.bb
index 00dbfce..62fc0c7 100644
--- a/recipes-core/journald-config/journald-config_0.1.bb
+++ b/recipes-core/journald-config/journald-config_0.1.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 SRC_URI = "file://persistent-journal.conf"
 
 do_install[cleandirs] = "${D}/usr/lib/systemd/journald.conf.d/"
diff --git a/recipes-core/kernel-panic/kernel-panic.bb b/recipes-core/kernel-panic/kernel-panic.bb
index 511febb..22a4dde 100644
--- a/recipes-core/kernel-panic/kernel-panic.bb
+++ b/recipes-core/kernel-panic/kernel-panic.bb
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 DESCRIPTION = "Systemd service file to cause kernel panic"
 
 SRC_URI = " \
diff --git a/recipes-core/ltp/ltp.inc b/recipes-core/ltp/ltp.inc
index 27e26a0..4d524f1 100644
--- a/recipes-core/ltp/ltp.inc
+++ b/recipes-core/ltp/ltp.inc
@@ -11,6 +11,8 @@
 
 inherit dpkg
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 DESCRIPTION = "Linux Test project for CIP"
 
 SRC_URI = " \
diff --git a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
index 608bb69..54e807a 100644
--- a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
+++ b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 DEBIAN_CONFLICTS = "home-fs"
 SRC_URI = "file://${BPN}.tmpfiles.tmpl"
 
diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
index d8fa22b..382f0c8 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 DESCRIPTION = "CIP Security configuration for IEC62443-4-2 evaluation"
 
 SRC_URI = "file://postinst \
diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
index 3569888..c800c84 100644
--- a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
+++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 PROVIDES := "${PN}"
 DEBIAN_PROVIDES := "${PN}"
 
diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
index 63fa320..cdfd8b9 100644
--- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
+++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 PROVIDES := "${PN}"
 DEBIAN_PROVIDES := "${PN}"
 
diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index 59ac49e..2ba192c 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 PROVIDES = "swupdate-handlers"
 
 SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index 035887e..1ab14c4 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg-gbp
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 require swupdate.inc
 
 DEB_BUILD_PROFILES += "nodoc"
diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
index 3a73c89..6193027 100644
--- a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
+++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 require swupdate.inc
 
 DEPENDS += "libebgenv-dev"
diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
index 6822153..5dd7c27 100644
--- a/recipes-core/swupdate/swupdate_2023.12.bb
+++ b/recipes-core/swupdate/swupdate_2023.12.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 require swupdate.inc
 
 DEPENDS += "libebgenv-dev"
diff --git a/recipes-core/tmp-fs/tmp-fs_0.2.bb b/recipes-core/tmp-fs/tmp-fs_0.2.bb
index bb5fcce..f2b7976 100644
--- a/recipes-core/tmp-fs/tmp-fs_0.2.bb
+++ b/recipes-core/tmp-fs/tmp-fs_0.2.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 SRC_URI = "file://postinst"
 
 do_install() {
diff --git a/recipes-devtools/dosfstools/dosfstools_latest.bb b/recipes-devtools/dosfstools/dosfstools_latest.bb
index 37a8f42..d0ac128 100644
--- a/recipes-devtools/dosfstools/dosfstools_latest.bb
+++ b/recipes-devtools/dosfstools/dosfstools_latest.bb
@@ -11,6 +11,8 @@
 
 inherit dpkg
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 CHANGELOG_V="<orig-version>+cip"
 
 SRC_URI = "apt://${BPN}"
diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
index 57ad1be..6963d09 100644
--- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
+++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
@@ -12,6 +12,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 DESCRIPTION = "Signing script for EFI Boot Guard setups"
 
 DEPENDS = "secure-boot-secrets"
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index 5277d9b..38b57ee 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 PROVIDES += "secure-boot-secrets"
 DEBIAN_PROVIDES = "secure-boot-secrets"
 
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
index 2abb963..4124b31 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
 PROVIDES += "swupdate-certificates-key"
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
index 344775d..3c59887 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
 PROVIDES += "swupdate-certificates"
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
index 44bbd0a..ee8d172 100644
--- a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
+++ b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 PROVIDES = "swupdate-signer"
 DEBIAN_PROVIDES = "swupdate-signer"
 
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
index fde9cb4..af9de76 100644
--- a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
+++ b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
@@ -10,6 +10,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 PROVIDES = "swupdate-signer"
 DEBIAN_PROVIDES = "swupdate-signer"
 
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
index 3538bcf..48f6458 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
@@ -11,6 +11,8 @@
 
 inherit initramfs-hook
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 RDEPENDS += "initramfs-cip-functions"
 DEBIAN_DEPENDS .= ", util-linux, initramfs-cip-functions"
 DEBIAN_CONFLICTS = "initramfs-verity-hook"
diff --git a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
index d497aa4..73ee68d 100644
--- a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
+++ b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 DESCRIPTION = "helper functions for cip initramfs-tools extensions"
 
 SRC_URI += "file://cip-initramfs-functions"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
index e132b9e..18a10a8 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
@@ -11,6 +11,8 @@
 
 inherit initramfs-hook
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 RDEPENDS += "initramfs-cip-functions"
 
 DEBIAN_DEPENDS .= ", \
diff --git a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
index e423248..2015503 100644
--- a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
@@ -11,4 +11,6 @@
 
 inherit initramfs-hook
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 HOOK_ADD_MODULES = "erofs"
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
index 7dc04eb..e962a51 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
@@ -10,6 +10,8 @@
 
 inherit initramfs-hook
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 DESCRIPTION = "Delete the content of the given Devices"
 
 # list of partitions by label
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
index 4ec382c..57b26ec 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
@@ -12,6 +12,8 @@
 
 inherit initramfs-hook
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
 
 SRC_URI += " \
diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
index 1f5decc..9ff4cbf 100644
--- a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
@@ -11,4 +11,6 @@
 
 inherit initramfs-hook
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 HOOK_ADD_MODULES = "squashfs"
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
index a0ee803..b2fb704 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
@@ -11,6 +11,8 @@
 
 inherit initramfs-hook
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 SRC_URI += " \
     file://hook \
     file://local-top-complete.tmpl \
diff --git a/recipes-python/shtab/python-shtab_1.5.5-4.bb b/recipes-python/shtab/python-shtab_1.5.5-4.bb
index 7a5cfd2..8ccef35 100644
--- a/recipes-python/shtab/python-shtab_1.5.5-4.bb
+++ b/recipes-python/shtab/python-shtab_1.5.5-4.bb
@@ -11,6 +11,8 @@
 
 inherit dpkg-gbp
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 SRC_URI += " \
     git://salsa.debian.org/python-team/packages/python-shtab.git;protocol=https;branch=main \
     "
diff --git a/recipes-security/fail2ban-config/fail2ban-config.bb b/recipes-security/fail2ban-config/fail2ban-config.bb
index 87d1497..4900069 100644
--- a/recipes-security/fail2ban-config/fail2ban-config.bb
+++ b/recipes-security/fail2ban-config/fail2ban-config.bb
@@ -12,6 +12,8 @@ DESCRIPTION = "Basic fail2ban config with systemd as backend"
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 SRC_URI += "file://systemd-defaults.conf"
 
 DEBIAN_DEPENDS += "fail2ban, python3-systemd, python3-pyinotify"
diff --git a/recipes-support/factory-reset-helper/factory-reset-helper.inc b/recipes-support/factory-reset-helper/factory-reset-helper.inc
index 56ac5b4..9e17daa 100644
--- a/recipes-support/factory-reset-helper/factory-reset-helper.inc
+++ b/recipes-support/factory-reset-helper/factory-reset-helper.inc
@@ -10,6 +10,8 @@
 
 inherit dpkg-raw
 
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+
 DESCRIPTION = "helper script to execute a factory reset"
 
 PROVIDES = "factory-reset-helper"
-- 
2.53.0


