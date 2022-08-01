Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2192FC25B06
	for <webhook@archiver.kernel.org>; Mon,  1 Aug 2022 14:57:59 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web09.25970.1659365874305839814
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Aug 2022 07:57:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=J9gAGykB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-51332-20220801145750222e09831660a44738-rizyt5@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20220801145750222e09831660a44738
        for <cip-dev@lists.cip-project.org>;
        Mon, 01 Aug 2022 16:57:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=U51PF9WgHAo5Bws4NxKA0t8scUhyMnY5EQJcAQI4c4Q=;
 b=J9gAGykBGdyCgMjFRFHJgL+0e41ZxrbFmtalsvk40dOh1KoC67ZXUjRxe0MkZHXZwhDSK5
 B8DeH3zfb1lqeRYW/o5oimBO31Os1gxzNkq17+c9VySgqmte+049DONG9D0DP1JcCbO2GXO1
 lUUaWt/r/volZQhyTDTGAgRx/o9Gw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 0/2] clean up kas/opt
Date: Mon,  1 Aug 2022 16:57:47 +0200
Message-Id: <20220801145749.42714-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Aug 2022 14:57:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8993

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Remove the kas option for efibootguard as it cannot build a image.
Move the package installation for swupdate to the include.

Quirin Gylstorff (2):
  kas: Remove efibootguard.yml
  kas/opt/swupdate: Move the package installation to swupdate.inc

 kas/opt/ebg-secure-boot-snakeoil.yml | 10 +++----
 kas/opt/ebg-swu.yml                  |  9 +++----
 kas/opt/efibootguard.yml             | 39 ----------------------------
 kas/opt/swupdate.yml                 |  4 ---
 recipes-core/images/efibootguard.inc | 26 +++++++++++++++++++
 recipes-core/images/swupdate.inc     |  3 +++
 6 files changed, 36 insertions(+), 55 deletions(-)
 delete mode 100644 kas/opt/efibootguard.yml
 create mode 100644 recipes-core/images/efibootguard.inc

-- 
2.35.1


