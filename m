Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD4EC3526F
	for <webhook@archiver.kernel.org>; Tue, 19 Apr 2022 17:48:47 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web09.1328.1650384423099893397
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Apr 2022 09:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Vn3QLbcO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-202204191607008708b398e96c1ffbd3-4mas9o@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202204191607008708b398e96c1ffbd3
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Apr 2022 18:07:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F04np6A3YIsU85PLtds4woYFdB864iC9yfTB8VZyVDw=;
 b=Vn3QLbcOXdzHNadwog3PO65aGPFaWcgulF/a3r08T5QlerVESCnGcnp7T+BvDBdNW7M3hB
 UCmYosSszaMZ9jzdQPJ7wYSsM/bgd/cR0zBD7wWr/kSyF980ud7zUnRiJ9YsNMt6uNQuHPgR
 AbaEIPJCQLuei7TSeEnLQSH+GsoVk=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 4/5] Restrict OVMF to qemu-amd64 machine
Date: Tue, 19 Apr 2022 18:06:57 +0200
Message-Id: 
 <32d37669f36a38fbdfb5e19ffcc1f16047aa9af8.1650384418.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650384418.git.jan.kiszka@siemens.com>
References: <cover.1650384418.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Apr 2022 17:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8109

From: Jan Kiszka <jan.kiszka@siemens.com>

No need to run this for non-qemu and non-x86. And, yes, overrides can
stack.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/efibootguard.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index ce89756..2d84427 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -29,8 +29,8 @@ local_conf_header:
 
   ovmf-binaries: |
     # Add ovmf binaries for qemu
-    IMAGER_BUILD_DEPS += "ovmf-binaries"
-    # not needed Debian 11 and later
-    OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
-    DISTRO_APT_SOURCES_append_buster = " conf/distro/debian-buster-backports.list"
-    DISTRO_APT_PREFERENCES_append_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
+    IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
+    # not needed for Debian 11 and later
+    OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
+    DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
+    DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
-- 
2.34.1


