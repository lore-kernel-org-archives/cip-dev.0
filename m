Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D704C47073
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 07:14:16 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web10.6928.1704870849225560282
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jan 2024 23:14:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=o7cClsRt;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.179, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso44714821fa.0
        for <cip-dev@lists.cip-project.org>; Tue, 09 Jan 2024 23:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1704870847; x=1705475647; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fnX8CXPeHcCHf+/J05HtRntHDcia9v3DxiCG1JagpfI=;
        b=o7cClsRtP70DXQkgj4jhYDAZ/2F/E6AkqOHMKLz+/ZovsLW1xdrdn7EKX2zNBEOLLC
         1pRTMEaEsFhZytF0rF92B1c+ZCYrl/KSTIO4oC+TtZllyuK/znWA3HSr6md8dMUmLDPi
         NZroHfQt48nTgX0Q8FvE5fZi9waqfhXkepb/zWuUCukn2K/ZcQHOMiH4wdTH074gXFPc
         zxHf9ACSHCIg0xTcNAXT0HkHM4wp1SXa4fIN3yY3oFSmVqSAlunf40cHiEMma4KVzldS
         iol4YDxQBfO8cPoDSt8H3jH4MmOJnXM8IedrA0KBFCjXlYEJejoINzouT0WxSjUUtNYs
         0AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870847; x=1705475647;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnX8CXPeHcCHf+/J05HtRntHDcia9v3DxiCG1JagpfI=;
        b=dNytLs6yyTKSeR0crxr70+nZKqoPGm0B/s4VIEGyc8L4vbNeRqUxrhc3oXGGBwiqcT
         TxPR44G1Q8Zx+npFaIoi4AVU8yBLUQ32oLUqdrv+Agrs538hl6YUDzzk6v82ayp2tbj6
         f1KVJs+18CYfY990q3W3MY2lk2v4wA3PGhsLwp9uOxRRwmAxFvTxHk+hy427LGC5PeiZ
         /Uad0/rl2iK4E4oqTxBp4m+y1VuGJ7FHPNyVefEllc2NmrbGxgodPKz5qcRxS8r8ZAbb
         us9Cr/cVCXY7kNlGoRv1jm10gveC2AC/PPjplOPyB5v47+1Ou1x1iKTY6aqHHeicxrnB
         CBmg==
X-Gm-Message-State: AOJu0YwRMIAQWCHu6BUOfvicttOF0l+N8Foek1ZKZ8reClHrB2wOStcJ
	9q5jF+Rcefs/+LhJ69MvLlgiV4NIAfWOioDq4931bERBkc8D6ADOawuaRB5yhg==
X-Google-Smtp-Source: AGHT+IHVEf6IImzMh45+7xXjOstgy4bGJTpW/n9GIdgn02EZWdtYaOCw6KSYoC/8Le0OACh+KmD08ZjKbbq60NhIGaM=
X-Received: by 2002:a2e:2404:0:b0:2cc:f1cf:78de with SMTP id
 k4-20020a2e2404000000b002ccf1cf78demr263026ljk.34.1704870846808; Tue, 09 Jan
 2024 23:14:06 -0800 (PST)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Wed, 10 Jan 2024 16:12:45 +0900
Message-ID: <CANgtXuOQr1FV31EhF48oiV3+Ag4pegGrMkKBZLBDQYk8Drawiw@mail.gmail.com>
Subject: IRC meeting tomorrow
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jan 2024 07:14:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14321

Hello

for personal reasons,
I cannot attend tomorrow IRC meeting.

Thanks,
Arisu

