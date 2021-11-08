Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0921AC433F5
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 10:49:33 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web09.43352.1636368571829036649
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Nov 2021 02:49:32 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
IronPort-SDR: 
 5qvs3c2xwTXKp8zBlHF2HDxngOwZKwSAidSAvc0QcdOfnSPXeERToPWSCN17E+3CLCVYu1Gbzp
 BpHH3lZ2AHPamLt/TupOzzjU24ag4G4+50oL0teY5RvRNMI047Hbll49hLFmVfFaJ0K6raC5on
 ZaVGIq+mvNw4yD78pxKjw0U6OGsCBUsfl5JHPXwPPoIgYxEcyxKUfazmgBzI8lDycn3UfTYkh4
 A8Um4+URcorbYmsZBNca8BMAcZAvKvIuuXo2I0rZvy+Whs6yp9SSQb7/aRmYJ5WvGL3y34iCa9
 xA5doFb1CZ6FX61Go9qjs5cP
X-IronPort-AV: E=Sophos;i="5.87,218,1631606400";
   d="scan'208";a="68024318"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 08 Nov 2021 02:49:30 -0800
IronPort-SDR: 
 7x7TebAC5cQinw95IqJL4gsiYpzwMkdT4IS5zWhEO0qcW78wz7jPagHrVQSRpKbFXDu10P/W4F
 cJkVP9gT4R2YrQfvIz7a5/sT89yJbEEgd4MOAN/H9HtWNepSPALWEfcxB3MypqcB9cRct45DTJ
 FfU5Qs2hgwAXg4Zc/W4P7AGt6BQ6Wdy3BWMcJ7qzIOsRJvMbGZvNUYt2/gWORmP7BzjojZVQP4
 xmWdLfnCn/gXxBLAoudELEFlSsg3EG7hCjC50vA4b/ywbeymlLI6y8+fp3yUe41dyqftk7H6MR
 fQ4=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-core] [PATCH] Kconfig: correct the name of image format
Date: Mon, 8 Nov 2021 16:19:05 +0530
Message-ID: <20211108104905.2745110-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Nov 2021 10:49:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6864

From: Srinuvasan A <srinuvasan_a@mentor.com>

Update the exact image format name in kconfig menu.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 13c3315..8421f1b 100644
--- a/Kconfig
+++ b/Kconfig
@@ -110,8 +110,8 @@ endchoice
 
 config KAS_INCLUDE_IMAGE_FORMAT
 	string
-	default "kas/opt/targz.yml" if IMAGE_ARTIFACTS && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
-	default "kas/opt/wic-targz.yml" if IMAGE_ARTIFACTS && !(TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
+	default "kas/opt/targz-img.yml" if IMAGE_ARTIFACTS && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
+	default "kas/opt/wic-targz-img.yml" if IMAGE_ARTIFACTS && !(TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
 
 config IMAGE_SECURITY
 	bool "Security extensions"
-- 
2.25.1


