Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48815CCD197
	for <webhook@archiver.kernel.org>; Wed, 18 Sep 2024 10:25:17 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.11988.1726655114974414958
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Sep 2024 03:25:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=Ddi6Y8t6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202409181025102e41b6e681fd0794b7-95ngv2@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202409181025102e41b6e681fd0794b7
        for <cip-dev@lists.cip-project.org>;
        Wed, 18 Sep 2024 12:25:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=CqTsrWy99JGBxpXJpNT/krg5AXkRYvoqAOPm1U9k3nA=;
 b=Ddi6Y8t6ji+7SI5zO3MYQmJ2BRCAbhMAax3izTOdJKbqxWSeTnBtbrSWmwX0pr7aAQH+8H
 j0subrCizgDYKKjHFB6yk7A5/VnkbOUA8l5ran5PvAR0TnBbW6UlzXwhCcRvaDWUsMv0EyL/
 VPdfgnr3PA13k8x1GinORzFO+3vJQJD1uGMhs33svrWSmzTnMDyJoJcBXtuh3NfQixDZhug7
 9G0oum+TS+O9BbEais7rxZeAIFNqw3xq1JRK8x8z3K+eBTcFAApr2mhHKRflt5gdeA8Xv/dr
 1L/TlOJuyM+KV9U72V4xbRkaEFGJf4LCFQT+hHYtGYDV4ouaGdcRjpTw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] Add missing paragraph for ABROOTFS_PART_UUIDs in production
Date: Wed, 18 Sep 2024 12:24:51 +0200
Message-ID: <20240918102509.1526632-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Sep 2024 10:25:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16908

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.swupdate.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 99df9ba..027a8fd 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -23,6 +23,10 @@ device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOT
 The variables `ABROOTFS_PART_UUID_A` and `ABROOTFS_PART_UUID_B` contain partition uuids. The handler searches
 for the matching device and SWUpdate writes the image to the selected device.
 
+> :exclamation: For production image the content of the variable
+`ABROOTFS_PART_UUID_A` and `ABROOTFS_PART_UUID_B` must contain project specific
+values.
+
 ## SWUpdate Efibootguard update
 
 :warning: **If the efibootguard binary is corrupted the system can no longer boot**
-- 
2.45.2


