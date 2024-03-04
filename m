Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C4BC48BF6
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 10:11:08 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.94820.1709547059142099781
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 02:11:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=UtpN8ExS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20240304101055f9a52cf03172d813e1-d7mmee@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240304101055f9a52cf03172d813e1
        for <cip-dev@lists.cip-project.org>;
        Mon, 04 Mar 2024 11:10:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=bxOyhGG/yVCVdRtogKdcYMFxxqdnK0NiGNY9SAjS5Ic=;
 b=UtpN8ExSWNqnhU7IMQ+gDRBVIbidtlEgnpFzjAYcYRo9vLZXcbjE21FogmtwJNPwjjt26a
 +yLhWQFMMIWmdRVb7IG84xIWuF36mnwYcn+rCPgzZsTbWuSQR6dYBXcWtX6cPU4fYD9UCxEz
 d1rWIyA0KdtOTaoTzG8Dg7vy3rLDc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 0/4] Make swupdate signing more
Date: Mon,  4 Mar 2024 11:08:40 +0100
Message-ID: <20240304101054.864948-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Mar 2024 10:11:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15186

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset adds checks to validate the certificate and key before
used in the signing process.

Add also adds the missing Documentation about swu signing in cip-core
and fixes two issues:
 - an error in the build logs of do_image_swu
 - Creating all existing image recipes by touching SRC_URI in a anonym
   python function.

Quirin Gylstorff (4):
  swupdate: check output of sign-swu
  sign-swu-cms: check if key and cert are valid
  doc: Add section about SWUpdate signing to README.swupdate.md
  fix do not add files to each image recipe

 classes/efibootguard.bbclass                  |  1 -
 classes/swupdate.bbclass                      | 83 +++++++++++++------
 doc/README.swupdate.md                        | 21 +++++
 .../swupdate-certificates/files/sign-swu-cms  | 29 ++++++-
 4 files changed, 105 insertions(+), 29 deletions(-)

-- 
2.43.0


