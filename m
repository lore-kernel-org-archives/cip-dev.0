Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AB6C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 12:17:06 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.12621.1707999422792122787
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 04:17:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=chlxh5TN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20240215121700f0b3508041809bdc77-wja4ls@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240215121700f0b3508041809bdc77
        for <cip-dev@lists.cip-project.org>;
        Thu, 15 Feb 2024 13:17:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Up95IQYBs059nCoNV+NaaJXk3SoIdf3fZPmK2enWyGE=;
 b=chlxh5TNb2RlxIcHXBKBKh9apvPE+0FDXrEafpBylMpn78Vl6ijvkKxJoDLbihUoKIF0AG
 BBMKZcjlJm7QNnd717aYAeRqVRrju0IQdLqZeAEkNyxLkl4VsueNu0hmTt0otNeDCAaK3jWB
 iyh03p4TUMazqEEYyth09Q5nXSBzQ=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 0/3] Add SWUpdate 2022.12
Date: Thu, 15 Feb 2024 13:14:04 +0100
Message-ID: <20240215121659.315309-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 12:17:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14991

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

SWUpdate changed the API for the Suricatta lua plugin with 2023.05.
To support released legacy application which use the old api add
SWUpdate 2022.12.

Quirin Gylstorff (3):
  swupdate delete unused patch
  add SWUpdate 2022.12
  build swupdate 2022.12 for qemu-amd64-secure-boot-bullseye

 .gitlab-ci.yml                                |  4 +-
 kas/opt/swupdate-2022.12.yaml                 | 22 ++++++++++
 ...-Add-option-to-enable-surricatta-lua.patch | 27 ++++++++++++
 ...ch-to-add-the-build-version-to-swup.patch} |  8 ++--
 .../swupdate/swupdate_2022.12+dsfg-4-cip.bb   | 41 +++++++++++++++++++
 5 files changed, 97 insertions(+), 5 deletions(-)
 create mode 100644 kas/opt/swupdate-2022.12.yaml
 create mode 100644 recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
 rename recipes-core/swupdate/files/{0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch => 2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch} (94%)
 create mode 100644 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb

-- 
2.43.0


