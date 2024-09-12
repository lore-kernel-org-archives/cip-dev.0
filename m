Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FC8EEB587
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 10:07:21 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.44542.1726135633739265472
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Sep 2024 03:07:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=DNF5A0rU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240912100710443b4fa3c8e2edd007-c_wtjw@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240912100710443b4fa3c8e2edd007
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Sep 2024 12:07:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=SOguypE7kJQ7PU8oFkALP2oy5a2fp9fzQwR0IrNYmAQ=;
 b=DNF5A0rUVs+tniSdKi0xblGzOCvaCudUIUr6vtPc+x59AT2iH1utzVv8xiVZ4AH6ea89eM
 vy/1yZMUkvU7fwc8gcbRU8hBvVWMVJug1eZykaIfXya1WUOfhDaN8S/ZvdzmIF3KtoPfCZbY
 +8KJfOXBlJVy9LL7Dj4JEAcLTPb/PmTXJOHHDh6ptbpPErgWIOHUlFAM0YuCiXeL+Xvbzv3L
 2GkXmOvAgdcATqU65SgNViFo7025wUaEjv5uXx6l/u+XaWLTONq5TTjXHU71FL+fPGOqehDF
 oCHFSvRw4P7UNTa/ca9Lhlq123fRBxI+c9WsKTstU7E+3dVhG/vAOi7w==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/3] Separate swu signing script from key
Date: Thu, 12 Sep 2024 12:06:39 +0200
Message-ID: <20240912100710.3183806-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 10:07:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16891

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

Quirin Gylstorff (3):
  Move signing script to seperate package to better support HSM signing
  Add check for sign-swu executable
  Update README for swupdate signing

 classes/swupdate.bbclass                      |  7 +++--
 doc/README.swupdate.md                        | 13 +++++++---
 recipes-core/images/swupdate.inc              |  5 +++-
 .../swupdate-certificates/files/sign-swu-rsa  |  6 -----
 .../swupdate-certificates-key.inc             |  9 +------
 .../files/sign-swu-cms                        |  0
 .../swupdate-signer-snakeoil_0.1.bb           | 26 +++++++++++++++++++
 7 files changed, 46 insertions(+), 20 deletions(-)
 delete mode 100644 recipes-devtools/swupdate-certificates/files/sign-swu-rsa
 rename recipes-devtools/{swupdate-certificates => swupdate-signer}/files/sign-swu-cms (100%)
 create mode 100644 recipes-devtools/swupdate-signer/swupdate-signer-snakeoil_0.1.bb

-- 
2.45.2


