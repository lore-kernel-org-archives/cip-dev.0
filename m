Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2369D11703
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:38 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3930.1764667288282373844
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=BoJ9u8lE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-294854-2025120209212144a506c318000207e5-ikphsb@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2025120209212144a506c318000207e5
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=7k1KR4UsE+AJNON27SPAjytwcf3DZ/MKIyUkwRz+3+8=;
 b=BoJ9u8lE1AfAVT24Gv5FQXBlD3Bozfre4az+hhOrIiXVSLJ43sVg0QcWh3LdJX4bci+854
 AgMiKCuP0Ci/NNMjkGR4AW4PLp+bkm2FGEzIbc1J92f/g9x2olceswGJHo3cHvxH1FIeZt4C
 X067FyO6laTmft3hRj3soHXz2BP90F+tYBWwzkiR/jJ/JMGB4T2gDoa4iZxy8QB3p4c+okft
 LCFZ8il2QJWpNehauwdugrD6xOSZDEHOGERuUyKYxRFLc3iGSk5U5boFwHD4ghJswitpooZj
 uQAKQ3hGoGncFUbKTC7/uHQXFP3sb3yg28vYf/K/Xd+OKZo2XIeBNcLA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 10/14] ci: Combine targz with no_kernel option
Date: Tue,  2 Dec 2025 10:21:15 +0100
Message-ID: <2a68ea2fda9ed5b138683e308aaa95aed5909450.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20794

From: Jan Kiszka <jan.kiszka@siemens.com>

It's already auto-selected for kernelci builds, and the only other
reasonable scenario for it are no_kernel images. So let's simplify the
configuration.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 697de681..1042bc62 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -18,7 +18,6 @@ variables:
   extension: none
   use_rt: enable
   encrypt: disable
-  targz: enable
   dtb: none
   deploy: enable
   deploy_kernelci: disable
@@ -60,7 +59,6 @@ default:
   script:
     - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi
     - if [ "${extension}" != "none" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi
-    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz.yml"; fi
     - if [ "${separate_home_partition}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/separate-home-partition.yml"; fi
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
@@ -71,7 +69,7 @@ default:
     - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
     - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
     - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
-    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml"; fi
+    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml:kas/opt/targz.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
@@ -263,7 +261,6 @@ build:x86-uefi-secure-boot:
     target: x86-uefi
     extension: security
     use_rt: disable
-    targz: disable
     watchdog: disable
     security_test: enable
     build_swu_v2: enable
@@ -276,7 +273,6 @@ build:qemu-amd64-swupdate:
     target: qemu-amd64
     extension: ebg-swu
     use_rt: disable
-    targz: disable
     deploy: disable
     factory_reset: enable
 
@@ -306,7 +302,6 @@ build:qemu-amd64-secure-boot-bullseye:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    targz: disable
     deploy: disable
     swupdate_version: "2022.12"
 
@@ -336,7 +331,6 @@ build:qemu-amd64-secure-boot-buster:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    targz: disable
     deploy: disable
     encrypt: enable
 
@@ -348,7 +342,6 @@ build:qemu-riscv64:
     target: qemu-riscv64
     release: trixie
     use_rt: disable
-    targz: disable
     deploy: disable
 
 build:ti-am62px-sk-secure-boot:
@@ -359,7 +352,6 @@ build:ti-am62px-sk-secure-boot:
     release: trixie
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    targz: disable
     deploy: disable
     encrypt: enable
 
-- 
2.51.0


