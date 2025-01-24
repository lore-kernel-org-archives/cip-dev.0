Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F02C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 08:07:10 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.6955.1737706022717092079
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 00:07:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=O71LZ5ee;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202501240806594d88bf48e1d18f4f0e-kezh9k@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202501240806594d88bf48e1d18f4f0e
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jan 2025 09:07:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MjqFPvwsBRBlRHUSzUPX5/la5IAT3ARaPgoy0XEiIaw=;
 b=O71LZ5ee1A63WNDW7WkDtDgOXgUBt278J1Bp8rC2FvtNMe/MC5q1kTscsgA/X+grEkCfHS
 4EjBDdsK+qnjJGMFQV0+YBS0bt13E915B6Bnth761V6Tpav5a4CaRqS6b4NZVCgubV0axmnj
 v6nRtaV7jhiVL7FM50FrskcK6fhgRWQ/nu8ABtxm16d9HJmzB/yEaD1Ci/wMoW5HHrvGUURg
 nMqZuILUIEErFWbq2K41Ye6CHCcc6FKe6gwU5wWIP5sGrJU+mrOym9Ov9HZnoOSuBJ78eljR
 Ge6B9X+GrwN7AZzat5P5rEahhN6TFKGXV/IuQHirgxG2wgWp1rF/Yenw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 1/3] build x86-uefi with secure boot
Date: Fri, 24 Jan 2025 09:06:25 +0100
Message-ID: <20250124080659.469424-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250124080659.469424-1-Quirin.Gylstorff@siemens.com>
References: <20250124080659.469424-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 08:07:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17618

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


