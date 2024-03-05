Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACBAC54E55
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 16:11:35 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.27141.1709655092397391767
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 08:11:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Qxdrxly+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240305161129c67d709689b46fd860-e7ykaf@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240305161129c67d709689b46fd860
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 17:11:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=rZt9xLHOOVD0xzy5q9BRC3NJBSqnemomCYZr8gLyb8I=;
 b=Qxdrxly+IGNd7tACOQ2C8ndsgy654T1OTOBpuGvz4iqVWUx8e+275KyBM/U//GLhhOsPLi
 VHjiwsz4w8+GAWDrt1kyybVaEacNiOBv/Iq3KrbJb2jxtXRiF74aABlVZDBVCpkAjOSzyA6P
 5Ep40qEgDB8aOY6zKOskmUpzNsxPc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 0/6] Make swupdate signing more robust
Date: Tue,  5 Mar 2024 17:10:53 +0100
Message-ID: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 16:11:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15233

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset adds checks to validate the certificate and key before
used in the signing process.

Add also adds the missing Documentation about swu signing in cip-core
and fixes two issues:
 - an error in the build logs of do_image_swu
 - Creating all existing image recipes by touching SRC_URI in a anonym
   python function.

Changes v3:
 - rebase onto next(704353612238cb2ac1c16f29db6f314b60cd83b0)
 - use local variable to increase readability
 - add formatting patches
 - fix typo in commit message

Changes v2:
  - Add information about cpio option in long form
  - replace cpio option `-H` with long form '--format='


Quirin Gylstorff (6):
  swupdate: check output of sign-swu
  sign-swu-cms: check if key and cert are valid
  doc: Add section about SWUpdate signing to README.swupdate.md
  fix do not add files to each image recipe
  format: classes/efibootguard fix spacing
  format: classes/swupdate fix parenthesis

 classes/efibootguard.bbclass                  | 39 ++++----
 classes/swupdate.bbclass                      | 88 +++++++++++++------
 doc/README.swupdate.md                        | 21 +++++
 .../swupdate-certificates/files/sign-swu-cms  | 29 +++++-
 4 files changed, 127 insertions(+), 50 deletions(-)

-- 
2.43.0


