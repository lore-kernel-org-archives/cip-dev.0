Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE34CE7717F
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 22:41:57 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.13490.1733845561343394414
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Dec 2024 07:46:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=mDhNjHz8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1321639-202412101545575e40bb7a7d4baa8864-oygdse@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202412101545575e40bb7a7d4baa8864
        for <cip-dev@lists.cip-project.org>;
        Tue, 10 Dec 2024 16:45:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=UAfTsE0z+5QJvKFGzyfkWHUhtWPI6MqL6wgqF2ukvrY=;
 b=mDhNjHz8zAPc/kUmIJyONU6G7TTcjGiT/wwxyfVZ6P+comuq5+gOffbcSgwhGqQ9FBYusY
 hc3NFjaYr6iQ9PLq9B9+90y4Usig5y9mbgFXmAQc4mCOoTL5FxqR/U0/usaCzB3wDeMMGPXx
 /2LC58LyJnQ47BUwoTnTkw7Esy4ciDDYJzLLdSsbDNvUyRPcZRXKJucTmVX1+1rYbjDGWLjg
 AlA/wL/lCjhuG29l0SIO3vJFWi3RRd67mefF6TEuDMNKjt0n0aKPQUIu0mde1XLmnHkXqYtf
 OsmiYXxdqsv6E77P+C3ZS49GWiyBq+QoHkrTM2zvu9uPjyz0fqvN/4GA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] define RO_ROOTFS_TYPE before using
Date: Tue, 10 Dec 2024 16:45:46 +0100
Message-Id: <20241210154546.2670554-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Dec 2024 22:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17394

When including isar-cip-core in another layer and not using the cip-core
distribution, the RO_ROOTFS_TYPE is undefined. This results in parsing
errors.

We now provide a weak default in the verity and squashfs recipes to not
break the parsing in downstream layers.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass | 1 +
 classes/verity.bbclass   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 5bf021a..3243f67 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -12,6 +12,7 @@
 
 inherit template
 
+RO_ROOTFS_TYPE ??= "squashfs"
 SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
 # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
diff --git a/classes/verity.bbclass b/classes/verity.bbclass
index 231d172..c3b89ec 100644
--- a/classes/verity.bbclass
+++ b/classes/verity.bbclass
@@ -12,6 +12,7 @@
 IMAGE_TYPEDEP:verity = "${VERITY_IMAGE_TYPE}"
 IMAGER_INSTALL:verity += "cryptsetup"
 
+RO_ROOTFS_TYPE ??= "squashfs"
 VERITY_IMAGE_TYPE ?= "${RO_ROOTFS_TYPE}"
 VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
 VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
-- 
2.39.5


