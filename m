Return-Path: <SRS0=Bmk1=IH=lists.cip-project.org=bounce+64572+6222+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3A7C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912C764FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912C764FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6222+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gihlYY4521723xhb6jIn7kDF; Tue, 09 Mar 2021 08:37:08 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:07 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591000"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:07 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 488AE40A2DC7;
	Wed, 10 Mar 2021 01:37:06 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 06/40] media: v4l: ctrl: Provide unlocked variant of v4l2_ctrl_grab
Date: Tue,  9 Mar 2021 16:36:22 +0000
Message-Id: <20210309163656.20944-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QPauzGI7KoiuF6UbQ6CN4N0vx4520388AA=
Content-Type: multipart/mixed; boundary="G0mCDciDPscAjpsv292F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307828;
 bh=7vMrYFr52k5eUaBP04rDOLikcUlxyfcRLFbrZRGKHP0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TAmcQrGA1Ir2ZCdwiiAu8mYeljKBYIt8QtNhd7d3SALyZfH7olOvcrqOnhT7eEKWb+r
 4o86zfd6hq9D3g8cFiiEZMfF+umyNbWYIxukvzviMo3zoaSDA+2f8XNcO+9EVJzz/uBmW
 Q4/TwM1fABNbX92vYGRI3B8Sb7rnwf/YvjI=

--G0mCDciDPscAjpsv292F

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 7a9b109d91cfc6089006378efd515cc287bdef67 upstream.

Sometimes it may be necessary to grab a control while holding the control
handler's lock. Provide an unlocked variant of v4l2_ctrl_grab for the
purpose --- it's called __v4l2_ctrl_grab.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/v4l2-core/v4l2-ctrls.c |  8 ++++----
 include/media/v4l2-ctrls.h           | 26 +++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index f4ebff347d7a..6868c1990534 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2517,14 +2517,15 @@ EXPORT_SYMBOL(v4l2_ctrl_activate);
 
    Just call this and the framework will block any attempts to change
    these controls. */
-void v4l2_ctrl_grab(struct v4l2_ctrl *ctrl, bool grabbed)
+void __v4l2_ctrl_grab(struct v4l2_ctrl *ctrl, bool grabbed)
 {
 	bool old;
 
 	if (ctrl == NULL)
 		return;
 
-	v4l2_ctrl_lock(ctrl);
+	lockdep_assert_held(ctrl->handler->lock);
+
 	if (grabbed)
 		/* set V4L2_CTRL_FLAG_GRABBED */
 		old = test_and_set_bit(1, &ctrl->flags);
@@ -2533,9 +2534,8 @@ void v4l2_ctrl_grab(struct v4l2_ctrl *ctrl, bool grabbed)
 		old = test_and_clear_bit(1, &ctrl->flags);
 	if (old != grabbed)
 		send_event(NULL, ctrl, V4L2_EVENT_CTRL_CH_FLAGS);
-	v4l2_ctrl_unlock(ctrl);
 }
-EXPORT_SYMBOL(v4l2_ctrl_grab);
+EXPORT_SYMBOL(__v4l2_ctrl_grab);
 
 /* Log the control name and value */
 static void log_ctrl(const struct v4l2_ctrl *ctrl,
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index f615ba1b29dd..ff89df428f79 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -728,6 +728,22 @@ struct v4l2_ctrl *v4l2_ctrl_find(struct v4l2_ctrl_handler *hdl, u32 id);
  */
 void v4l2_ctrl_activate(struct v4l2_ctrl *ctrl, bool active);
 
+/**
+ * __v4l2_ctrl_grab() - Unlocked variant of v4l2_ctrl_grab.
+ *
+ * @ctrl:	The control to (de)activate.
+ * @grabbed:	True if the control should become grabbed.
+ *
+ * This sets or clears the V4L2_CTRL_FLAG_GRABBED flag atomically.
+ * Does nothing if @ctrl == NULL.
+ * The V4L2_EVENT_CTRL event will be generated afterwards.
+ * This will usually be called when starting or stopping streaming in the
+ * driver.
+ *
+ * This function assumes that the control handler is locked by the caller.
+ */
+void __v4l2_ctrl_grab(struct v4l2_ctrl *ctrl, bool grabbed);
+
 /**
  * v4l2_ctrl_grab() - Mark the control as grabbed or not grabbed.
  *
@@ -743,7 +759,15 @@ void v4l2_ctrl_activate(struct v4l2_ctrl *ctrl, bool active);
  * This function assumes that the control handler is not locked and will
  * take the lock itself.
  */
-void v4l2_ctrl_grab(struct v4l2_ctrl *ctrl, bool grabbed);
+static inline void v4l2_ctrl_grab(struct v4l2_ctrl *ctrl, bool grabbed)
+{
+	if (!ctrl)
+		return;
+
+	v4l2_ctrl_lock(ctrl);
+	__v4l2_ctrl_grab(ctrl, grabbed);
+	v4l2_ctrl_unlock(ctrl);
+}
 
 /**
  *__v4l2_ctrl_modify_range() - Unlocked variant of v4l2_ctrl_modify_range()
-- 
2.17.1


--G0mCDciDPscAjpsv292F
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6222): https://lists.cip-project.org/g/cip-dev/message=
/6222
Mute This Topic: https://lists.cip-project.org/mt/81205347/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--G0mCDciDPscAjpsv292F--
