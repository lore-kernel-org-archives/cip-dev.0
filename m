Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADC3D11707
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:39 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3932.1764667288602256512
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=JjnfFeEL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-2025120209212027bb59092c0002071a-gb8nqd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025120209212027bb59092c0002071a
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=hLL7jy+/GL7Cdf/uTP2iAObc2/DOTOuQbWU3jtjbrdQ=;
 b=JjnfFeELc9/Rl04vhXI0KiNTklgj80B35hLnrTkrcNS3V9rwkVckDTtENeb1OfZep54UhQ
 UYBuL/Dfhz+rndBbds91T13gkb0I1LgRTAza4yt9Psp5EUqKTsJGlnMheHo2SW8B+iMnVhol
 f60Sj4YV7f9bnk1H/lOR+ryI/TdelBc4OTO3vRNFDzea93Zzqdoh+TdYXTB0Es0cxGPOlcAk
 RTvGzJpwYqIDEQLY/4VBpS90h0x2owy1lgyvr9G498rSRdgSFwN1ZbV8vIvObn7NfPUJ3+/p
 wHpd/8FxYy2R8zdvMm9wCHoBeleP9xYcT32ZNNWwBGho5wme3YBe31mA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 00/14] CI changes to move testing to trixie
Date: Tue,  2 Dec 2025 10:21:05 +0100
Message-ID: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20792

Quite a lot of changes were needed to finally get us to trixie by
default for testing isar-cip-core.

Along that, I also looked into how to generate lava test images (patches
9 and 10) and refactored the artifact deployment a bit (patch 11).
Please double-check if those changes make sense and are fully correct.

Jan

Jan Kiszka (14):
  tests: Avoid hard-coding distribution in M-COM test
  ci: Prepare for running non-bookworm secure boot tests
  ci: Select qemu-amd64 OVMF according to target release
  ci: Raise qemu x86 CPU model
  qemu-amd64: Raise boot watchdog timeout to 120 seconds
  ci: Inject image version into common cip-core-image.inc
  ci: Clean up no-kernel deployment
  Kconfig: Do not offer swupdate or security options without a kernel
  kas: Auto-enable targz format for kernelci images
  ci: Combine targz with no_kernel option
  ci: Make deployment opt-in
  ci: submit_lava.sh: Reduce number of sed calls
  ci: Build and deploy kernel-panic update artifact
  ci: Switch to trixie based builds and tests

 .gitlab-ci.yml                                | 141 ++++++++++--------
 .reproducible-check-ci.yml                    |   5 +-
 Kconfig                                       |   2 +-
 conf/machine/qemu-amd64.conf                  |   3 +
 kas/opt/kernelci.yml                          |   3 +
 scripts/deploy-cip-core.sh                    |  20 +--
 scripts/submit_lava.sh                        | 102 +++++++------
 .../templates/swupdate-test-action-M-COM.yml  |   2 +-
 8 files changed, 153 insertions(+), 125 deletions(-)

-- 
2.51.0


