Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC49C433F5
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 13:05:06 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web09.11478.1645016704498037944
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 05:05:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=mnUEfmxR;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-51332-2022021613031838d9cfb2b336e6a1b9-glpf1x@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 2022021613031838d9cfb2b336e6a1b9
        for <cip-dev@lists.cip-project.org>;
        Wed, 16 Feb 2022 14:05:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=HyH8UX5vZL5EHxZ4qmTjHQ/4AjMPJjJrnfwei3TRs+4=;
 b=mnUEfmxRm1jZmb1PV66q9+kRyyL6lMI/Jkkrt4vzVydolr0Dn9CY0ARXfbJfKFConoTkSc
 8wEhQClNciJqGGAESgBQbX7JrYNlIN8maWzPkAgSacNOezHkqSJS1Gdob96Aw+rvqG0s9ahg
 UjwScP1Y05eRb6pPXnpmWgzg3M5Bo=;
From: Quirin.Gylstorff@siemens.com
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 0/2] Update ISAR layer
Date: Wed, 16 Feb 2022 14:03:15 +0100
Message-Id: <20220216130317.3018990-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 13:05:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7619

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This Updates the ISAR revision cf3f18a649ff42726677a58b224b9bb58ea4ba46
and converts the swupdate recipes to the usage of DEB_BUILD_PROFILES

Quirin Gylstorff (2):
  Update ISAR to next
  swupdate: Convert to DEB_BUILD_PROFILES

 kas-cip.yml                                          |  2 +-
 recipes-core/swupdate/swupdate.inc                   | 12 ++----------
 .../swupdate/swupdate_2021.11-1+debian-gbp.bb        | 11 ++++-------
 3 files changed, 7 insertions(+), 18 deletions(-)

-- 
2.34.1


