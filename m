Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B8CC4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 09:47:21 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web11.14463.1713865631669914588
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Apr 2024 02:47:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=vBWqeWmI;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.170, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dd615b6c44so27200211fa.0
        for <cip-dev@lists.cip-project.org>; Tue, 23 Apr 2024 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1713865630; x=1714470430; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t+tf5YQgw6ZONBuUgig0jplBJsr4/Zzpj/O0Kty8Sjw=;
        b=vBWqeWmIFG3/T1mB3iRcXNjA4SA6OX2Uzc+5+f9QNPiAZfKyRtMYrgJbuYMasp8tW1
         NU5A2b7IYAIdUpP4fg9+1ZQqq7iWdPymLEY7Nc3MtfQT80ZbJbzHBQ7vA+5s9pfFAWDC
         JrTQ4bRqjyRFqMMcgLYyHc73bsiOAnNPT5HD4PEfF4rFEv/g+y9UUgAnb+XhlINVSPA6
         4FNJpdix3cnGO4aNK3SzQrLPKeju07/zqW3jqHmgJTr8dVlxk+Rv+p1//KQ0i1ixuHda
         846/18WdwQ21OcaLMAyNWOsc1AiDHYiFqLtJHFhpd4pnpu9bmk3zAWkGosdtRmP3rPbO
         jUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713865630; x=1714470430;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+tf5YQgw6ZONBuUgig0jplBJsr4/Zzpj/O0Kty8Sjw=;
        b=YsOCHwMiqYoZipF8FTAQyPitfSF+ktclpAlFoirBlP4hA2Gd4uXLPCKHVhcL3HzQKq
         APRnCk7EDugJ6qN9D5py5zRiojuJfoXsRCt64LqSbsFek9Zk6qi+j82EvIpRB5zZRxgf
         VDsey5Z1LlVkfDLjq1HsghWSIWOiilKC+0Gah2m0s6nTf9hTniZiiU0MU4SBKRGlwhCn
         DpPm+Ul7AYbeeKuda3y/bNEdXYpHOlIh7ZUNxpZhpWlQJhl3S023X4DBTWtgZ1e1sVmW
         XCDUb0yAU8nWphIU+nbyGqXeoW0rf6+sKSZvou5yu5hlSUPG0GfcCEagCO3N14J4nuXf
         R59g==
X-Gm-Message-State: AOJu0Yws3x2/8hWW8uKo23XNRvEqlPsN325XZ/8pIYvPKHZ1oJ9Uv2Qk
	cdUVdCrTHtqujDJiOJvoG1kOZYdsY83JGdsA5vZw7xc+JlByiIOLyBpI9E2Z2I6IPr3/00cUXja
	ayCmBox2YVkx80UIZqO47qP+eUvEJ3u5qr3E4IBuszk1ZwuY1zg==
X-Google-Smtp-Source: AGHT+IHZcbP3OI3PWMx6lNCeGvYINa/+2ZrxbYoxoo4qU+3T9wGpfKRa5jSiT8Nvz2mfkdQC6YRkECr2QKBcHmbtubw=
X-Received: by 2002:a05:651c:218:b0:2dd:985d:9915 with SMTP id
 y24-20020a05651c021800b002dd985d9915mr3312649ljn.53.1713865629360; Tue, 23
 Apr 2024 02:47:09 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Tue, 23 Apr 2024 18:46:34 +0900
Message-ID: <CANgtXuNLYu8rLdndC5ogzi+v5Rqwk51MvVey=MtuYKBbiXR5=w@mail.gmail.com>
Subject: [cip-dev] IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Apr 2024 09:47:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15732

Hello

for personal reasons,
I will not attend May 2nd IRC meeting.

Thanks,
Arisu

