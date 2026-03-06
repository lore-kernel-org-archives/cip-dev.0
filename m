Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5999AF51416
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 14:22:29 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.70219.1772806940831154853
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 06:22:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=DAzXUIGw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1330684-202603061422186adfa6cd7d00020770-my5ilu@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202603061422186adfa6cd7d00020770
        for <cip-dev@lists.cip-project.org>;
        Fri, 06 Mar 2026 15:22:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fFBIhalVq2vdMDVNPzXi5fRlPRwZkJ9qIeXKPgBc5Qg=;
 b=DAzXUIGw6X0W5ADQKtXpur+S/ucOSWPPoaS3R1EOzjzg3AYlp1Zit2+C9PWiMqbuaZiIIQ
 2Wpo6Ol/Ee5olR36ROAM8Mb2ePd59D5R6p6uI1cMP7udk8hzGMHX8lmaYI/QG+NrDckqARSK
 OiYrzC1Z9MPk9jDYz0EC07EO8ZUI3s79hlpcxAA6OprjGHt5eG7ntivQc2Cx9NK+KfEb6dJl
 EUYsV9Z5QS2ZeQdQ7hGDO0N8ihhsiMDYbljsWRSyid+Qxb6LuHycV8I1QnVeFa+Wu33gS7nY
 E3lghUdH0drQIL71tRc5LMTGWxHcyZT+B9XepqtxrHjnhz6RUKfB1H7Q==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Cc: quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 2/2] wic: Wipe rootfs-B headers on bmaptool copy
Date: Fri,  6 Mar 2026 15:22:13 +0100
Message-ID: <20260306142213.1273718-3-alexander.heinisch@siemens.com>
In-Reply-To: <20260306142213.1273718-1-alexander.heinisch@siemens.com>
References: <20260306142213.1273718-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 14:22:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22104

From: Alexander Heinisch <alexander.heinisch@siemens.com>

To copy images `bmaptool copy` uses a bmap file that maps regions
that actually hold data. That means empty regions / holes in the file
are skipped by the tool and thus those regions on the disk do not
change. - That's actually the feature why bmaptools exists.

Wiping the bytes from the beginning of the rootfs-B partition avoids
undesired hold-partition-data bugs. Especially on systems where
disk encryption is deployed.

When reinstalling an image configured to use A/B-rootfs and disk encryption
that way, this results in a LUKS2 header created for rootfs-B during
disk encryption setup of the previous installation to remain on the target.

The LUKS2 header for rootfs-A gets overwritten properly, as that range
actually contains filesystem information for squashfs or erofs).

When installing images using different secure boot keys for signing or
wiping the TPMs state during reinstallation the key cannot be unsealed
and/or retrieved anymore.

On boot the initramfs-crypt-hook sets up disk encryption for
rootfs-A (creates a new key) and tries to retrieve the key used for for
rootfs-B in the TPM as it still has a valid LUKS2 header, which fails.
Thus, mounting the old LUKS2 encrypted rootfs-B in local-bottom fails
and the system panics and ends up in a restart/panic loop.

By setting the sourceparam size=5M we ensure that the first 5MB of the partition
actually gets overwritten. As there are actual zeros in the file compared to
holes previously, the bmap also maps those regions and overwrites them on copy.

Without an offset specified (as in our cse) the LUKS header is stored at the start
of the partition and has a size of 4k.
Due to the nature of LUKS2 it is hard to determine the exact position of the
backup header. Therefore, I chose to stay close to the actual cryptsetup
implementation (as of 3b6794a2a3580559bcbc3ad0e67ab4805f48fa7d) to derive furthest
backup header location which is 4MiB.

This is also sufficient to wipe erofs and squasfs superblocks

 - the squashfs superblock (96 bytes) starting with fs identifier (4 bytes)
   which is stored at the begin of the partition,
 - the erofs superblock (78 bytes) starting with fs identifier (4 bytes)
   which is stored at an offset of 1k

Thus, as the default block size used in EmptyPartitionPlugin is 1MB choosing 5MB as an
additional write overhead seemed propper.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 kas/opt/swupdate.yml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index c5b7c61..b4c4b99 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -26,3 +26,17 @@ local_conf_header:
     PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
     PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
     PREFERRED_PROVIDER_swupdate-signer ??= "swupdate-signer-cms"
+
+  wipe-fs-header: |
+    # Overwrite the first 5 MiB of the rootfs-B partition with zeroes to avoid undesired
+    # hold-partition-data bugs. Especially on systems with disk encryption enabled for the
+    # rootfs, we need to make sure that LUKS2 headers already stored on the disk from a
+    # previous installation are properly overwritten by `bmaptool copy`.
+    # By setting the sourceparams="size=5M" the first 5 MiB of the partition will be overwritten
+    # with zeros, which is sufficient to cover: LUKS2 header, squashfs, erofs, ...
+    # - the LUKS2 header (4k) and the backup header (max offset used by cryptsetup = 4M),
+    # - the squashfs superblock (96 bytes) starting with fs identifier (4 bytes)
+    #   which is stored at the begin of the partition,
+    # - the erofs superblock (78 bytes) starting with fs identifier (4 bytes)
+    #   which is stored at an offset of 1k
+    ABROOTFS_SOURCEPARAMS_B = "size=5M"
-- 
2.47.3


