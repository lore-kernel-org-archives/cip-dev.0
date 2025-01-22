Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BB4C02181
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 01:28:07 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.39224.1737537415331206953
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 01:16:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fairphone.com header.s=fair header.b=ulrEBFuI;
 spf=pass (domain: fairphone.com, ip: 209.85.208.52, mailfrom: luca.weiss@fairphone.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso12695008a12.0
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 01:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1737537413; x=1738142213; darn=lists.cip-project.org;
        h=to:from:subject:cc:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyPMAZe0rhsRz/noQKlXeptu6joiwMOpmTKMMVF7C/w=;
        b=ulrEBFuI0GpmjRTZDjvVZP3ZOe7wh+cdQB1x9X6FmjLOETGCUiMEThKzFM1WO+/B/y
         PwtYhogU5+rqiobTqKm5Oj4GsEe8iYBAPqwjJHgyLYiuKF/Zcf2amLgatCDuDc8x3Izv
         POV/ENKyRDNuLQBElgRdKNqVTUsmwfxPBLFoxMLfF6VSnmKtahJQ+1lUwgPIjbevPWFc
         5shOIbiFaSfNCWBCrb66kmv8Js5gkvuiX0BdZs6wEooSBcxqMr9BQ85voaltyWyQzH1M
         9R+6ARNSYAYU/Se5CnJbZkyWQvBHSqhxVsgGempht3cCZXqP6eJeLOSWYwuhocBYzpq7
         UC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737537413; x=1738142213;
        h=to:from:subject:cc:message-id:date:content-transfer-encoding
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyPMAZe0rhsRz/noQKlXeptu6joiwMOpmTKMMVF7C/w=;
        b=E7SchYxy0YwQIoufvxeivIrPHIq1FC0SS72FLX8iPWP7lzhPnFmNStQ/hDt/0bmVvS
         W6K3kOfKdwsVY5m59l4twRhMzcWmue5gZC58l/U2jafWrUpfUeAovEmeHNu2ZkYiW8vl
         qLjZ4MwH2U/QNvi5YXTYN0xt8Z5hSiL+yUahLL4n/vXxDzbsYLTSrbzEHQkEs8RuvT79
         XgRLRabMQ3IQ6D99sVQCGWXE6aKk81ihyzWT1N6hrQyWD4BTBQuYJNBxXRfflVBkViu7
         53aqjIt7Sx6M+f+Sc5qDfjndt3uD3lcHBO9kOrNAQfAaNcbRAxC+iWKEeg9STVsh6aqQ
         RCIw==
X-Gm-Message-State: AOJu0Yw9bZB7/DxHSGwrhmqT9C8ixhYXowF+yE+0+b3apgf3B6rHZsK1
	lt2g7Bhn3vi41qVLrQk5Iyhx6MJonRwSYOvNlWZwmPg3PwC29tj7BjRhod1qPGN/8fj6yzufheb
	I
X-Gm-Gg: ASbGncsYKGhn5gLBL9eMhCFBuc8T8ExQiK0Uj1wrj62iW4I/joui2sGZwhPIKn3t6TG
	spac9NYjrdsfsYpf1PnBG0kMzmlxWDHb75KRP2a98yfNGVGjiMrOKqxVklxlL6rotrJ8MURp8pg
	zh+Wn2rGNC+zJ+85jZMTZEfZRLNA7qXtfXXq449aedSV+j2TXRJ8gHZrZDEOG66xcupzPJPnJFV
	Tcxm0i0a5FKAp2Jwj2PZt7QTIL2RFqaYC3EKkpO124Sv3D2swJdNLqTictfobqxB0nZ/fc7l8vI
	s4jzV01GmP0JONPamTAUktd/ZBgoiFFJO88WRgU=
X-Google-Smtp-Source: AGHT+IFALkr/D1qFkzYD9YIFRawbaBpY+lRMJDbL8YaV6rKxofRoEJLpTcI4WlsZ/GPkkWrkrs1kDQ==
X-Received: by 2002:a17:906:3c5:b0:ab6:52d6:7bf3 with SMTP id a640c23a62f3a-ab652d67c6cmr175539566b.54.1737537413306;
        Wed, 22 Jan 2025 01:16:53 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fccf7dsm886316366b.171.2025.01.22.01.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 01:16:53 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 22 Jan 2025 10:16:52 +0100
Message-Id: <D78HLVUGEZ2B.19ENWIOOSFW5A@fairphone.com>
Cc: <karsten@fairphone.com>
Subject: Questions about SLTS v4.19
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: <cip-dev@lists.cip-project.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 01:28:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17600

Hi,

I've got some questions regarding the SLTS v4.19 tree which I couldn't
find an answer to on the website.

As Fairphone, one of our Android devices, Fairphone 4 is running on a
4.19 kernel fork which was provided by Qualcomm. Unfortunately
linux-stable support has run out and while we're looking into upgrading
the kernel to a newer version, for now we're stuck with 4.19.

Since CIP will continue maintaining the 4.19 kernel for the foreseeable
future, we were thinking about starting to merge the v4.19 CIP releases
into our tree, and continuing to do that for the foreseable future.

But it's not clear to me what is actually in scope for the 4.19 branch.
At
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaint=
enance
I see the text "For the 4.4 branch, the architectures we've committed to
so far are arm (32-bit) and x86_64." but no info about 4.19, whether
arm64 will be included, which is what our device is running on.

And also while we're not a CIP member we'd like to know whether we can
consider the CIP branches to be reasonably equivalent to the
linux-stable branches, for example where we can assume that all known
(security) issues will be getting the fixes backported, or how else it
might differ from regular LTS.

Regards
Luca

