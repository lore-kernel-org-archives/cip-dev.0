Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CEFD3B9A8
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 15:18:03 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.48227.1732634276194984196
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Nov 2024 07:17:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=g48Ri+Wr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2024112615175344a35de8319358e4de-wznaqu@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024112615175344a35de8319358e4de
        for <cip-dev@lists.cip-project.org>;
        Tue, 26 Nov 2024 16:17:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/kJOkce8H9G3JPAxyqqQ0BFdo6VyJzNnZaBG0qDr+bw=;
 b=g48Ri+Wr5vcXIOYZZG7yy5HS3BRQLnLYifcjyxcHj5SVFmyrz31CcAe4dZEcvcBmaIDtHB
 pfkAdnKoAzsH16unfRPg34po6YkegFh7pJ+LvSOo6phGoWZIh2cjiL5DIQ52fsQLiRln5won
 qWao0CXyaX7a63RjyBnk5HPOJ0FyO6aBwSeReqJpnPkl2vTyhlL2qS5CrTp16HQPlAgvI2+I
 RIk/RAsQNoPLGkDkBLWA3Dtc64RpgWoXo1OH73oU0hZ30rpAnNyOC48rGAk0Rtqer3e/B/6M
 k0H3w81STVzsgDQLbAEcIWPf7MsxQLZt9ddVv8NtXcSXUS0xVDFFB/bA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	Jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 1/2] update cip-kernel-defconfig to lastest version
Date: Tue, 26 Nov 2024 16:16:27 +0100
Message-ID: <20241126151751.1747275-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20241126151751.1747275-1-Quirin.Gylstorff@siemens.com>
References: <20241126151751.1747275-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Nov 2024 15:18:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17279

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This contains fixes for the cip_merged_defconfig for arm targets.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 1682131..57c352c 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,6 +14,6 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "9b1b425c87248ba476e3a3aff3c9f905abdb3982"
+SRCREV_cip-kernel-config ?= "bb2485db01c5ce14ec571b9fb9e03f90c686a69f"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
-- 
2.46.1


