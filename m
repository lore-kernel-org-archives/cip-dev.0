Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA99C4829B
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 13:45:12 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.20318.1707313509130459101
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Feb 2024 05:45:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=I+5TT0C5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2024020713450655406fd0e33222b83b-43hadb@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024020713450655406fd0e33222b83b
        for <cip-dev@lists.cip-project.org>;
        Wed, 07 Feb 2024 14:45:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=wcaUD+twg0bF3pGH5hnEgqA/jMAFQH/9bljftrOkRII=;
 b=I+5TT0C5q3nFT9qrINhHnLTzHCz31bh0HXlclKT3GR5V3X2+OwrW+dIePllKnSuuSLk2wj
 k06Txky9gchsdITiQWPj3Oe8T/qYYKzDcYKL4iTDYHq3Bg7zVZzt8pdJSlngDDoeLWOuM4P+
 r/0bH4sn+ZFxN7AJJwJZrN19R/7Ys=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/3] Reduce difference to debian
Date: Wed,  7 Feb 2024 14:44:24 +0100
Message-ID: <20240207134505.3286003-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 13:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14884

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset introduces a new configuration package for SWUpdate:
  - It adds /etc/hwrevision to allow removal of the
    swupdate.pkg.nohwcompat build options
  - It moves the swupdate.cfg from customizations to allow the reusage
    in downstream layers

Changes v2:
 - drop Add patch to copy the server_wfx.lua to /usr/share as Debian
   upstream is also enabling CONFIG_EMBEDDED_SURICATTA_LUA[1]
 - Use RDEPENDS in customization


[1]: https://salsa.debian.org/debian/swupdate/-/commit/3dede8b0bd8fe2a313905512fa738dcb37ff46481

Quirin Gylstorff (3):
  swupdate-config: move swupdate.cfg from customizations to own recipe
  swupdate: set SWU_HW_COMPAT
  swupdate.bbclass: weak default assignment for SWU_HW_COMPAT

 classes/swupdate.bbclass                      |  2 +-
 recipes-core/customizations/common.inc        |  8 ++----
 recipes-core/images/swupdate.inc              |  2 +-
 .../swupdate-config/files/hwrevision.tmpl     |  1 +
 .../files/swupdate.cfg                        |  0
 .../swupdate-config/swupdate-config_0.1.bb    | 27 +++++++++++++++++++
 recipes-core/swupdate/swupdate.inc            |  3 ---
 7 files changed, 32 insertions(+), 11 deletions(-)
 create mode 100644 recipes-core/swupdate-config/files/hwrevision.tmpl
 rename recipes-core/{customizations => swupdate-config}/files/swupdate.cfg (100%)
 create mode 100644 recipes-core/swupdate-config/swupdate-config_0.1.bb

-- 
2.43.0


