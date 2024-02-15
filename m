Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04534C48BC4
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 15:53:58 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.17380.1708012436345481566
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 07:53:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=CZp8rfel;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20240215155351e0d5fff5a0456da5e8-nicm8i@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240215155351e0d5fff5a0456da5e8
        for <cip-dev@lists.cip-project.org>;
        Thu, 15 Feb 2024 16:53:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=32Pb2uddY8KP7exwIwZqd2r7EFpKyITPslVLp/h05hY=;
 b=CZp8rfelr9qJ+go0nij+Dibl0iS5Dks8j6/RgUEQnS2rrtEimfwqHi9XdvlA/kh9kbYK4b
 MU/iJuey5rttzKILcq2uO6UsIUtOpi9oBsHxA3N5H23K5RS8m8tMJI956FvK2+ldAluycO13
 YOP1WfH1ltBgYCaHnbSXSnt22NKZY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 0/3] Add SWUpdate 2022.12
Date: Thu, 15 Feb 2024 16:53:25 +0100
Message-ID: <20240215155350.434472-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 15:53:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15004

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

SWUpdate changed the API for the Suricatta lua plugin with 2023.05.
To support released legacy application which use the old api add
SWUpdate 2022.12.

Changes v2:
 - Reword commit message 'add SWUpdate 2022.12'
   - add information from salsa

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


