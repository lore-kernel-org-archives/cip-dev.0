Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF46C48BEB
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 08:08:58 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.14262.1708070934664994160
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 00:08:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=bVJANkHw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240216080850963476f8a358b90bb5-mvselm@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240216080850963476f8a358b90bb5
        for <cip-dev@lists.cip-project.org>;
        Fri, 16 Feb 2024 09:08:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=PMTsnhCPDulSUJmdfGOzbd14N2xgv2NpG1OAhhlE050=;
 b=bVJANkHwmYp6o20ddjIlnsOIT6aD7xUzPi/QhvXBi7ljjJkK4LQTqBvpxLKlePh7WSYGEU
 GUYzvXRcL5KtvNu/DdX40iZXM9wU5Y0ToCQwzhOYFuirS0N4vR35MrhgA48mQY/89BxaE4El
 nlca/mFBiRUESyaYtYigBdEiFGOHA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 0/3] Add SWUpdate 2022.12
Date: Fri, 16 Feb 2024 09:07:12 +0100
Message-ID: <20240216080848.9146-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 08:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15008

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

SWUpdate changed the API for the Suricatta lua plugin with 2023.05.
To support released legacy application which use the old api add
SWUpdate 2022.12.

Changes v3:
  - remove cowsay - was added for update testing

Changes v2:
 - Reword commit message 'add SWUpdate 2022.12'
   - add information from salsa


Quirin Gylstorff (3):
  swupdate delete unused patch
  add SWUpdate 2022.12
  build swupdate 2022.12 for qemu-amd64-secure-boot-bullseye

 .gitlab-ci.yml                                |  4 +-
 kas/opt/swupdate-2022.12.yaml                 | 21 ++++++++++
 ...-Add-option-to-enable-surricatta-lua.patch | 27 ++++++++++++
 ...ch-to-add-the-build-version-to-swup.patch} |  8 ++--
 .../swupdate/swupdate_2022.12+dsfg-4-cip.bb   | 41 +++++++++++++++++++
 5 files changed, 96 insertions(+), 5 deletions(-)
 create mode 100644 kas/opt/swupdate-2022.12.yaml
 create mode 100644 recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
 rename recipes-core/swupdate/files/{0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch => 2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch} (94%)
 create mode 100644 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb

-- 
2.43.0


