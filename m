Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EDEC433EF
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 07:25:37 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.24146.1654845929333211476
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jun 2022 00:25:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=T0YkUaP7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-20220610072525d7bad6eb5899f30e13-qnihoc@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220610072525d7bad6eb5899f30e13
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Jun 2022 09:25:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=01nwAEeg2oJH776KgYkItIak3NBGxSi94FK9NuKJwGY=;
 b=T0YkUaP7AoqwPtvput4fysWMmoCqNZdx+7Ka/jze+hzSAxe5f7Zny9nCHzlnxt6RGSb8HN
 +7SZTI1rU/D70Nv9zegFmHqRjszVuUbxtpV4K/ds3rSR7GEaEDwdIkqBoXKmHbGEPEkFR5N7
 4Gtay8ywV1xpL09cM4FcN/AtXs9a0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 0/2] Update CI builds
Date: Fri, 10 Jun 2022 09:25:22 +0200
Message-Id: <20220610072524.910925-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 07:25:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8524

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

 - Add CI builds for secureboot arm64
 - Use Debian bullseye as default distro

Quirin Gylstorff (2):
  .gitlabci: add qemu-arm64 secureboot and swupdate
  .gitlabci: switch to bullseye

 .gitlab-ci.yml | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

-- 
2.35.1


