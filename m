Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C217CC54E71
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 12:51:54 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.43262.1710766308388255715
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 05:51:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=cB0XZbGV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240318125145f7fca85d6a9f6385ad-p5hyas@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240318125145f7fca85d6a9f6385ad
        for <cip-dev@lists.cip-project.org>;
        Mon, 18 Mar 2024 13:51:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=cKfRWGLuhwwndQ5U6I3MXdxrW1hoxlUXgRVTAqm4mQE=;
 b=cB0XZbGVaJsRGX7zZccFKXMSMfNekvSYn3UcjoE26h8tc8uTonD/uwMid94FtDICUnFoCi
 3reDbp+j2SoRTPyBoIPqUOFT0C3BwsM1TjhWrKvy+0AH508hxF87TaGD5TfkdvekWjIzKhLU
 LcSNW+ari3Qvz8hfV7WIM7nQkALt0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/3] Update to SWUpdate
Date: Mon, 18 Mar 2024 13:51:27 +0100
Message-ID: <20240318125144.634700-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 12:51:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15356

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This will use the latest release on salsa for swupdate. It activates
WFX by default and fixes a regression with postinstall scripts.

SWUpdate 2023.12.1 will replace 2023.05.

Changes v2:
 - fix whitespaces and Copyright
 - Remove Preferred_version for Sid as we use the upstream binary
 - remove preferred_version for libubootenv -> unnecessary

Quirin Gylstorff (3):
  swupdate: Add recipe for 2023.12.1
  conf/distro/cip-core-*: prefer swupdate 2023.12 for all distro except
    buster
  remove SWUpdate recipe 2023.05

 conf/distro/cip-core-bookworm.conf            |  2 +-
 conf/distro/cip-core-bullseye.conf            |  2 +-
 conf/distro/cip-core-sid.conf                 |  1 -
 ...tch-to-add-the-build-version-to-swup.patch | 94 -------------------
 ...s-Add-option-to-enable-suricatta_wfx.patch | 30 ------
 ...rate-build_profile-option-for-delta-.patch | 10 +-
 ...nstall-Fix-path-for-debian-bullseye.patch} |  6 +-
 ...wupdate_2023.05.bb => swupdate_2023.12.bb} | 22 ++---
 8 files changed, 21 insertions(+), 146 deletions(-)
 delete mode 100644 recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
 delete mode 100644 recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
 rename recipes-core/swupdate/files/{2023.05 => 2023.12}/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch (87%)
 rename recipes-core/swupdate/files/{2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch => 2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch} (84%)
 rename recipes-core/swupdate/{swupdate_2023.05.bb => swupdate_2023.12.bb} (54%)

-- 
2.43.0


