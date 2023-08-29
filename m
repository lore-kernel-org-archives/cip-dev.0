Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B04AC83F12
	for <webhook@archiver.kernel.org>; Tue, 29 Aug 2023 13:52:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.17952.1693317113877703030
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Aug 2023 06:51:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,210,1688396400"; 
   d="scan'208";a="174351402"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2023 22:51:51 +0900
Received: from localhost.localdomain (unknown [10.226.93.1])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 04A564005B4F;
	Tue, 29 Aug 2023 22:51:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/2] Fix RZ/{G2L,V2M} pinctrl NULL pointer dereference
Date: Tue, 29 Aug 2023 14:51:46 +0100
Message-Id: <20230829135148.173386-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Aug 2023 13:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12893

This patch series aims to fix RZ/{G2L,V2M} pinctrl NULL pointer
dereference
 
All the patches are cherry-picked from the mainline.

This patch is not required for 6.1.y as it will be applied in
stable.

Biju Das (2):
  pinctrl: renesas: rzg2l: Fix NULL pointer dereference in
    rzg2l_dt_subnode_to_map()
  pinctrl: renesas: rzv2m: Fix NULL pointer dereference in
    rzv2m_dt_subnode_to_map()

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 13 +++++++++++--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.25.1


