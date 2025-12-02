Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AC1D1170A
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:39 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4096.1764667289342092487
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=hbVmL5A1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20251202092121586de923d9000207c0-etjrsa@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251202092121586de923d9000207c0
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1utn9adTIPlkjMZhb5sItqzLgCITLrMPQ3LsnTMAHxk=;
 b=hbVmL5A17ilr9Zt7k7K8tZ0kWzwKCZu0LAFORrMSAyPi5BaJVVtFWG/5u9ICIRwa0QOABh
 7k0mwlL5dUEPZygJfHu6AvQLTl4vv17EZJcEL6UfjVNZATR+ZBBTt9rk1tVn8oFpqjB2iE2P
 5IYLVfnnJA2BIssCUFoNrxA6DZqIfE8uUY3r4HeReYPhQR3kn7UtaJGU2EIJyAgDjci3LT9e
 W3/1j+xcOSqKxqsfOwdPSHUZ3Q42s3osLfKWD4vU0F6BlZY11V373Y5+RsSTew+ABJD5QY7f
 Wl9WJkHHQZGX2TWYCBmB5AK1bxp2PWlCe2ttn5XKba7UFsepRGGIVP3g==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 05/14] qemu-amd64: Raise boot watchdog timeout to 120 seconds
Date: Tue,  2 Dec 2025 10:21:10 +0100
Message-ID: <11a53ab6f5320077334a106cd614a2305012f20a.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20791

From: Jan Kiszka <jan.kiszka@siemens.com>

As the CI setup currently still uses tcg rather than kvm, waiting for
"only" 60 s can be too short on busy hosts.

This should be reverted once we moved also with CI to kvm.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/qemu-amd64.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index d8f5453c..748aaa33 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -12,3 +12,6 @@ IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 
 PREFERRED_PROVIDER_factory-reset-helper:swupdate = "factory-reset-helper-efi"
+
+# when running without kvm (as in CI so far), 60 seconds might be to short
+WDOG_TIMEOUT = "120"
-- 
2.51.0


