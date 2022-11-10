Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3088C43219
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 12:45:10 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web09.6907.1668084308423803106
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 04:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=qQPQCr7c;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202211101245057173d129217d31aafe-7vmh_r@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202211101245057173d129217d31aafe
        for <cip-dev@lists.cip-project.org>;
        Thu, 10 Nov 2022 13:45:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=AZW5CNaC+9dIDRffN5gV/CIQZM6NzEHowiVeC3x2Agg=;
 b=qQPQCr7cRSQWPJwumv2373ouvwgpdDkE9wHkMyWFIqnZdb+Bu+pSBZiSLISHTITUSIZTk/
 tE6Juv+ZFz6F2cqW8F2f6jroxBB1CcshEb/91mcEwIYBq6n85nNSfqZilFoSlZYMp3NTrsm6
 NoMQo0dXrrSZRkgwZwBWzEUObfcGo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 0/5] SWUpdate abort on installing indentical image
Date: Thu, 10 Nov 2022 13:44:58 +0100
Message-Id: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 12:45:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10000

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Use a pre/post function of the SWUpdate handler round robin to check if the given uuid
is already in the current root file system and abort if the uuid matches.

This fixes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/43

Quirin Gylstorff (5):
  core/images/swupdate.inc: Move image_uuid to swupdate.inc
  swupdate-handler-roundrobin: Increase revision
  swupdate-handler-roundrobin: add uuidcheck patch
  image_uuid: read target_image_uuid
  recipe-core/images: Integrate uuidcheck into sw-description

 classes/image_uuid.bbclass                    | 19 ++++++++
 kas/opt/ebg-swu.yml                           |  2 +-
 recipes-core/images/files/sw-description.tmpl |  1 +
 recipes-core/images/image-uuid.inc            | 12 ------
 recipes-core/images/swupdate.inc              |  6 ++-
 ...-add-uuidcheck-to-roundrobin-handler.patch | 43 +++++++++++++++++++
 .../swupdate-handler-roundrobin_0.1.bb        |  5 ++-
 7 files changed, 73 insertions(+), 15 deletions(-)
 delete mode 100644 recipes-core/images/image-uuid.inc
 create mode 100644 recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch

-- 
2.35.1


