Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDAEC3ABCE
	for <webhook@archiver.kernel.org>; Mon, 16 Sep 2024 12:55:24 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.7844.1726491322281678490
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Sep 2024 05:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=WEFGMpKo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202409161255196f1266f38330927f88-ggbuno@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202409161255196f1266f38330927f88
        for <cip-dev@lists.cip-project.org>;
        Mon, 16 Sep 2024 14:55:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=rS2B8+Tl8m6VJ3oWOYfG2PnkWa8UmZQE3V6VRQm7q7Y=;
 b=WEFGMpKo29PbUHeMNkCVmD6gZvjtM9zWkW9nT6LxlSuoWZIdg/QFp/ZuLrV2qy/q/Vj9er
 7ztnnPyaU5LqVKtz8KrcTgZe8QYz6v0RjLfftA0MQMZ6NyTfBLKYKVGKtzLAS7k+HVc9eQFe
 D7lHDCYLhg8l5DnhGHB9tnZ67BhBS1D/ilBrZ5Hf1A9SX9Qfk4Ilmb6ZDXk7mHnPZwvJ/M9a
 dRG3W03e+YCTvj8+tS4STS+3PsL9uA6foxal9X/UgII7l7vtPmT9noKMgV01iX3PkYRPugHE
 TeAh/+hAUtksY9rtv4KqWXNpxXRyExO73QPKhrVfnIP4Yjfv12HTaP4Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 0/3] Separate swu signing script from key
Date: Mon, 16 Sep 2024 14:54:52 +0200
Message-ID: <20240916125518.614224-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Sep 2024 12:55:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16903

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Some downstream projects use Hardware security module(HSM) to sign their
updates. To avoid a error message in case a HSM is used the user needs
override the major parts of the swupdate-certificates-key recipe. To
reduce the integration work in a downstream layer:
- seperate the signing script from the keys
- move the package installation of th scripts out of the swupdate.bbclass.
- update the readme to show this new behaviour

Changes in v2:
 - remove SWU_SIGN_SCRIPT variable
 - remove rsa-swu-sign script
 - fix typos in commit messages
 - rename swu-signer to swu-signer-snakeoil

Changes in v3:
  - Add example of an empty swupdate-signer
  - Clarify signing script section
  - rename swu-signer to swu-signer-cms

Quirin Gylstorff (3):
  Move signing script to seperate package to better support HSM signing
  Add check for sign-swu executable
  Update README for swupdate signing

 classes/swupdate.bbclass                      |  7 +++--
 doc/README.swupdate.md                        | 25 +++++++++++++++---
 kas/opt/swupdate.yml                          |  1 +
 recipes-core/images/swupdate.inc              |  5 +++-
 .../swupdate-certificates/files/sign-swu-rsa  |  6 -----
 .../swupdate-certificates-key.inc             |  9 +------
 .../files/sign-swu-cms                        |  0
 .../swupdate-signer-cms_0.1.bb                | 26 +++++++++++++++++++
 .../swupdate-signer/swupdate-signer-empty.bb  | 22 ++++++++++++++++
 9 files changed, 81 insertions(+), 20 deletions(-)
 delete mode 100644 recipes-devtools/swupdate-certificates/files/sign-swu-rsa
 rename recipes-devtools/{swupdate-certificates => swupdate-signer}/files/sign-swu-cms (100%)
 create mode 100644 recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
 create mode 100644 recipes-devtools/swupdate-signer/swupdate-signer-empty.bb

-- 
2.45.2


