Return-Path: <SRS0=xwYW=IH=lists.cip-project.org=bounce+64572+6218+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4ADC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E6564FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E6564FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6218+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YHQbYY4521723xchpBPljpEm; Tue, 09 Mar 2021 08:37:04 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:04 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74590988"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:03 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4FB0040A2EDA;
	Wed, 10 Mar 2021 01:37:02 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 03/40] media: v4l2-async: Accept endpoints and devices for fwnode matching
Date: Tue,  9 Mar 2021 16:36:19 +0000
Message-Id: <20210309163656.20944-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2AVHQu7qGfhYmnN86KEaI36Wx4520388AA=
Content-Type: multipart/mixed; boundary="auso8dxGEzENqrENBKX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307824;
 bh=72jXPlA5DEu7EffmBFpWdUTO32kf1oZRMLbPtXQthLU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=a17OZ0KGuvuWzmkIwbyOYibVF47sSWyky0Yc49H8ukNtYLb5fOxdLR6iIjvVtgGn43R
 jx+7POlJ0+sG1WPgEpC7IKok9mFIx7zACOxIx0n/PFC1f478DXkmSl/qtuOin6ARkkkN3
 rxfjh1tRDvS5jk1c8a6PdfmbjJXpOFtInOk=

--auso8dxGEzENqrENBKX0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit b98158d837efa0b2f2f59ee2ff77f4791f978d74 upstream.

fwnode matching was designed to match on nodes corresponding to a
device. Some drivers, however, needed to match on endpoints, and have
passed endpoint fwnodes to v4l2-async. This works when both the subdev
and the notifier use the same fwnode types (endpoint or device), but
makes drivers that use different types incompatible.

Fix this by extending the fwnode match to handle fwnodes of different
types. When the types (deduced from the presence of remote endpoints)
are different, retrieve the device fwnode for the side that provides an
endpoint fwnode, and compare it with the device fwnode provided by the
other side. This allows interoperability between all drivers, regardless
of which type of fwnode they use for matching.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/v4l2-core/v4l2-async.c | 43 +++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 2b08d03b251d..72f8c070ad9d 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -73,7 +73,48 @@ static bool match_devname(struct v4l2_subdev *sd,
 
 static bool match_fwnode(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
 {
-	return sd->fwnode == asd->match.fwnode;
+	struct fwnode_handle *other_fwnode;
+	struct fwnode_handle *dev_fwnode;
+	bool asd_fwnode_is_ep;
+	bool sd_fwnode_is_ep;
+
+	/*
+	 * Both the subdev and the async subdev can provide either an endpoint
+	 * fwnode or a device fwnode. Start with the simple case of direct
+	 * fwnode matching.
+	 */
+	if (sd->fwnode == asd->match.fwnode)
+		return true;
+
+	/*
+	 * Otherwise, check if the sd fwnode and the asd fwnode refer to an
+	 * endpoint or a device. If they're of the same type, there's no match.
+	 * Technically speaking this checks if the nodes refer to a connected
+	 * endpoint, which is the simplest check that works for both OF and
+	 * ACPI. This won't make a difference, as drivers should not try to
+	 * match unconnected endpoints.
+	 */
+	sd_fwnode_is_ep = fwnode_graph_is_endpoint(sd->fwnode);
+	asd_fwnode_is_ep = fwnode_graph_is_endpoint(asd->match.fwnode);
+
+	if (sd_fwnode_is_ep == asd_fwnode_is_ep)
+		return false;
+
+	/*
+	 * The sd and asd fwnodes are of different types. Get the device fwnode
+	 * parent of the endpoint fwnode, and compare it with the other fwnode.
+	 */
+	if (sd_fwnode_is_ep) {
+		dev_fwnode = fwnode_graph_get_port_parent(sd->fwnode);
+		other_fwnode = asd->match.fwnode;
+	} else {
+		dev_fwnode = fwnode_graph_get_port_parent(asd->match.fwnode);
+		other_fwnode = sd->fwnode;
+	}
+
+	fwnode_handle_put(dev_fwnode);
+
+	return dev_fwnode == other_fwnode;
 }
 
 static bool match_custom(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
-- 
2.17.1


--auso8dxGEzENqrENBKX0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6218): https://lists.cip-project.org/g/cip-dev/message=
/6218
Mute This Topic: https://lists.cip-project.org/mt/81205341/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--auso8dxGEzENqrENBKX0--
