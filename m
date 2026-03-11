Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A30104BEBF
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:16 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17320.1773223504971693294
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J2h4ZyBp;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso7857315f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223503; x=1773828303; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNgw0DHw03iANe55vl4U+qqNoMZz4mvYbEz8Kh4vTys=;
        b=J2h4ZyBpSaAXysBSb54gqSU1+jEmpNfKETKR/GV1eQBGfu0LYfBDNSzvTlHmvNj5VK
         noHEZmkdrIuHb8v9ZivR21pVxay1BLE3HnHR5VKS0cNw7fO51HH793Nz+cTFyAnsDsXv
         3qx/9bFg5YvFZweI2kGPLoWhhGoXGrxah816NkEljBj5XaUIVsx9+T7DwjS9ySw+QFhO
         P4FolLIwXENMVtXHD6SmKRI8Njd9bpKCf1wSkCMC+4mMsDWYiGqLpysYvJBE4QEkUPka
         mnHTN5U7LVNlGm5SU5DUS1LA/Ddtu/C7msuy8Y9jJ3ADrnZRbIqtZ5VwzMca+jR8PnAt
         yYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223503; x=1773828303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aNgw0DHw03iANe55vl4U+qqNoMZz4mvYbEz8Kh4vTys=;
        b=dtUClNRHuAAbZCAzsNzkoKZsPrqJuEKLdoNLVtxTeqX/XOFsHuNRv79BywcmnuzCkw
         tHILGdi4e7Hg9fkLSrlCalJOL8UiVDvB3Vj5/GvU2AEwdRywhryD+46fj9svWQFU9IcL
         luQQVqOrQzeRi2v7p0kh9B1HNNmIE9jGIXrnT1UmAST5seegsN6iBPioyx7wYmYMfM9I
         R7StxP/FVjiWlKTIcpQ4Va42ow+YXzX3qJCwPIyNMOn6L6o+Quu8Fg8vAFDceWvRgi5i
         2b8hZctc/61ULdl92Uv0mBNwmunQX9CruITwiYY6hHcjr5OrpQ6TJP5z/7RqDEwz2XcU
         AdBQ==
X-Gm-Message-State: AOJu0Yx0tcNHTvESfVV1H4f3mhoe7etlEPseDyfQP/WNRc5s2bKUyL5n
	onMN6UOvEs3SCDaQLgRIotCYfrUE1fHpYSyxy9rvRL0d6s4cTOMsCNZ6/h/0ng==
X-Gm-Gg: ATEYQzzM1c+LGz6FjRGO6bfJIlBfceOmcsW370QmEhq0f6siO2IyiVPN7sIhERXyaKu
	+aYPo19czjY2xW20nzGBVOZJVXuj5hNos7zgfQQP22Ygtynv4Zbh+IVmdnI83fd0rd4LQAoLAGM
	oydsRkr3ji4eKMfA7FiTPZTX46MlgrUIJTUUtgGwygptnvaeALikoZGIJI/xaWQpOB7hzn/GvV4
	lhOAL2NoQYhjVWvXnEfJsligonvKK3skOWt9w2/QOgqEsbS9Fhc7p5xCxgxu+XV8f1tr5gUrqM2
	5MiKeRK5tKbNcMLO941bKgfL1XjmCeCY0MlfspZYYSw6dV7KS2FRaw/0nld5jRmc9YgVpxolXT9
	8UoUDFD3H857SmkfRNF5ah9YnQYSlhSxOSM/S7I3u4zZJzuLVyeAXWlRdPKDrRS7QI9l+VRilZD
	Wh4K4hn4z40gv8fNfw3nqJcOTP//B9JqE/yjELK2eunQ==
X-Received: by 2002:a5d:5d02:0:b0:439:c279:32ee with SMTP id ffacd0b85a97d-439f821b6e4mr3340735f8f.33.1773223502745;
        Wed, 11 Mar 2026 03:05:02 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:02 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 06/27] serial: sh-sci: Sort include files alphabetically
Date: Wed, 11 Mar 2026 10:04:25 +0000
Message-ID: <20260311100458.162447-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22252

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 8e2c0a9f12edb7f05b3b60f02e03dc319ba7ccbf ]

Sort the include lines alphabetically, no impact on code behavior.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251023104313.210989-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index caa98b1257d4..ceb16b964f63 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -19,11 +19,11 @@
 
 #include <linux/clk.h>
 #include <linux/console.h>
-#include <linux/ctype.h>
 #include <linux/cpufreq.h>
+#include <linux/ctype.h>
 #include <linux/delay.h>
-#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -32,8 +32,8 @@
 #include <linux/ktime.h>
 #include <linux/major.h>
 #include <linux/minmax.h>
-#include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -50,14 +50,14 @@
 #include <linux/tty_flip.h>
 
 #ifdef CONFIG_SUPERH
-#include <asm/sh_bios.h>
 #include <asm/platform_early.h>
+#include <asm/sh_bios.h>
 #endif
 
 #include "rsci.h"
 #include "serial_mctrl_gpio.h"
-#include "sh-sci.h"
 #include "sh-sci-common.h"
+#include "sh-sci.h"
 
 #define SCIx_IRQ_IS_MUXED(port)			\
 	((port)->irqs[SCIx_ERI_IRQ] ==	\
-- 
2.43.0


