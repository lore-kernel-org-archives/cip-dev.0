Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C0C83039
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 18:15:42 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.48071.1751307331097939331
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 11:15:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=cqWxJm+A;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1330684-20250630181527a223ba8c16b53cfe71-4acobg@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250630181527a223ba8c16b53cfe71
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jun 2025 20:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wGKFf4cjevYXzAlMfpR+gRgt5KtrrszHliI0/46nTKs=;
 b=cqWxJm+A3K2XvOShrrfNFkc7QfhcLTCh6pDE+FnYy+XjuSjtBkDqHf5RWjnylcYvFJrDBP
 Em77qyC2k6x7t/MoYw4TA5ekKeAuhljx9oema7g59uXttWK60i8/wrIrY1pOjNkx31GbF0RN
 vjv5C8CHRTHE2TuIp27PMRTxHv3CzP+Ndcv6lVYgmnGTpsFvWEaY98WyD46XT1dIaPQTUxir
 gluV+tsMfaHxgBW4jMb9vAY90TNJNCRSlb2xw/HnMkZtbscXEBFeVTZVNqM1krizXZMGrUNO
 8Pr6l5ynrAQR5aJeJUDKjOfuKsGbGYwqK5yE8mm5sU3/OW3HMpCYhwrw==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	felix.moessbauer@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][RFC 3/7] temporary-kas: Added patches for isar upstream
Date: Mon, 30 Jun 2025 20:15:12 +0200
Message-Id: <20250630181516.1718712-4-alexander.heinisch@siemens.com>
In-Reply-To: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
References: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 18:15:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19260

From: Alexander Heinisch <alexander.heinisch@siemens.com>

* to support linked /etc/machine-id
* to populate systemd units at build time.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 kas-cip.yml                                   |  7 ++
 ...stproc-Enable-systemd-units-based-on.patch | 70 +++++++++++++++++++
 ...stproc-chroot-before-postprocessing-.patch | 37 ++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 patches/0001-classes-image-postproc-Enable-systemd-units-based-on.patch
 create mode 100644 patches/0001-classes-image-postproc-chroot-before-postprocessing-.patch

diff --git a/kas-cip.yml b/kas-cip.yml
index 47c02ec..e65b80a 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -25,6 +25,13 @@ repos:
     commit: 938dab363006529f0b5296dfbc09ef306fc8c3d7
     layers:
       meta:
+    patches:
+      1-chroot-before-postprocessing-etc-machine-id:
+        repo: cip-core
+        path: patches/0001-classes-image-postproc-chroot-before-postprocessing-.patch
+      2-enable-systemd-units-bsed-on-presets:
+        repo: cip-core
+        path: patches/0001-classes-image-postproc-Enable-systemd-units-based-on.patch
 
 bblayers_conf_header:
   standard: |
diff --git a/patches/0001-classes-image-postproc-Enable-systemd-units-based-on.patch b/patches/0001-classes-image-postproc-Enable-systemd-units-based-on.patch
new file mode 100644
index 0000000..ecbebf1
--- /dev/null
+++ b/patches/0001-classes-image-postproc-Enable-systemd-units-based-on.patch
@@ -0,0 +1,70 @@
+From 48ab8e834cf46f08cc2d7cf11637a3c25c67b2bd Mon Sep 17 00:00:00 2001
+From: Alexander Heinisch <alexander.heinisch@siemens.com>
+Date: Thu, 26 Jun 2025 11:11:01 +0200
+Subject: [PATCH] classes/image-postproc: Enable systemd units based on systemd
+ presets
+
+By default population of the presets is automatically done by systemd
+on first-boot.
+
+There were several issues with that:
+
+1. The rootfs we get as a build artifact does not reflect the actual
+system running in the field.
+
+2. For setups without writeable /etc this fails. With that addition
+it happens already at build time.
+
+Note: Additional services are enabled only. Services already enabled
+during the package installation won't be changed.
+
+Opt-out: `ROOTFS_POSTPROCESS_COMMAND:remove = "image_postprocess_populate_systemd_preset"`
+
+Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
+---
+ RECIPE-API-CHANGELOG.md                       | 18 ++++++++++++++++++
+ meta/classes/image-postproc-extension.bbclass |  5 +++++
+ 2 files changed, 23 insertions(+)
+
+# diff --git a/RECIPE-API-CHANGELOG.md b/RECIPE-API-CHANGELOG.md
+# index 8468717d..fb9ad4f3 100644
+# --- a/RECIPE-API-CHANGELOG.md
+# +++ b/RECIPE-API-CHANGELOG.md
+# @@ -727,3 +727,21 @@ Changes in next
+
+#  This was never documented and never had practical relevance. `oci-archive` is
+#  the useful OCI image format that can be imported, e.g., by podman.
+# +
+# +### Populate systemd units based on presets during image postprocessing
+# +
+# +By default population of the presets is automatically done by systemd
+# +on first-boot.
+# +
+# +There were several issues with that:
+# +
+# +1. The rootfs we get as a build artifact does not reflect the actual
+# +system running in the field.
+# +
+# +2. For setups without writeable /etc this fails. With that addition
+# +it happens already at build time.
+# +
+# +**Note**: Additional services are enabled only. Services already enabled
+# +during the package installation won't be changed.
+# +
+# +Opt-out: `ROOTFS_POSTPROCESS_COMMAND:remove = "image_postprocess_populate_systemd_preset"`
+diff --git a/meta/classes/image-postproc-extension.bbclass b/meta/classes/image-postproc-extension.bbclass
+index 991bac4c..269b86c0 100644
+--- a/meta/classes/image-postproc-extension.bbclass
++++ b/meta/classes/image-postproc-extension.bbclass
+@@ -95,3 +95,8 @@ image_posprocess_disable_systemd_firstboot() {
+         fi
+     fi
+ }
++
++ROOTFS_POSTPROCESS_COMMAND =+ "image_postprocess_populate_systemd_preset"
++image_postprocess_populate_systemd_preset() {
++    sudo chroot '${ROOTFSDIR}' systemctl preset-all --preset-mode="enable-only"
++}
+--
+2.39.5
+
diff --git a/patches/0001-classes-image-postproc-chroot-before-postprocessing-.patch b/patches/0001-classes-image-postproc-chroot-before-postprocessing-.patch
new file mode 100644
index 0000000..85aa265
--- /dev/null
+++ b/patches/0001-classes-image-postproc-chroot-before-postprocessing-.patch
@@ -0,0 +1,37 @@
+From 409ec65811c4c5fccc2552d6772c171dfb2c3fee Mon Sep 17 00:00:00 2001
+From: Alexander Heinisch <alexander.heinisch@siemens.com>
+Date: Tue, 17 Jun 2025 16:18:51 +0200
+Subject: [PATCH] classes/image-postproc: chroot before postprocessing
+ /etc/machine-id
+
+If /etc/machine-id happens to be a link to e.g. /var/...
+the postprocessing overrides build-hosts /var/... instead of
+the desired file on the rootfs.
+
+Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
+---
+ meta/classes/image-postproc-extension.bbclass | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/meta/classes/image-postproc-extension.bbclass b/meta/classes/image-postproc-extension.bbclass
+index 991bac4c..4f2a3d00 100644
+--- a/meta/classes/image-postproc-extension.bbclass
++++ b/meta/classes/image-postproc-extension.bbclass
+@@ -58,12 +58,12 @@ image_postprocess_machine_id() {
+     # systemd(1) takes care of recreating the machine-id on first boot
+     # for systemd < v247, set to empty string, else set to uninitialized
+     # (required if initramfs with ro root is used)
+-    SYSTEMD_VERSION=$( sudo chroot ${IMAGE_ROOTFS} dpkg-query --showformat='${source:Upstream-Version}' --show systemd || echo "0" )
++    SYSTEMD_VERSION=$( sudo chroot '${IMAGE_ROOTFS}' dpkg-query --showformat='${source:Upstream-Version}' --show systemd || echo "0" )
+     MACHINE_ID="uninitialized"
+     if dpkg --compare-versions "$SYSTEMD_VERSION" "lt" "247"; then
+         MACHINE_ID=""
+     fi
+-    echo "$MACHINE_ID" | sudo tee '${IMAGE_ROOTFS}/etc/machine-id'
++    echo "$MACHINE_ID" | sudo chroot '${IMAGE_ROOTFS}' tee '/etc/machine-id'
+     sudo rm -f '${IMAGE_ROOTFS}/var/lib/dbus/machine-id'
+ }
+ 
+-- 
+2.39.5
+
-- 
2.39.5


