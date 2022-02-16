Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDDAC433FE
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 16:04:06 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.936.1645027444932596328
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 08:04:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=HCNsmJwU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-51332-20220216160400adadf14aee1239ae7d-9cscfp@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20220216160400adadf14aee1239ae7d
        for <cip-dev@lists.cip-project.org>;
        Wed, 16 Feb 2022 17:04:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=IKauMqdn8Am3HDlENuxzyNKh5t3WXsytsw50UQZnfzI=;
 b=HCNsmJwUlfLtm4xs+TUr/TO3D7jNl2kbXmP0JVzGg1ud+iI1hibJ9i7/qXuFqLCYqim4za
 qcUQHqR9FdiPZLdOqMezzgzJ388UHxbOL5lFk/vPkS7EyCmeafjoKjp03gkqaiz1TYp0YCGC
 DRBDMciQWSpIeTOenJqkng9WniKSI=;
From: Quirin.Gylstorff@siemens.com
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-dev][PATCH v2 0/1] Update ISAR layer
Date: Wed, 16 Feb 2022 17:03:58 +0100
Message-Id: <20220216160359.3517492-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 16:04:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7625

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This Updates the ISAR revision cf3f18a649ff42726677a58b224b9bb58ea4ba46
and converts the swupdate recipes to the usage of DEB_BUILD_PROFILES

Changes V2:
 - folded patches into one
 - added reason for dropped nodoc to commit message

Quirin Gylstorff (1):
  Update ISAR to next

 kas-cip.yml                                          |  2 +-
 recipes-core/swupdate/swupdate.inc                   | 12 ++----------
 .../swupdate/swupdate_2021.11-1+debian-gbp.bb        | 11 ++++-------
 3 files changed, 7 insertions(+), 18 deletions(-)

-- 
2.34.1


