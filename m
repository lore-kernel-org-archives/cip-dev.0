Return-Path: <SRS0=SQxA=4J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF826C35656
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74714222C4
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74714222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3659181F29;
	Fri, 21 Feb 2020 16:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uIIyz9wighKV; Fri, 21 Feb 2020 16:52:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A5B98767B;
	Fri, 21 Feb 2020 16:52:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F4E0C07FE;
	Fri, 21 Feb 2020 16:52:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BA8EC013E
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 30A2A86356
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gpVeY4sUJd7c for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2020 16:52:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 82DCF8634C
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:12 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.70,468,1574089200"; d="scan'208";a="39942212"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 22 Feb 2020 01:52:10 +0900
Received: from marian-VirtualBox.ree.adwin.renesas.com (unknown
 [10.226.36.164])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id E49D440A35F7;
 Sat, 22 Feb 2020 01:52:09 +0900 (JST)
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
Date: Fri, 21 Feb 2020 16:51:47 +0000
Message-Id: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Subject: [cip-dev] [PATCH v2 4.19.y-cip 00/22] Renesas RZ/G2E USB Type-C
	Backport
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

This is the second version of USB Type-C backport of RZ/G2E board, named
Silicon Linux EK874. The first version was reviewed by Pavel Machek. All
the modifications included in v2 were recommended by him.

This patchset revolves around the following patch set from upstream:
https://patchwork.kernel.org/cover/10969899/

Unfortunately, the driver is using a slightly different version of the USB
API. In upstream, the connection between the fwnode of the USB controller
device tree node, that is the connector device tree node, and the USB
peripheral device tree node is nicely done via some new function calls that
are basically some extensions to the graph traverse and graph discovery
methods for the device tree parser. This is needed for role switch feature.

I tried to create the minimum set for the USB API extension and it should
not affect at all the current behavior. All the modifications are additions
and some rewritings of some of the current functions.

I also backported some fixes where I have found them.

Tested on Si-Linux EK874 (with RZ/G2E SoC) that we have in house.

Changes compared to v1:
  - drop the defconfig modifications
  - fix return value inside HD3SS3220 driver
  - 0-initialized the newly added field inside device_connection

Biju Das (7):
  dt-bindings: usb: hd3ss3220 device tree binding document
  dt-bindings: usb: renesas_usb3: Document usb role switch support
  usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller
  usb: typec: hd3ss3220: hd3ss3220_probe() warn: passing zero to
    'PTR_ERR'
  usb: gadget: udc: renesas_usb3: Enhance role switch support
  arm64: dts: renesas: cat874: Enable USB3.0 host/peripheral device node
  arm64: dts: renesas: cat874: Enable usb role switch support

Dan Carpenter (1):
  usb: typec: fix an IS_ERR() vs NULL bug in hd3ss3220_probe()

Heikki Krogerus (10):
  device connection: Add fwnode member to struct device_connection
  usb: typec: mux: Find the muxes by also matching against the device
    node
  usb: roles: Find the muxes by also matching against the device node
  usb: typec: Find the ports by also matching against the device node
  device connection: Prepare support for firmware described connections
  device connection: Find device connections also from device graphs
  device property: Introduce fwnode_find_reference()
  device connection: Find connections also by checking the references
  device connection: Add fwnode_connection_find_match()
  usb: roles: Add fwnode_usb_role_switch_get() function

Mao Wenan (1):
  usb: typec: add dependency for TYPEC_HD3SS3220

Yu Chen (1):
  usb: roles: Introduce stubs for the exiting functions in role.h

YueHaibing (1):
  usb: typec: mux: Fix unsigned comparison with less than zero

kbuild test robot (1):
  usb: typec: hd3ss3220_irq() can be static

 .../devicetree/bindings/usb/renesas,usb3-peri.txt  |  23 ++
 .../devicetree/bindings/usb/ti,hd3ss3220.txt       |  38 +++
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    |  49 ++++
 drivers/base/devcon.c                              | 107 +++++++-
 drivers/base/property.c                            |  24 ++
 drivers/extcon/extcon-axp288.c                     |   1 +
 drivers/platform/x86/intel_cht_int33fe.c           |   4 +
 drivers/usb/gadget/udc/renesas_usb3.c              |  91 ++++++-
 drivers/usb/roles/class.c                          |  41 ++-
 drivers/usb/typec/Kconfig                          |  11 +
 drivers/usb/typec/Makefile                         |   1 +
 drivers/usb/typec/class.c                          |  24 +-
 drivers/usb/typec/hd3ss3220.c                      | 275 +++++++++++++++++++++
 drivers/usb/typec/mux.c                            |  86 ++++++-
 include/linux/device.h                             |  16 +-
 include/linux/property.h                           |   4 +
 include/linux/usb/role.h                           |  38 +++
 17 files changed, 802 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
 create mode 100644 drivers/usb/typec/hd3ss3220.c

-- 
2.7.4

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
