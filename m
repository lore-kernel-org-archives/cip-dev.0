Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88891C7EE2E
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 07:52:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.3523.1686037970188610868
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 00:52:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,219,1681138800"; 
   d="scan'208";a="162379938"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jun 2023 16:52:49 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 705F14187F1A;
	Tue,  6 Jun 2023 16:52:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 4/8] Documentation: ABI: sysfs-bus-counter: add cascade_counts_enable and external_input_phase_clock_select
Date: Tue,  6 Jun 2023 08:52:31 +0100
Message-Id: <20230606075235.183132-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 07:52:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11845

commit 7bb985ac03c4a91d185c006f68c4fadfb71e1cca upstream.

This commit adds cascade_counts_enable and external_input_phase_
clock_select items to counter ABI file.
(e.g. for Renesas MTU3 hardware used for phase counting).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230330111632.169434-4-biju.das.jz@bp.renesas.com
[biju]: updated kernel version from 6.4->6.1.
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index ff83320b4255..2f1e4d8e50f6 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -1,3 +1,33 @@
+What:		/sys/bus/counter/devices/counterX/cascade_counts_enable
+KernelVersion:	6.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Indicates the cascading of Counts on Counter X.
+
+		Valid attribute values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Selects the external clock pin for phase counting mode of
+		Counter X.
+
+		MTCLKA-MTCLKB:
+			MTCLKA and MTCLKB pins are selected for the external
+			phase clock.
+
+		MTCLKC-MTCLKD:
+			MTCLKC and MTCLKD pins are selected for the external
+			phase clock.
+
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_available
+KernelVersion:  6.1
+Contact:        linux-iio@vger.kernel.org
+Description:
+                Discrete set of available values for the respective device
+                configuration are listed in this file.
+
 What:		/sys/bus/counter/devices/counterX/countY/count
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
@@ -215,6 +245,8 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute indicates the number of overflows of count Y.
 
+What:		/sys/bus/counter/devices/counterX/cascade_counts_enable_component_id
+What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_component_id
 What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
-- 
2.25.1


