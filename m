Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E66BC53213
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 10:51:25 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16606.1784890280823348198
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 03:51:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=I/fR28hl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202607241051175c4fcada8e000207b8-wjm30o@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202607241051175c4fcada8e000207b8
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 12:51:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=TPvbIYCAe4jM++3ECT9bDLeTaatUEdyjFMUaFE9ekIc=;
 b=I/fR28hlz388hsZIxvDzlnPBuh3mI64MUJBT8beH91wb3wLTeaDYULcbVjV6DLxuH4PHB+
 6uJzfPSXdMFcdHzHL+d0vJedEFTuo3+CC52+gpZ9dhD7i1Uz06jGLbAIJ8/Z+ffoyalkMK7f
 W2J4L6/Razau7x7yWA6RO/kzz5Xqz2Vg5f6kcFbov85l6gPHNosZftnklm0Yb8EMUhuUpcTn
 zZPiLqK7+0fucXqIASeKi2x99AvdnljicfUwQOTfxzCkZRfeLd4/mP893Geq8s0Vn19KenY2
 lA2AoUGe0UhGpBWbHqfV2omS40a1m/syCod6RApuHFXVlfTaAhbRhKHA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 0/4] switch to rootless build
Date: Fri, 24 Jul 2026 12:51:04 +0200
Message-ID: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 10:51:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23729

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset contains the necessary changes to switch
isar-cip-core to the new rootless build.

This has an impact on downstream as the classes need the new
rootless changes. So this is no longer compatible with isar before
the rootless merge.

The patchset is build with the following pipeline
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2702946001

Quirin Gylstorff (4):
  update to kas 5.4
  update Isar to contain rootless changes
  use run_priviledged instead of sudo
  switch to isar-rootless

 .gitlab-ci.yml                          |   2 +-
 Kconfig                                 |   2 +-
 classes-recipe/image_uuid.bbclass       |   4 +-
 classes-recipe/read-only-rootfs.bbclass |   8 +-
 kas-cip.yml                             |   4 +-
 kas-container                           | 311 +++++++++++++-----------
 6 files changed, 178 insertions(+), 153 deletions(-)

-- 
2.53.0


