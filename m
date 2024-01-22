Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE6C47DDE
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 12:38:00 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.72529.1705927075633837439
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jan 2024 04:37:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=GA7yIFBY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2024012212375207a6a2f7f9b03dc97a-ic4hjd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024012212375207a6a2f7f9b03dc97a
        for <cip-dev@lists.cip-project.org>;
        Mon, 22 Jan 2024 13:37:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=VItGZIGAF9gwclhFttRw3qgbmodMSxkTrqNVBUv7ALo=;
 b=GA7yIFBYtHShr76oBucDFq/OfW0xqD9QEOrvpHn0h5oxhhtw03fpSLIIxVsXI51+WRoezt
 KeW31r3OnVjoTXcYTmEHSKuyS/bKAq9C9Wv1UoSvm5VQrug5aXzjk/WdhqyuKaYlG4P15XRG
 +M08CW5Z8lAw0NbFTJUDHDegFZd5g=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 0/4] Reduce difference to debian
Date: Mon, 22 Jan 2024 13:37:11 +0100
Message-ID: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jan 2024 12:38:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14435

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset introduces a new configuration package for SWUpdate:
  - It adds /etc/hwrevision to allow removal of the
    swupdate.pkg.nohwcompat build options
  - It moves the swupdate.cfg from customizations to allow the reusage
    in downstream layers
  - It adds an patch for suricatta_wfx which allows to use wfx without
    embedding the lua code in swupdate.

Quirin Gylstorff (4):
  swupdate-config: move swupdate.cfg from customizations to own recipe
  swupdate: set SWU_HW_COMPAT
  swupdate.bbclass: weak default assignment for SWU_HW_COMPAT
  swupdate: Add patch to copy the server_wfx.lua to /usr/share

 classes/swupdate.bbclass                      |  2 +-
 recipes-core/customizations/common.inc        |  8 +---
 recipes-core/images/swupdate.inc              |  2 +-
 .../swupdate-config/files/hwrevision.tmpl     |  1 +
 .../files/swupdate.cfg                        |  0
 .../swupdate-config/swupdate-config_0.1.bb    | 27 ++++++++++++
 ...rate-build_profile-option-for-delta-.patch |  8 ++--
 ...tch-to-add-the-build-version-to-swup.patch |  6 +--
 ...s-Add-option-to-enable-suricatta_wfx.patch |  6 +--
 ...install-Fix-path-for-debian-bullseye.patch |  6 +--
 ...tall-server_wfx.lua-to-usr-share-lua.patch | 44 +++++++++++++++++++
 recipes-core/swupdate/swupdate.inc            |  3 --
 recipes-core/swupdate/swupdate_2023.05.bb     |  8 +---
 13 files changed, 90 insertions(+), 31 deletions(-)
 create mode 100644 recipes-core/swupdate-config/files/hwrevision.tmpl
 rename recipes-core/{customizations => swupdate-config}/files/swupdate.cfg (100%)
 create mode 100644 recipes-core/swupdate-config/swupdate-config_0.1.bb
 create mode 100644 recipes-core/swupdate/files/2023.05/0005-d-rules-install-server_wfx.lua-to-usr-share-lua.patch

-- 
2.43.0


