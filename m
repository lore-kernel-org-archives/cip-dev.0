Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C2C4332F
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 15:17:49 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.49.1637767067421335548
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 07:17:48 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AOFHjsW008760
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 16:17:45 +0100
Received: from md2dvrtc.fritz.box ([139.22.38.174])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOFHiVp005533;
	Wed, 24 Nov 2021 16:17:44 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 0/2] start-qemu add missing option
Date: Wed, 24 Nov 2021 16:17:42 +0100
Message-Id: <20211124151744.949054-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 15:17:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7006

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the missing option for cip-core-image-security.
Add documentation for start-qemu.sh defaults from kas-container menu

Quirin Gylstorff (2):
  start-qemu.sh: Add defaults for IMAGE_SECURITY
  README: Add information about start-qemu-defaults with menu config

 README.md                | 6 ++++--
 doc/README.secureboot.md | 7 +++++++
 start-qemu.sh            | 3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.30.2


