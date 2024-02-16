Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74137C48BF7
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 15:30:31 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.21577.1708097428125575983
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 07:30:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Zy/p9UdC;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240216153024c701e5ed89396f6983-pwqkwz@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240216153024c701e5ed89396f6983
        for <cip-dev@lists.cip-project.org>;
        Fri, 16 Feb 2024 16:30:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=x15vENfmupFfPAnmRoX/yGkRLEXgcKi0HY2bmA1Ewmw=;
 b=Zy/p9UdCrtWy/ZxIFoxt/E9g+MEnv4I/mKFZivEFRWHbEY4OzyapxWgFjqnthUleM2WFcX
 zVRp+tJ/iOLsOIx1xIF9MArgO8frMg6/Xv7wBAcc99CWg7B7/k8pHqHQQjQ4S2BW6C/h4Nak
 umHAmad9vHZ56Qg0qQTUTQulXKuzA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 0/4] Reduce difference to debian
Date: Fri, 16 Feb 2024 16:30:01 +0100
Message-ID: <20240216153024.260416-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 15:30:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15015

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>


This patchset introduces a new configuration package for SWUpdate:
  - It adds /etc/hwrevision to allow removal of the
    swupdate.pkg.nohwcompat build options
  - It moves the swupdate.cfg from customizations to allow the reusage
    in downstream layers


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
 doc/README.swupdate.md                        | 10 +++++++
 recipes-core/customizations/common.inc        |  8 ++----
 recipes-core/images/swupdate.inc              |  2 +-
 .../swupdate-config/files/hwrevision.tmpl     |  1 +
 .../files/swupdate.cfg                        |  0
 .../swupdate-config/swupdate-config_0.1.bb    | 27 +++++++++++++++++++
 recipes-core/swupdate/swupdate.inc            |  3 ---
 8 files changed, 42 insertions(+), 11 deletions(-)
 create mode 100644 recipes-core/swupdate-config/files/hwrevision.tmpl
 rename recipes-core/{customizations => swupdate-config}/files/swupdate.cfg (100%)
 create mode 100644 recipes-core/swupdate-config/swupdate-config_0.1.bb

-- 
2.43.0


