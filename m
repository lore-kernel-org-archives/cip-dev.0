Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A791E7716D
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 02:36:50 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.1864.1733366200259279629
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Dec 2024 18:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=zyj8LXc4;
 spf=pass (domain: miraclelinux.com, ip: 209.85.216.47, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso334099a91.3
        for <cip-dev@lists.cip-project.org>; Wed, 04 Dec 2024 18:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1733366199; x=1733970999; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/owQvRID5HYH+toNSXIOwjjv0wE2Jc/jBp3GLwxB9Jw=;
        b=zyj8LXc40Mo4ehsWblTg9HzOYP7d4B26dA7tS+h/tF/Gdlb5ZVVZy0UtSSafj/uTUb
         HaWvWWTqWcMq3nT+ZP3hC+a95RfAzlSHCeKZVMsXHiAaQ8MTqsNufpScg6QrJLhC+71p
         sd4De9KCMKO2330B1h65VG4Pur+Jajk/jqMZY6mBGUdaitPoGa7U4QKIT1CQ4+YX3IX2
         oM9atg8TjdS5C/t7O/is8DtH19wtW22F4VQu/f8JwVmIWT5xg0lvAN/2jM79m6rkHGcY
         cFCixWKOdZWMK50lGTCZsGLb0pgbRJY0NedY7J68YjgAb1h6ivQKvh3VTTTNchNRpA/w
         3B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733366199; x=1733970999;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/owQvRID5HYH+toNSXIOwjjv0wE2Jc/jBp3GLwxB9Jw=;
        b=NOLbwtsvJ7Uff7+SGPHUObdfoMJe133U9lr4fMROgBOUZBzUD3wpARxAkQ3/4IMEZI
         6WPBk+TtPkYWQkZVpy1ALsaxBiYA385ry2vf7ra945Bv1QH6E+qtceSwpehzfChiZAwq
         KwEQ/WwQM+SD/MSujvuSlTTKNZ8aQmWbBmYi4b2kyypl86zP5VLuVGBmOTe6GUgIAowx
         d9fZA1YHNLRaFYFASJwbG5ZTtbReS4cbiidbhiQqwIxheY2rmVVqNYfkmPcOUreH0KdH
         2qkJ19POoYM0vyJVa2mBqvkN005dVbjDWY0KqNNwGyJsJsbl4JLMZFI/vmi6QPZsbnoI
         O65g==
X-Gm-Message-State: AOJu0YxcuxKK0g/37n+MPHEPFI2INIZdRKThe6iWDq7b3rp6VZlO1Lc2
	E+86efMbDPjdyay4RiPURTupVArZ4CuP/Bev6dc5dgagP6v7a6+CTMJu0IM6d5ZWTsJSkuvEjt+
	P5UqEnIP4VCuFh6wEtmV4e8Q3M2MUHC8L/Q+nHntp6LhLUX69kA==
X-Gm-Gg: ASbGncuCexvgjmeXfddoFagXcdSlC2DzK5ONarksgtrhUYOUnwU5MLYlqoTjGwVkWy2
	xIHfs2baCqkoUQ+pdWYat2lJRehpnb5A=
X-Google-Smtp-Source: AGHT+IFH5Z7cpAtxCfIQYZQuI0D9mWAd7nW5koKYV906xZtoOKND0podPyCFY+0xldPZr2f+PToTmizSjhYUWPSZ3Io=
X-Received: by 2002:a17:90b:2547:b0:2ee:f22a:61dd with SMTP id
 98e67ed59e1d1-2ef01274f35mr10629145a91.32.1733366199614; Wed, 04 Dec 2024
 18:36:39 -0800 (PST)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Thu, 5 Dec 2024 11:36:03 +0900
Message-ID: <CANgtXuPazP7efwhCbgYW1=9YnN29HjYyr1hE4cTKUxmF55oykg@mail.gmail.com>
Subject: IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Dec 2024 02:36:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17328

Hello

for personal reasons,
I will not attend today IRC meeting.

Thanks,
Arisu

