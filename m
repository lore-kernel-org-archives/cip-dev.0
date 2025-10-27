Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E3CCCF9EB
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:01 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.26591.1761549712479131097
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=bCIbsDCk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20251027072151205a05e4fa0002074f-k5jo69@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251027072151205a05e4fa0002074f
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MhbQFOiHTES64bn9jBwaCLcImtkDAVEFtY2AwNcR/6I=;
 b=bCIbsDCkqTRhONIof2vknw3FPGxi2aDKOAzCdg4S8X1yHwumWnACdSikkWvGBZcOgv2FzJ
 ZhOJIYTibQANozm4x50RQM+ZejixdQOwVId/ambaeOw1EM9BAlc1ZotYTZ7Aj75A6g0w/hXC
 6dnwWbGnrx9jYrTNrV9mzYUNZfzSD3nf9ARVPrbsFJZoyKBUBek0K8ImnXsx7M3y0dKZwecC
 PT9C2XYgJCzOvxdykOZAfEjlmYe3M4ebRE/VaGkfobLkz76sgfhHmzi4rapg7cAauhO7ugCT
 sKcX820GK5ctQs3z2fneUbpaDWVQWWfPv2teRNjz1h0egotDNP80QSpA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 14/19] customizations: Install efitools in secure boot mode
Date: Mon, 27 Oct 2025 08:21:43 +0100
Message-ID: <02efba06ae27eecae94c69ae864a26ea2155b31f.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20240

From: Jan Kiszka <jan.kiszka@siemens.com>

This is useful for initially deploying or updating the UEFI keys to the
running system.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/customizations/customizations.bb | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index 3f6b5de3..bf6e7175 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2022
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,6 +14,8 @@ require common.inc
 SRC_URI += "file://ssh-permit-root.conf"
 SRC_URI:remove:security = "file://ssh-permit-root.conf"
 
+DEBIAN_DEPENDS:append:secureboot = ", efitools"
+
 DESCRIPTION = "CIP Core image demo & customizations"
 
 do_prepare_build:prepend:qemu-riscv64() {
-- 
2.51.0


