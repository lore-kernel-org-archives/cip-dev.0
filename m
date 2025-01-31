Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF5BC02194
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 15:26:02 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.21434.1738337157744939051
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jan 2025 07:25:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=AoJ/44dB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202501311525541c4e763a480f6aaab4-n9ekiy@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202501311525541c4e763a480f6aaab4
        for <cip-dev@lists.cip-project.org>;
        Fri, 31 Jan 2025 16:25:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=uWNOyqjdb3DXkmX6Tjl61lEYb0g73+7wrmzmmTSkvIY=;
 b=AoJ/44dBcs6sfecw9HuA7KHXvBdk3dLy/Wz5LKbD1ruWeeJcB1405uc54y33MVovsAM/ED
 3P15G44RTVfpS4lAitgAYChoy6/Q1gwAAaKhEtfzdjy9yDPnOFy8vu7wmuqoL6ob1F3YtPwB
 Q0Ij39BSEWrDKeMsAXmorXiGaDo0ncPdog/TyYdwW29dJCatcqH5L1yBMxP190n/5iLntfX3
 0QoHgiWajDqO8H3ZWkegZHJ5y4zIbebQpjLVLuSHu4Ga1pk3ABE6TyjBl8MMf4wqVyN0dfY0
 7O7X8nZ23qxXl1OwCtvk7xaKlV9A/WwCW2dPYVxAIKg8SUaAotH0/UHA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 0/4] Security testing with MTDA
Date: Fri, 31 Jan 2025 16:25:28 +0100
Message-ID: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 15:26:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17724

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>


This patch set builds an image to test IEC on the mcom device with
secure-boot and disk encryption enable.

Changes v3:
 - use separate kas/opt/security_test.yml instead of test
   as test.yml adds an extension to the image name and these
   images are used by the kernel tests

 - remove qemu-<arch>-secure-boot as the qemu-arch-base contains
   these options by including kas/opt/security.yml

Changes v2:
 - move curl to kas/opt/test.yml
 - add test option to gitlab-ci.yml
 - rename disable_watchdog to watchdog

Quirin Gylstorff (4):
  build x86-uefi with secure boot
  x86-uefi: disable watchdog for testing on mcom
  kas/opt: add new option for security testing
  .gitlab-ci.yml: Remove unused build jobs

 .gitlab-ci.yml               | 45 ++++++------------------------------
 kas/opt/disable-watchdog.yml | 15 ++++++++++++
 kas/opt/security_test.yml    | 16 +++++++++++++
 3 files changed, 38 insertions(+), 38 deletions(-)
 create mode 100644 kas/opt/disable-watchdog.yml
 create mode 100644 kas/opt/security_test.yml

-- 
2.47.0


