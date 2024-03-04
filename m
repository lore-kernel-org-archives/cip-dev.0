Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D7C54E5A
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 10:54:58 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.95415.1709549696687355888
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 02:54:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=fSsXBJNf;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240304105453e60d0d745f547459ee-wk3cy4@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240304105453e60d0d745f547459ee
        for <cip-dev@lists.cip-project.org>;
        Mon, 04 Mar 2024 11:54:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=nDkhf6FBDK5IPFSPDsgggFriMOJ4voRPtmrxghUHMB0=;
 b=fSsXBJNfB+TPpgwHQuuE02tUD92K/p+PNaCzGx4vgYWxvCBWh3Kh6vJxyoO7yBmqUYTyee
 cT1y60/8N12mWI9CzXzr8vO5aJIwRYtHyfweELBnGn9hSt15jg/RUm+c1smHiABKGVKeDSDf
 dPhEuZWoQsZCt083aDLp45Guy4sNU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 0/4] Reduce difference to debian
Date: Mon,  4 Mar 2024 11:54:48 +0100
Message-ID: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Mar 2024 10:54:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15191

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset introduces a new configuration package for SWUpdate:
  - It adds /etc/hwrevision to allow removal of the
    swupdate.pkg.nohwcompat build options
  - It moves the swupdate.cfg from customizations to allow the reusage
    in downstream layers

Changes v4:
 - rebase onto next(35f5ab2)
 - Add information for HW_COMPAT in production

Changes v3:
 - add entry to README.swupdate.md
 - correct hwrevision.tmpl
 - rework commit message

Changes v2:
 - drop Add patch to copy the server_wfx.lua to /usr/share as Debian
   upstream is also enabling CONFIG_EMBEDDED_SURICATTA_LUA[1]
 - Use RDEPENDS in customization

Quirin Gylstorff (4):
  swupdate-config: move swupdate.cfg from customizations to own recipe
  swupdate: set SWU_HW_COMPAT
  swupdate.bbclass: weak default assignment for SWU_HW_COMPAT
  doc/README.swupdate.md: Add documentation for hardware compatibility

 classes/swupdate.bbclass                      |  2 +-
 doc/README.swupdate.md                        | 14 ++++++++++
 recipes-core/customizations/common.inc        |  8 ++----
 recipes-core/images/swupdate.inc              |  2 +-
 .../swupdate-config/files/hwrevision.tmpl     |  1 +
 .../files/swupdate.cfg                        |  0
 .../swupdate-config/swupdate-config_0.1.bb    | 27 +++++++++++++++++++
 recipes-core/swupdate/swupdate.inc            |  3 ---
 8 files changed, 46 insertions(+), 11 deletions(-)
 create mode 100644 recipes-core/swupdate-config/files/hwrevision.tmpl
 rename recipes-core/{customizations => swupdate-config}/files/swupdate.cfg (100%)
 create mode 100644 recipes-core/swupdate-config/swupdate-config_0.1.bb

-- 
2.43.0


