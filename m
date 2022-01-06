Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D68C433EF
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 11:17:23 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.7281.1641467838712259538
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:17:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=II2UGZdL;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.176,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pg1-f176.google.com with SMTP id 200so2284592pgg.3
        for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIATOyQofeUF5Nuv6Ln+Oj2h/9BIXCrTWIgNB3B2qRg=;
        b=II2UGZdLMBY9b8s96tcXasd7XxDyX9vSdmMeYxH3LE6hiD5UYv5m+YkYSh2tHi7laJ
         IABD1YKjgnHWStDXL2uH5B5SxEYLCWdq6nMX5K1igq+OHNej6NxS08avKgHQUdCmjqbP
         /bqg/CetuPhEHZlpM0p6Utkg799Mzf70kaxdvANMHNjpYatJcD7pEunzfnGOPFuyfgJU
         rzqrntl7iKlG9np6pB9iNFcQlJ+f+gHfWESJbV+SPC+kfCQxfZl+J4m4aKHAbF7gXdOW
         G6PPGdw5z+w71+0Th0JpdIRxqPqp0rayMgu1iU7KIlQdWCCrhjKcjrNta5G3o8vA129q
         VxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIATOyQofeUF5Nuv6Ln+Oj2h/9BIXCrTWIgNB3B2qRg=;
        b=wFN6UOYGFLWwTZiBhKtjnUAOGnv6FZ6v9CMsU5CYgftjy946NOmUYqKNBKPT0FeW67
         2iwh0JW5KOHo0nUhHca83cftiz3b/cnILVIVIwzAyYD80MO7nXzP5v8Hnpuk7u/oGfSg
         9xG2rOHub+x709I2lYvK7uk/IxLqDPxx4s22YJH9LxOb+DCqG+LzkL2HlJYN1yCEHwz6
         O2VSJ++MtORG+lFyuu+4vtlBbMW54F9XyZhS9Y1gC2bRcTQup0bq2+UkmpShCF/Cap66
         ACE0z05NPKxaEUTp1KFas832qC/M1hYLkq9GfQ4UVonjKwcTRREwy8NGmlc1M9AvKjnY
         CXqQ==
X-Gm-Message-State: AOAM531GskFjsqRPltFH79cttM3PE23hmnuP6wctZ1BmOewGnrEZeNE2
	oV0ZeD5JgcYM82TZEcL7VwNnI+ynfiNl
X-Google-Smtp-Source: 
 ABdhPJzKV4jascWgDXbGDluHKy6GxyIaGZNq+9hUn2/voobJ2trM+d2FPigjm28lnX43IYn+KMaO9w==
X-Received: by 2002:a63:700d:: with SMTP id
 l13mr52722093pgc.333.1641467838366;
        Thu, 06 Jan 2022 03:17:18 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 x6sm1766325pge.50.2022.01.06.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 03:17:17 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 4/4] enable cip-core-image-kernelci
Date: Thu,  6 Jan 2022 20:16:14 +0900
Message-Id: <20220106111614.218823-5-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 11:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7330

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


