Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82040C0015E
	for <webhook@archiver.kernel.org>; Mon, 17 Jul 2023 10:54:26 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.5351.1689591261877825121
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 03:54:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=bGU4iZ9v;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230717105418bd965f644568ff1cd0-gblm2b@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230717105418bd965f644568ff1cd0
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Jul 2023 12:54:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=I3NU/Ivl9FFZptlSbCZviQeP1CIMvB9mKtS9rid/se0=;
 b=bGU4iZ9vu9ISi+vVIateWqyV4Xo5JX/B3QDLkMMws/phzd5Q5W5MbovLOcuFeYcAXC06cE
 Q+TXnpGbdV9Nbse7EYBsQNUyKhd6291duS+rntfJ9gIC2TyQQKAJWxTqTYs/aGj8mTOhCB+g
 MYT8Pamiq9OA8A/rlsjZZZq+wrNXs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 0/3] Enable signed Software Update Binaries
Date: Mon, 17 Jul 2023 12:54:14 +0200
Message-Id: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jul 2023 10:54:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12367

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

With this patch series SWUpdate applies only signed update binaries.
Also the signing will switch from RSA PKCS#1.5 or RSA PSS signing to
a certificate based signing.

Changes v2:
 - use Debian snakeoil keys and certificates
   from secure-boot-secrets for signing
 - fix typos in commit messages
 - fix author name in recipe-devtools/swupdate-certificates/*
 - enabled signing in swupdate.bbclass instead of image recipe
 - moved dependency to swupdate-certificates to swupdate.bbclass


Quirin Gylstorff (3):
  recipe-devtools: Add recipe to sign SWUpdate update binaries
  swupdate.bbclass: Use new swupdate-certificate
  swupdate: Enable signed updates

 classes/swupdate.bbclass                      | 21 ++++++-------
 kas/opt/swupdate.yml                          |  2 ++
 .../customizations/files/swupdate.cfg         |  1 +
 recipes-core/images/swupdate.inc              |  4 ++-
 .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  9 ++++--
 recipes-core/swupdate/swupdate_2023.05.bb     |  8 +++--
 .../secure-boot-secrets/files/buster/bookworm |  1 +
 .../secure-boot-secrets/files/buster/bullseye |  1 +
 .../swupdate-certificates/files/bookworm      |  1 +
 .../swupdate-certificates/files/bullseye      |  1 +
 .../swupdate-certificates/files/buster        |  1 +
 .../swupdate-certificates-key-snakeoil_0.1.bb | 18 +++++++++++
 .../swupdate-certificates-key.inc             | 31 +++++++++++++++++++
 .../swupdate-certificates-key_0.1.bb          | 17 ++++++++++
 .../swupdate-certificates-snakeoil_0.1.bb     | 16 ++++++++++
 .../swupdate-certificates.inc                 | 31 +++++++++++++++++++
 .../swupdate-certificates_0.1.bb              | 14 +++++++++
 17 files changed, 160 insertions(+), 17 deletions(-)
 create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bookworm
 create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bullseye
 create mode 120000 recipes-devtools/swupdate-certificates/files/bookworm
 create mode 120000 recipes-devtools/swupdate-certificates/files/bullseye
 create mode 120000 recipes-devtools/swupdate-certificates/files/buster
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates.inc
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb

-- 
2.40.1


