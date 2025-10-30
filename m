Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373E5CCF9F0
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 08:50:15 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.22240.1761814208726389886
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Oct 2025 01:50:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: Q8Ar5IGjQkiOLXqLM9scIw==
X-CSE-MsgGUID: l+bErJMmRWaL+264qvyePw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Oct 2025 17:50:08 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.118])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F2D4B416064F;
	Thu, 30 Oct 2025 17:50:06 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 0/1] Add RZ/V2H ICU support
Date: Thu, 30 Oct 2025 08:50:04 +0000
Message-ID: <20251030085005.47524-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Oct 2025 08:50:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20282

Hi,

This series adds the ICU dts node for the Renesas RZ/V2H SoC, to
the linux-6.1.y-cip kernel.

The ICU driver and its dependencies are already present in the 6.1.y-cip
branch, having been included earlier as part of the RZ/G3E backporting
work.

For reference, see the related commits:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.1.y-cip&id=b142b3b91d5235096ee472472c7a5690d1d8d6ef
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.1.y-cip&id=46696984ffc837b920d05ef5a1e07588af08e603
[3] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.1.y-cip&id=4a97e4b6845fa6e577ee707b7530dc77f3a38568
[4] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.1.y-cip&id=cc2cb4eb962467d04c319620a00677fef5f3c915
[5] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.1.y-cip&id=30c326b3db178a302bfb34f3689db33c5e51306f
[6] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.1.y-cip&id=0b0e21f2a5c1a1fcedcf7b82b0543c0e45c90b47

The patch was cherry-picked from mainline kernel.

Best regards,
Ovidiu

Fabrizio Castro (1):
  arm64: dts: renesas: r9a09g057: Add ICU node

 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

-- 
2.51.0


