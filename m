Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EB0C35278
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 12:40:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.630.1702384840537154755
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Dec 2023 04:40:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,270,1695654000"; 
   d="scan'208";a="190069291"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 12 Dec 2023 21:40:38 +0900
Received: from localhost.localdomain (unknown [10.226.93.124])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 09DC8400517D;
	Tue, 12 Dec 2023 21:40:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 00/14] Add Mali-G31 GPU support for RZ/G2L SoC
Date: Tue, 12 Dec 2023 12:40:21 +0000
Message-Id: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Dec 2023 12:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14043

RZ/G2L SoC embeds Mali-G31 bifrost GPU.
This patch series aims to add support for the same.

Please don't apply patch#7 to patch#14as it is added for testing purpose.

It is tested with 5.10.y-cip + out of tree patch for (DU) + [1]

[1] https://renesas.info/wiki/RZ-G/Panfrost_for_RZG2L

Tested the kmscube application.

test logs:-
root@smarc-rzg2lc:/# kmscube
Using display 0xaaaafc431020 with EGL version 1.4
===================================
EGL information:
  version: "1.4"
  vendor: "Mesa Project"
  client extensions: "EGL_EXT_client_extensions EGL_EXT_device_base EGL_EXT_device_enumeration EGL_EXT_device_query EGL_EXT_platform_base EGL_KHR_client_get_all_proc_addresses EGL_KHR_debug EGL_EXT_platform_device EGL_EXT_platform_wayland EGL_KHR_platform_wayland EGL_MESA_platform_gbm EGL_KHR_platform_gbm EGL_MESA_platform_surfaceless"
  display extensions: "EGL_ANDROID_blob_cache EGL_EXT_buffer_age EGL_EXT_image_dma_buf_import EGL_EXT_image_dma_buf_import_modifiers EGL_KHR_cl_event2 EGL_KHR_config_attribs EGL_KHR_create_context EGL_KHR_create_context_no_error EGL_KHR_fence_sync EGL_KHR_get_all_proc_addresses EGL_KHR_gl_colorspace EGL_KHR_gl_renderbuffer_image EGL_KHR_gl_texture_2D_image EGL_KHR_gl_texture_3D_image EGL_KHR_gl_texture_cubemap_image EGL_KHR_image EGL_KHR_image_base EGL_KHR_image_pixmap EGL_KHR_no_config_context EGL_KHR_partial_update EGL_KHR_reusable_sync EGL_KHR_surfaceless_context EGL_EXT_pixel_format_float EGL_KHR_wait_sync EGL_MESA_configless_context EGL_MESA_drm_image EGL_MESA_image_dma_buf_export EGL_MESA_query_driver EGL_WL_bind_wayland_display "
===================================
OpenGL ES 2.x information:
  version: "OpenGL ES 3.1 Mesa 21.3.0"
  shading language version: "OpenGL ES GLSL ES 3.10"
  vendor: "Panfrost"
  renderer: "Mali-G31 (Panfrost)"


root@smarc-rzg2lc:/# cat /proc/interrupts | grep panfrost
 87:       1655          0     GICv3 186 Level     panfrost-job
 88:          2          0     GICv3 187 Level     panfrost-mmu
 89:         18          0     GICv3 185 Level     panfrost-gpu

root@smarc-rzg2lc:/# cat /sys/class/devfreq/11840000.gpu/trans_stat
     From  :   To
           :  50000000  62500000 100000000 125000000 200000000 250000000 400000000 500000000   time(ms)
*  50000000:         0       119         0         0         0         0         0         1     19848
   62500000:       119         0         0         0         0         0         0         0      7236
  100000000:         0         0         0         0         0         0         0         1       132
  125000000:         0         0         0         0         0         0         0         0         0
  200000000:         0         0         0         0         0         0         0         0         0
  250000000:         1         0         0         0         0         0         0         0       780
  400000000:         0         0         0         0         0         1         0         0        56
  500000000:         1         0         1         0         0         0         1         0       176
Total transition : 245

Biju Das (10):
  dt-bindings: gpu: mali-bifrost: Document RZ/G2L support
  arm64: dts: renesas: r9a07g044: Add Mali-G31 GPU node
  arm64: dts: renesas: rzg2l-smarc-som: Add vdd core regulator
  arm64: dts: renesas: rzg2lc-smarc-som: Add vdd core regulator
  arm64: dts: renesas: r9a07g044: [HACK DO NOT APPLY] Add DU node
  arm64: dts: renesas: r9a07g054: [HACK DO NOT APPLY] Add DU node
  arm64: dts: renesas: rzg2l-smarc: [HACK DO NOT APPLY] Enable DU and
    link with DSI
  arm64: dts: renesas: rzg2lc-smarc: [HACK DO NOT APPLY] Enable DU and
    link with DSI
  drm: [HACK DO NOT APPLY] Add RZ/G2L DU Support
  defconfig: [HACK DO NOT APPLY] Enable display on RZ/G2L SMARC EVK.

Daniel Vetter (1):
  drm: [HACK DO NOT APPLY] Allow const struct drm_driver

Lad Prabhakar (2):
  dt-bindings: gpu: mali-bifrost: Document RZ/V2L SoC
  arm64: dts: renesas: r9a07g054: Fillup the GPU node

Philipp Zabel (1):
  drm: [HACK DO NOT APPLY] add drmm_encoder_alloc()

 .../bindings/gpu/arm,mali-bifrost.yaml        |  48 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  79 ++++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  77 +++-
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  13 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  21 +
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    |  13 +
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  21 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/drm_drv.c                     |  17 +-
 drivers/gpu/drm/drm_encoder.c                 | 109 ++++-
 drivers/gpu/drm/rz-du/Kconfig                 |  22 +
 drivers/gpu/drm/rz-du/Makefile                |   8 +
 drivers/gpu/drm/rz-du/rzg2l_du_crtc.c         | 432 ++++++++++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_crtc.h         |  91 ++++
 drivers/gpu/drm/rz-du/rzg2l_du_drv.c          | 187 ++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_drv.h          |  85 ++++
 drivers/gpu/drm/rz-du/rzg2l_du_encoder.c      | 121 +++++
 drivers/gpu/drm/rz-du/rzg2l_du_encoder.h      |  33 ++
 drivers/gpu/drm/rz-du/rzg2l_du_kms.c          | 389 ++++++++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_kms.h          |  43 ++
 drivers/gpu/drm/rz-du/rzg2l_du_regs.h         |  67 +++
 drivers/gpu/drm/rz-du/rzg2l_du_vsp.c          | 428 +++++++++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_vsp.h          |  96 ++++
 include/drm/drm_device.h                      |   4 +
 include/drm/drm_drv.h                         |   5 +-
 include/drm/drm_encoder.h                     |  30 ++
 28 files changed, 2409 insertions(+), 34 deletions(-)
 create mode 100644 drivers/gpu/drm/rz-du/Kconfig
 create mode 100644 drivers/gpu/drm/rz-du/Makefile
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_crtc.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_crtc.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_drv.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_drv.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_encoder.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_encoder.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_kms.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_kms.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_regs.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_vsp.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_vsp.h

-- 
2.25.1


