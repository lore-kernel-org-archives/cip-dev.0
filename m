Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AFCC021A1
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 10:01:29 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.47989.1739786484630316067
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Feb 2025 02:01:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=eOGzZv5H;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1326448-202502171001213b5971dea92af1f32b-uoyb81@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202502171001213b5971dea92af1f32b
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Feb 2025 11:01:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=BUBU7QImDMuFNFi7bnslonuzYhruJ5Mg3RbKFAgA+lM=;
 b=eOGzZv5HpAq7jft0OXKfR0tR3azr/9mccE921pusufEyMH81U5nxGNzuQeMhHU/1nnXlaD
 h+wCukL8Npss0Bgz/g3VRE7Ih5ctzLLLyqfUjjL2hlxxgxzyOmdqumqTKS8mHUMjyxQJ3C/1
 iaWHhf8E9ROS79hHlYiHn37NTWMF/ffolO2IzJQiHGSND4N9HGdloK8Eqi7fTIP2rF52Oxl0
 1yfUpjiFjXGvJsMLuxAVYZLXctZtIR71kL2g3r267uMUmnDECwgSVWd1k99jf8VMks2Sg1r+
 9NZHdh6LkBwxiOM71FrQG5SWn2bjQSnJR1jYDwzzN/GuLBJJJQG/VwKw==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 0/3] Added support for rootfs-overlay (for development).
Date: Mon, 17 Feb 2025 11:00:21 +0100
Message-ID: <20250217100024.42995-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Feb 2025 10:01:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17855

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Updateable images based on isar-cip-core come with immutable rootfs
out of the box. During development this oftentimes comes with the penalty
of having to either rebuild images with additional files, packages aso.
to accomplish development and debugging tasks or derive from the production
image in a way that some fundamental features like verity, squashfs, swupdate, aso.
are not part of such.

Both cases are far from optimal. With this patch series we want to share
our attempt to streamline development by staying as close as possible to
our production image by overlaying the squashfs or erofs based ro filesystem
with an overlay. To make changes redundant accross reboots, we decided
to use a persistent storage option in favour of a tmpfs based approach.
(Although, technically there is no limitation on doing so)

Keep in mind, support for the root overlay is thought as a development
feature! Thus, it is not thought for production, as it invalidates many
of the properties we have from ro-filesystems. Also, keep in mind that
changes on the overlay may partially hide updates or lead to "unexpected"
results after applying updates.

Alexander Heinisch (3):
  Removed "ro" option from read-only-rootfs's fstab.
  Fix return value handling on filesystem check
  Added support for rootfs-overlay.

 classes/read-only-rootfs.bbclass              |  2 +-
 .../files/local-bottom.tmpl                   | 97 ++++++++++++++++---
 .../initramfs-overlay-hook_0.3.bb             |  2 +-
 3 files changed, 87 insertions(+), 14 deletions(-)

-- 
2.39.5


