Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F989FD707E
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:34 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73428.1773746244215593391
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=N8sJyQDx;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-485345e1013so4917885e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746242; x=1774351042; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neDyEnfGzLN6aOmdEsxpNoC4lIC0/W/5MuHgIu8DWtc=;
        b=N8sJyQDxMP4pSwQAQinY7QXfMho4bkU3UN9HiMo5Xl6HbPJcP/BBp7yTbX2jCXywwH
         gwhC1PseEiF9s9ov/hN3abIuOSJQCKyOGjZ407EhUWqMtLuOD5xdZEKrGDfm40RgUYg0
         h3soLjg0xtY2QcdcTJLXlg+aH+ChMCvi6ksT3W48yplE+mRM8+YkmRnCW3Mp1JurnwxU
         Z7v3T+a76ufUxdn2KMHrCsSHkUdYN1GxWKTkSoKzL10eONtffgtUu+cYEHk+6aw8ljkI
         ybKQCdFsb3wRn2gD0jSUYNfgUkiiO3XWFfAmXQOFuQBH3di8iBHE5/31Osws1XqaPVXL
         vV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746242; x=1774351042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=neDyEnfGzLN6aOmdEsxpNoC4lIC0/W/5MuHgIu8DWtc=;
        b=ZcZKfPuWqL2rF3rsi+Zu05Sv4FfYKOByEfw8dhuCXzQX2gGRZCXQNq1jLrJXriAfn+
         8GYv+aoy59VeT/7VBHH+v2ogYmi0Od2dUQcUsoOCqw+qw7FhUm2eS38Zk91SMbVoGYGo
         TkQuiOKbSWl4aNgvshkATEBIjhi1FQtn4OOIUYOwlFPf2tdtUAjl+DCoZimLq22juEa7
         zpdyGFXkFrlrcP0+bk/6bMXjVIohtdF7xvq2MRvH80mcO3ss6jpf0OBgzkLNLCIv85PS
         G/XNi8UBowbJkHLZjO6s93xFgNtBzUV++2xUNT6/ImkxM2ypGWORo98QR9cyZhK6QXdk
         I3Hw==
X-Gm-Message-State: AOJu0YwdESNqM0RbHEfnMOy+MWiLMjziEruMBrk9lep4A+Q5GG7aR4Nx
	IYYxPhtjgGsKMK86apXD6QjBz2sYcsZLccJ7IoYkSr/NQkyt+3n1oJcfztp5NA==
X-Gm-Gg: ATEYQzwEvJ6LKwjw70ZLGypKUNbslyrCRklsQpUHToRULhXitASeS1v/7zAUIXhAFVd
	TuYrhfuXWVNc+UA5EhF2nz1rAm0EYI8iUk/3x2rnvjDANc6PfFZyP2mr3mZYnewWGaj0loC2iU7
	NazhPxaCC46gzdwqhaw+CWNvLls6z8i/niz0NqDTE0hyF719eRvMp/wUQ5xxVtj/76r0ZP/buqB
	PDGYBjHZH8MsCjYJgJcb42NZA8fUUQM4Pf8avgcH4dHe2ZVEDrrNOeARuJDWn6IVDayEsMv1QyZ
	DEnJUIADeNNZ4xHtc6KDGYXxb9pODyys9TcEK5SO6bIcZp2fxa/v4KJ43x4crUa4YX2vFqwK7tI
	SkNgkjDmQp3/4SiLbC1aNDaB1h0hMzaaaGJLdA/ZNbQG6Qj7jgB5CCEcqrrEHT5ORcmzSWFhCsx
	iZ3z0bNFh82UkPHg3n4XMBuUPrem5QnbYn9D8X9kSISRGyOoVh
X-Received: by 2002:a05:600c:630f:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-4856eacf5c6mr47660155e9.12.1773746242065;
        Tue, 17 Mar 2026 04:17:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:21 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/39] serial: sh-sci: mark OF related data as maybe unused
Date: Tue, 17 Mar 2026 11:16:28 +0000
Message-ID: <20260317111718.281633-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22436

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 88dcd07d27d1873810cd8423238f3ce4e9bd0bfc ]

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/tty/serial/sh-sci.c:3144:34: error: ‘of_sci_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230310222957.315848-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3ad2c06ff45f..670e866dca13 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3282,7 +3282,7 @@ static int sci_remove(struct platform_device *dev)
 #define SCI_OF_TYPE(data)		((unsigned long)(data) >> 16)
 #define SCI_OF_REGTYPE(data)		((unsigned long)(data) & 0xffff)
 
-static const struct of_device_id of_sci_match[] = {
+static const struct of_device_id of_sci_match[] __maybe_unused = {
 	/* SoC-specific types */
 	{
 		.compatible = "renesas,scif-r7s72100",
-- 
2.43.0


