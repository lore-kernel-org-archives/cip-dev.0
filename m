Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42937C54E68
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 12:37:46 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.11501.1710419861218481772
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 05:37:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Q9q2sw4x;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202403141237379bc097e4dbf555cb45-j1lgwx@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202403141237379bc097e4dbf555cb45
        for <cip-dev@lists.cip-project.org>;
        Thu, 14 Mar 2024 13:37:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=eqnysPW1GQGxKzdVv07xdV365ccvRQBtNAh2oVh1vJk=;
 b=Q9q2sw4xc798KBiOndOBsb9g5x/+RKhF8Te8uJh/IhSAA/5u/KRe/jiPL9Te72VnCo+Fg9
 StPvYsctArD0vAb3MjwAuU6cjvQOW+BMN2XkLz1x8rbT2e+kM2MJEQh+TFsctpRwYRQwtHGX
 0wJKEGq2tJxJt//fUPdZRTkLT18eg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 0/3] Update to SWUpdate
Date: Thu, 14 Mar 2024 13:36:35 +0100
Message-ID: <20240314123736.1100948-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 12:37:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15306

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This will use the latest release on salsa for swupdate. It activates
WFX by default and fixes a regression with postinstall scripts.

SWUpdate 2023.12.1 will replace 2023.05.

Quirin Gylstorff (3):
  swupdate: Add recipe for 2023.12.1
  conf/distro/cip-core-*: prefer swupdate 2023.12 for all distro except
    buster
  remove SWUpdate recipe 2023.05

 conf/distro/cip-core-bookworm.conf            |  3 +-
 conf/distro/cip-core-bullseye.conf            |  2 +-
 conf/distro/cip-core-sid.conf                 |  2 +-
 ...tch-to-add-the-build-version-to-swup.patch | 94 -------------------
 ...s-Add-option-to-enable-suricatta_wfx.patch | 30 ------
 ...rate-build_profile-option-for-delta-.patch | 10 +-
 ...nstall-Fix-path-for-debian-bullseye.patch} |  6 +-
 ...wupdate_2023.05.bb => swupdate_2023.12.bb} | 20 ++--
 8 files changed, 22 insertions(+), 145 deletions(-)
 delete mode 100644 recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
 delete mode 100644 recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
 rename recipes-core/swupdate/files/{2023.05 => 2023.12}/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch (87%)
 rename recipes-core/swupdate/files/{2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch => 2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch} (84%)
 rename recipes-core/swupdate/{swupdate_2023.05.bb => swupdate_2023.12.bb} (56%)

-- 
2.43.0


