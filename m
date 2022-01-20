Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D60C433FE
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 12:56:03 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.11212.1642683362027040130
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 04:56:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=JtBqGA8C;
 spf=pass (domain: miraclelinux.com, ip: 209.85.216.49,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pj1-f49.google.com with SMTP id
 s2-20020a17090ad48200b001b501977b23so4958351pju.2
        for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 04:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gg+ppPp5FucG+md+HTlpu2GaKreMSHMuhWd/UbzxLeM=;
        b=JtBqGA8Cr5/xPdz0tJuD9WPfdALts3Q6at6eoNFJ6fS1qmbCvqeOjnxWt4VcJn+7t7
         9eyo5e4XFFdijT9wy06qDi+WzLfuD96mgkYfViOn06jhId9xpPcP32vkmcJecO2srWYV
         u4gE76ZdLxZZ6RlHwdj+aTbc0BvPhvW+fkT8B8R+8qJkK6XXRww2jNRZfv2CrqvWi750
         cIuavDe+Z5/G252KHxSx+UtHQX8p/NTTWdmo9IFyuYf36mvENso6h6+t3i0BePllkFqP
         26IKn+dqAetm9jeW23oLSpwOq+xnjR64J9IeFjs4rJsiUYgwHQX8Yk5l/mOZjUoCurzY
         iTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gg+ppPp5FucG+md+HTlpu2GaKreMSHMuhWd/UbzxLeM=;
        b=J9hk0dFMqVEuQnM8DViVZnBDXLhShmRV5shIgmw+6/ZiIJa38z/nsgeEZ/yT64vvRT
         /+XCz3u0GoMcZe0OyfeOMX8IPFUJlqDCTYvCYQP5yq5X2l16bUR9hGXAMeozCQZBZ0uX
         EKS3jLrrT3xFY18ixPtpfhs654oX5NZPctcq5628PIj3r8HoWjz28FZLvzg2yBU7dvTa
         fLPo6rhLDOrn1T2pZ0OJxO3Guvyw45TVkBeP38Vg+AZJTfLgwpBIo+QqYmK25KgBwPN/
         i1qND/IxfQ5ccHbx17OMmeBhmnEBTiTx9WlqoVlf9Z0FHnSSscT4XM09KUY/HvLtDMQR
         IwSg==
X-Gm-Message-State: AOAM532RaVVuh3NxXYAbBoaMZopb8QNvNuqzULqmowui8ec5SXz1zyCd
	VQXJMZ6RtS/5M4JmnmASmZsKaNAHNfXa
X-Google-Smtp-Source: 
 ABdhPJzEtBNhz4nnFTndeD9QBuoRtISgNlKR32kB1DJDRpZj9eZNzGY4M+ulHeGNk/owbhn8sOuiug==
X-Received: by 2002:a17:90b:224c:: with SMTP id
 hk12mr10563487pjb.62.1642683361556;
        Thu, 20 Jan 2022 04:56:01 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 n11sm9975634pjf.29.2022.01.20.04.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:56:00 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v2 4/4] enable cip-core-image-kernelci
Date: Thu, 20 Jan 2022 21:54:18 +0900
Message-Id: <20220120125418.236990-5-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jan 2022 12:56:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7476

enable CIP core image KernelCI to be built with gitlab pipeline
and uploaded to the KernelCI storage using KernelCI API.
enable cip-core-image-kernelci to be built for amd64, arm and arm64.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 .gitlab-ci.yml | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e9cbc60..c06c783 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,6 +9,7 @@ variables:
   targz: disable
   dtb: none
   deploy: enable
+  deploy_kernelci: disable
 
 stages:
   - build
@@ -38,6 +39,7 @@ default:
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
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


