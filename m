Return-Path: <SRS0=zMHH=IH=lists.cip-project.org=bounce+64572+6219+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4995CC433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE506651BB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE506651BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6219+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NNVhYY4521723xp5pgZk4hmz; Tue, 09 Mar 2021 08:37:05 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11724.1615307821262695682
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:05 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342216"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:04 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A028D40A2EDA;
	Wed, 10 Mar 2021 01:37:03 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 04/40] media: v4l2-async: Pass notifier pointer to match functions
Date: Tue,  9 Mar 2021 16:36:20 +0000
Message-Id: <20210309163656.20944-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AyzCLl9ZB8WnHLw1aYB1f0g8x4520388AA=
Content-Type: multipart/mixed; boundary="y3KPSSUtRXUWYr3XBO6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307825;
 bh=51LkFWGE7ZbLUhIR74bQlaTAdbKseL6TYTELvGbyK/Q=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=mGVQ3RSSyN5l9RBGe+hchwUopMUSlmxHpPxTD4j9UbZGhx09thXwCgBOuhgomDUXs40
 RxKXFIik72DymVTKy4YpiPAcI9Ysmrji3IGqHMbCv5Op3nd8pjQ1HNxa4P6Q/ntYSA0Fd
 eURIetzPl73MgHw9yuOeeyz/zN4tgV8IiFQ=

--y3KPSSUtRXUWYr3XBO6D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 3e33392a9561fd64515049317041646ab3bf32aa upstream.

The notifier is useful to match functions to access information about
the device matching a subdev. This will be used to print messages using
the correct struct device and driver name.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/v4l2-core/v4l2-async.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 72f8c070ad9d..0ee5e9f51877 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -53,7 +53,8 @@ static int v4l2_async_notifier_call_complete(struct v4l2_async_notifier *n)
 	return n->ops->complete(n);
 }
 
-static bool match_i2c(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
+static bool match_i2c(struct v4l2_async_notifier *notifier,
+		      struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
 {
 #if IS_ENABLED(CONFIG_I2C)
 	struct i2c_client *client = i2c_verify_client(sd->dev);
@@ -65,13 +66,14 @@ static bool match_i2c(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
 #endif
 }
 
-static bool match_devname(struct v4l2_subdev *sd,
-			  struct v4l2_async_subdev *asd)
+static bool match_devname(struct v4l2_async_notifier *notifier,
+			  struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
 {
 	return !strcmp(asd->match.device_name, dev_name(sd->dev));
 }
 
-static bool match_fwnode(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
+static bool match_fwnode(struct v4l2_async_notifier *notifier,
+			 struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
 {
 	struct fwnode_handle *other_fwnode;
 	struct fwnode_handle *dev_fwnode;
@@ -117,7 +119,8 @@ static bool match_fwnode(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
 	return dev_fwnode == other_fwnode;
 }
 
-static bool match_custom(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
+static bool match_custom(struct v4l2_async_notifier *notifier,
+			 struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
 {
 	if (!asd->match.custom.match)
 		/* Match always */
@@ -133,7 +136,8 @@ static DEFINE_MUTEX(list_lock);
 static struct v4l2_async_subdev *v4l2_async_find_match(
 	struct v4l2_async_notifier *notifier, struct v4l2_subdev *sd)
 {
-	bool (*match)(struct v4l2_subdev *, struct v4l2_async_subdev *);
+	bool (*match)(struct v4l2_async_notifier *notifier,
+		      struct v4l2_subdev *sd, struct v4l2_async_subdev *asd);
 	struct v4l2_async_subdev *asd;
 
 	list_for_each_entry(asd, &notifier->waiting, list) {
@@ -158,7 +162,7 @@ static struct v4l2_async_subdev *v4l2_async_find_match(
 		}
 
 		/* match cannot be NULL here */
-		if (match(sd, asd))
+		if (match(notifier, sd, asd))
 			return asd;
 	}
 
-- 
2.17.1


--y3KPSSUtRXUWYr3XBO6D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6219): https://lists.cip-project.org/g/cip-dev/message=
/6219
Mute This Topic: https://lists.cip-project.org/mt/81205342/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--y3KPSSUtRXUWYr3XBO6D--
