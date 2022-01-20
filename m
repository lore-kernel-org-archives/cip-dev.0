Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C694C433EF
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 12:56:01 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web12.11059.1642683355739386866
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 04:55:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=VVPO9Mkr;
 spf=pass (domain: miraclelinux.com, ip: 209.85.216.41,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pj1-f41.google.com with SMTP id
 s2-20020a17090ad48200b001b501977b23so4958041pju.2
        for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 04:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTHS+D8v5iHTS/UXgT3kKjIanyW4w9irHfKQidWy9GY=;
        b=VVPO9MkrYrhG8Jc0LtizZNc41KhmFhuWF5+Ixvet2xyte6bIPic5+j+z8BVWcowQPf
         YjWsxe9zzbaPl0VS6DLhhXE6ltIxa+OjgL0mhUHl1r6Ay9x0SP7t0VZjdZW8678t67E7
         rdrkSnY9VhpyF+IZrIbDSVlHEbOM6LE+AD4Z8z63mGINUh5GlzhM9CzzeviBqOANGtV9
         O5v08e229Y58qc6Vl68HtoqiE7R/r588D/qrH+8W6m6bJPq8CvPhU/WmK1CjCDgeT3eV
         +MdHaBdJU9XOZ+CUzR7MJ0COh4YN5w/jbx09PDaVzkVuRxZXKQos2smqaqm57BCfjWrD
         AoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTHS+D8v5iHTS/UXgT3kKjIanyW4w9irHfKQidWy9GY=;
        b=Ga72z9mJVJwCIsxP5AhhjV3dh3f1LKZwCEpl4o4b02KGjJrTy8zQ47tXN1Eu5tLLBl
         gCoXs46LIrdDLnqlsDd3fgYaU1YgRUlWeU5dWIetGeMKeQeRWPI3MR2rZaRpTorKfy+U
         7OCOfD29xQPEZiPDyMngvO3Zizvd0Usb/kWZnB+znD4qKZydWcF4vVTIil7JzkJ0QvnG
         xni+nYDKexpZLYaOtqPsaQvi4aSyY44c/5TXt5eePlp0Y5qLs/8QXmFPmFwk0EU28QiS
         yTUuiS38nlV6E2vqtpSxioXbE4eSp6lrxfoTDSUkwpgCQcaGiYvlNjuKE1mj2/7HmpCU
         Bxtw==
X-Gm-Message-State: AOAM532eHaQWIidUr33uEoQW9esKVepcJwe0hgSl2sHeKjkOH0EJ0pXS
	Fj04vZRu7ti0tMxySnhUWjxFzy06diGe
X-Google-Smtp-Source: 
 ABdhPJxvkBaT/LIh9JeY+rvEr4wxNCYJQ15CEtzJLxUIQT+CAg2iWaKcqcoy4hKpFTnop4ZMLIZQbA==
X-Received: by 2002:a17:903:244e:b0:14a:537b:db0b with SMTP id
 l14-20020a170903244e00b0014a537bdb0bmr37642686pls.28.1642683355267;
        Thu, 20 Jan 2022 04:55:55 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 n11sm9975634pjf.29.2022.01.20.04.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:55:54 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v2 2/4] Add dmesg filter needed for lava test
 result
Date: Thu, 20 Jan 2022 21:54:16 +0900
Message-Id: <20220120125418.236990-3-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jan 2022 12:56:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7474

KernelCI is using a dmesg filter script for checking dmesg
logs result with lava.
Adding the script to the cip-core-image-kernelci.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 .../kernelci-customizations/files/dmesg.sh    | 23 +++++++++++++++++++
 .../kernelci-customizations.bb                |  1 +
 2 files changed, 24 insertions(+)
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
index dca0891..c3f677c 100644
--- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
+++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
@@ -18,6 +18,7 @@ DESCRIPTION = "CIP Core image demo & customizations"
 SRC_URI = " \
     file://postinst \
     file://ethernet \
+    file://dmesg.sh \
     file://99-silent-printk.conf"
 
 DEPENDS += "sshd-regen-keys"
-- 
2.33.1


