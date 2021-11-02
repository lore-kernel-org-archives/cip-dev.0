Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D0FC433FE
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 20:18:41 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web09.861.1635884320258224250
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Nov 2021 13:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1A2KIbia018992
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 2 Nov 2021 21:18:37 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.22.43.93])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1A2KIXYB007052
	for <cip-dev@lists.cip-project.org>; Tue, 2 Nov 2021 21:18:33 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v2 0/3] kas update, menu support, Isar update
Date: Tue,  2 Nov 2021 21:18:30 +0100
Message-Id: <cover.1635884313.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Nov 2021 20:18:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6854

Changes in v2:
 - move to kas 2.6.2 bug-fix release
 - make security image depend on buster (apparently broken for other
   releases)
 - add Isar update

With kas 2.6 being released, this now allows to adopt the new "menu"
feature and make the various image flavors and options more accessible.

@all: Please play a bit with the options and check if you find anything
that does not work (crowd-sourced randconfig...).

Thanks,
Jan

Jan Kiszka (3):
  Update to kas 2.6.2
  Add kconfig menu
  Update Isar revision

 .gitignore                           |   1 +
 .gitlab-ci.yml                       |   2 +-
 Kconfig                              | 147 +++++++++++++++++++++++++++
 README.md                            |  39 ++++---
 kas-cip.yml                          |   2 +-
 kas/opt/ebg-secure-boot-base.yml     |   2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml |   2 +-
 kas/opt/ebg-snakeoil-swu.yml         |   4 +-
 kas/opt/ebg-swu.yml                  |   4 +-
 9 files changed, 180 insertions(+), 23 deletions(-)
 create mode 100644 Kconfig

-- 
2.31.1


