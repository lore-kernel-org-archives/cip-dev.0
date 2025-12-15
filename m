Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9A7D5B16F
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:53:25 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47617.1765803199667893690
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 04:53:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IQ2UxTJW;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb3801f7eso1661505f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 04:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765803198; x=1766407998; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFpN1Fcgl0fqXLmrb7UUHVPeZqTzvyHJvB+sneVzmAM=;
        b=IQ2UxTJWfrp/TxNENL+KJsXLB7sF3Q8dzHGj0qBRMN09NoUVyvIQIROHWeWXtq8ooi
         qCZ8lneP1AFYu4jrz+sfxmPTe7pEfbnApu7jZyEmrfCAxtuwWsN5c8Fagu/zZAQzyniw
         0dvz10f3CjZEswzGS83iZusiTvPjBBm+FRZ7Tq2Aw/34bM+crM/4oJj+3IIjJStfp2nU
         jhn+1J7yg6/aTwVfpIkV+FNR5q4FbOMgrYeZn0gxE8IYzYQzxWj1hX7GjSUCFCK3wV5l
         J/AWs4d7rv4GEN+6BvDYVZkCdU+syfpLFoded26b0YzNUTE8xfCxyyBeha0BzRVh2Hj7
         QdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765803198; x=1766407998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFpN1Fcgl0fqXLmrb7UUHVPeZqTzvyHJvB+sneVzmAM=;
        b=g0ePk37a6TObHOIbXwf2vGiQCbl6QLeMmGuFRPYKFc6YbpsNPuSssxlrYCtVX629s1
         Gx43a9zs9V05TjjO0hi2ZsuVr6QvYcdE612Tp5jIc20tPXOal5ntGXmIBL9Jgl+nqEfJ
         FjqUTWGt45OM9b/YrcDDRzRlSTcqZE7KJuJ2xHohMkq9hgVm1wGYS4r2KQDhwK0nUnH+
         wNS+EkDtIsLuQta0qxH12VzQPNFo20wXDZQw9qOSSG0ABoTuCVIuBUhRjxeriPS/3t/o
         anTwHap562EgWsfsZGywfDxZzlG2ikT7GPhk16BvIZwna+2CJ/zrwhh40QCqTb0De3xS
         2T5Q==
X-Gm-Message-State: AOJu0Yxn7ltMj7MViJfhZeMQC7+MruPUEFWO3Abc354A8HFwGikpx0dX
	JLiVWyTAurxtvV3073qSUb67+DFCNKXBkS96wZdiw1Ehie4zEKoBpl/KF9nfKg==
X-Gm-Gg: AY/fxX6zFzGqkhYOFNvNEHaBVU8U0oSxN9sWRhrzfmWVudf8wFNuehtZBMPTcueeF/r
	fheeOMgQwCjniOfIDzidZ4AsKYAQzgl3dTZtiMfAylnFlnhIFHTL64Gk6rh8DtXm5t1bvU7vTr2
	8NtMg/26Ake4HSnl8EgyCCcD7SXSMvZIO3SQGBek7Qy3QSF4Q0JoudGu17NfbrxMUuIqfi8FMLn
	DP+NuMJnROkXurIx2VaayEEiK1+CTLs/Ybq/nNYuOkSod4RtWfB3Gaob8NR432FlZN7YbS91Bv1
	alKGONhotsPN85dCg1Qv5tTYTXim4+kvMNJeQhqURp3Blg5+xJbpP/x18fTzbBTZjcZFdAvWCwd
	L7xU/PGB7hiYRUWyjEz3i3R1ggD6GEF5tzW6Z/MfoTh/ojGk20oj5OjecyLJW+SNuD0bv+GINfX
	YczlXE7qAW0C36nQ8tuBPFwHi3IDTz2kkMids=
X-Google-Smtp-Source: AGHT+IEQzo/G2fkY9QrvuPEQ6U3BHV4YP6BnR0u3C/pulM5YVIZhr03aPMhSDut+B7+IXcSarlAefQ==
X-Received: by 2002:a5d:40c7:0:b0:42f:bc61:d1be with SMTP id ffacd0b85a97d-42fbc61d43fmr7702914f8f.32.1765803197675;
        Mon, 15 Dec 2025 04:53:17 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:73b2:9197:2aa3:716f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f268d459sm13820577f8f.32.2025.12.15.04.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:53:17 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/3] Add 64-bit polling support
Date: Mon, 15 Dec 2025 12:52:59 +0000
Message-ID: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 12:53:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21056

From: Biju Das <biju.das.jz@bp.renesas.com>

As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 bytes.
During testing it is found that, if the DMA buffer is not aligned to 128
bit it fallback to PIO mode. In such cases, 64-bit access is much more
efficient than the current 16-bit.

Biju Das (3):
  mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
  mmc: renesas_sdhi: Enable 64-bit polling mode
  mmc: renesas_sdhi: Replace magic number '0xff' in
    renesas_sdhi_set_clock()

 drivers/mmc/host/renesas_sdhi_core.c          |  2 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 drivers/mmc/host/tmio_mmc.h                   | 15 +++++++++
 drivers/mmc/host/tmio_mmc_core.c              | 33 +++++++++++++++++++
 include/linux/mfd/tmio.h                      |  3 ++
 5 files changed, 54 insertions(+), 2 deletions(-)

-- 
2.43.0


