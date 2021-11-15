Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38ACC433FE
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:26 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.24555.1636993225666436328
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=UXKFPjZL;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.178,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pg1-f178.google.com with SMTP id n23so14949547pgh.8
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjdOy9CS5ZWuEy65mhqt65d+1lsNNmAofS+vEMcdyK8=;
        b=UXKFPjZLZDlm/0iFkiXWxjeUc74c1RCVfUFQw1/vmkbhPlKuDqHxfnDYvm2uHZVo+w
         F6wrO0k+UZmf55m1sHr89ZV98yZoVxswqiRHBaptXSJQBPxEFW9n4ooFbJDXfca4YzCr
         wsuTx4Hqear2Ng19XRAcrtyGhwWZCiv711HXRk+o9p3tSwcOgRUF8OvxYN2Vn/0foicu
         ARso0YbsX7rEB5nMYKBkT02ENnasz+QhimUfsG0/k3GCEXPvnGtjLv2WSrTATV6yQjz2
         xgrfCDqQZP7OgyasSQVU3EptPlQYF5X6CEobrMsmddyRenkSpLpCtHE/MOaD0t3CUUTR
         MGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjdOy9CS5ZWuEy65mhqt65d+1lsNNmAofS+vEMcdyK8=;
        b=HsVK+KuvZEBIJpnJn9mFlRAaII8bOwmnvDW/57r3w5eRAhtk/GHJMm4GpLCPOi5Yw8
         RUxUV0Dah4YBIXQa1Tz1SVhfb1t/2sR/0l0i7j6mbKvmtzb8Ik3n9ns/VQN59nES8afU
         Zfx7r0we1lt6VrQE8gXb6ktSWmBK/9FTMGumzWMWcRsIebvPJ87bohPnsSHVROW93a4M
         kW2p6LRXdk5otlJXXYNOqBFlAnIO1K8v71GFObYpwELz7tLTl+ceRu9+JkbHKTcon848
         SCvMXLRpgkL5uAd0MK8DsFrIPanV0hXDL1Fvecq1fsI9KltECzGezL5mQo3hmJ/7s/64
         O8dQ==
X-Gm-Message-State: AOAM531qA/PPgC0uXZ+fwg+i7mb81SGkULU7jNkJr0us7hf5PUEIcZc7
	+nDENCYgDl8XNPGojf2z3gt4lfjnd1WFucA=
X-Google-Smtp-Source: 
 ABdhPJy0msmPqRhuSpsy1P0STkee7UGgisCr/NfmG7FxK4+GSlcIpR5TYLMqmaw0JfQ3NMpzkUn72A==
X-Received: by 2002:a63:8749:: with SMTP id i70mr42976pge.158.1636993224988;
        Mon, 15 Nov 2021 08:20:24 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:24 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 04/11] Create kernelci build step
Date: Tue, 16 Nov 2021 01:17:17 +0900
Message-Id: <20211115161724.19516-5-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6907

By default disable KernelCI upload and enable it only when 
needed for KernelCI image build.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 .gitlab-ci.yml | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index dd7d9cc..5f0463e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,7 +9,7 @@ variables:
   targz: disable
   dtb: none
   deploy: enable
-  deploy_kernelci: enable
+  kernelci: disable
 
 stages:
   - build
@@ -39,7 +39,7 @@ default:
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi;
-    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extention} ${dtb}; fi
+    - if [ "${kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extention} ${dtb}; fi
 
 # base image
 build:simatic-ipc227e-base:
@@ -79,6 +79,17 @@ build:qemu-amd64-base:
     wic_targz: disable
     targz: enable
 
+build:qemu-amd64-base-kernelci:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    kernelci: enable
+
 build:qemu-arm64-base:
   extends:
     - .build_base
-- 
2.33.1


