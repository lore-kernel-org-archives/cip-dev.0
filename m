Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C21C0218D
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 13:22:53 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.11707.1737724970278423009
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 05:22:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=HEyM+SfG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20250124132247427553fcf3f97ba154-7e9bhq@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250124132247427553fcf3f97ba154
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jan 2025 14:22:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MjqFPvwsBRBlRHUSzUPX5/la5IAT3ARaPgoy0XEiIaw=;
 b=HEyM+SfGWhA+qSI+EiM5LqPitNnrnZ7cSewKmikjDXMv2SNg8T+3r0tuKSeT9WlYHQCthK
 bF0Y8eR7k+ALvkvjBZwbZQwfOI24k21u/35q4CdYf/ADi9CRxaXWP1pG2J/z9ZBgs6R8pIBF
 vviUrXcER4JbDnBJrq2yzFZS3WAn6hUmqE1QC9Uq8LXjHewKf0nxBwCsrjmLf8YMJ/1x3UV/
 1hYhKgfhTKrPHw7SwBMkdONzVPyGvfWOuFLwn+RVUwL5Y1ph45dtHkMVY531Guq1tc4gAZBT
 xbCtVuGUCorK4KOlXBqNU9LfC7Ot12CwlE8yRgF9G7aqP+XxQGDZ14tw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 1/3] build x86-uefi with secure boot
Date: Fri, 24 Jan 2025 14:22:19 +0100
Message-ID: <20250124132246.64738-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 13:22:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17659

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d4bd283..42e247d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -241,6 +241,16 @@ build:qemu-amd64-secure-boot-encrypt:
     deploy: disable
     encrypt: enable
 
+build:x86-uefi-secure-boot:
+  extends:
+    - .build_base
+  variables:
+    target: x86-uefi
+    extension: security
+    use_rt: disable
+    targz: disable
+    encrypt: disable
+
 build:qemu-amd64-swupdate:
   extends:
     - .build_base
-- 
2.47.0


