Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802C1C32774
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 04:12:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.38230.1660795955001224132
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 21:12:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 27I4CXjH019485;
 Thu, 18 Aug 2022 13:12:34 +0900
X-Iguazu-Qid: 34tMXISijY6hN7RMHJ
X-Iguazu-QSIG: v=2; s=0; t=1660795953; q=34tMXISijY6hN7RMHJ;
 m=uYi5ad5Gi27dB8YSQXUebnAX0oLqDnA522OwR/JzUeY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 27I4CXxR024107
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Aug 2022 13:12:33 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/4] customizations: add custom modifications for
 swupdate
Date: Thu, 18 Aug 2022 09:34:27 +0530
X-TSB-HOP2: ON
Message-Id: <20220818040428.11124-4-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Aug 2022 04:12:28.0283 (UTC)
 FILETIME=[BAA98CB0:01D8B2B8]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 04:12:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9286

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Add /boot entry at /etc/fstab for /etc/fw_config and also add network
settings for SSH connection

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 recipes-core/customizations/common.inc       | 5 ++++-
 recipes-core/customizations/files/interfaces | 6 ++++++
 recipes-core/images/cip-core-image.bb        | 9 +++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/customizations/files/interfaces

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index 1124ff2..e5f31ca 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -17,7 +17,8 @@ SRC_URI = " \
     file://postinst \
     file://ethernet \
     file://99-silent-printk.conf \
-    file://99-watchdog.conf"
+    file://99-watchdog.conf \
+    file://interfaces"
 
 WIRELESS_FIRMWARE_PACKAGE ?= ""
 INSTALL_WIRELESS_TOOLS ??= "0"
@@ -38,4 +39,6 @@ do_install() {
 
 	install -v -d ${D}/etc/systemd/system.conf.d
 	install -v -m 644 ${WORKDIR}/99-watchdog.conf ${D}/etc/systemd/system.conf.d/
+
+	install -v -m 644 ${WORKDIR}/interfaces ${D}/etc/network/interfaces.d/
 }
diff --git a/recipes-core/customizations/files/interfaces b/recipes-core/customizations/files/interfaces
new file mode 100644
index 0000000..be04284
--- /dev/null
+++ b/recipes-core/customizations/files/interfaces
@@ -0,0 +1,6 @@
+auto eth0
+iface eth0 inet static
+  address 192.168.2.2
+  netmask 255.255.255.0
+  network 192.168.2.0
+  broadcast 192.168.2.255
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 3f8c320..7bf0f22 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -18,3 +18,12 @@ IMAGE_INSTALL += "customizations"
 
 CIP_IMAGE_OPTIONS ?= ""
 include ${CIP_IMAGE_OPTIONS}
+
+image_configure_fstab_append () {
+    # Add /boot to /etc/fstab for fw_printenv
+    echo "/dev/mmcblk0p1 /boot vfat defaults,nofail 0 0" | sudo tee -a ${IMAGE_ROOTFS}/etc/fstab
+    # remove /var partition
+    sudo sed -i '/LABEL=var/d' ${IMAGE_ROOTFS}/etc/fstab
+    # make /dev/root as read-write
+    sudo sed -i 's/defaults,ro/defaults/' ${IMAGE_ROOTFS}/etc/fstab
+}
-- 
2.20.1



