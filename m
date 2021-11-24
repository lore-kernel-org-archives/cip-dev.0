Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775A2C433EF
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 14:31:35 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.6860.1637764294438493478
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 06:31:35 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AOEVWe2005765
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 15:31:32 +0100
Received: from md2dvrtc.fritz.box ([139.22.38.174])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOEVVLP022964;
	Wed, 24 Nov 2021 15:31:32 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [PATCH v2 0/3] start-qemu.sh: Add some ease of use functionality
Date: Wed, 24 Nov 2021 15:31:28 +0100
Message-Id: <20211124143131.939349-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 14:31:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7000

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Fix booting of secure-boot image
Parse .config.yaml for ease of use and reduced commandline clutter

Changes V2:
 - Add Sentence to README
 - Add default cip-core-image-security

Quirin Gylstorff (3):
  start-qemu.sh: set bootindex for SECURE_BOOT
  start-qemu.sh: parse .config.yaml for ease of use
  start-qemu.sh: Simplify qemu call

 README.md     |  6 ++++--
 start-qemu.sh | 36 +++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.30.2


