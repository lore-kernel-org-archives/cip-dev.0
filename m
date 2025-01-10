Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE06E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 16:53:00 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.23926.1736527976775640112
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jan 2025 08:52:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=G39LhLKI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-202501101652540dcec86b9cabbd26fa-wdelnm@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202501101652540dcec86b9cabbd26fa
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Jan 2025 17:52:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=bpqfXfO13tocpA4HFm29wTzrkFcDjerVfSGriNvE3Ao=;
 b=G39LhLKILG3S4uMUQJXFbOc8i6Z/UUvH9DneeqmP4lVSxkcFZPrAR1FgJ6KorSL3XviOzM
 ZeDmaj9o3l2Jo7P5zOjOuOib3iNL/yb4iA+zTXEqZTDix/iQZecNLdrPpOCYHGh8EV3B+oSi
 eVwcPejEcXbRgRsd8OfTSy58uZw3Fwnq0Nh922dBpgV1l3WfRA2fxGwCVFj5tep+Ai5c/ymo
 /aB1MMoXqZXo8ss+N7hpNVhcb+YDA80dIhSttHHA1VOsd/pEE4KlNxDly/4KLceonc1RDKmM
 bAROFGMKWl96tU1k67DUGVasGalgswbyBOFv+P3L5xz+8aVVFa30Os5Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3] initramfs-crypt-hook: clarify resize error
Date: Fri, 10 Jan 2025 17:52:38 +0100
Message-ID: <20250110165253.77676-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jan 2025 16:53:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17531

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add context to the resizing error as it is was unclear why the
encryption can not continue.

Also fix typo.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v3:
 - us "reencryption" instead of encryption
Changes v2:
  - do not skip the check in case of optional encryption
  - add indication what failed to panic message
  - fix typo


 .../initramfs-crypt-hook/files/local-top-complete             | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 95d0a5d..9197fb6 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -82,14 +82,14 @@ reencrypt_existing_partition() {
 EOF
 		e2fsck -p -f "$1"
 		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
-			panic "reencryption of filesystem $1 cannot continue!"
+			panic "reencryption of partition $1 cannot continue - resizing of the partition failed!"
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


