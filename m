Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA279D462D3
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 16:27:02 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.15652.1731515220170973581
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Nov 2024 08:27:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=0w2N6ztr;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.174, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72410cc7be9so6285369b3a.0
        for <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 08:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1731515219; x=1732120019; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/owQvRID5HYH+toNSXIOwjjv0wE2Jc/jBp3GLwxB9Jw=;
        b=0w2N6ztr9vXvFox6NXfE68jWSXNAT38W95NuoIQdN49Tm6ICCgL+6pJI7bzCbINYVK
         33SsTUmdTihliAcxptBlz+mqXxtF5JUhPxPlQcXuco747qFKWJxt8AlNZIwLczHrseMs
         n2d42PAuAksWUvmN5q5Z+i/VrsT5NxdRvZ5QmBt6oXeAAezuTykX3uNj6Em/T8iRYJxH
         BmSTLtHExvDw2d8j7CBQDxUN+ZkdM3Qb8Lkm6DOTXGvC0jyBODzp9dSNRmsWIhyQAtMt
         MTOHFNyy2ygYVWt4HZD4YG+hoamczxvA+78y7haLJibKGxNOlKYTgH08eKJ8uu6OgWNA
         RH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515219; x=1732120019;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/owQvRID5HYH+toNSXIOwjjv0wE2Jc/jBp3GLwxB9Jw=;
        b=oYDynGsYusHrkJL96+lw9IRT7hC5FvApGqU8PhvY9d0b97gmLE6GT4eiNoDfXRTbt/
         mkdAA3GhqmANKhlclXfMGCyVeHC36cprVqtLidPTOXPgMkFYAFSWvnTTWQJeX051FbyI
         t5PhsURITfUfFjGBO4v/Z0nc9mJ1rqhb+g94qXdpIM7YdqJSIAVBeXrN0PPOJeC5jGNd
         udGDlZmxv/CDEPQzth7vTDsdlcwX/xHlVyzGPdb9vTzVV35YcX8TimAxhBo4IAPeRYUR
         TtsdRCISs+S1PnWh3Ql7+Z7PtbYU8ZARmCetXYomyRleGFql/yXtqxPYDdKH5oRCNuMq
         +1yQ==
X-Gm-Message-State: AOJu0Yy/jqJS18h24FqUfdbDoFI4nCn4ou+PDkoFPqwGMDaWcB/26V4v
	GjXUr92S0W9hz0Ub9dTyF2FzrQOqlJnRijn3POa/n811p22ObeDG80Y2suQ5sZY8OpP9acVuxBR
	TEnZ4NcPcaj8VOkan6PMNquVlBlW532ujrNkTtYh0cSGXBZCs/Q==
X-Google-Smtp-Source: AGHT+IGzK57vYIDEdgPfrRQfOqDcaqoVYn7f7/0zEAKdAEVuUTuMjV6RQR1OR8S0ie/qiJqdTyzlHiH63s1kJppm7Nc=
X-Received: by 2002:a17:90b:2dcc:b0:2e9:2bef:6552 with SMTP id
 98e67ed59e1d1-2e9b1793d60mr26532367a91.32.1731515219466; Wed, 13 Nov 2024
 08:26:59 -0800 (PST)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Thu, 14 Nov 2024 01:26:23 +0900
Message-ID: <CANgtXuMj3LAc9PNomZ=DXrX-nqRNWUGMGOkskqRY9BNawX5fog@mail.gmail.com>
Subject: IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 16:27:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17247

Hello

for personal reasons,
I will not attend today IRC meeting.

Thanks,
Arisu

