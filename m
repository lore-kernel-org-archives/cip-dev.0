Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82C8C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:41:29 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web11.162360.1692196882783860272
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:41:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=tkjjJ90x;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.171, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so105579181fa.3
        for <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1692196881; x=1692801681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I2REtd7MvXwCGquT/4zncz5Av83gnL0oeOn2jitzzWI=;
        b=tkjjJ90xboSe9ynqkjJ3mB22pvADFO2MqhIqukzcjqOzUD/f2RjYHhDGTivsAWJRrF
         +y66EYVADHYlLHvsdpUx/11ei894ibCXLTiifAzBwsNkkp0B+LHDOfP7mYZ3K5pW1usO
         rkVVI64x6D19Q8Ig0qfLgjk2RtIK/tJpV9wLHvlLn1oziYcQNdsPUN/RmShZ1c88hiZ3
         D3autnlUNE3zA1L263z8/MW5etLz86gMxiNXGO5ERhWBCTB9ohPMUKh8JOfqHvlkjHr1
         RAKdLAzixVDdiR20buwjQKuq9kVKV0tJdz0Z1HOETwUF47XzDrnIPh1B9Jwe75LqwmAy
         GVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692196881; x=1692801681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2REtd7MvXwCGquT/4zncz5Av83gnL0oeOn2jitzzWI=;
        b=E94P6Bmua6FuSFPSx64K5/5G38ySc6S9oLBhOO0ahW99dqSlOVJKfgMbQWRpwXCuPu
         SOLI7GVxzMMxGDInXZ20hFV4dfx75XBooGx3P0TRXfBa2dbYpBppnPIXqhvTCWcOXS80
         Pn9xuPb7pUcMBYBBCwpTWxksHPvgNAec/95NqfScHo/le8P7vndoWDXMttD+akgyU+GQ
         O4k9BbUg2tfHZEAuMRNYrBg20nZHW40dCTM5MawLz8oUN2StPCASoTtjHOQZHFcUCibc
         HYiL3Yxgoxixmw6uQ9FehIJEQjakgxtgA30AKvT7rGW405bn7P9zj0gjc36xaWNW4n/r
         kdKw==
X-Gm-Message-State: AOJu0YxwUXC5Gat1rqOufSYUCxmnS9leO9U7P9iOkzBBo4svwX2hlSTu
	2Pw+lJRdrS/ccgJS7uqrMU2E+skFuLe7RcuSjOJ9
X-Google-Smtp-Source: AGHT+IEHCW8H3Cbx8B1eWy4cUfPcVoh0Eg4Na8AJHVTuZqo3dNoUku9/JEVPlAxeMRO0qnaQwQ8GhfMAt4aexD6zKs4=
X-Received: by 2002:a2e:9141:0:b0:2b8:4100:b565 with SMTP id
 q1-20020a2e9141000000b002b84100b565mr1927494ljg.15.1692196880786; Wed, 16 Aug
 2023 07:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230816080300.5559-1-arisu.tachibana@miraclelinux.com> <e4fb5477-18a7-4c65-9caa-4d647dae6a07@siemens.com>
In-Reply-To: <e4fb5477-18a7-4c65-9caa-4d647dae6a07@siemens.com>
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Wed, 16 Aug 2023 23:40:39 +0900
Message-ID: <CANgtXuP_=UBMwaVu2UOwnzmJpQPJdsJh2tJKqDP3LCoWy_Hbkg@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH] .gitlab-ci: Create amd64 release
 variations for KernelCI
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:41:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12731

> Happy to add that - just wondering if adding those two targets may allow
> dropping one or two others which are implicitly covered by this now. Did
> you check that as well?
>

sorry, I'm not sure of the meaning of your question.
could you explain it better? what are you willing to drop?

