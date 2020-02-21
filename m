Return-Path: <SRS0=SQxA=4J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD9CC35646
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8B5222C4
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8B5222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 116BF864A6;
	Fri, 21 Feb 2020 16:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ga-aJKR78I0c; Fri, 21 Feb 2020 16:52:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 838B4864AA;
	Fri, 21 Feb 2020 16:52:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FDEBC013E;
	Fri, 21 Feb 2020 16:52:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 736ABC013E
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7092F864A6
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XpXg0cgGwHw7 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2020 16:52:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B94148648C
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:31 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.70,468,1574089200"; d="scan'208";a="39942250"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 22 Feb 2020 01:52:31 +0900
Received: from marian-VirtualBox.ree.adwin.renesas.com (unknown
 [10.226.36.164])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id A215F40A3602;
 Sat, 22 Feb 2020 01:52:30 +0900 (JST)
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
Date: Fri, 21 Feb 2020 16:52:04 +0000
Message-Id: <1582303929-5773-18-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 17/22] usb: typec: add dependency
	for TYPEC_HD3SS3220
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

From: Mao Wenan <maowenan@huawei.com>

commit da4b5d18dd949abdda7c8ea76c9483b5edd49616 upstream.

If CONFIG_TYPEC_HD3SS3220=y, CONFIG_USB_ROLE_SWITCH=m, below errors
can be found:
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_remove':
hd3ss3220.c:(.text+0x64): undefined reference to `usb_role_switch_put'
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_dr_set':
hd3ss3220.c:(.text+0x154): undefined reference to `usb_role_switch_set_role'
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_set_role':
hd3ss3220.c:(.text+0x294): undefined reference to `usb_role_switch_set_role'
hd3ss3220.c:(.text+0x2f4): undefined reference to `usb_role_switch_set_role'
hd3ss3220.c:(.text+0x348): undefined reference to `usb_role_switch_set_role'
hd3ss3220.c:(.text+0x390): undefined reference to `usb_role_switch_set_role'
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_probe':
hd3ss3220.c:(.text+0x5e8): undefined reference to `fwnode_usb_role_switch_get'
hd3ss3220.c:(.text+0x8a4): undefined reference to `usb_role_switch_put'
make: *** [vmlinux] Error 1

This patch add dependency USB_ROLE_SWITCH for TYPEC_HD3SS3220.

Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/20191009014707.38716-1-maowenan@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/usb/typec/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index fde51c5..a4bdb5c 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -95,6 +95,7 @@ source "drivers/usb/typec/ucsi/Kconfig"
 config TYPEC_HD3SS3220
 	tristate "TI HD3SS3220 Type-C DRP Port controller driver"
 	depends on I2C
+	depends on USB_ROLE_SWITCH
 	help
 	  Say Y or M here if your system has TI HD3SS3220 Type-C DRP Port
 	  controller driver.
-- 
2.7.4

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
