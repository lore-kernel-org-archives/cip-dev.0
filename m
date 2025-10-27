Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04578CCF9F2
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.26393.1761549712335410639
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=HrqtPsee;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-2025102707215164e1583edf00020714-rnkv_m@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025102707215164e1583edf00020714
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=43lf7cEQ0IVUzzcQx0oXUXgWG0GIaJ2KbHZIpr8HgJ8=;
 b=HrqtPseeuTBbYmNw8SZcALfj4x5teYLHC8XhuuQj/t81WnoaQFfnrCCc4M31tXvnGLsbUU
 s3kFExwI/XM/cT4MawaSOB3Dse0VbGIlSKBDHSsQ9QVi3w2OHYpxZovpecGySyVoDEoszeDC
 p420rAqJ3NVb8dj2iu2GH2rm8jZHxJg8s+Sbr24575qyb/wOXL5QSseGcsEcAqDExuJSxy2U
 +bjtTZ1GwBcE2OkBQsZBMP3FiAYwDBKfUAR8qE0loYlrTyCIbM2iEa8irp42i+qWcuF5nePA
 KFevJvJ0rclULlMlGERLILjQp9wqq8mOvNAUpVyOvgMu6N/oZSINz1Ew==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 19/19] linux-cip: Disable CONFIG_HW_RANDOM_TPM in QEMU
Date: Mon, 27 Oct 2025 08:21:48 +0100
Message-ID: <00207b2fc3d8b4803396e906e0f89c817d6da97c.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20239

From: Jan Kiszka <jan.kiszka@siemens.com>

It turned out that the fTPM at least writes every 4 seconds its time to
flash when executing commands while hwrng asks it for a random number
every minute if this config is enabled, triggering the write.

Disabling is recommended for now, also for discrete TPMs. We do that via
config snippet so that the official CIP kernel config keeps the feature
in scope.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc  | 3 ++-
 recipes-kernel/linux/files/no-tpm-hwrng.cfg | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 recipes-kernel/linux/files/no-tpm-hwrng.cfg

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 8baf79b8..6c9ac568 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -10,7 +10,8 @@
 #
 
 SRC_URI:append = " ${@ \
-    'git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;branch=master;destsuffix=cip-kernel-config;name=cip-kernel-config' \
+    'git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;branch=master;destsuffix=cip-kernel-config;name=cip-kernel-config \
+    file://no-tpm-hwrng.cfg' \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
diff --git a/recipes-kernel/linux/files/no-tpm-hwrng.cfg b/recipes-kernel/linux/files/no-tpm-hwrng.cfg
new file mode 100644
index 00000000..ab46cd81
--- /dev/null
+++ b/recipes-kernel/linux/files/no-tpm-hwrng.cfg
@@ -0,0 +1,2 @@
+# see https://lore.kernel.org/lkml/bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com/
+# CONFIG_HW_RANDOM_TPM is not set
-- 
2.51.0


