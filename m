Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5ABC433FE
	for <webhook@archiver.kernel.org>; Fri, 22 Oct 2021 17:40:52 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.830.1634924450689866303
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Oct 2021 10:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 19MHelIH023443
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 22 Oct 2021 19:40:47 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.72.144])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19MHelRE014474;
	Fri, 22 Oct 2021 19:40:47 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 0/2] kas update and menu support
Date: Fri, 22 Oct 2021 19:40:44 +0200
Message-Id: <cover.1634924446.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Oct 2021 17:40:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6836

With kas 2.6 being released, this now allows to adopt the new "menu"
feature and make the various image flavors and options more accessible.

Quirin, please have a look if I modeled the dependencies for secure boot
and SWUpdate correctly, exposed reasonable combinations and didn't
forget something useful.

@all: Please play a bit with the options and check if you find anything
that does not work (crowd-sourced randconfig...).

Thanks,
Jan

Jan Kiszka (2):
  Update to kas 2.6
  Add kconfig menu

 .gitlab-ci.yml                       |   2 +-
 Kconfig                              | 146 +++++++++++++++++++++++++++
 README.md                            |  39 ++++---
 kas/opt/ebg-secure-boot-base.yml     |   2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml |   2 +-
 kas/opt/ebg-snakeoil-swu.yml         |   4 +-
 kas/opt/ebg-swu.yml                  |   4 +-
 7 files changed, 177 insertions(+), 22 deletions(-)
 create mode 100644 Kconfig

-- 
2.31.1


