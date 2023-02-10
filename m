Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F856C05027
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 12:07:25 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.6136.1676001947237970150
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Feb 2023 20:05:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=ZAgabFwh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-20230210040544c94fc12c1e81c0b202-tbwqgm@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230210040544c94fc12c1e81c0b202
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Feb 2023 05:05:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=jFqZfkA2eerHQNl0BpZnxeQhg8swpIcTdZg2aEgfj74=;
 b=ZAgabFwh+f2y+VQCon/U/Lq178EkM95or4OKF9bHwqAWWWpujbuQY50MIOqtztxLqC9iJz
 MX41wXsJ6ygVlS8/j7gFlrSY1WH/wjE00W0TO8TCwpfvwBlE3vgveonwy0EoRELDbmaifivP
 vOl7E7CncFsoraZOkze3EXdpzl4sE=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 0/5] Rework image classes
Date: Fri, 10 Feb 2023 04:05:27 +0000
Message-Id: <20230210040532.239406-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 12:07:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10650

This series reworks the image classes so that they are fully based on
the existing imagetypes infrastructure. Issues with swupdate on non
default partition layouts are solved by directly using the underlying
image / rootfs variant instead of a fixed wic partition. To support
further customizations, an interface is provided to select the type of
the rootfs image (e.g. squashfs). The verity class then uses this interface
to configure the swu.

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (5):
  register image classes via layer.conf
  refactor: use imagetypes for swu generation
  swu: directly image from squashfs rootfs
  swupdate: only check partition uuids on swupdate
  refactor verity image creation

 classes/swupdate.bbclass             | 31 +++++++++++++++++++++-------
 classes/verity.bbclass               |  7 +------
 conf/layer.conf                      |  2 ++
 kas/opt/ebg-secure-boot-snakeoil.yml |  2 +-
 kas/opt/swupdate.yml                 |  5 +----
 recipes-core/images/swupdate.inc     | 20 ------------------
 6 files changed, 28 insertions(+), 39 deletions(-)

-- 
2.34.1


