Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430A2C5AC7A
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 15:45:07 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45355.1786117503671045111
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Aug 2026 08:45:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=Nh4Qyghv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1330684-20260807154505e0721b2e7900020714-w0is5q@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260807154505e0721b2e7900020714
        for <cip-dev@lists.cip-project.org>;
        Fri, 07 Aug 2026 17:45:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hsaDlAx51bk2/TRFevQb4MJh5cgtWjsgHpw3MkjlDtg=;
 b=Nh4Qyghv2NX8wDmwUJ1/jYuolcZi/jsiN3sAFXTSRXUwWFgfAyoqXvyXlfwVg60ALsWRVi
 mBfV3IwJ6y3FCNdDMP08nSMyOP0KN4+s3VPD0EdANuuFXRxEq2ZO9GjUzVUg6xF8CwljK+PS
 CdGihj4cwu6r38orAejXl65tP4Dz4fHCoHbUsmXMvoV9T2BRpsmAutgiOTD13WyBmsBsP+Bi
 WYnNrzLRFxgD4zOHddClzaWhcg1OnQTITDew2jhQxzukhUtLwgSFE9m/uuxH8eKx4+ZnUbYy
 zWn5FZZ6KwOmmfhU5hMi1jBKERQexyhEtY6JQwoecMrT9GUTywNxZnTQ==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] doc/README.factory-reset: Explicitly document full disk encryption is not supported with factory reset tpm clearing enabled.
Date: Fri,  7 Aug 2026 17:44:38 +0200
Message-ID: <20260807154439.625212-2-alexander.heinisch@siemens.com>
In-Reply-To: <20260807154439.625212-1-alexander.heinisch@siemens.com>
References: <20260807154439.625212-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Aug 2026 15:45:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23876

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 doc/README.factory-reset.md | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
index 4b1a1ab..15c4f60 100644
--- a/doc/README.factory-reset.md
+++ b/doc/README.factory-reset.md
@@ -23,6 +23,8 @@ and [systemd](https://github.com/systemd/systemd/blob/114ad16c4dcac136fb7646866f
 use the primary key of TPM. To ensure that the key is not reused the factory-reset deletes the primary key from the TPM
 before formatting the selected hard drives with a new LUKS container.
 
+> Note: By default, the factory reset deletes the TPM primary key. As a result, any A/B rootfs partitions using TPM-sealed encryption will become inaccessible, since their encryption keys can no longer be unsealed. Factory reset with full disk encryption on A/B rootfs partitions is therefore not supported unless TPM key clearing is disabled.
+
 The removal of the TPM keys can be deactivated by setting the variable `INITRAMFS_FACTORY_RESET_CLEAR_TPM` to `0`.
 As the factory-reset is executed before the disks are unlocked in the initramfs, the file system type must be provided with the
 variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of encrypted partition is not supported with the file based
@@ -54,7 +56,7 @@ root@demo:~# find /var -name "to-be-deleted"
 
 ## Use cases
 
-- The primary use case is resetting data partitions (e.g. `/home` and `/var`). This also resets any configuration changes made under `/etc`, since the read-write overlay for /etc is currently backed by /var.
+- The primary use case is resetting (wiping) data partitions (e.g. `/home` and `/var`). This also resets any configuration changes made under `/etc`, since the read-write overlay for /etc is currently backed by /var.
 - If the `/etc` RW overlay is backed by a dedicated partition (separate from `/home` or `/var`), that partition can be formatted independently to restore default configurations (included at build time).
 
 ## Relevance to IEC 62443-4-2
-- 
2.47.3


