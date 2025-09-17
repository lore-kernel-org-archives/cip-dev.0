Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B55CAC599
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 08:01:21 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.17468.1758096070251967021
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 01:01:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=alGzacUJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20250917080107254147c89b0002073f-k7tukc@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250917080107254147c89b0002073f
        for <cip-dev@lists.cip-project.org>;
        Wed, 17 Sep 2025 10:01:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=QUe2BJRR1OkDbIelUIno7JxFosSa6o2wz8k01cHQcHs=;
 b=alGzacUJrh+7UYNBro9Gnw8Uc+IPBdLToXOHO/wKRk6BcGo1W9RnmEN1wuehiYmWEfHIm7
 SdsUr89A2lObiJlg2gCiXvGy7LTeLWnmXk0BR0BA6k0Bm61gyM+gNzssL50LwVhtJAzqkPq/
 scVsB6+IpxG3acmdpIYCTsKeVLcEnMV4lpjto8hfnb81uE2bXr+oJ6K30fDVB9jq6IOYdcXx
 XOQgSllJC6LWkZbq8GSjT/U6u4vk7xCoQKaOcM/CQQezC+jRlrJ6N98n8ldS0n91VBIiJMLe
 WcSHid1eQAOl8ay8/wmRDI8tFU8ZwUkmeERK+KvJf/GjISFr2l1QgARw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/3] ci: Switch test jobs to self-built lavacli container
Date: Wed, 17 Sep 2025 10:01:06 +0200
Message-ID: <640238410510929209d1478e994533e53bf74f34.1758096066.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758096066.git.jan.kiszka@siemens.com>
References: <cover.1758096066.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 08:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20066

From: Jan Kiszka <jan.kiszka@siemens.com>

This accelerates the startup of the test jobs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml         | 4 ++--
 scripts/submit_lava.sh | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index de082272..99c8013b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -12,8 +12,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-image: ghcr.io/siemens/kas/kas-isar:4.8.1
-
 variables:
   GIT_STRATEGY: clone
   release: bookworm
@@ -47,6 +45,7 @@ default:
 
 .build_base:
   stage: build
+  image: ghcr.io/siemens/kas/kas-isar:4.8.1
   rules:
     - if: $CI_COMMIT_TAG
       when: never
@@ -344,6 +343,7 @@ build:qemu-riscv64:
 
 .test-cip-core:
   stage: test
+  image: $CI_REGISTRY_IMAGE/lavacli
   rules:
     - if: $CI_COMMIT_TAG
       when: never
diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 5cb4430c..ea733748 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -38,8 +38,6 @@ image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -smp 4 -device virtio-seri
 image_args[qemu-arm]="-cpu cortex-a15 -machine virt -smp 2 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
 
 set_up (){
-	echo "Installing dependencies to run this script..."
-	sudo apt update && sudo apt install -y --no-install-recommends lavacli curl xmlstarlet
 	job_dir="$(mktemp -d)"
 }
 
-- 
2.51.0


