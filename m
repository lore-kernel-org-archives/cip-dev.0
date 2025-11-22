Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56AFCFC527
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 10:51:29 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7109.1763808679395790101
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 02:51:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GBU9cm3p;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so24983025e9.1
        for <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 02:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763808678; x=1764413478; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sV0Ru3GTqO2KWOe8LiOnm/Y136+5KNWPL+nR5ecHa0M=;
        b=GBU9cm3p/j2/mgX+Tssbe+M/BBkD83DOLHOAd5Vv5HU5LV25Ww67Cj9KYXJQUgrjR4
         rOHltWkJRvDLj33+my/o/7Uvo4kcxJtjT350/fLGjNsv14pxjfpdS2pbEC7oUc+rXkBy
         Lya+txyJxF1lSEYfkGwnfMAZi4HxuCxTRlDlVDfb1voTWCnYkvhT8OfRmhtRheAAA3aY
         g2Urs+KWUwp7bMzMcoYld3UVPxBnEOVFZWqwQbdOQbFAf9shJojPZpAN7NicRz/s7AnE
         kH/GsDFuFMhNP+1cj1bwfDSWaK1zbzUbS9PGvTSo2Jp+WPXekCCX+WXAftQPFzbCHYWr
         /XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808678; x=1764413478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV0Ru3GTqO2KWOe8LiOnm/Y136+5KNWPL+nR5ecHa0M=;
        b=HohKmiiC2oiqQ8dhwF5pjpRe9Sl6kztA7oOybDvMkHzXVaJTze1d+QLsj0hg55m6Jx
         ZTncCLwNK0ZsB8XkxCbduTVd3jIQUbYcsldngOiBEo6+Hs7ROvL8SMBFxZ0W22oLAmyE
         j0PtGkf9ReJ2N5b2aj8YOgD06yJKSJGn6bJVVeqVNhu/5xeo8nhAQ5Zu+l61ccia6Xx6
         Aebqlf1eNp2pjphgsh4jRIwleY82csKGZrs+qcvZGFYfgKNel8PdMni3GsPlJarLY5js
         mP7Paoq2zeU+Mtgh4SdcPwWjicfhTGjvUs2Vhv3Zi4FC+MPfWrYwMXmYLimkethAegrM
         FEOA==
X-Forwarded-Encrypted: i=1; AJvYcCWwGREvPwhqyBJmtApH+WLiZQi4Sw0YWqjcSf/XUdahWEtQ1Tlf83RHRVGbryX8TlATmE5HVwEf@lists.cip-project.org
X-Gm-Message-State: AOJu0YzcMTkyrPSI4xcHvPxi9FbvH+whdOko9T/H0txfCILRypRW4B36
	o6cFHzPS+qXD/yW+9Pmw74Yiq+Aiap9eKiMDv8k3T6KBSbW8EYUQdtlkmep0L+HZgZg=
X-Gm-Gg: ASbGnctdqDLGDLBEAhcxtINB43jnAd73WujDYRPOzHe9y0eDsCILkWSrAAcv+Jjf/TU
	36p6y5CaDmJNr+usymo70ZZ3zvEU1EI6BcC4dIChBRcNo9iUuXMTgBtBVn326LUcVARP/6XXdsB
	SIB1hFN4cHnYXLVo3qQjs/ntEou8bncbPrD4m6Pexy2mo/OPs/MwY0fgwTknlgKIv34hrjNhD1j
	hS4V+OGKlgXERUaIkF7thRjRhul/GnQmgPfP/pPtUV1IRS5IF8PRxjdEjZlhzeNhrE6TK77g67e
	D7h3av/47OAcF+4rUMuvOfiWQaWNvmatOXHR1zkj07Es4bgJgU7th3+vvdDp5hNS+OM31NZUWjI
	GiA27b9DkOPPetldvGOFLwpoEtl4wIabJJCI7BZKkR1mLEAaH5haD/8vqktId6ycJOBvHY8fMNd
	Xmt7wZWom9V2SAn7HpaZ9abMrjBQ4/6faVoWWQS95e
X-Google-Smtp-Source: AGHT+IEFADUVRT6RWlXH5XvToaxRerp+/0u4PasFASf/WZFJEjJDrxg4ZzEC3E2xygSjgvuGiMvFjA==
X-Received: by 2002:a05:600c:3110:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-477c01f67d5mr57084365e9.32.1763808677707;
        Sat, 22 Nov 2025 02:51:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf227ae2sm88105385e9.9.2025.11.22.02.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:51:17 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 0/2] ASoC: Renesas: Backport audio fixes
Date: Sat, 22 Nov 2025 12:51:14 +0200
Message-ID: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 10:51:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20687

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports audio fixes necessary for the Renesas RZ/G3S SoC
and the Renesas RZ SMARC Carrier-II board.

Thank you,
Claudiu

Claudiu Beznea (2):
  ASoC: da7213: Use component driver suspend/resume
  ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume

 sound/soc/codecs/da7213.c | 65 ++++++++++++++++++++++++---------------
 sound/soc/codecs/da7213.h |  1 +
 sound/soc/sh/rz-ssi.c     | 25 ++++++++-------
 3 files changed, 54 insertions(+), 37 deletions(-)

-- 
2.43.0


