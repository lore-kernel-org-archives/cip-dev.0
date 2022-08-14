Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE8C282E7
	for <webhook@archiver.kernel.org>; Sun, 14 Aug 2022 12:47:44 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.4526.1660481259086347315
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Aug 2022 05:47:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=UypULXP0;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-2022081412473519be7ada5a12a8d16e-16onu7@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 2022081412473519be7ada5a12a8d16e
        for <cip-dev@lists.cip-project.org>;
        Sun, 14 Aug 2022 14:47:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=igBEulg9HlT062t9Jz6MOer1MH+RL7JY/Lg0bpotGFA=;
 b=UypULXP0KFCPX1CBP5WrYMZgap6BpD+tayrDybRd12C2SCNWW7M0AGJ+dbb4dZyIFM1Psm
 vxeRuFMNXz92fvpsKDXIJdHQXFyazmJ/5z+kwIo6bGDoykLy11OPpYEVsGN/hphwhmZ81TuE
 CuER9FTa2b3BIqHx9wt33AZNmsUDI=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Shivanand.Kunijadar@toshiba-tsip.com
Subject: [isar-cip-core][PATCH 0/4] BeagleBone Black related fixes and
 cleanups, kernel updates
Date: Sun, 14 Aug 2022 15:47:29 +0300
Message-Id: <cover.1660481252.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Aug 2022 12:47:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9207

Resolves [1] and also removes the last deviation from cip-kernel-config.
Along this, it brings kernel updates which are also needed to perform
the config update for 5.10 on rzg2m.

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/37

Jan Kiszka (4):
  bbb: Fix console parameter
  linux-cip: Update to latest 4.4/4.19/5.10 releases
  linux-cip: Update cip-kernel-config revision
  linux-cip: Switch to bbb to cip-kernel-config

 conf/machine/bbb.conf                         |   3 +
 recipes-kernel/linux/files/bbb_defconfig      | 455 ------------------
 recipes-kernel/linux/linux-cip-common.inc     |   4 +-
 ...bb => linux-cip-rt_4.19.252-cip78-rt26.bb} |   2 +-
 ....bb => linux-cip-rt_4.4.302-cip70-rt40.bb} |   2 +-
 ....bb => linux-cip-rt_5.10.131-cip13-rt5.bb} |   2 +-
 ...9-cip76.bb => linux-cip_4.19.252-cip78.bb} |   2 +-
 ...02-cip69.bb => linux-cip_4.4.302-cip70.bb} |   2 +-
 ...6-cip11.bb => linux-cip_5.10.131-cip13.bb} |   2 +-
 wic/bbb.wks                                   |   2 +-
 10 files changed, 11 insertions(+), 465 deletions(-)
 delete mode 100644 recipes-kernel/linux/files/bbb_defconfig
 rename recipes-kernel/linux/{linux-cip-rt_4.19.245-cip74-rt25.bb => linux-cip-rt_4.19.252-cip78-rt26.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip69-rt39.bb => linux-cip-rt_4.4.302-cip70-rt40.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.109-cip5-rt4.bb => linux-cip-rt_5.10.131-cip13-rt5.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.249-cip76.bb => linux-cip_4.19.252-cip78.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip69.bb => linux-cip_4.4.302-cip70.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.126-cip11.bb => linux-cip_5.10.131-cip13.bb} (72%)

-- 
2.35.3


