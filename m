Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829C8E70713
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 10:23:40 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.12704.1695291815941159500
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Sep 2023 03:23:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=ThMbU/KO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20230921102332b2d324be6ef4c02aff-6ztj_m@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230921102332b2d324be6ef4c02aff
        for <cip-dev@lists.cip-project.org>;
        Thu, 21 Sep 2023 12:23:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=FyJWAimHZ4BwqOxKb/bnx2kfqijLdUNOAB0bPN6Nkg4=;
 b=ThMbU/KOvNUGP9lLO1jjnD2J11qGhUSnop6r+/8B/DjdYBFN0/O3Sgm1MzJOmFChPiDbKT
 tK4ac5OFd3glelqjsicRardw2a4oaJdgPIt9odr3U2MowwAXcPldfSrjhkEGvNFo/XqMVdoO
 loQzwljfdgv03ODMjkZh6sLRMBmQ4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/5] Switch kernel downloads, make bookworm default, refine CI targets
Date: Thu, 21 Sep 2023 12:23:26 +0200
Message-Id: <cover.1695291811.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 10:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13194

See patches for details.

Jan

Jan Kiszka (5):
  linux-cip: Switch to new download space
  linux-cip: Move KERNEL_DEFCONFIG_VERSION into linux-cip-common.inc
  linux-cip: Update to 5.10.194-cip39[-rt16] and 6.1.54-cip6
  Make bookworm the default Debian version
  ci: Reduce number of build tests, focus on bookworm

 .gitlab-ci.yml                                | 76 ++++++-------------
 Kconfig                                       |  2 +-
 kas-cip.yml                                   |  2 +-
 recipes-kernel/linux/linux-cip-common.inc     |  5 +-
 .../linux-cip-rt_4.19.288-cip101-rt32.bb      |  4 +-
 .../linux/linux-cip-rt_4.4.302-cip78-rt45.bb  |  4 +-
 ...bb => linux-cip-rt_5.10.194-cip39-rt16.bb} |  4 +-
 .../linux/linux-cip-rt_6.1.46-cip4-rt2.bb     |  4 +-
 .../linux/linux-cip_4.19.292-cip102.bb        |  4 +-
 .../linux/linux-cip_4.4.302-cip79.bb          |  4 +-
 ...1-cip38.bb => linux-cip_5.10.194-cip39.bb} |  4 +-
 ....1.52-cip5.bb => linux-cip_6.1.54-cip6.bb} |  4 +-
 12 files changed, 37 insertions(+), 80 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.186-cip37-rt15.bb => linux-cip-rt_5.10.194-cip39-rt16.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_5.10.191-cip38.bb => linux-cip_5.10.194-cip39.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.1.52-cip5.bb => linux-cip_6.1.54-cip6.bb} (50%)

-- 
2.35.3


