Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB834C433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:41 +0000 (UTC)
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by mx.groups.io with SMTP id smtpd.web09.24770.1636993240649585664
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=HIuB7Ueh;
 spf=pass (domain: miraclelinux.com, ip: 209.85.214.196,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pl1-f196.google.com with SMTP id v19so4164669plo.7
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qM5NKEFLl6w02DySQC+9Qr0hpqAPAAOh4OF2MtLXxwo=;
        b=HIuB7Ueh/V7COjjUZPENrmaT2htp7P9HbtOY4mZ5+u3d2uCEa0D5VoXk9SRIaa/n2c
         u1x43C+hXaXHEizo5Il/LqB3cgPdcoJjYmn/uEWeGH8Ar8sCyquxpe+nlCP2Y3bWBDGu
         o7oia7zKKwnB0bGn7KnC8iiBb/DN1flabQi672bHhL3+pdP0POHOBIk5AF5FQ/1z1E0+
         UZK3yJy4IlqjdvZF85jeyHP7Z2dr4DUqpaWF0Z5KajlJtwAlDhpFvXcmy4HJevu41mkU
         p7F7Se9zDXzLXRD/QtQatTbYbYdTFlkkYtYuqz3bCP6dTFOMkYh55nEoHw8Ufs+qdgGC
         pcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qM5NKEFLl6w02DySQC+9Qr0hpqAPAAOh4OF2MtLXxwo=;
        b=zUtghtB9ButKu26E/inrKBCun79CR5adLdLnom0ZK1mjnqmHkHoUh5YexZCjSewWEW
         LHjCUkIJ1RnTDweHinVoQT4/rEGj7Dg+mdZqBAheksUxCuBgvLK2f1wJtFYCR3Fse7Gm
         8hvXIcs9zXKmhwEBh57RX8+ZMf3e8qoLHD6LoVw4v9LnbicJzsD0HXMSKs99mCB37Zhh
         b700wkdIPRDvkA07fkGy5sdsM2nxjdnlJbwGaHz/58yS81ubz/cgh4w2b5J3iUP/roRV
         WZ/a1JeJ8n1y0V8pbsKpgCGqtq1yQSaLKQlfN3DLBs1ACb+fsQbtxeArbg3OlFh/Nx4C
         fqTA==
X-Gm-Message-State: AOAM530QGoIhFOSR4KKqfH7buuyeyb7z+Wzaw4QuAMo8SdOWIfS08Tu1
	Iw9mZ+Bx/4rk+QYCNtAp3QRHVw75KeMpJm4=
X-Google-Smtp-Source: 
 ABdhPJyXoDm4jXJS/qWb/IXQLTUb29wKM2NXntdVJ4Y33Y3e2/H/+dvO3xg58m2RsviBE/6oJP45Bg==
X-Received: by 2002:a17:902:f551:b0:143:759c:6a30 with SMTP id
 h17-20020a170902f55100b00143759c6a30mr37517539plf.0.1636993240258;
        Mon, 15 Nov 2021 08:20:40 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:39 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 10/11] dmesg.sh is needed for KernelCI
Date: Tue, 16 Nov 2021 01:17:23 +0900
Message-Id: <20211115161724.19516-11-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6913

This script is needed for make dmesg logs readable by lava.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 .../kernelci-customizations/files/dmesg.sh    | 23 +++++++++++++++++++
 .../kernelci-customizations.bb                | 12 ++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh

diff --git a/recipes-core/kernelci-customizations/files/dmesg.sh b/recipes-core/kernelci-customizations/files/dmesg.sh
new file mode 100644
index 0000000..3b096e1
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/dmesg.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+set -e
+
+if [ "$KERNELCI_LAVA" = "y" ]; then
+    alias test-result='lava-test-case'
+else
+    alias test-result='echo'
+fi
+
+for level in crit alert emerg; do
+    dmesg --level=$level --notime -x -k > dmesg.$level
+    test -s dmesg.$level && res=fail || res=pass
+    count=$(cat dmesg.$level | wc -l)
+    cat dmesg.$level
+    test-result \
+        $level \
+        --result $res \
+        --measurement $count \
+        --units lines
+done
+
+exit 0
diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
index 15788a0..df4257c 100644
--- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
+++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
@@ -18,6 +18,7 @@ DESCRIPTION = "CIP Core image demo & customizations"
 SRC_URI = " \
     file://postinst \
     file://ethernet \
+    file://dmesg.sh \
     file://99-silent-printk.conf"
 
 DEPENDS += "sshd-regen-keys"
@@ -26,9 +27,12 @@ DEBIAN_DEPENDS = " \
     ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
 
 do_install() {
-	install -v -d ${D}/etc/network/interfaces.d
-	install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
+  install -v -d ${D}/etc/network/interfaces.d
+  install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
 
-	install -v -d ${D}/etc/sysctl.d
-	install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
+  install -v -d ${D}/etc/sysctl.d
+  install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
+
+  install -v -d ${D}/opt/kernelci
+  install -v -m 744 ${WORKDIR}/dmesg.sh ${D}/opt/kernelci/
 }
-- 
2.33.1


