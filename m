Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8B9D59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 06:26:42 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42271.1765779992287822630
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 22:26:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=P4PjRYWk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20251215062629811102300c0002072d-ddmw8e@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251215062629811102300c0002072d
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Dec 2025 07:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=qrMTedZJWrp68hAtWoFSswpLmKT7Lq3KVuzC1Wzv2Mo=;
 b=P4PjRYWk+zvOswyH1TKeSYLNkGHhEyrZz0P79QTtOrY9KQ4SktH4O2873Iz6qq/EHJuiGC
 gy2b3lB3wCa4eZ1iFShQuoretSSR5KGAlhDgKZ1xQMdUn70rNsIaM8FXjVYy8MT56eB1kX4F
 33FPmN2FlIreao0T7sqMnqF7Dtx1g5cPlxZfQ2OvH6d7EEEZe6UVr+7HKTOo0hEGQ996YyKF
 t8V4zOoEylr2uSI4t9hEt4R2yA1tyA5tq1z9CYzHO7vsXTMMWCdaDm87mQpD6uYuGhkEbuA+
 qpHFhdBiFUB1v5xSF9Whv8TGqBee31CUh9ZZU6nHdF974Meus+RioWRA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 4/4] Migrate all classes to classes-recipe
Date: Mon, 15 Dec 2025 07:26:27 +0100
Message-ID: <b23aaa3a27d3a70874fa5b4258cf6a41b997d690.1765779987.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1765779987.git.jan.kiszka@siemens.com>
References: <cover.1765779987.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 06:26:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21031

From: Jan Kiszka <jan.kiszka@siemens.com>

This follows the class types description of yocto and recent adoption of
it in isar upstream. It has no noticeable impact on users.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 {classes => classes-recipe}/delta-update.bbclass     | 0
 {classes => classes-recipe}/deploy-firmware.bbclass  | 0
 {classes => classes-recipe}/efibootguard.bbclass     | 0
 {classes => classes-recipe}/erofs.bbclass            | 0
 {classes => classes-recipe}/image_uuid.bbclass       | 0
 {classes => classes-recipe}/qemu-emmc.bbclass        | 0
 {classes => classes-recipe}/read-only-rootfs.bbclass | 0
 {classes => classes-recipe}/swupdate.bbclass         | 0
 {classes => classes-recipe}/verity.bbclass           | 0
 9 files changed, 0 insertions(+), 0 deletions(-)
 rename {classes => classes-recipe}/delta-update.bbclass (100%)
 rename {classes => classes-recipe}/deploy-firmware.bbclass (100%)
 rename {classes => classes-recipe}/efibootguard.bbclass (100%)
 rename {classes => classes-recipe}/erofs.bbclass (100%)
 rename {classes => classes-recipe}/image_uuid.bbclass (100%)
 rename {classes => classes-recipe}/qemu-emmc.bbclass (100%)
 rename {classes => classes-recipe}/read-only-rootfs.bbclass (100%)
 rename {classes => classes-recipe}/swupdate.bbclass (100%)
 rename {classes => classes-recipe}/verity.bbclass (100%)

diff --git a/classes/delta-update.bbclass b/classes-recipe/delta-update.bbclass
similarity index 100%
rename from classes/delta-update.bbclass
rename to classes-recipe/delta-update.bbclass
diff --git a/classes/deploy-firmware.bbclass b/classes-recipe/deploy-firmware.bbclass
similarity index 100%
rename from classes/deploy-firmware.bbclass
rename to classes-recipe/deploy-firmware.bbclass
diff --git a/classes/efibootguard.bbclass b/classes-recipe/efibootguard.bbclass
similarity index 100%
rename from classes/efibootguard.bbclass
rename to classes-recipe/efibootguard.bbclass
diff --git a/classes/erofs.bbclass b/classes-recipe/erofs.bbclass
similarity index 100%
rename from classes/erofs.bbclass
rename to classes-recipe/erofs.bbclass
diff --git a/classes/image_uuid.bbclass b/classes-recipe/image_uuid.bbclass
similarity index 100%
rename from classes/image_uuid.bbclass
rename to classes-recipe/image_uuid.bbclass
diff --git a/classes/qemu-emmc.bbclass b/classes-recipe/qemu-emmc.bbclass
similarity index 100%
rename from classes/qemu-emmc.bbclass
rename to classes-recipe/qemu-emmc.bbclass
diff --git a/classes/read-only-rootfs.bbclass b/classes-recipe/read-only-rootfs.bbclass
similarity index 100%
rename from classes/read-only-rootfs.bbclass
rename to classes-recipe/read-only-rootfs.bbclass
diff --git a/classes/swupdate.bbclass b/classes-recipe/swupdate.bbclass
similarity index 100%
rename from classes/swupdate.bbclass
rename to classes-recipe/swupdate.bbclass
diff --git a/classes/verity.bbclass b/classes-recipe/verity.bbclass
similarity index 100%
rename from classes/verity.bbclass
rename to classes-recipe/verity.bbclass
-- 
2.51.0


