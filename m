Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53409CCF9F0
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 08:49:35 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.22226.1761814171427972569
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Oct 2025 01:49:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: PX7OwiJcSOOhNyRUgvzlUA==
X-CSE-MsgGUID: VAUuFoekTQK4lVuVzfsyfg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Oct 2025 17:49:30 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.118])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E50554160645;
	Thu, 30 Oct 2025 17:49:28 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
Date: Thu, 30 Oct 2025 08:49:26 +0000
Message-ID: <20251030084927.47505-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Oct 2025 08:49:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20280

Hi,

This series adds the ICU dts node for the Renesas RZ/V2H SoC, to
the linux-6.12.y-cip kernel.

The ICU driver and its dependencies are already present in the 6.12.y-cip
branch, having been included earlier as part of the RZ/G3E backporting
work.

For reference, see the related commits:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.12.y-cip&id=3d3a549e2fb073619507de56be14aab242f87b7b
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.12.y-cip&id=ae9102da607f85ba0831c6b5af0c0d52d5166f7d
[3] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.12.y-cip&id=69c328745d39318be83b84a7f379009cc574d072
[4] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.12.y-cip&id=9fc198d9b2c292fb089eaaa2a5b679b24d26f072
[5] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.12.y-cip&id=2e7375bcebd154ccf175eed1982d11b8b3c4cb8a
[6] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-6.12.y-cip&id=1fe131fc74f7fa9d0753fbfb7dbb92483a10ba01

The patch was cherry-picked from mainline kernel.

Best regards,
Ovidiu

Fabrizio Castro (1):
  arm64: dts: renesas: r9a09g057: Add ICU node

 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

-- 
2.51.0


