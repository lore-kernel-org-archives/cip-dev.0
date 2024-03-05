Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133C3C54E58
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 11:03:24 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.20090.1709636595243027490
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 03:03:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=WT64Fqr2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2024030511031233fa411f306ebe3701-rcnx6o@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024030511031233fa411f306ebe3701
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 12:03:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=b6XqPRIERsrgEA6hopMgvLs6kQ6XcAsOYodlSafPnqU=;
 b=WT64Fqr275H3ZduMyaJIplsh4h4k4Xe6Tk6k+ivVu3Xdu/c94eSOy15pwpWmNAJa1W9vt3
 MySoNgGCdx6t6OUd9zhaOxR6Q9fl+dV2V3BdFznrPSK3BvfoPJX3joa9a5z3bd7KXAUjmr7R
 Wxb/7C/lZvk/mgzlxj4rFOKW1OGMg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/4]  Make swupdate signing more robust
Date: Tue,  5 Mar 2024 12:02:42 +0100
Message-ID: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 11:03:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15216

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset adds checks to validate the certificate and key before
used in the signing process.

Add also adds the missing Documentation about swu signing in cip-core
and fixes two issues:
 - an error in the build logs of do_image_swu
 - Creating all existing image recipes by touching SRC_URI in a anonym
   python function.

Changes v2:
  - Add information about cpio option in long form
  - replace cpio option `-H` with long form '--format='

Quirin Gylstorff (4):
  swupdate: check output of sign-swu
  sign-swu-cms: check if key and cert are valid
  doc: Add section about SWUpdate signing to README.swupdate.md
  fix do not add files to each image recipe

 classes/efibootguard.bbclass                  |  1 -
 classes/swupdate.bbclass                      | 83 +++++++++++++------
 doc/README.swupdate.md                        | 21 +++++
 .../swupdate-certificates/files/sign-swu-cms  | 29 ++++++-
 4 files changed, 105 insertions(+), 29 deletions(-)

-- 
2.43.0


