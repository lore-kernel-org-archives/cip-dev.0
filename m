Return-Path: <SRS0=Ids6=IH=lists.cip-project.org=bounce+64572+6220+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74418C43381
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B95864F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B95864F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6220+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xiRAYY4521723xp0LPOSRYOM; Tue, 09 Mar 2021 08:37:06 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11724.1615307821262695682
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:06 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342219"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:05 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EFB6A40A2EDA;
	Wed, 10 Mar 2021 01:37:04 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 05/40] media: v4l2-async: Log message in case of heterogeneous fwnode match
Date: Tue,  9 Mar 2021 16:36:21 +0000
Message-Id: <20210309163656.20944-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KdOIYHhCvFIAeT6yxpkfPIIpx4520388AA=
Content-Type: multipart/mixed; boundary="47qFHo5vv18meNtsEbIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307826;
 bh=mU4EEW33vwf29SkXtH4XF0JEAJ2TlbVk2o3bWV/Fekc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lzDfcnfT7xzAGZKSSZJC9AhYjkdOzuZcbJGruE7xnTEvwxlV7Ya36O9Dxm2vLetidGr
 BfIEz/QrXFjlBzxFWS5Po9s7cWOuFAkD2blRYZ791HX8aHG5LByKhU9nzC9nB8s0kNVnN
 RpuOMQgyY8Yd8eWTCvBwjrOiByobD2KSCv8=

--47qFHo5vv18meNtsEbIJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit e80cdf0a3843fe570c891cb976feb0c136b19fb7 upstream.

When a notifier supplies a device fwnode and a subdev supplies an
endpoint fwnode, incorrect matches may occur if multiple subdevs
correspond to the same device fwnode. This can't be handled
transparently in the framework, and requires the notifier to switch to
endpoint fwnodes. Log a message to notify of this problem. A second
message is added to help accelerating the transition to endpoint
matching.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/v4l2-core/v4l2-async.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 0ee5e9f51877..72285709c4c2 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -79,6 +79,7 @@ static bool match_fwnode(struct v4l2_async_notifier *notifier,
 	struct fwnode_handle *dev_fwnode;
 	bool asd_fwnode_is_ep;
 	bool sd_fwnode_is_ep;
+	struct device *dev;
 
 	/*
 	 * Both the subdev and the async subdev can provide either an endpoint
@@ -116,7 +117,28 @@ static bool match_fwnode(struct v4l2_async_notifier *notifier,
 
 	fwnode_handle_put(dev_fwnode);
 
-	return dev_fwnode == other_fwnode;
+	if (dev_fwnode != other_fwnode)
+		return false;
+
+	/*
+	 * We have a heterogeneous match. Retrieve the struct device of the side
+	 * that matched on a device fwnode to print its driver name.
+	 */
+	if (sd_fwnode_is_ep)
+		dev = notifier->v4l2_dev ? notifier->v4l2_dev->dev
+		    : notifier->sd->dev;
+	else
+		dev = sd->dev;
+
+	if (dev && dev->driver) {
+		if (sd_fwnode_is_ep)
+			dev_warn(dev, "Driver %s uses device fwnode, incorrect match may occur\n",
+				 dev->driver->name);
+		dev_notice(dev, "Consider updating driver %s to match on endpoints\n",
+			   dev->driver->name);
+	}
+
+	return true;
 }
 
 static bool match_custom(struct v4l2_async_notifier *notifier,
-- 
2.17.1


--47qFHo5vv18meNtsEbIJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6220): https://lists.cip-project.org/g/cip-dev/message=
/6220
Mute This Topic: https://lists.cip-project.org/mt/81205344/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--47qFHo5vv18meNtsEbIJ--
