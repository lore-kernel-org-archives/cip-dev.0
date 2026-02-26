Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50F5FD8FCA
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 16:08:51 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73665.1772122123306302930
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 08:08:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=C/ewBfsa;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1330684-20260226160841090b5095c900020704-8_3hn8@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260226160841090b5095c900020704
        for <cip-dev@lists.cip-project.org>;
        Thu, 26 Feb 2026 17:08:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rO6bm8MqhGzORbVdcrAjq9bpPm+vobU+tUf3bnRCyb0=;
 b=C/ewBfsaAARwQCL4VxbQFxknJxzWRDlbb6lFuf5n6jCUlQXWCb/JneoVOqjxx7v/YPYNrF
 GSOKZlW52bLTm/GXXmEG3e+xQSn8sV5jyEcgvLNgvR6kuYLIpyOVBG+41dEc4QtKxdv3hsZn
 l9iH9hohgkxOXQ07ulmMTxUBvQzfK8if68p3ttIsIIYYkh7FdY21TJrZk3gs61anDrF+EyVc
 caEZ4xW9CwwAvHzU5SJZ8t5EG+Kb/eUunQCpK+9pRs+j7lM0c0Mzw/5sWq2eRikkwnCWvo2Y
 UsNZ24NFLHtMbg2hRzXSXQHBjkvggFh4/VPJtHnoTH9rqIVhIj1z3OkQ==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] wic: Wipe LUKS2 header of rootfs-B on bmaptool copy
Date: Thu, 26 Feb 2026 17:08:37 +0100
Message-ID: <20260226160837.1107096-3-alexander.heinisch@siemens.com>
In-Reply-To: <20260226160837.1107096-1-alexander.heinisch@siemens.com>
References: <20260226160837.1107096-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 16:08:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21993

From: Alexander Heinisch <alexander.heinisch@siemens.com>

To copy images `bmaptool copy` uses a bmap file that maps regions
that actually hold data. That means empty regions / holes in the file
are skipped by the tool and thus those regions on the disk do not
change. - That's actually the feature why bmaptools exists.

When reinstalling an image configured to use A/B-rootfs and disk encryption
that way, this results in a LUKS2 header created for rootfs-B during
disk encryption setup of the previous installation to remain on the target.

The LUKS2 header for rootfs-A gets overwritten properly, as that range
actually contains filesystem information for squashfs or erofs).

On boot the initramfs-crypt-hook sets up disk encryption for rootfs-A and
evicts the old handle still in use for rootfs-B in the TPM, thus, mounting
the old LUKS2 encrypted rootfs-B in local-bottom fails.

By setting the sourceparam size=5M we ensure that the first 5MB of the partition
actually gets overwritten. As there are actual zeros in the file compared to
holes previously, the bmap also maps those regions and overwrites them on copy.

Without an offset specified (as in our cse) the LUKS header is stored at the start
of the partition and has a size of 4k.
Due to the nature of LUKS2 it is hard to determine the exact position of the
backup header. Therefore, I chose to stay close to the actual cryptsetup
implementation (as of 3b6794a2a3580559bcbc3ad0e67ab4805f48fa7d) to derive furthest
backup header location which is 4MiB.

Thus, as the default block size used in EmptyPartitionPlugin is 1MB choosing 5MB as an
additional write overhead seemed propper.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 kas/opt/encrypt-all.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
index faf7206..799f804 100644
--- a/kas/opt/encrypt-all.yml
+++ b/kas/opt/encrypt-all.yml
@@ -21,3 +21,10 @@ local_conf_header:
     # to set all partitions
     CRYPT_PARTITIONS = "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PART_UUID_B}::reencrypt \
                          var:/var:reencrypt"
+
+    # On systems with disk encryption enabled for the rootfs, we need to make sure that
+    # LUKS2 headers already stored on the disk from a previous installation are properly
+    # overwritten by `bmaptool copy`. By setting the sourceparams="size=5M" the first 5 MiB
+    # of the partition will be overwritten with zeros, which is sufficient to cover the
+    # LUKS2 header (4k) and the backup header (max offset used by cryptsetup = 4M).
+    ABROOTFS_SOURCEPARAMS_B:append:encrypt-partitions = " size=5M"
-- 
2.47.3


