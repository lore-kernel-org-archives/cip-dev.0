Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E69FC433FE
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 11:17:18 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web12.7215.1641467833448547009
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:17:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=1ap6dB6t;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.182,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pg1-f182.google.com with SMTP id 8so2265546pgc.10
        for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTHS+D8v5iHTS/UXgT3kKjIanyW4w9irHfKQidWy9GY=;
        b=1ap6dB6tlcBV+8dKls/bkq1m9fK3NrWv2hkRba5OD/gr1mHhBn1o6TRl7gug1HIwsC
         hocn4Q8eHOPsTqwb+vjpRSSQBB91G7wBm3v6kVr0b/uFgnMM+iAGN016K1UOb4MBuaCY
         KRgrgUpOIGAsgrH9bUWr/GGOWc9N8trUxRUJ7eo3TBx/a1cw8YvT13cyzE2dxyxA3NGk
         TUEIh+7d74jWhr6hpgS9QKjKkgjYUcnuYI0GnF8GoByhWTMQmadSlcdd52VZ+So7MPQd
         WSNmS5WIIcTq5muFpur5xEU9Jbhjw+O7VCT4KoxLrfFJDBlUPSGk8b2BEQcVEDEk3MEX
         oWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTHS+D8v5iHTS/UXgT3kKjIanyW4w9irHfKQidWy9GY=;
        b=bYWrC/lahc7/MZEwltHMrQR8myBlSbRrD06uLCN3+3nl1anzINSo/PN5TwPhVC8NHu
         QQ8jLxv8qXJNyX8fbRBxKuvZ8nizttPHeNE7hEm6FSroa8/rjtt3RqhYgwINquIQlBKx
         KC46m0QgZ7IH8B/RqPfldGG8Ix8o7fP+dopCaBvY2MlR6AS92EN4T56sZZ7VbinBUHAy
         fmv3MIxacgnIjL7HqIw2fL7qSPiSXDpBi7Hfxfq/CMbnQfH1hhGG21Wybr/UlKg3aMyz
         LB5gYbgCD3v++NxVARvIvz8VW5dsmojjs9hTMbCg3cUYSKdfYvQxNQTBYQhE93XIpXlb
         ZFgQ==
X-Gm-Message-State: AOAM530xujZtUrnfg4OqHwVkzTnSIs7YmTsiEGKoOFfaOT/e/sydnsDa
	FIHb4vXAGW9qAchdb0YzK5yz9LokFC74
X-Google-Smtp-Source: 
 ABdhPJyR3jy5rOghBfHTfqFJY+sn3FiYJDEqFTuTvV3wgIBRRSfCMTyl8fORbveugLSiWB+f7ouSsA==
X-Received: by 2002:a62:ed06:0:b0:4bb:1152:2fbd with SMTP id
 u6-20020a62ed06000000b004bb11522fbdmr59513822pfh.34.1641467833050;
        Thu, 06 Jan 2022 03:17:13 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 x6sm1766325pge.50.2022.01.06.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 03:17:12 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 2/4] Add dmesg filter needed for lava test
 result
Date: Thu,  6 Jan 2022 20:16:12 +0900
Message-Id: <20220106111614.218823-3-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 11:17:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7328

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


