Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F7DC6FA99
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 18:20:10 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.27126.1678472408412738974
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Mar 2023 10:20:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=C4BMgeWd;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2023031018200489117c3cd685bb08b7-9e9asr@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023031018200489117c3cd685bb08b7
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Mar 2023 19:20:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=pKLRYzIsAR5FltGYysewdTdNAsdEcisIiSQ5bOyb+1I=;
 b=C4BMgeWdM950uFOCBGV3tNdd1u9e8xrvBzzHyRIBdycFU69V+aJekW4G3cWUj8V/m7xD6g
 JvKFDLJJ/+guTZ7PCfAAmJiviguXHIhfi3IX8IENNxcc7s1K4Cx1an5ti+NqCo+WdtbSo7iw
 UZtQhqxoKo3h3wLbqkTjy0FbngWGU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/2] Enable Images based on Debian 12
Date: Fri, 10 Mar 2023 19:20:01 +0100
Message-Id: <20230310182003.201194-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Mar 2023 18:20:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10978

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add ci builds for bookworm
Change efibootguard build to use debian folder from salsa

Changes v2:
 - rebase onto next 
 - always build efibootguard 


Quirin Gylstorff (2):
  Enable Images based on Debian 12 (bookworm)
  efibootguard: use debian folder from salsa

 .gitlab-ci.yml                                | 45 +++++++++++++++++++
 Kconfig                                       |  5 +++
 conf/distro/cip-core-bookworm.conf            | 16 +++++++
 kas/opt/bookworm.yml                          | 15 +++++++
 ...guard_0.13.bb => efibootguard_0.13+cip.bb} | 31 +++++++------
 ...l-Make-compatible-with-debian-buster.patch | 36 +++++++++++++++
 ...rol-remove-native-from-python3-shtab.patch | 26 +++++++++++
 recipes-bsp/efibootguard/files/debian/compat  |  1 -
 .../efibootguard/files/debian/control.tmpl    | 20 ---------
 .../debian/efibootguard-dev.install.tmpl      |  2 -
 .../files/debian/efibootguard.install         |  5 ---
 recipes-bsp/efibootguard/files/debian/rules   | 15 -------
 ...01-add-machine-type-name-for-riscv64.patch |  0
 recipes-core/images/efibootguard.inc          |  1 -
 recipes-core/images/swupdate.inc              |  6 ++-
 recipes-core/swupdate/swupdate.inc            |  2 +-
 16 files changed, 167 insertions(+), 59 deletions(-)
 create mode 100644 conf/distro/cip-core-bookworm.conf
 create mode 100644 kas/opt/bookworm.yml
 rename recipes-bsp/efibootguard/{efibootguard_0.13.bb => efibootguard_0.13+cip.bb} (53%)
 create mode 100644 recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
 create mode 100644 recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
 delete mode 100644 recipes-bsp/efibootguard/files/debian/compat
 delete mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
 delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
 delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
 delete mode 100755 recipes-bsp/efibootguard/files/debian/rules
 rename recipes-bsp/efibootguard/files/{ => src-patches}/0001-add-machine-type-name-for-riscv64.patch (100%)

-- 
2.39.2


