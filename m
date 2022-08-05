Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51784C00140
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 15:26:31 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web09.8329.1659713187904603484
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Aug 2022 08:26:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=MNsnd9Dg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-20220805152624aa7d0d5b83d3ebe460-ceyngv@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220805152624aa7d0d5b83d3ebe460
        for <cip-dev@lists.cip-project.org>;
        Fri, 05 Aug 2022 17:26:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Lli9rC/bUZVGWFpDgWVKmodBM30qZj4fVL02+NC+JmI=;
 b=MNsnd9DgW+ZJdlKxEnzMHwttePTkG+x70zh2cg5nv/99K7VfhDO2v5hUWPAR97+ceSRj3A
 m157fhY/Zja5gXzPONCsfR5P1LMxI/Q5n1uVDj5AdlK9tgz75l9tIe190x5Xq4N7p6Rtfe6j
 dOccemluwoE30tC/9gKhxwkex3x1s=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 0/2] clean up kas/opt
Date: Fri,  5 Aug 2022 17:26:21 +0200
Message-Id: <20220805152623.2155519-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Aug 2022 15:26:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9136

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Remove the kas option for efibootguard as it cannot build a image.
Move the package installation for swupdate to the include.

Changes V2:
 - Readd WICVARS(KERNEL_IMAGE INITRD_IMAGE DTB_FILES)
 - Fix setting WKS_FILE for ebg_swu

Changes V3:
 - Fix assignment of WKS_FILE
   - use weak assignment in conf/distro/cip-core-common.inc

Quirin Gylstorff (2):
  kas: Remove efibootguard.yml
  kas/opt/swupdate: Move the package installation to swupdate.inc

 conf/distro/cip-core-common.inc      |  2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml | 11 +++-----
 kas/opt/ebg-swu.yml                  |  7 ++---
 kas/opt/efibootguard.yml             | 39 ----------------------------
 kas/opt/swupdate.yml                 |  4 ---
 recipes-core/images/efibootguard.inc | 28 ++++++++++++++++++++
 recipes-core/images/swupdate.inc     |  3 +++
 7 files changed, 40 insertions(+), 54 deletions(-)
 delete mode 100644 kas/opt/efibootguard.yml
 create mode 100644 recipes-core/images/efibootguard.inc

-- 
2.35.1


