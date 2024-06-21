Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33303C2BA18
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 01:58:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.63836.1718935092613038946
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jun 2024 18:58:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=drWz3aur;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1718935083;x=1720144683;bh=zVuWuWLpndHJxN+Kd4zRPGvJCWIz82t0YwnGME2qpgQ=;b=drW
	z3aur9yzlC3zkhTCJtd89SIMU5JFLvDWKCakxXGnyLQ00yh+DIe4IvrZxqMZBuvGpaXtQdhGhZSmB
	Fs02xRcIsIve2TcjsZzRaWVlc3kLVXwsCX68UEN9A4N0JJ93rlO7dZTWoeUgPRCCeYnHb0LKuFSkD
	iaHai5sZlBosI5pfxIDNkCWSd979EhRadChKJoW+WmlNt4k/OPpNzJNO4igXkn9vQKEe7D1HXe1j2
	SNkMqN0Gwtbm8ZW/PzLDPtRhPs961ZcdfYXeB9fEOunCkrj+BRejTUSKzrJcSLuiCe2MUgs9dpaqv
	d71g+Mf18GzjKz4xHTf7UC/+zHgAA8w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 45L1w3gY1715710; Fri, 21 Jun 2024 10:58:03 +0900
X-Iguazu-Qid: 2yAbNsrDL2X3sngW9Q
X-Iguazu-QSIG: v=2; s=0; t=1718935082; q=2yAbNsrDL2X3sngW9Q; m=0OqdC9kOBG/9i03yIf86DSquhDK61WB1uzGtNV9y/JQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 45L1w2nB1575476
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 10:58:02 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.10.y-cip] drm/amdgpu/virt: fix handling of the atomic flag
Date: Fri, 21 Jun 2024 10:58:00 +0900
X-TSB-HOP2: ON
Message-Id: <1718935080-25727-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 01:58:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16308

From: Alex Deucher <alexdeucher@gmail.com>

commit e431eb8089eef1477082d6ae072ac252699b231f upstream.

Use the per device drm driver feature flags rather than the
global one.  This way we can make the drm driver struct const.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20201104100425.1922351-3-daniel.vetter@ffwll.ch
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406210812.Au5U3OkG-lkp@intel.com/
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d6f295103595..a95ada001b0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -47,11 +47,13 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 
 void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 {
+	struct drm_device *ddev = adev_to_drm(adev);
+
 	/* enable virtual display */
 	if (adev->mode_info.num_crtc == 0)
 		adev->mode_info.num_crtc = 1;
 	adev->enable_virtual_display = true;
-	adev_to_drm(adev)->driver->driver_features &= ~DRIVER_ATOMIC;
+	ddev->driver_features &= ~DRIVER_ATOMIC;
 	adev->cg_flags = 0;
 	adev->pg_flags = 0;
 }
-- 
2.43.0



