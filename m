Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F80C433FE
	for <webhook@archiver.kernel.org>; Fri, 24 Dec 2021 07:33:20 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.43150.1640331199234655385
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 23:33:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=A0q2YhJR;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.181,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pg1-f181.google.com with SMTP id f125so7165208pgc.0
        for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 23:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTHS+D8v5iHTS/UXgT3kKjIanyW4w9irHfKQidWy9GY=;
        b=A0q2YhJRmQXXzQmGyUxjX37MWIiD9DJWHzqy69o8ExSXmiJks3ODTorssfSmF3rIHp
         xtla4fr3fHR4Lp9S+b4FdSpAUjUtI5W24BjEAaIkpQizVtamjEKa7JUg6vbZyZUzLqkl
         lc/ClnpYawAScEHX6IUR9lVFNLQLsnZtHxHB0o2vDJ6XY/7KR3JFQLFkALv032ObjOc6
         ueucoNHrMndKWGTmH8BrCMdPV3bx4X3LsEaChXQunVp3TplOkceO0wT91f0cSxVErKJf
         YN7zI0ULX/nVpQFk4kgl4Y73yTrGQNwqFsrZqkjrSjqrztbgaKu4/JhTqPpmZpCdysSg
         AnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTHS+D8v5iHTS/UXgT3kKjIanyW4w9irHfKQidWy9GY=;
        b=KsbLGIABxtXypjsitXn1EvJvctJsWI1MJOTov1iNy0fge8kXOBIzg/DKk2HVrdDX64
         uckyJpHm+7v/tzp2JgpARzVb1jnTC/HWrLbGN7Zr0BKxvNrpbjSN0qLJQ1cAldnRG3tW
         SmU0vUyIXdg2nkQEjXzXvA2Ag14GjvUAF3ioAfaqEoPJWwTFM6sm25o9oVHbjsWexrfu
         pYxmeRIjvp6qx5zHxzrBgud9q9rqR5mObzyQsxELz5ZRgoTnD1PwnZhkgLm4jfoRQ4uB
         0lyqh5P90CSZGpME1rdXyNo3smcQJGdCR5jq/7OEtI0p0pGvrXBQ1hLr+Yhuov+pCJWK
         yBrQ==
X-Gm-Message-State: AOAM533CwnNME8P9pzpJ9iJFVyTm51TvSDqMsozsTV/W/tcgTqYYwJXZ
	BEjFMFhQ+vXKn/d6Uc1kuiYI77rUsuG4
X-Google-Smtp-Source: 
 ABdhPJxTXnqoeeeJKwHIlnYOR3KvA+tkBLtuKjetOxMCUsm3Ed7917AChzk2fYakbYNEWsZv9Ef8tQ==
X-Received: by 2002:a65:5bc4:: with SMTP id o4mr5007042pgr.489.1640331198723;
        Thu, 23 Dec 2021 23:33:18 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 u18sm8763175pfi.158.2021.12.23.23.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 23:33:18 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [PATCH 2/4] Add dmesg filter needed for lava test result
Date: Fri, 24 Dec 2021 16:32:40 +0900
Message-Id: <20211224073242.69676-3-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211224073242.69676-1-alice.ferrazzi@miraclelinux.com>
References: <20211224073242.69676-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Dec 2021 07:33:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7266

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


