Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18660E6B261
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 12:58:05 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.36849.1730465882716997335
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 05:58:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,249,1725289200"; 
   d="scan'208";a="223655297"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Nov 2024 21:58:02 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.182])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4854C400A66A;
	Fri,  1 Nov 2024 21:58:01 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 07/28] media: v4l: subdev: Add pre_streamon and post_streamoff callbacks
Date: Fri,  1 Nov 2024 12:57:25 +0000
Message-ID: <20241101125746.33222-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 12:58:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17141

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 253171a0da67304f0ee7358b37df7b715c65dd77 upstream.

Add pre_streamon and post_streamoff callbacks that can be used to set a
CSI-2 transmitter to LP-11 or LP-111 mode. This can be used by receiver
drivers to reliably initialise the receiver when its initialisation
requires software involvement.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/media/v4l2-subdev.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 73150520c02d4..bb97106e1ae86 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -354,6 +354,16 @@ struct v4l2_mbus_frame_desc {
 	unsigned short num_entries;
 };
 
+/**
+ * enum v4l2_subdev_pre_streamon_flags - Flags for pre_streamon subdev core op
+ *
+ * @V4L2_SUBDEV_PRE_STREAMON_FL_MANUAL_LP: Set the transmitter to either LP-11
+ *	or LP-111 mode before call to s_stream().
+ */
+enum v4l2_subdev_pre_streamon_flags {
+	V4L2_SUBDEV_PRE_STREAMON_FL_MANUAL_LP = BIT(0),
+};
+
 /**
  * struct v4l2_subdev_video_ops - Callbacks used when v4l device was opened
  *				  in video mode.
@@ -409,6 +419,19 @@ struct v4l2_mbus_frame_desc {
  * @s_rx_buffer: set a host allocated memory buffer for the subdev. The subdev
  *	can adjust @size to a lower value and must not write more data to the
  *	buffer starting at @data than the original value of @size.
+ *
+ * @pre_streamon: May be called before streaming is actually started, to help
+ *	initialising the bus. Current usage is to set a CSI-2 transmitter to
+ *	LP-11 or LP-111 mode before streaming. See &enum
+ *	v4l2_subdev_pre_streamon_flags.
+ *
+ *	pre_streamon shall return error if it cannot perform the operation as
+ *	indicated by the flags argument. In particular, -EACCES indicates lack
+ *	of support for the operation. The caller shall call post_streamoff for
+ *	each successful call of pre_streamon.
+ *
+ * @post_streamoff: Called after streaming is stopped, but if and only if
+ *	pre_streamon was called earlier.
  */
 struct v4l2_subdev_video_ops {
 	int (*s_routing)(struct v4l2_subdev *sd, u32 input, u32 output, u32 config);
@@ -435,6 +458,8 @@ struct v4l2_subdev_video_ops {
 			struct v4l2_dv_timings *timings);
 	int (*s_rx_buffer)(struct v4l2_subdev *sd, void *buf,
 			   unsigned int *size);
+	int (*pre_streamon)(struct v4l2_subdev *sd, u32 flags);
+	int (*post_streamoff)(struct v4l2_subdev *sd);
 };
 
 /**
-- 
2.43.0


