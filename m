Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58140C77B7E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:17:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6166.1682061454427200641
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156786872"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:17:40 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 34C7441AA647;
	Fri, 21 Apr 2023 16:17:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 03/33] serial: 8250: extend compile-test coverage
Date: Fri, 21 Apr 2023 08:16:59 +0100
Message-Id: <20230421071729.130347-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:17:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11276

From: Johan Hovold <johan@kernel.org>

commit b1442c55ce8977aa304c9f5a078e895fac5d1d63 upstream.

Allow more drivers to be compile tested more easily, for example, when
doing subsystem-wide changes.

Verified on X86_64 as well as arm, powerpc and m68k with minimal configs
in order to catch missing implicit build dependencies.

Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20210715083011.18887-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[biju: Done the changes only for 8250_EM]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/8250/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index b7922c8da1e6..f4fcc85e2555 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -378,7 +378,8 @@ config SERIAL_8250_DW
 
 config SERIAL_8250_EM
 	tristate "Support for Emma Mobile integrated serial port"
-	depends on SERIAL_8250 && ARM && HAVE_CLK
+	depends on SERIAL_8250 && HAVE_CLK
+	depends on ARM || COMPILE_TEST
 	help
 	  Selecting this option will add support for the integrated serial
 	  port hardware found on the Emma Mobile line of processors.
-- 
2.25.1


