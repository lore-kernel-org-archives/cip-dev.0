Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A1DE95A67
	for <webhook@archiver.kernel.org>; Sun,  8 Oct 2023 14:26:20 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.32143.1696734951928093939
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Oct 2023 20:15:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=FZfpbAg5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-72506-202310080315483cbdbb3090f9fb45f3-tewfh_@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202310080315483cbdbb3090f9fb45f3
        for <cip-dev@lists.cip-project.org>;
        Sun, 08 Oct 2023 05:15:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/BppzL9XdNZVb4OH1nTJHQ9udqIkGGn/BkZCC0KH1Wc=;
 b=FZfpbAg5FiaxsqjT9qpu3T0auGUl8XZBR6y54AkBk4l7UbPVHRu6YWmgvJ8gTFWPSvFZjV
 2bS5HjEK7A//gW7vX+oIPzw1a3fAovEjv5bqUTCVw+CvcFfhxIPNX/NpyQjK39D0bEDxfPRJ
 DKTrWgOqh3Ga7+oOa9j2zlPj5ochg=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 0/4] make compatible with latest ISAR revision
Date: Sun,  8 Oct 2023 11:15:25 +0800
Message-Id: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Oct 2023 14:26:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13309

This series adapts the imager parts of cip-core to the new schroot-based
imaging in ISAR. This change is required to make it compatible with the latest
master branch of ISAR. Finally, the ISAR version is bumped.

Note: This series depends on "drop dependency to no longer existing buildchroot".

Best regards,
Felix Moessbauer

Felix Moessbauer (4):
  make deploy-ovmf compatible with schroot imaging
  make swupdate class compatible with schroot imaging
  avoid use of sudo when creating squashfs
  update ISAR to latest version on master branch

 classes/squashfs.bbclass            |  2 +-
 classes/swupdate.bbclass            |  5 +++--
 kas-cip.yml                         |  2 +-
 recipes-core/images/deploy-ovmf.inc | 10 +++++++---
 4 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.39.2


