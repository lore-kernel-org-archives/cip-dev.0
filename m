Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E60ACA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 13:56:32 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.20503.1755698186835829712
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 06:56:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: ftFL2JCKRVue8vvx+Qc+gw==
X-CSE-MsgGUID: +R+PsdDAS5+o7Hf6fB+rgQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 22:56:25 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.236])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7D9104178746;
	Wed, 20 Aug 2025 22:56:23 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Ulrich Hecht <uli@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the notify_hotplug_work
Date: Wed, 20 Aug 2025 14:56:22 +0100
Message-ID: <20250820135622.27414-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 13:56:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19819

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 552ca6b87e3778f3dd5b87842f95138162e16c82 upstream.

When performing continuous unbind/bind operations on the USB drivers
available on the Renesas RZ/G2L SoC, a kernel crash with the message
"Unable to handle kernel NULL pointer dereference at virtual address"
may occur. This issue points to the usbhsc_notify_hotplug() function.

Flush the delayed work to avoid its execution when driver resources are
unavailable.

Fixes: bc57381e6347 ("usb: renesas_usbhs: use delayed_work instead of work_struct")
Cc: stable <stable@kernel.org>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250225110248.870417-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi all,

This backport is intended to fix CVE-2025-21912 [0].

[0] https://nvd.nist.gov/vuln/detail/CVE-2025-21912

Note,
- This patch is already present in 6.1-cip [1] & 6.12-cip [2].
- I intended to send similar patch for 4.4-cip too.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/drivers/usb/renesas_usbhs?h=linux-6.1.y-cip&id=4ca078084cdd5f32d533311d6a0b63a60dcadd41
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/drivers/usb/renesas_usbhs?h=linux-6.12.y-cip&id=e5aac1c9b2974636db7ce796ffa6de88fa08335e

Cheers, Prabhakar
---
 drivers/usb/renesas_usbhs/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 4b5621d24f87..56a43d74a395 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -823,6 +823,8 @@ static int usbhs_remove(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "usb remove\n");
 
+	flush_delayed_work(&priv->notify_hotplug_work);
+
 	dfunc->notify_hotplug = NULL;
 
 	/* power off */
-- 
2.51.0


