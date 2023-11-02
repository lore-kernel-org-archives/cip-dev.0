Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D740FC4167D
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 06:40:25 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.25138.1698907220641969596
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Nov 2023 23:40:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=XmCyWFHc;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.54, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50797cf5b69so579293e87.2
        for <cip-dev@lists.cip-project.org>; Wed, 01 Nov 2023 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1698907218; x=1699512018; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OtjjEsPBzH4g9G9vhz8T3f5p4gy2wlHuNVcbV8WsIYc=;
        b=XmCyWFHcxerfSL7yFxvZYc0NOLxPBEZuIHyixY5n2FXH4QKJ3ESMHnELLFpxo2m2qo
         gFeOQzfCNa7O81Q57JH0JWPf48Tq7N6OchUH4kEoC4xRIaS5T2dIzzWHa+Aln9ofRyPd
         f9siRqypS61GgvuAGxYLiAjHifIikRAzoZHhJu4Wb7Bp1ISs1xLDXvkyYu5gVQytMFZM
         8aVs2DpPxQL6w4RXSWDeT0hI+s4JcKV6P7ZmKKrx+SxSmXG8I3wa45MY37SrD9pSb80E
         VdgmEVfQTDF6j2F4r1VFGB5ZnUf3aYT34SnNbXGDcZ67BEGSZbOETdZFd4+W4oKC56FG
         +WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698907218; x=1699512018;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtjjEsPBzH4g9G9vhz8T3f5p4gy2wlHuNVcbV8WsIYc=;
        b=KTAplibwHeOrlFmkUrD0x9eIuTrcRoWilMbASTj/3n+NM15fl2lDzEURxQs8QOjygz
         Pp2AJ4jBOGCODqvu8Jaq8mmdOGVTNFnp/qKeASznGGtypnNBesIxwKLQM8fkGwzxnZXJ
         EEJHD6KaOLBq8tWDoaV/sOWCcPGFsPcyq6XNl1048k0WkxRkP3A54AfCvGl/7q5gt13c
         Pykkyrw4o/fJ/iBbmZi6IrQCak2AtLhCtqtu1J3SBqTTJ1liRCBKEoMYugLeJlcdLtsx
         9h9C9T3Lqq9jb2bef31dN2C97s2o6Ren1h9z8ihctiZ3BnfTg9Ak/MnYv3lOpX9/7+C5
         Sp+w==
X-Gm-Message-State: AOJu0YzBKIpuUcMwtXiN2R1Bdkl1lCXDMCAg8gUKIJLiZhpk5YK4quVn
	VNG0bailP8F/yhrQd+H1PCAQtMSsN+1ep6kAxlETjQGjnL7Yx3Q=
X-Google-Smtp-Source: AGHT+IGtYUcWUHq21m51qrGgjKYNzoN37ezSRFWbDAhLpB1uXWrcFjPHL/J3aXn82rWC8SGA6vFJK5j7EkWq+JKQAYo=
X-Received: by 2002:a05:6512:5c8:b0:509:4a02:1205 with SMTP id
 o8-20020a05651205c800b005094a021205mr618588lfo.46.1698907218249; Wed, 01 Nov
 2023 23:40:18 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Thu, 2 Nov 2023 15:39:30 +0900
Message-ID: <CANgtXuPWJaz5HpkgLTG2JQ+T-mEZdq5aj3JYBQiR2K2nPBjDBg@mail.gmail.com>
Subject: IRC meeting today
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 06:40:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13510

Hello,

sorry,
I cannot attend today IRC meeting.

Thanks,
Arisu

