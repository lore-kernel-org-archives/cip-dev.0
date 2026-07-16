Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D17C4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 13:09:25 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12471.1784207360162229367
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 06:09:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=MTlg522r;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202607161309160eaf16e7b000020773-i_cpke@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202607161309160eaf16e7b000020773
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Jul 2026 15:09:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=3TaVxI/5+4H9CvXhcnpYUHhnefOxdqyB1zb3/fCDrW4=;
 b=MTlg522rczJ6Y5WWV3bWiJMhjC4amRf9ysF26g8SXPLrTHnpOXmNIkc7bpx1zRJwdVc/EU
 /wq3e81phR0LSFOflbeZx+jznjhdWT0p/Xz6BWrr+C+1Qk3mzc/o3PDELRFY6jKvbFDqqvNj
 RYnswYBjaJFqnDWMVJTh7W2cJNQtLzy4cQT0n66SupZzzSCbd/CfJMcBah5txTuCvYfqXEea
 THPoyn4k/fIFJK4Hma59bbt0+CV0DEgC67OhDLLoRoljQe/Tc3RxnXoVV8ECiIF7Ahet1KR3
 /Ckgs177sU7J5EQei64zEZjXzcnGA5E1DoeqbeUsipK1LvStktwCMnjg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 2/3] initramfs-crypt-hook: suppress stderr log from cryptsetup
Date: Thu, 16 Jul 2026 15:07:43 +0200
Message-ID: <20260716130816.1095792-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260716130816.1095792-1-Quirin.Gylstorff@siemens.com>
References: <20260716130816.1095792-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 13:09:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23623

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

LuksDump prints additional information to stderr on Debian Sid,
this information is not necessary for the grep command. Suppress
the messages to avoid cluttering the boot log.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/local-bottom-complete            | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
index 120ac29..0821566 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
@@ -75,7 +75,7 @@ for partition_set in $partition_sets; do
 		continue
 	fi
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
-			| grep -q "luks2"; then
+			2>/dev/null | grep -q "luks2" ; then
 		mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
 	else
 		mount_partition "$part_device" "$rootmnt""$partition_mountpoint"
-- 
2.53.0


