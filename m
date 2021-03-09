Return-Path: <SRS0=odbd=IH=lists.cip-project.org=bounce+64572+6217+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A2AC433E9
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F9864F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F9864F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6217+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 92XPYY4521723xF4sv8scgio; Tue, 09 Mar 2021 08:37:03 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:03 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74590977"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:01 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0155340A2DC7;
	Wed, 10 Mar 2021 01:37:00 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 02/40] media: device property: Add a function to test is a fwnode is a graph endpoint
Date: Tue,  9 Mar 2021 16:36:18 +0000
Message-Id: <20210309163656.20944-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KU5XLNB2FBDzZDrLnzyww6jEx4520388AA=
Content-Type: multipart/mixed; boundary="N2bI3UMtvTEjff0AIXu6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307823;
 bh=P17gzoTEmYgKwNkdd6Ytnaa7Mq6zoO8uBN3AcorYWAM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DhxSILyTr29MiPRTmdspCps04Kth0qA9G2HLVoUdk/EK+c8/+qrPCcDgvGqy7kGpR7w
 JxKjGuZ0+lDJpBgotDEzVfCZTFjjGNKC98a4Wg9e6HBJaqNx2aNm0OORhGmTHnt5NDQ4n
 kyHKn3JiYufvFZt/0qYLjI6hQxXb/ZwPcUY=

--N2bI3UMtvTEjff0AIXu6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 35694afc92646ac24d7f3ef34a7387876d998fe7 upstream.

Drivers may need to test if a fwnode is a graph endpoint. To avoid
hand-written solutions that wouldn't work for all fwnode types, add a
new fwnode_graph_is_endpoint() function for this purpose. We don't need
to wire it up to different backends for OF and ACPI for now, as the
implementation can simply be based on checkout the presence of a
remote-endpoint property.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/linux/property.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 216dcfe567df..ec8ebd73b2c4 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -308,6 +308,11 @@ struct fwnode_handle *
 fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port,
 			     u32 endpoint);
 
+static inline bool fwnode_graph_is_endpoint(struct fwnode_handle *fwnode)
+{
+	return fwnode_property_present(fwnode, "remote-endpoint");
+}
+
 #define fwnode_graph_for_each_endpoint(fwnode, child)			\
 	for (child = NULL;						\
 	     (child = fwnode_graph_get_next_endpoint(fwnode, child)); )
-- 
2.17.1


--N2bI3UMtvTEjff0AIXu6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6217): https://lists.cip-project.org/g/cip-dev/message=
/6217
Mute This Topic: https://lists.cip-project.org/mt/81205338/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--N2bI3UMtvTEjff0AIXu6--
