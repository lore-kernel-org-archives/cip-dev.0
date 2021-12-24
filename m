Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D161C433F5
	for <webhook@archiver.kernel.org>; Fri, 24 Dec 2021 07:33:29 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web12.43285.1640331208021807340
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 23:33:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=0daf3Rb2;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.169,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pf1-f169.google.com with SMTP id m1so7192705pfk.8
        for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 23:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIATOyQofeUF5Nuv6Ln+Oj2h/9BIXCrTWIgNB3B2qRg=;
        b=0daf3Rb2Ade4YByrpY0STbr4gz7+p5o62fJqvnnYAhtpqglK//9oW5p+js2uEvuCAS
         ncduANNgFvxIqCN1A7XAeuHih3o/TGdwCPg+gHweLJbSXNWGtlgLpfbvpkUJXMNcJkDl
         OZ4ZLsCnZMcwBkRVQx+/dr2SXWSYUneQtm/aXlx5VK4Qts6WRrFgsbod3wX0tWLQ+A8T
         7H5j18SstGGv3Hz2k45FT5A/msq/NJrVNpNj7t1KWN2d2/qim3y909fxq1mcLhbtYHMP
         pUg/mDfhTSfE5gxaAYzLT0BWpJ4FqOWUHEbd396VcQOvtsmsDGOkjiWQU3HWPsHF28Ip
         zvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIATOyQofeUF5Nuv6Ln+Oj2h/9BIXCrTWIgNB3B2qRg=;
        b=OM/OSxVA7rZTLp5Hm10fS391s4+ArJnJFZZZVGtgxpGZDMNv3Z7Lry07/28LbBPtbR
         c8Av7Aj9lWR3wHvu8Rm+Qg7hvWwitW9dvS5vqs7VHnIgcaIHkjSvINstgUrhKskrTyRr
         IJAZHv04WmgHk4aKbo4p5K6cGLoqVpJAbZwJAvVEoIvK0r6xmomLB6nwrJFVY3wmM/li
         EEQyHMkMVY7NKB2FTHLXWDDTSs+AKDZjfqvUsMu2T4EXG5zeQBfcUNM/njYIkKuK/+0g
         Kvzclq5/1/S5qkgkn2kDNoLlsKU1RhrUNzkW3dnvqRqwsM4TR4hLgzObYQItaUm8aSKf
         OreQ==
X-Gm-Message-State: AOAM531E3j05cqzncdXhKGn7XHF5fpDBQv5viEPuHo7aIJjJWMDjz6g5
	2XscdQ7JuN0jR6TdPmJgRzh1u4HgnvMw
X-Google-Smtp-Source: 
 ABdhPJzLvt9SqZEcNgUZIDGgTbcaygLbnKwpwCXyqXy2lgHUlH6Uc4nKGSJM1OO+CdCOBcG3M669TA==
X-Received: by 2002:a63:6ac9:: with SMTP id f192mr5118602pgc.79.1640331207628;
        Thu, 23 Dec 2021 23:33:27 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 u18sm8763175pfi.158.2021.12.23.23.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 23:33:26 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [PATCH 4/4] enable cip-core-image-kernelci
Date: Fri, 24 Dec 2021 16:32:42 +0900
Message-Id: <20211224073242.69676-5-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211224073242.69676-1-alice.ferrazzi@miraclelinux.com>
References: <20211224073242.69676-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Dec 2021 07:33:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7268

enable CIP core image KernelCI to be built with gitlab pipeline
and uploaded to the KernelCI storage using KernelCI API.
enable cip-core-image-kernelci to be built for amd64, arm and arm64.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 .gitlab-ci.yml | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e7db8c1..784343b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,6 +9,7 @@ variables:
   targz: disable
   dtb: none
   deploy: enable
+  deploy_kernelci: disable
 
 stages:
   - build
@@ -37,7 +38,8 @@ default:
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
-    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
+    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi;
+    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
 # base image
 build:simatic-ipc227e-base:
@@ -77,6 +79,18 @@ build:qemu-amd64-base:
     wic_targz: disable
     targz: enable
 
+build:qemu-amd64-base-kernelci:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    extension: kernelci
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    deploy_kernelci: enable
+
 build:qemu-arm64-base:
   extends:
     - .build_base
@@ -87,6 +101,18 @@ build:qemu-arm64-base:
     wic_targz: disable
     targz: enable
 
+build:qemu-arm64-base-kernelci:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm64
+    extension: kernelci
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    deploy_kernelci: enable
+
 build:qemu-arm-base:
   extends:
     - .build_base
@@ -97,6 +123,18 @@ build:qemu-arm-base:
     wic_targz: disable
     targz: enable
 
+build:qemu-arm-base-kernelci:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm
+    extension: kernelci
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    deploy_kernelci: enable
+
 # test
 build:simatic-ipc227e-test:
   extends:
-- 
2.33.1


