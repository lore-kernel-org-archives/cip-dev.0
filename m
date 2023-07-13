Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455CDC001DF
	for <webhook@archiver.kernel.org>; Thu, 13 Jul 2023 08:51:22 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.4096.1689238271656695802
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jul 2023 01:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=OVhYOS0d;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20230713085108cdee841501b9b2702d-fm3wia@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230713085108cdee841501b9b2702d
        for <cip-dev@lists.cip-project.org>;
        Thu, 13 Jul 2023 10:51:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Exaek7ukP/vgWxqePcAvYXlKlFyTK02FiXztIPdwHyY=;
 b=OVhYOS0dwp4VPJa2jLxh4bvOrBGD71kICFtcAd32b7oYNJdEau7mccnlcxPYQCxQffNEAx
 f2Dsd/Rb3Dq5sCFE49En0KvET4nKc3HDLbOuA7I0jJd9+p6FhdZ0sdWtOSdrXUYdqoaDU0KU
 APgJ8OfJmIrVhPi/y/wPk35jgNvss=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC 0/3] Enable signed Software Update Binaries
Date: Thu, 13 Jul 2023 10:51:03 +0200
Message-Id: <20230713085106.2062587-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jul 2023 08:51:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12330

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

With this patch series SWUpdate applies only signed update binaries.
Also the signing will switch from RSA PKCS#1.5 or RSA PSS signing to
a certificate based signing.


Quirin Gylstorff (3):
  recipe-devtools: Add recipe to sign SWUpdate update binaries
  swupdate.bbclass: Use new swupdate-certificate
  swupdate: Enable signed updates

 classes/swupdate.bbclass                      | 15 +++---
 conf/distro/cip-core-common.inc               |  1 +
 kas/opt/swupdate.yml                          |  2 +
 .../customizations/files/swupdate.cfg         |  1 +
 recipes-core/images/swupdate.inc              |  4 ++
 recipes-core/swupdate/swupdate_2023.05.bb     |  3 +-
 .../files/cip-swupdate-snakeoil.cert.pem      | 30 +++++++++++
 .../files/cip-swupdate-snakeoil.key.pem       | 52 +++++++++++++++++++
 .../swupdate-certificates-key-snakeoil_0.1.bb | 17 ++++++
 .../swupdate-certificates-key.inc             | 31 +++++++++++
 .../swupdate-certificates-key_0.1.bb          | 15 ++++++
 .../swupdate-certificates-snakeoil_0.1.bb     | 16 ++++++
 .../swupdate-certificates.inc                 | 31 +++++++++++
 .../swupdate-certificates_0.1.bb              | 14 +++++
 14 files changed, 221 insertions(+), 11 deletions(-)
 create mode 100644 recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem
 create mode 100644 recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates.inc
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb

-- 
2.40.1


