Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB3C6FA8E
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 20:31:01 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.5500.1677789059648389585
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 12:31:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=liw7kjgt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20230302203056bf9cf580eec6e3cb09-ijbzv1@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230302203056bf9cf580eec6e3cb09
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 21:30:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mc3M9bDlAnSxapUV9shCKDUxWNekgKWzSa2bjggDDUI=;
 b=liw7kjgtiruAeBRubPr5zKIWH3J1yexqRMxPfyYAf9ZaOMKPGZOVIn8vZWU2KicLTyN4UC
 AB68lmbTtBHzY8RHgEJ0PmCDcQm0NWc6yoaa7iPGVTpd/Jd0Z6z9GDNjs/+nXPKy5Zl0kz1f
 RFXPmeGdS22bku3Nmec9RDDAEyi4w=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 4/5] cip-core-image-security: Add support for SWUpdate
Date: Thu,  2 Mar 2023 21:30:53 +0100
Message-Id: <eb47ff287a4397729795bb830768825728a7eade.1677789054.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1677789054.git.jan.kiszka@siemens.com>
References: <cover.1677789054.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 20:31:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10888

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to enable both SWUpdate and the security-extended image at
the same time.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/security.yml                           | 3 +++
 recipes-core/images/cip-core-image-security.bb | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index c385a627..4d119056 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -18,3 +18,6 @@ local_conf_header:
     USERS += "root"
     USER_root[password] = "Cipsecurity@123"
     USER_root[flags] = "clear-text-password"
+  adjust-swupdate: |
+    ABROOTFS_IMAGE_RECIPE = "cip-core-image-security"
+    VERITY_IMAGE_RECIPE = "cip-core-image-security"
diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index bfd91bd3..563de897 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -43,3 +43,6 @@ IMAGE_PREINSTALL += " \
 # Package names based on the distro version
 IMAGE_PREINSTALL:append:buster = " libtss2-esys0"
 IMAGE_PREINSTALL:append:bullseye = " libtss2-esys-3.0.2-0"
+
+CIP_IMAGE_OPTIONS ?= ""
+require ${CIP_IMAGE_OPTIONS}
-- 
2.35.3


