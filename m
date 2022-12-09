Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E20C4332F
	for <webhook@archiver.kernel.org>; Fri,  9 Dec 2022 14:58:34 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.3363.1670597912593852054
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Dec 2022 06:58:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=imHdZS9f;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202212091458284a3eebaf8ec9f26485-yzfe3q@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202212091458284a3eebaf8ec9f26485
        for <cip-dev@lists.cip-project.org>;
        Fri, 09 Dec 2022 15:58:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=By5LDKOUL/hvQKj326TeIqIr8XW8ZTLPIqlf2qDyvUM=;
 b=imHdZS9f8uBtfuAAFiq9aVxLRhkFnTXvMBmI3A8kBvA8cOxGPLgWq4nvSft8qvlP7Dml2Y
 5BHsJ6pvEKuIZfyFk2FTdcVxBk0xqgWzwIv+MVT7Olrea5+Cz8+mZx+OzhWkAsASZbOk/t3s
 lJP1dS9am4WEQHsMAqjgmKEY69N+0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/4] SWUpdate abort on installing indentical image
Date: Fri,  9 Dec 2022 15:58:23 +0100
Message-Id: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Dec 2022 14:58:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10176

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Use a pre/post function of the SWUpdate handler round robin to check if the given uuid
is already in the current root file system and abort if the uuid matches.

This fixes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/43

Changes in V2:
 - remove RFC
 - Use upstream version instead of patch
 - add comment for variable expension

Quirin Gylstorff (4):
  core/images/swupdate.inc: Move image_uuid to swupdate.inc
  swupdate-handler-roundrobin: Increase revision for configfilecheck
  image_uuid: read target_image_uuid
  recipe-core/images: Integrate configfilecheck into sw-description

 classes/image_uuid.bbclass                    | 19 +++++++++++++++++++
 kas/opt/ebg-swu.yml                           |  2 +-
 recipes-core/images/files/sw-description.tmpl |  1 +
 recipes-core/images/image-uuid.inc            | 12 ------------
 recipes-core/images/swupdate.inc              |  6 +++++-
 .../swupdate-handler-roundrobin_0.1.bb        |  2 +-
 6 files changed, 27 insertions(+), 15 deletions(-)
 delete mode 100644 recipes-core/images/image-uuid.inc

-- 
2.35.1


