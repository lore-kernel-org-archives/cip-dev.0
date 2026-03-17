Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E265DF33838
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:45 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73440.1773746257905295764
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=chqzTPA7;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so6828045e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746256; x=1774351056; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In5CWCT/FB8I6DPQ9nD39LOwO6S3UisutMOe/UgEzCM=;
        b=chqzTPA7O6ZmOWccEJA9z1oVcP2hIcR/zaSeaWj1AxFSLEUmX01u3hOxmImFeDMdon
         +qymfor+zg5Xmh8DLDpkQ16aLVQnE9nwjF0kOHKUZ6lmnEfn4Lv4B82yHdzepjyyeiav
         jRCSuGZAB4B1dBZ/1S41BpLAY8JdboUbV/tGj9y03GiEba2IjzoZ1JN76LhrpHmj3QbY
         c3m419KqcXRi4PC1DDZDWDsJnq0/H+H4rRLKUtMX+A4y6tbZW0NIIvfNlL8FDVfjkpSO
         eZc/dLUeNGMf7WxXi7M7a4cRcDiGAsJGhkY+7n+PG1x4CU+3kxVGof+wIu2/5DF1jp/4
         KyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746256; x=1774351056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=In5CWCT/FB8I6DPQ9nD39LOwO6S3UisutMOe/UgEzCM=;
        b=dLkxrmNeQCuedvp9jpqbSKuj3cdr1fPcIEu1C7RXLnq98otOyPN0fdLwz7DReOMB6y
         VOPzylahu1svdOwAZvtsiboPQLBhHeOkoZuwCKCH/nMUfd6upSUeubd9aDpox3sSZH7q
         hQu3WEQHVdQb+LOWle5C78Qj33zu0XF4rFUd+Hdn3F22DHYhXbetMajDY6ClnrqXG0l/
         weUxEeQ88xsdhgcNxEXYXDfOuEpMUSxuKl/nYTUp6TiW9qSxNaoJsgepkpqSn31OL4jM
         VsPFOFlvcQLy1Lb8B0t6vv0IoGiEez2nuAIJhtW5piY7NUiVvttWzqPhpmjoFBVwqk3+
         4LRw==
X-Gm-Message-State: AOJu0YzLmqXMZQ3n02fJrex3l2yKpk0m5xMLL++dLIL58dnszDeJcOgi
	dPlieiD2S92hTS2IjMkT2vul19100/wW8P5szlMHmxBuFXsh4ye8a9DAhZwBSg==
X-Gm-Gg: ATEYQzziIVouqN8IS9FIt3GxtUUCTZ+qxMz4aKhIe4GFaPZRM1FwPQrXw6S0xxLpwb7
	rg44Kidmm4osgklytH3FrDIN6bmEn60rbi7TRZZsM/4XsM3esf9GMl7hl/MElDF7tH2dEXCQtf6
	rsqde0P1L8+3/XbVSNDumeVJ7Swz0m02JNERP/PehWO+BMX7FCb7hgoKbpuukRxiPcoKMzHrRIg
	jjLUMIMc92QcVMq3v7FFAWF8Ozb7PhBmM0QJl6XLRLro+Yn6472OfDiCewinCPM4rlpP+8CJLOT
	IavBZq1fTFCFz37HdwkrSuRa5ySsEmB+y8zt9NUi7BwZsSLWoyj9Ez/Vs94Zfu4zHPMLrL1b3rZ
	ebQNXTzE30cMDMEPYPRp4BvL2nCPFpXRba7mUJa12TIhieC2kyWhbzMZ2+YQBvtv/54wDzIESr/
	8VTx+3cdBvkxPClkYfSJPI0Pky/rkLBWumR9xD1BP3ig1cVJKesZWLuIdPnfc=
X-Received: by 2002:a05:600c:4f8f:b0:485:40c6:f507 with SMTP id 5b1f17b1804b1-48556711c6cmr300381245e9.30.1773746255784;
        Tue, 17 Mar 2026 04:17:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:35 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 20/39] serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
Date: Tue, 17 Mar 2026 11:16:45 +0000
Message-ID: <20260317111718.281633-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22453

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 3a3ab10245b6779e32114bc70052ec7a8a380152 ]

The RZ/T2H RSCI has 16-stage FIFO. Like other SoCs, set the default
rx_trigger as the fifosize.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-3-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 398f6518ff28..02284def0a35 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3338,7 +3338,7 @@ static int sci_init_single(struct platform_device *dev,
 			sci_port->rx_trigger = 8;
 		break;
 	case SCI_PORT_RSCI:
-		sci_port->rx_trigger = 15;
+		sci_port->rx_trigger = 16;
 		break;
 	default:
 		sci_port->rx_trigger = 1;
-- 
2.43.0


