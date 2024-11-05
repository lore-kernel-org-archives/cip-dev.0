Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7991D3176D
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 17:54:43 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.26676.1730829277268625642
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 09:54:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=WrJwP9G7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20241105175434d66efaf86bcb2bdce1-wjxsjo@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241105175434d66efaf86bcb2bdce1
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Nov 2024 18:54:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=l5D7z0u/8vSc+uUR2iZPuri+R7h18MnmxsuaQX0gLC0=;
 b=WrJwP9G7LD2TDBXy7rLmxa7o1N+ARacXENI8Lfb5loU6Hbo/wD5kbv14mlhi9UPa1u7OqG
 vnwxZIhCmKiNAWzXJPAKwnb9cnTGWqB8Zyw+xcq58WSgenGNnGTMw7/g3xvUzAVk+Tucl1dZ
 F251/wtH5yFgQzlyB6Y3i6+FIq62ZSo9A4AY0HsODXKTtwUUAgOoBTHz5NLSKwGnBzD/aeQX
 6FSeI7kVktxaklIkRL2XeebxwuKcBJHK73qqDd1ega6P3ANxyVZhZquBPLcYOQnnRFznMSii
 chtZ25F8rheak8SWWhMj5fWXHRJsnEhB3v1IUXcs1P4se+McRnvTHATg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v2 5/6] linux-cip: Update cip-kernel-config revision
Date: Tue,  5 Nov 2024 18:54:32 +0100
Message-ID: <73a844ea95fea4724914fe989276e673accacea5.1730829273.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730829273.git.jan.kiszka@siemens.com>
References: <cover.1730829273.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 17:54:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17177

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings support for EROFS and PID namespaces for 6.1 and also fixes
Ethernet configuration on BeagleBone Black.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 9c1ab946..16821319 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,6 +14,6 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "f6b7018cb6845f34f8a03c126bf4f823ce10d637"
+SRCREV_cip-kernel-config ?= "9b1b425c87248ba476e3a3aff3c9f905abdb3982"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
-- 
2.43.0


