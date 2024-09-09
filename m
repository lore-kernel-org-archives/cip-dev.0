Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8291EECE584
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 11:23:23 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.50639.1725880993268113177
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Sep 2024 04:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=TFzl6tR5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202409091123107d9e5e63b5dcff6bc2-h_34ty@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202409091123107d9e5e63b5dcff6bc2
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Sep 2024 13:23:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=8I83gkYcbx+euJ8bHvio8mNeKr1LcCm9ihUwllcQ9sY=;
 b=TFzl6tR59yDRpdSWBJ+K5QUaylsjyfv8oHx/BDrUjZSeErN7QXnT8gyrExtBqK7A+sFSqd
 b9iHboPWpOQuHQCVSKPUJyREncsjegxdq+HG0Z7gFurDCjpF4+aUEFbLXLhKmsvq3/ZcJtGF
 ck9PL0RzOIu6rvLkAmS0bpNrHh4d9OUvJOFVmUXK232V0T4XI5kDgFoo4SPO3XBjRulkiYZG
 EH0V8JcW8609NnKdG5lkmDbHd6jt4gTHVSGC18Wn06/lM0V1gQdhgMGsxQuBP2t+hyQlsoIz
 6/WbSino7vScvqIEfcZxFhGY5+GDQETUkLojUDEVQC3ktri094pbB75w==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC 0/3] Separate swu signing script from key
Date: Mon,  9 Sep 2024 13:21:37 +0200
Message-ID: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Sep 2024 11:23:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16867

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Some downstream projects use Hardware security module(HSM) to sign their
updates. To avoid a error message in case a HSM is used the user needs
override the major parts of the swupdate-certificates-key recipe. To
reduce the integration work in a downstream layer:
- seperate the signing script from the keys
- move the package installation of th scripts out of the swupdate.bbclass.
- update the readme to show this new behaviour

Quirin Gylstorff (3):
  Move signing script to seperate package to better support HSM signing
  Add check for sign-swu executable
  Update README for swupdate signing

 classes/swupdate.bbclass                      |  7 ++++--
 doc/README.swupdate.md                        | 16 ++++++++++--
 recipes-core/images/swupdate.inc              |  5 +++-
 .../swupdate-certificates-key.inc             |  9 +------
 .../files/sign-swu-cms                        |  0
 .../files/sign-swu-rsa                        |  0
 .../swupdate-signer/swupdate-signer_0.1.bb    | 25 +++++++++++++++++++
 7 files changed, 49 insertions(+), 13 deletions(-)
 rename recipes-devtools/{swupdate-certificates => swupdate-signer}/files/sign-swu-cms (100%)
 rename recipes-devtools/{swupdate-certificates => swupdate-signer}/files/sign-swu-rsa (100%)
 create mode 100644 recipes-devtools/swupdate-signer/swupdate-signer_0.1.bb

-- 
2.45.2


