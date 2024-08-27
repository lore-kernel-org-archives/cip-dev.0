Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9E3C54734
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 12:44:12 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.77511.1724762642554475755
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Aug 2024 05:44:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm1 header.b=KW3h3IN3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1324425-202408271243596493fd196e6f9aaaeb-ddovpq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202408271243596493fd196e6f9aaaeb
        for <cip-dev@lists.cip-project.org>;
        Tue, 27 Aug 2024 14:43:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=SNYJuyFS6IrOabTvEIcmaAVmVanMc6D7x1karJRLFWY=;
 b=KW3h3IN382li+h8UlB91hhKBRWR3XUiMtRLs57OrbT9gw68jSdKRZ0r3L98Z0tAFCH/zj5
 qkJU3diQp+x9PfCCB9uUzg8xwtxTBiN3WMaBVdoYyiVcW7OPP9LSoeMegaWD1cyDVNbn89XB
 dMmfO1felTCE+zZC6RuDe87WuTbzstImsSqDauwbzwMObB3V4LnxmYhLdp+6oMV5rnPUcu7u
 ALXwduM1O+hN1hkWpul+j/HnYYIaF1AD6v4BfMxadcDYSK1cbFHt3cOW+cjZoAtjoZVi+hEz
 QVT0OZ3ndy5eA8C9+WJM/tGV2/0Cv9tO0mau+8vV2eqScJriVpAxPm9g==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	srinuvasan <srinuvasan.a@siemens.com>
Subject: [PATCH][isar-cip-core] recipes-core/images/cip-core-image.bb: install cryptsetup package
Date: Tue, 27 Aug 2024 18:14:07 +0530
Message-Id: <20240827124407.810136-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Aug 2024 12:44:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16814

From: srinuvasan <srinuvasan.a@siemens.com>

When we validate expand-on-first-boot with encrypted partition, the last
encrypted partition is not expanded due to cryptsetup package not availabe,
hence added the package in the rootfs.

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 recipes-core/images/cip-core-image.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 4a9cea9..28f5f3c 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -15,5 +15,7 @@ DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
 
+IMAGE_PREINSTALL:append:encrypt-partitions = " cryptsetup"
+
 CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
-- 
2.39.2


