Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC864C61DA4
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 03:36:46 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.2509.1676518597047642879
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Feb 2023 19:36:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=IA/2KNRA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-20230216033634fd3b509bc2d6d10a33-zm8q1i@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230216033634fd3b509bc2d6d10a33
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Feb 2023 04:36:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=7+S5od+wWmqGWIAsznLjqPDHYmLL/cGgcDP5cqM3MR8=;
 b=IA/2KNRAPLeOQh73KxVKGChGPBk16BxSXf8Fq+gWlqOkwy56vWyFAQaGTD6Tujm6Rev96T
 cdWeEzESPthDRNvpghrxAEc+EAyWdxKEpZ2rK7Gtx+2GkmtsfPPTipouspjkQ7SoXR0BGXUI
 Uc8TqX7k6FRQlqECCGsPrFXDQqegM=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v5 0/8] Rework image classes
Date: Thu, 16 Feb 2023 03:35:36 +0000
Message-Id: <20230216033544.1990604-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Feb 2023 03:36:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10701

Changes since v4:

- append default sw-description path (instead of prepending)
- remove IMAGE_CLASSES used in kas in correct patch
- remove IMAGE_CLASSES from documentation (is now handled automatically)

Changes since v3:

- add patch to make sw-description spec compliant
- replace hand-crafted swu compression logic with imagetypes
  (+ support for zstd) 
- prefix variables in swupdate class to avoid collisions
- avoid double-inherit in swupdate.inc
- explicitly add sw-description path to FILESEXTRAPATHS as
  FILESOVERRIDES do not apply here (see comment for details)

Changes since v2:

- remove unnecessary dependency to template task (it is a dep anyways)

Changes since v1:

- separation of concerns: do not append to :wic typedep in :swu [1]

This series reworks the image classes so that they are fully based on
the existing imagetypes infrastructure. Issues with swupdate on non
default partition layouts are solved by directly using the underlying
image / rootfs variant instead of a fixed wic partition. To support
further customizations, an interface is provided to select the type of
the rootfs image (e.g. squashfs). The verity class then uses this interface
to configure the swu.

[1] As we now use the image (e.g. squashfs / verity) directly to create
the swu file, we also explicity need that image type (compressed).
For wic, we now explicitly have to state the imagetype again, as we copy
that into one of the partitions (but this is not an aspect of the swu type).
In addition, we cannot simply always add that type to IMAGE_TYPEDEP:wic, as
otherwise always a squashfs is built when the swupdate.bbclass is included.
One key aspect of the imagetypes is that they are non-intrusive. By that,
the classes can always be added and only become into effect when selecting
the corresponding type.

Best regards,
Felix Moessbauer
Siemens AG


Felix Moessbauer (8):
  register image classes via layer.conf
  refactor: use imagetypes for swu generation
  swu: directly image from squashfs rootfs
  swupdate: only check partition uuids on swupdate
  make sw-description spec compliant
  swu: replace custom image compression
  prefix swu related variables with SWU
  refactor verity image creation

 classes/swupdate.bbclass                      | 73 +++++++++++--------
 classes/verity.bbclass                        |  7 +-
 conf/layer.conf                               |  2 +
 doc/README.secureboot.md                      |  1 -
 kas/opt/ebg-secure-boot-snakeoil.yml          |  2 +-
 kas/opt/swupdate.yml                          |  4 +-
 .../images/{files => swu}/sw-description.tmpl |  7 +-
 recipes-core/images/swupdate.inc              | 21 ------
 8 files changed, 52 insertions(+), 65 deletions(-)
 rename recipes-core/images/{files => swu}/sw-description.tmpl (84%)

-- 
2.34.1


