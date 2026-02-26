Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E4BFCE08C
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:33:53 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78740.1772134431416919967
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:33:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cduALuwO;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483a233819aso12787705e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134429; x=1772739229; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAW1lrZEcsfxRk4nrIblNG2fztFZ6WPjgeNimJlBTH0=;
        b=cduALuwODpWTcU9lEUPmoiaTDnAa+EEeJLmLKxEbppWMMr92QscAcmaCE5Uzxr4KLf
         oMkAB4LK6n311djYVtFqo86DARnzScTRYliSRYULDY3db10lrTGBuiH54/5ey7e9qvE7
         Vp8jcrQ1ZAX4IscNukJtdT5o9NFTOwHFjmnhuQrZ8wLnyYqa4IqmPHDZTxZ4njv4N97B
         jwWo4qS02DkJ79W0DPvyUy1oyL09n5uGTP7CIegPH7LL7bJdT2fvSikrYz2TTSHAiEjd
         /yhJBe64/Arq+MsoPBUzazpn3iLN/gpZgi8RFzbNyO5LUvm+DVb0MGtI1Djsxn6bwZlX
         p3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134429; x=1772739229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAW1lrZEcsfxRk4nrIblNG2fztFZ6WPjgeNimJlBTH0=;
        b=o0igeIZb7GV+8N+V9HmCM244ACgl6k92HiXdJ3tYFzyN1nMAVq9RIxnXGTYWWdxwVG
         vC72FOc76DZFiXOcEmaPeuon44w2CasykMRr+PDiaIzpnTqY4RUdjoyH57vhZVdRbDop
         +dbYb1Db7fbIwZIwq2kVOywqyXuDiuDqKf4erp3gmAgJKH+k4qHS6H6+FMOaCKOZnuTG
         MK16ocEWPrcuH6G7d67VkWIakgh/FDrc+qMxfKPv1YhTtvEvZH7x36WRnqQSFPEeXbye
         JZ1Snrodw/ae1bAevVcp9AkjOR5dcRKb8NQ3E/xDAAHhIWbIFF43TvQKVZXVq627+Xep
         heZg==
X-Gm-Message-State: AOJu0Yxsf8uLD/Wz6JFvY4MrBo9wUhlXDEjUl0YIVdZbQRSonxP9DGkK
	JduXr7g5rj1MSwVWwU2Gix0Q6Y7PCSZwuYQGDYkwmSNDbemf4I1mDSXToxqmR2BM
X-Gm-Gg: ATEYQzwo7PXfQg3WqkscCKXgbkvqhesZbLlMFoXiO1jjPLJFPX9IGo9H5FkY3X/r/Pi
	iF8KtL+PdXNRr7yhNFAdYhXb4nIgxe5htUBrTI3QoqYCmVjNow6xbMj+tfSkZ1CdydIs7OfHCDS
	i4ACz4dT+mHyS3BTrISDIzb89LgQWPVBlyCXDnNj08qJV6i7wCGRDFhyRS8U1u53yM71RCe+xts
	Xfz7cBAGncib9UBwMdz3xFGjWcQYAHtuUAGThEOt25Iby4R2EkgPaINBOVHqky7ZKr6x0PHkNLC
	sQz5TgkTVMnSlLlOvZhux3dXNNwGLDWChNodh3JMfrzKiFgKHRyPvul6ltEbnGqHephlAehYl+q
	9khlrZIoaNOLDUPmOu9ufvVGkN8Ptgo4VXGYHmZE/1ngBU7cXTCLQvA0JZZNy0SpL3psdMckFYa
	p1bd4GJrySqqrJ+IxR+0S+rYn7DFalkc2DaYs4Ku9iACEcP6I=
X-Received: by 2002:a05:600c:468b:b0:483:c35d:367f with SMTP id 5b1f17b1804b1-483c3dd6fd2mr60987695e9.21.1772134429333;
        Thu, 26 Feb 2026 11:33:49 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm167721555e9.14.2026.02.26.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:33:48 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/8] RZ/G2L SSI Improvements
Date: Thu, 26 Feb 2026 19:33:24 +0000
Message-ID: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:33:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22002

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for 24, 32 bit sample format width. Also fix
channel swap issue.

patch#1  fixes 2 issue
1) ktime_get related kernel warning during ostm driver suspend 
2) Fullduplex testing triggers an error:
   rz-ssi-pcm-audio 10049c00.ssi: timeout waiting for SSI idle errors

Biju Das (7):
  ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
  ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width
  ASoC: renesas: rz-ssi: Use dev variable in probe()
  ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
  ASoC: renesas: rz-ssi: Move DMA configuration
  ASoC: renesas: rz-ssi: Add support for 24 bits sample width
  ASoC: renesas: rz-ssi: Add support for 32 bits sample width

Geert Uytterhoeven (1):
  iopoll: Do not use timekeeping in read_poll_timeout_atomic()

 include/linux/iopoll.h |  22 +++--
 sound/soc/sh/rz-ssi.c  | 183 ++++++++++++++++++++++++++++-------------
 2 files changed, 141 insertions(+), 64 deletions(-)

-- 
2.43.0


