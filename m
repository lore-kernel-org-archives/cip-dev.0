Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB69ACCF9F0
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:01 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.26591.1761549712479131097
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=TtoIb6v+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-2025102707215079d1d2f570000207cf-la_oml@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025102707215079d1d2f570000207cf
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zc4ZANHkshbNQntsZENb1S/J6D6J6rZlSMILgZD982k=;
 b=TtoIb6v+JFjiBLj0BxDZ95wBnA5Oq/hunbY+jbSi+AthdU1VXQlB+UU3aJgQR5Cce7lRhk
 5nf+8mV8WCmSJtUeirnqG9dZ7uuzPZkf29eqYNnRGHm18vkBtx85NrHYz6HhQpRDtGfUlGym
 odExCf1QalVpsNWPkNzFEnH+5EqmzP+zOKC3+534nzOP0iFqsYwC67OkTYbrR0wJw1Q4pOJ7
 ZJkVp1kKHPLjj+8b2WTm5A8Rrb8BkMTOfQW8Lu9DNDwX5RzfRH8Fp3WM8cOOQDsbouvQdsqf
 rpl73FPCQBsTDHBpPqD1zPzYe++XwFCdTlC41Ssw+3sSR+KyqBS/co6g==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 11/19] cip-core-initramfs: Add initramfs-tee-ftpm-hook when needed
Date: Mon, 27 Oct 2025 08:21:40 +0100
Message-ID: <c93038fe8eba7dfb0ce1104d80b17177dc1bb7df.1761549708.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20223

From: Jan Kiszka <jan.kiszka@siemens.com>

This ensures that all modules required for the fTPM are part of the
initramfs.

We only support fTPM with kernel 6.12 are newer, so
TEE_SUPPLICANT_IN_USERSPACE can be disabled by default.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-common.inc                            | 2 ++
 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 1 +
 2 files changed, 3 insertions(+)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 86f79f0f..b5c0d5ac 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -23,3 +23,5 @@ PREFERRED_VERSION_linux-cip-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip}"
 
 PREFERRED_VERSION_linux-cip-rt-native ?= "${PREFERRED_VERSION_linux-cip-rt}"
 PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip-rt}"
+
+TEE_SUPPLICANT_IN_USERLAND ?= "0"
diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 4fe7ee15..c54a4897 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -17,3 +17,4 @@ INITRAMFS_INSTALL += " \
 
 INITRAMFS_INSTALL:append:encrypt-partitions = " initramfs-crypt-hook"
 INITRAMFS_INSTALL:append:factory-reset = " initramfs-factory-reset-hook"
+INITRAMFS_INSTALL:append:ftpm-stmm = " initramfs-tee-ftpm-hook"
-- 
2.51.0


