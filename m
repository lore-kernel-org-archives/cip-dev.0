Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54980E9A03B
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 11:01:24 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11168.1771498883786758895
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Feb 2026 03:01:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dn3ezrEW;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5069ad750b7so6241231cf.2
        for <cip-dev@lists.cip-project.org>; Thu, 19 Feb 2026 03:01:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771498883; cv=none;
        d=google.com; s=arc-20240605;
        b=CUvkw44cOPcUUBaf08J4IQqDY4eEwf7Q8cEWJH1iIumCikpiOwQE+iUlkZ3A8rJpuq
         5LSZoZK5/AFp1qcnCIRMxxkLjPjlpBOiXo8gbFr7XhaAqPx0qf7yuYq1fHo0ofTMOk1j
         8Uj/GpEWvGuTjXft9V9EtN6gn8uPQWavm3+InXDQ7TvUvzWP+F4PfrXFHCqKdZSE6EDN
         o3VAH83PqsxB0zaKTuPONiy7OeXVWHUXrB2EebWhghd/GLV7lwh1YFjps3aBkPWkxIur
         FtLxFHy3OupbidD0VQRNKvGa3mmJ8qLM2TuY22MmK38tVjiGZoTIcvrmAPvMl4lcBw4F
         FJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E0z3zcd+mDFlFnczmNcz3NcMySgFmv/PsQQXCqzHblc=;
        fh=TKnUO5H0/SHOG5E2xt2hiOHSMeYkP2viblmO0veQLUg=;
        b=ZmCZlZl31wpMyhzNpT6ltOFoBk6EbnD954eG4U+M8dT6ykXBCdGJla4yreo/F5r0fn
         fivSXae22mTvnen5X8Oq49F0QYEQ5HlAWRkJisQ0MIrOmo02CgDS8pBglLd2wBTeo4Dh
         SnycFKENqxji5UqPgfKwR+gRbWDPPLXhDwmiAR34KAAJXRKohOXvgkjvfFc6lQKFMOwW
         NUmRLYf1cZxKeMy36VhhrlZr95N8Tj10U4nIj1aGKyEJiw78Ig4X2Csv7dNHouux08A6
         NS/Xl0ysCHGXZqtoh/Xb5Pu4CHKSvCaUZi+RQD6KZUTKp2Z35sTM21PVAX27esUR8JTi
         hkCA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771498883; x=1772103683; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0z3zcd+mDFlFnczmNcz3NcMySgFmv/PsQQXCqzHblc=;
        b=dn3ezrEW8rl6qdYJsEesp7RF1PVlJ6nCiKilK5U157+0q57n/pfNMJ0zTXPAOmKmWs
         ej1FW4KCPzQqXuG/ZxSzdgeMf891DFdjKXB/EA1sCMEg3JljPTrf3YsDHYmkicr/Mh1v
         yE+H65p4P2/QjjOq/QABWezOuORJutUd3ZFln7rdUABP8szgsUHcSrg5Yr0bbwnGji/N
         dcqHTWkq+dQXrW4N919RjQEUaOi6cOGDSvovEAtJlcY8/rgkGu4lW8oGUHbQfJwJQ5NH
         bGAd+J9ml1vNQgoVIZ2KfV+jhf+rtSd3wnOf1DKhk0lTS+Airkjy8UlYbqW1ld8Lk1+D
         pO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771498883; x=1772103683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0z3zcd+mDFlFnczmNcz3NcMySgFmv/PsQQXCqzHblc=;
        b=dNjpU8DqVnUSCiae+tvB8Smm4z6HM7nRJS+AbelNSz55pyNosX5UJ4e3fHkRrqfgPD
         IpTyJPxGpw8y0leXyGUEAw3snDnJ+bqWBuCmwldCTROyoMGXXCVQ5a4JahPz3DJBma5r
         YAEnMqJrYrbcnaC049KCB5w8c3JmYWAQ0gkYIAMnPEOyLwWzkhnvuJF/5Jt+vqyPOmzK
         JWJEbuxJ5xIXt9kjokNnvNwhjiqRNwCsF0RjfYx3dBEmNaVualGq9ku/Fp3PIp7nVl13
         iUZ4hvyC/EzmcbQ9CLUHbr8dJDliCxH6QgyHv3fIP24KWd68/9v19mo3R02NCx9BvXWY
         ml8Q==
X-Gm-Message-State: AOJu0Yycf5gKqE27C5K94e87NWPZgwpbRBYoPjUQodUVvtrE8W/PdM9W
	4P2Z8a7XTCGgCSjPcewj4LC5zeNZPQy1xE0nBq2aV6HOphKKOCIEpwsXTHX5MObYHPYS9dluPoy
	QesPSezvXGZE83PMk5m9n/ORVxX8ZSHybFlrJ
X-Gm-Gg: AZuq6aKcT0r3tnYpNzK1vevL/5hjD+AdN8+RM4sbDi9aU0vbt4o/fcVNrEl3KPqDESk
	sskx5sV/BW663ygulfidzApja7kN17jQYkXN09Cy0RyFF8eB1v+qti6BRFKSYhgPrBNLhTOnwFP
	kj4Wlz2VR1bamT+kKwus6qmVjHFhgHUW39vKMOPPLPK2T+Jx5dAsOBb8SOI3N0lSLkRRoFtmJ8p
	llMU6fBQaJltkW+Kl4QxZ5uzE9qpUeEaE0wZvOOUFiMm73ZBRSa69x8HKAGLOIe/yXg4DWX6dI/
	8vhU
X-Received: by 2002:a05:622a:1390:b0:506:534b:7871 with SMTP id
 d75a77b69052e-506b4000723mr221472071cf.46.1771498882255; Thu, 19 Feb 2026
 03:01:22 -0800 (PST)
MIME-Version: 1.0
References: <79ec7880-394d-4e29-a213-9c23de51785d@siemens.com>
In-Reply-To: <79ec7880-394d-4e29-a213-9c23de51785d@siemens.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Thu, 19 Feb 2026 20:01:11 +0900
X-Gm-Features: AaiRm51VGtWghXRvqlCbB9vb9eD47n-X2ZezXikpqoVByvg1aU89_ZTvmo3BKT8
Message-ID: <CACe6DC4-ROyrMYUyYRV9G8mrkVWyhrA=M6oztGYFDow1yQkfQQ@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: jan.kiszka@siemens.com
Cc: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Feb 2026 11:01:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21896

Hi Jan,

I can not precipitate today"s meeting for personal reasons.

2026=E5=B9=B42=E6=9C=8819=E6=97=A5(=E6=9C=A8) 15:51 Jan Kiszka via lists.ci=
p-project.org
<jan.kiszka=3Dsiemens.com@lists.cip-project.org>:
>
> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>
>     irc:irc.libera.chat:6667/cip
>
> The IRC meeting is scheduled to UTC (GMT) 12:00:
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2026&mo=
nth=3D2&day=3D19&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 04:00     07:00     12:00     13:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/02/cip.2026-02-12=
-12.02.log.html
>
> * Action items
> * Kernel maintenance updates

I reviewed 6.12.69 and 70.

> * Kernel release status [*]
> * Kernel testing
> * AOB
>   - any further comments on
>     https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/=
2c2fcf8082a3f69eef81f4f3d204473d7879ad1b
>

I will check it tom

> Jan

Best regards,
 Nobuhiro

>
> [*]
> Date the data is created: Thu Feb 19 06:47:57 AM UTC 2026
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Wed Feb  4 01:55:28 AM UTC 2026
>   limit date: Fri Mar  6 01:55:28 AM UTC 2026
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Sun Jan 11 09:55:11 AM UTC 2026
>   limit date: Thu Mar 12 09:55:11 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Thu Jan 29 04:48:14 AM UTC 2026
>   limit date: Sat Feb 28 04:48:14 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Wed Feb  4 10:41:33 AM UTC 2026
>   limit date: Sun Apr  5 10:41:33 AM UTC 2026
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Fri Feb 13 12:33:43 AM UTC 2026
>   limit date: Sun Mar 15 12:33:43 AM UTC 2026
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Sat Jan 10 07:38:46 PM UTC 2026
>   limit date: Wed Mar 11 07:38:46 PM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Fri Feb 13 12:25:20 AM UTC 2026
>   limit date: Sun Mar 15 12:25:20 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Thu Feb  5 10:58:13 AM UTC 2026
>   limit date: Mon Apr  6 10:58:13 AM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Thu Feb 12 10:21:35 PM UTC 2026
>   limit date: Fri Feb 27 10:21:35 PM UTC 2026
>   Status: On track
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#21895): https://lists.cip-project.org/g/cip-dev/messa=
ge/21895
> Mute This Topic: https://lists.cip-project.org/mt/117888659/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmai=
l.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu

