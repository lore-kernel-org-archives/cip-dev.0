Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC0DE77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 16:01:00 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.22331.1736524855193835651
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jan 2025 08:00:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=eKCOcdpp;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202501101600513838b8dd3f1c95d5c7-ymz4ib@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202501101600513838b8dd3f1c95d5c7
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Jan 2025 17:00:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=mKOZhblXnCPMUwKMkRZvuWD8r/Y7T1nEtD7uSbUGBAw=;
 b=eKCOcdpp2bGWdsJDYyAHatJ/5cAxGj216xlMotCtPzcS8kBjJ9ZV/qFoaSEsjEjmrxvHxd
 tKN6akr3MZG01MskjndfVasQKh8fLdY6KjRmT0gKQfxKZ/1nxW9yEsUDVPIeAaW3zuamsVuI
 p/4/+5V+TGbRtAT2bBDAFQe4UJklLDszrQo8jK98TVtGRrqeM7L15hvrw/MeM9kIHpdwYWh+
 mU603LeLXPwMqMFKINnP81leWNIKL3Nywk6uowz8DT80upehhe3JXVUcC2guNNUG10WCMmrO
 mNkAjw1EULEp+PdcnxJCcua9Kdwk76ksMNw5VtDS2ywOCWI4OUypqq+w==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] initramfs-crypt-hook: clarify resize error
Date: Fri, 10 Jan 2025 17:00:38 +0100
Message-ID: <20250110160051.91196-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jan 2025 16:01:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17525

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add context to the resizing error as it is was unclear why the
encryption can not continue.

Also fix typo.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - do not skip the check in case of optional encryption
 - add indication what failed to panic message
 - fix typo

 .../initramfs-crypt-hook/files/local-top-complete             | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 95d0a5d..b8a2f18 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -82,14 +82,14 @@ reencrypt_existing_partition() {
 EOF
 		e2fsck -p -f "$1"
 		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
-			panic "reencryption of filesystem $1 cannot continue!"
+			panic "encryption of partition $1 cannot continue - resizing of the partition failed!"
 		fi
 		;;
 	squashfs|swap|erofs|"")
 		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
 		;;
 	*)
-		panic "cannot resize parition. unsupport fstype: $partition_fstype"
+		panic "cannot resize partition. unsupport fstype: $partition_fstype"
 		;;
 	esac
 	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
-- 
2.46.1


