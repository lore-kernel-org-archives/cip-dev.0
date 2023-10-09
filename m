Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B26E95A8E
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 11:49:59 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.56096.1696837950533849289
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 00:52:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=pmCpVLnA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-72506-20231009075226014a1dca753b19384a-vpui1a@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231009075226014a1dca753b19384a
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Oct 2023 09:52:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gJ9Ldx+wZOxpKMZ9FHc2MENsGnkiTqnY4dF1c9zP7iU=;
 b=pmCpVLnAZICF9xG26/u/Cbz6kbqPfzSkLbbsJDbuX+0ogGVvzhYf9RNCBlMaCvuROhHfMS
 IagkN2RsxXiQd2bDhKKEBFL8jBByxTu1bLG2/7GDyhOybQSHMVY6taEM0K1ehWcWy4L3AwYZ
 1Ctgfz4UP+yIfOLSdaTI0Fu7rg1Nc=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 0/1] make compatible with latest ISAR revision
Date: Mon,  9 Oct 2023 15:52:05 +0800
Message-Id: <20231009075206.194903-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 11:49:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13317

This series adapts the imager parts of cip-core to the new schroot-based
imaging in ISAR. This change is required to make it compatible with the latest
master branch of ISAR. Finally, the ISAR version is bumped.

Changes since v1:

- rebased against current next
- squashed all commits into one (atomic)
- fixed missing task dep in OVMF deploy

Best regards,
Felix Moessbauer

Felix Moessbauer (1):
  update ISAR to latest version on master branch

 classes/squashfs.bbclass            |  2 +-
 classes/swupdate.bbclass            |  5 +++--
 kas-cip.yml                         |  2 +-
 recipes-core/images/deploy-ovmf.inc | 10 ++++++----
 4 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.39.2


