Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5761CC19F2D
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 10:04:24 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web09.3027.1659607454606097726
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Aug 2022 03:04:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=hKBc7fID;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-51332-20220804100410fd702c65508290779e-9pw87v@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220804100410fd702c65508290779e
        for <cip-dev@lists.cip-project.org>;
        Thu, 04 Aug 2022 12:04:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=DyvRrIiig/mxEKmHDzYTR4z5ixpVmBSsSJhwbTJ0kFs=;
 b=hKBc7fIDy2S3q36X3KlV7xYy2qG7kIL2wU6s8M6PtkFOtjLnvdNxeBFyEZ2TLiRu3cIuDH
 8X5COsNxmtZmLKSMqJdIsbhv1gAzmYz2z7n3zUxc4t9lWPYx5Dx/bbeDpKpSRuKGK24VHesj
 w1Iuoyqog8MPr68+ueEulKVc0E7r0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/2] clean up kas/opt
Date: Thu,  4 Aug 2022 12:04:07 +0200
Message-Id: <20220804100409.163990-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 10:04:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9116

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Remove the kas option for efibootguard as it cannot build a image.
Move the package installation for swupdate to the include.

Changes V2:
 - Readd WICVARS(KERNEL_IMAGE INITRD_IMAGE DTB_FILES)
 - Fix setting WKS_FILE for ebg_swu

Quirin Gylstorff (2):
  kas: Remove efibootguard.yml
  kas/opt/swupdate: Move the package installation to swupdate.inc

 kas/opt/ebg-secure-boot-snakeoil.yml | 11 +++-----
 kas/opt/ebg-swu.yml                  |  7 ++---
 kas/opt/efibootguard.yml             | 39 ----------------------------
 kas/opt/swupdate.yml                 |  4 ---
 recipes-core/images/efibootguard.inc | 28 ++++++++++++++++++++
 recipes-core/images/swupdate.inc     |  3 +++
 6 files changed, 39 insertions(+), 53 deletions(-)
 delete mode 100644 kas/opt/efibootguard.yml
 create mode 100644 recipes-core/images/efibootguard.inc

-- 
2.35.1


