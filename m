Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5921ED3B9A4
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 15:18:03 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.48464.1732634275868989090
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Nov 2024 07:17:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=JnoSUDtW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202411261517520b926e0c6dce1b4e3d-feje3q@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202411261517520b926e0c6dce1b4e3d
        for <cip-dev@lists.cip-project.org>;
        Tue, 26 Nov 2024 16:17:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=FwcG1ziqkDmmb1RLdHhBmrvif3MpWraOJtG/JbzZ6Tk=;
 b=JnoSUDtWhXMl+TRj5cP6IbOoSUClu9qeiCilyqUlRZ/b7ivML7rUTbEFFgozp2xOtlYydF
 fUO9KNl3z/TmiUNLsCwkt25EDwv6CskljB9YzZSH0Xp+3/r6BSmnVJ/Zb4LzbGtZpTFuWr4z
 IQW7/EPJNoG9HWx4inn95gzhMzpvrGOopduKGp4XTl0arHnvwTkOCgaNPsEAwwWjov+flPC7
 HHp5c58eY3sgHxhhkKzxIg9J2TEQGL+3wvZV0+EUVBQgktSeWcxu6ZU7WCCLhxznisJLCSdE
 5clkSSUSrRqYLEFKaqjFBRRk3f62qCODEm5Y1H0Cu94OpbczNS1/VJwQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	Jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 0/2] Switch qemu-targets to
Date: Tue, 26 Nov 2024 16:16:26 +0100
Message-ID: <20241126151751.1747275-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Nov 2024 15:18:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17280

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This enables the cip_merged_defconfig for all qemu targets to reduce
the number defconfig under test. This is a followup from https://patchwork.kernel.org/project/cip-dev/patch/fa83e565-8950-4ca7-837b-1c513a119bfa@siemens.com/


Quirin Gylstorff (2):
  update cip-kerne-defconfig to lastest version
  use cip_merged_defconfig for qemu_*

 conf/machine/qemu-arm.conf                 | 2 +-
 conf/machine/qemu-arm64.conf               | 2 +-
 conf/machine/qemu-riscv64.conf             | 2 +-
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.46.1


