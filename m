Return-Path: <SRS0=cQ/i=IH=lists.cip-project.org=bounce+64572+6236+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB66C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408A464FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408A464FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6236+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BUL4YY4521723x0NeFuss6dF; Tue, 09 Mar 2021 08:37:27 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:26 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342245"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:25 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E72CE40A2DC7;
	Wed, 10 Mar 2021 01:37:24 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 20/40] media: i2c: imx219: take lock in imx219_enum_mbus_code/frame_size
Date: Tue,  9 Mar 2021 16:36:36 +0000
Message-Id: <20210309163656.20944-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qG8n75aw7C6U56nwWVzz8woix4520388AA=
Content-Type: multipart/mixed; boundary="nWdQXEYAnxHht3sk4Lg7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307847;
 bh=J4KtNE26HtTJ8zqyuH3ANcfpz8/phMuqMxzFea+2rMk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=fTMBTbhUDYsLisselcwLLCa4pskYNXaGgEB6t0Ii/qIUeM/GAeoLv5Gm67qLxyevacZ
 Lnvv5+GyVdt9yECVO3OSzhGaidJoHu6+yKgtu1LRrwTtdAEHFKppANCTBiaoD0LGQAhex
 kzeg8f8ydB1dErB5PXKaf///PqTku1Sr4jk=

--nWdQXEYAnxHht3sk4Lg7

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 81015221a269e0d9bf6dbc3fda099b09a876ebb7 upstream.

These two functions did not take the imx219->mutex lock, but
imx219_get_format_code checks that a lock is taken, so it issues
a warning:

[    8.738717] WARNING: CPU: 2 PID: 60 at drivers/media/i2c/imx219.c:653 imx219_get_format_code+0xac/0xc0
[    8.748113] Modules linked in:
[    8.751214] CPU: 2 PID: 60 Comm: kworker/2:1 Tainted: G        W         5.8.0-rc1-arm64 #148
[    8.759821] Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
[    8.765806] Workqueue: events deferred_probe_work_func
[    8.771003] pstate: 60000005 (nZCv daif -PAN -UAO BTYPE=--)
[    8.776635] pc : imx219_get_format_code+0xac/0xc0
[    8.781390] lr : imx219_get_format_code+0xa8/0xc0
[    8.786143] sp : ffff800012a538f0
[    8.789495] x29: ffff800012a538f0 x28: ffff800012838e90
[    8.794867] x27: ffff0000f28c5800 x26: ffff800011161c68
[    8.800237] x25: ffff0000f2a5a3f8 x24: 0000000000000018
[    8.805605] x23: ffff0000f284ef18 x22: ffff0000f2a5a080
[    8.810974] x21: ffff0000f284ff00 x20: ffff0000f2a5a080
[    8.816343] x19: 000000000000300f x18: 00000000ffffffff
[    8.821712] x17: ffff800011c77268 x16: 00000000000040d7
[    8.827081] x15: 00000000000040d8 x14: 0000000000000000
[    8.832451] x13: 00000000000040d4 x12: ffff800011d19300
[    8.837819] x11: 00000000000208c0 x10: 0000000000000004
[    8.843188] x9 : 000000003baa2ecd x8 : 000000008b3f9c73
[    8.848558] x7 : 0000000000000008 x6 : 0000000000000034
[    8.853929] x5 : 0000000000000000 x4 : 0000000000000001
[    8.859297] x3 : ffff800010a2a8a8 x2 : ffff0000f84a8000
[    8.864666] x1 : 0000000000000000 x0 : 0000000000000000
[    8.870034] Call trace:
[    8.872515]  imx219_get_format_code+0xac/0xc0
[    8.876921]  imx219_enum_mbus_code+0x38/0x60
[    8.881241]  call_enum_mbus_code+0x50/0x70
[    8.885387]  tegra_vi_graph_notify_complete+0x290/0x5e8
[    8.890670]  v4l2_async_notifier_try_complete.part.0+0x48/0x68
[    8.896563]  v4l2_async_register_subdev+0x100/0x1c0
[    8.901497]  v4l2_async_register_subdev_sensor_common+0x70/0xf0
[    8.907477]  imx219_probe+0x590/0x728
[    8.911184]  i2c_device_probe+0xe4/0x2b0
[    8.915151]  really_probe+0xd8/0x330
[    8.918768]  driver_probe_device+0x58/0xb8
[    8.922909]  __device_attach_driver+0x84/0xc8
[    8.927315]  bus_for_each_drv+0x78/0xc8
[    8.931193]  __device_attach+0xe4/0x140
[    8.935072]  device_initial_probe+0x14/0x20
[    8.939301]  bus_probe_device+0x9c/0xa8
[    8.943179]  deferred_probe_work_func+0x74/0xb0
[    8.947759]  process_one_work+0x2c4/0x740
[    8.951813]  worker_thread+0x4c/0x430
[    8.955518]  kthread+0x158/0x178
[    8.958786]  ret_from_fork+0x10/0x1c
[    8.962401] irq event stamp: 63536
[    8.965846] hardirqs last  enabled at (63535): [<ffff800010082398>] el1_irq+0xd8/0x180
[    8.973846] hardirqs last disabled at (63536): [<ffff8000100a6484>] do_debug_exception+0x16c/0x258
[    8.982895] softirqs last  enabled at (63534): [<ffff800010080d4c>] _stext+0x54c/0x594
[    8.990896] softirqs last disabled at (63525): [<ffff8000100c8350>] irq_exit+0x100/0x138
[    8.999066] ---[ end trace ebfbcd84b75ef921 ]---
[    9.004354] ------------[ cut here ]------------

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/imx219.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 386717fb2b99..a2829c7012aa 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -811,7 +811,9 @@ static int imx219_enum_mbus_code(struct v4l2_subdev *sd,
 	if (code->index >= (ARRAY_SIZE(codes) / 4))
 		return -EINVAL;
 
+	mutex_lock(&imx219->mutex);
 	code->code = imx219_get_format_code(imx219, codes[code->index * 4]);
+	mutex_unlock(&imx219->mutex);
 
 	return 0;
 }
@@ -821,11 +823,15 @@ static int imx219_enum_frame_size(struct v4l2_subdev *sd,
 				  struct v4l2_subdev_frame_size_enum *fse)
 {
 	struct imx219 *imx219 = to_imx219(sd);
+	u32 code;
 
 	if (fse->index >= ARRAY_SIZE(supported_modes))
 		return -EINVAL;
 
-	if (fse->code != imx219_get_format_code(imx219, fse->code))
+	mutex_lock(&imx219->mutex);
+	code = imx219_get_format_code(imx219, fse->code);
+	mutex_unlock(&imx219->mutex);
+	if (fse->code != code)
 		return -EINVAL;
 
 	fse->min_width = supported_modes[fse->index].width;
-- 
2.17.1


--nWdQXEYAnxHht3sk4Lg7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6236): https://lists.cip-project.org/g/cip-dev/message=
/6236
Mute This Topic: https://lists.cip-project.org/mt/81205367/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nWdQXEYAnxHht3sk4Lg7--
