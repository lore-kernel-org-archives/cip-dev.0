Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B81C433EF
	for <webhook@archiver.kernel.org>; Thu,  2 Jun 2022 16:17:53 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web09.1094.1654186665226805968
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jun 2022 09:17:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=jXuT31ip;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-20220602161742a038a413ce961503b9-idvr4i@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220602161742a038a413ce961503b9
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Jun 2022 18:17:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=giVWnTL6x1IYLTblo1gKwbKDGUV/WMfdiWzEHcLIq0o=;
 b=jXuT31ipgZwp1GEn2dVQ13bQROunLTvKIAS6E4syVkwNNbtjormMtfoqGGWzCRiQJTYT5+
 QKTb5hsy3HJ5bVPnf19G6toiTPZYLhNzyI6TPzqF02MxS7y/2LgP0g7pO0vuwuYn8++nqi/x
 pXxwHxSbzuTMfE4KFilykDy9w7U8I=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/2] swupodate: Account for slower storage in
 initramfs hooks
Date: Thu,  2 Jun 2022 18:17:39 +0200
Message-Id: <cover.1654186661.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jun 2022 16:17:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8478

This addresses boot issues when slow storage devices do not show up
immedately, preventing discovery without waiting for a while.

Thanks to Srinu for reporting. Please help with testing. The secured
path was only regression-tested - I do not have a real HW deployment
with secure boot on in reach, and isar-cip-core does not directly
support that as well.

Jan Kiszka (2):
  initramfs-abrootfs-hook: Account for slower storage devices
  initramfs-verity-hook: Account for slower storage devices

 .../files/abrootfs.script                     |  86 +++++++++++---
 .../files/verity.script.tmpl                  | 109 ++++++++++++++----
 2 files changed, 159 insertions(+), 36 deletions(-)

-- 
2.35.3


