Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED518D3E2D1
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 20:04:24 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.2537.1730145853990506462
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Oct 2024 13:04:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,239,1725289200"; 
   d="scan'208";a="227219301"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Oct 2024 05:04:22 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.179])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9786A408CD3A;
	Tue, 29 Oct 2024 05:04:13 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 12/27] media: rzg2l-cru: Remove unnecessary shadowing of ret in rzg2l_csi2_s_stream()
Date: Mon, 28 Oct 2024 20:03:34 +0000
Message-ID: <20241028200349.9620-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Oct 2024 20:04:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17096

From: Nathan Chancellor <nathan@kernel.org>

commit 1aba7930c63ea57b4918dc61dcc315f451cec21e upstream.

Clang warns:

  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:445:7: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                  if (ret)
                      ^~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:475:9: note: uninitialized use occurs here
          return ret;
                ^~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:445:3: note: remove the 'if' if its condition is always false
                  if (ret)
                  ^~~~~~~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:441:7: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                  if (ret)
                      ^~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:475:9: note: uninitialized use occurs here
          return ret;
                ^~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:441:3: note: remove the 'if' if its condition is always false
                  if (ret)
                  ^~~~~~~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:431:9: note: initialize the variable 'ret' to silence this warning
          int ret;
                ^
                  = 0
  2 errors generated.

ret is unnecessarily shadowed, meaning the assignments to ret within the
first 'if (enable)' block are only applied to the inner scope, not the
outer one as intended. Remove the shadowing to fix the warnings and make
everything work correctly.

Link: https://github.com/ClangBuiltLinux/linux/issues/1764

Fixes: 51e8415e39a9 ("media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 40e105613bc99..306c5d3a9fb6e 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -428,8 +428,6 @@ static int rzg2l_csi2_s_stream(struct v4l2_subdev *sd, int enable)
 	int ret;
 
 	if (enable) {
-		int ret;
-
 		ret = pm_runtime_resume_and_get(csi2->dev);
 		if (ret)
 			return ret;
-- 
2.43.0


