Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7112C433F5
	for <webhook@archiver.kernel.org>; Tue, 23 Nov 2021 18:25:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.15344.1637691788507912298
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Nov 2021 10:23:08 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.87,258,1631545200";
   d="scan'208";a="101167952"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Nov 2021 03:23:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 07D814000911;
	Wed, 24 Nov 2021 03:23:03 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][RESEND PATCH 0/2] Add support to test WiFi
 on RZ/G2M
Date: Tue, 23 Nov 2021 18:23:00 +0000
Message-Id: <20211123182302.8976-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 18:25:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6982

Hi All,

This patch series adds support to install required tools and firmware
for testing WiFi on HiHope RZ/G2M platform.

Cheers,
Prabhakar

Lad Prabhakar (2):
  customizations: Add support to include tools and Firmware required for
    WiFi testing
  conf: hihope-rzg2m: Enable tools and firmware for testing WiFi

 conf/machine/hihope-rzg2m.conf                | 3 +++
 recipes-core/customizations/customizations.bb | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.17.1


