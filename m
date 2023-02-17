Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0F7C64EC4
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:26:04 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.9072.1676647560685193466
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 07:26:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Z4p8z3HY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2023021715255794368bbb1ddc293a28-zmxobe@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023021715255794368bbb1ddc293a28
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Feb 2023 16:25:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=c/8OajvrJO1iGNwrBTPA6dUrvMOBCT0tYMVtlxi1MXw=;
 b=Z4p8z3HYPLqbANXs8brByug35DD/+a5f1GU9WE2kWYwVhEt2K52YwuNd5x8sgmD09pmvG7
 XaI/ackHcMx5ZA0zoaDz77+UQSsolQDN2rhnnsoCRvxMtywi+QBNhmDEeAuRiCCbdhqZ8N/N
 d16cHuPOsRh7gqGvxXEg54LtPnJfs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 0/3] Enable Images based on Debian 12
Date: Fri, 17 Feb 2023 16:25:53 +0100
Message-Id: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 15:26:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10730

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add ci builds for bookworm
Change efibootguard build to use debian folder from salsa
Add missing riscv64 build to .gitlabci

Quirin Gylstorff (3):
  Enable Images based on Debian 12 (bookworm)
  efibootguard: use debian folder from salsa
  .gitlabci: add riscv64

 .gitlab-ci.yml                                | 60 +++++++++++++++++++
 Kconfig                                       |  5 ++
 conf/distro/cip-core-bookworm.conf            | 17 ++++++
 conf/distro/cip-core-bullseye.conf            |  1 +
 conf/distro/cip-core-buster.conf              |  1 +
 conf/distro/cip-core-sid-ports.conf           |  1 +
 kas/opt/bookworm.yml                          | 15 +++++
 ...uard_0.13.bb => efibootguard_0.13+isar.bb} | 25 ++++----
 ...l-Make-compatible-with-debian-buster.patch | 36 +++++++++++
 ...rol-remove-native-from-python3-shtab.patch | 26 ++++++++
 recipes-bsp/efibootguard/files/debian/compat  |  1 -
 .../efibootguard/files/debian/control.tmpl    | 20 -------
 .../debian/efibootguard-dev.install.tmpl      |  2 -
 .../files/debian/efibootguard.install         |  5 --
 recipes-bsp/efibootguard/files/debian/rules   | 15 -----
 recipes-core/images/efibootguard.inc          |  4 ++
 recipes-core/images/swupdate.inc              |  6 +-
 recipes-core/swupdate/swupdate.inc            |  2 +-
 18 files changed, 184 insertions(+), 58 deletions(-)
 create mode 100644 conf/distro/cip-core-bookworm.conf
 create mode 100644 kas/opt/bookworm.yml
 rename recipes-bsp/efibootguard/{efibootguard_0.13.bb => efibootguard_0.13+isar.bb} (55%)
 create mode 100644 recipes-bsp/efibootguard/files/0001-d-control-Make-compatible-with-debian-buster.patch
 create mode 100644 recipes-bsp/efibootguard/files/0002-d-control-remove-native-from-python3-shtab.patch
 delete mode 100644 recipes-bsp/efibootguard/files/debian/compat
 delete mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
 delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
 delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
 delete mode 100755 recipes-bsp/efibootguard/files/debian/rules

-- 
2.39.1


