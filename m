Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80378D68BE8
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 07:29:22 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36513.1766042961098991328
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 23:29:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=ChuI89JS;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78d6dc596eeso2093737b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 23:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1766042960; x=1766647760; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaIJ+f7LVKuJOxxHHO+ts9f4N/+4kTBuPMa7bCmWgR0=;
        b=ChuI89JSv08395rMGrEm3AKRj5C+jV2OvZMfjGlzdS0w5nFvM4xg29pzgjHF97KV1c
         WeMVqlG4FEfTiuvQkAnkTBp6/pZ8ebger5wsc9HaZIPJe2Bals/w6qixWZU0ebRZXQIe
         37UZ/P7DfW1TOt3Z6u+iK392y0JchxDsnfe6086Gp8X8xfmMnMNcUniLTTyIuLz6ahQG
         CToC4Epu0z3/4shpz0rsZFsQhkLYY1xOpJxiC+F/sMUuH7rTG9uf2R+n90YMqC6mpUSR
         IhVzWTy2UeaI5dJKcf/XWzBsHrmEDGWeIhjm2PSjjJ6Gs71QGk0obk5TZ/viIBxkhnw4
         sdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766042960; x=1766647760;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OaIJ+f7LVKuJOxxHHO+ts9f4N/+4kTBuPMa7bCmWgR0=;
        b=c9jJLP8RNpst7tFShIEy16uoBco8Z+IpX1VQMeYJ4pdtoMS+8LoFA+RJDeubnfJTzx
         wNg73XuOb2wsz08DTdHP5e5cBgFnDjcJSOEdPdmprr2mK6+KQxKZLvDge8/eQTOoYDvV
         7rQFNlzL/yzIEyc+i1Y7oIpWy587SVaII2EucXlIjlixfQMAcMC5J/mdQRt9eKXkedgl
         X5hA2Pk+qyaH6pktaAOX5xsfYXjjjW88lA6OUJwNSIQy4STUjMKTPPc/6rEhIqlxrWX8
         oXdWZ4CkCegccTsRjAnT52/1t3fsdsrX2kYbcnv7UtRaMXZ9rbqrWSymXvP4SKgV4qCJ
         5KAw==
X-Gm-Message-State: AOJu0YxIf2khkf+3X+yPzHkRWJ0qt6IHb0E0WaU7gZL4lAhvaF0feh9p
	XhQfZGomYWW5Z732HXMDKYceoIcrz1jDzQ0y4zwFB9vvBHt8HgdEC8cOIfjDjaX1wVhWkcEJNlc
	ieuyGlbXpF6sOlsDdGfQVx28au/9ZrDh58qykEiIUwJTOecLLRpWg
X-Gm-Gg: AY/fxX4sEoelutdwIip1XsYcLaj2On3LQLU6EfWp+/hhZV17wqpFZWN0WK10hd0U1lx
	abNh1mTl2UO0JWt8zWJpnRmIt9X6zqaLS9dVFGRQ5aTQJ/hwHNSzdncUymZetFS/VCkx4HjVp1b
	bikfzP4lQHFfqWgpbKtwp3e+2IC9T8YiFiio9AWmUygt4O2nAuv01QOgIlu5aA5BIukSQ7E+XMs
	WlExX+Y5SSFnagg+W3piHiISI/52N+F2GOJ/bGmkmh43FK8pFlSLLy59DcFW61QMMqGetyD
X-Google-Smtp-Source: AGHT+IE6vc05mgMprutLhP8F+S2l88lh5fOMoydoQQmSwDQCSJuRdhoPA7+pY0OO9tfsOE8XHMlJsi7sfdD5ENWjkk4=
X-Received: by 2002:a05:690c:7208:b0:783:71ee:8977 with SMTP id
 00721157ae682-78e66d4d412mr182516977b3.11.1766042959989; Wed, 17 Dec 2025
 23:29:19 -0800 (PST)
MIME-Version: 1.0
References: <258113dc-28cf-4348-9555-02eaf6741132@siemens.com>
In-Reply-To: <258113dc-28cf-4348-9555-02eaf6741132@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Dec 2025 16:28:44 +0900
X-Gm-Features: AQt7F2q3IFJeuwzOrR0yKYJzHx4e96dDt8xyi2sakhVbu5g4XE-OyonuozWExAg
Message-ID: <CAODzB9pGXNGhwRMgE-ZgAmcTfnLTop23o80+OdJijCv-qVAB5Q@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:29:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21124

Hi

I'm sorry. I'll be absent today.

On Thu, Dec 18, 2025 at 4:02=E2=80=AFPM Jan Kiszka via lists.cip-project.or=
g
<jan.kiszka=3Dsiemens.com@lists.cip-project.org> wrote:
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
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2025&mo=
nth=3D12&day=3D18&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
=3D37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 04:00     07:00     12:00     13:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/12/cip.2025-12-11=
-12.01.log.html
>
> * Action items
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
>
> Jan
>
> [*]
> Date the data is created: Thu Dec 18 07:01:39 AM UTC 2025
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Thu Nov 27 12:52:11 AM UTC 2025
>   limit date: Sat Dec 27 12:52:11 AM UTC 2025
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Wed Nov  5 10:07:00 AM UTC 2025
>   limit date: Sun Jan  4 10:07:00 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Thu Nov 20 10:20:08 AM UTC 2025
>   limit date: Sat Dec 20 10:20:08 AM UTC 2025
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
>   limit date: Sat Nov 22 10:53:07 AM UTC 2025
>   Status: *Late*
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Wed Dec 10 10:14:17 PM UTC 2025
>   limit date: Fri Jan  9 10:14:17 PM UTC 2026
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Fri Nov  7 09:45:57 AM UTC 2025
>   limit date: Tue Jan  6 09:45:57 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Tue Dec  9 09:48:21 PM UTC 2025
>   limit date: Thu Jan  8 09:48:21 PM UTC 2026
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
>   limit date: Sun Jan  4 06:50:13 PM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Tue Dec  2 05:29:12 AM UTC 2025
>   limit date: Wed Dec 17 05:29:12 AM UTC 2025
>   Status: *Late*
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#21123): https://lists.cip-project.org/g/cip-dev/messa=
ge/21123
> Mute This Topic: https://lists.cip-project.org/mt/116839064/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [masami.ichika=
wa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

Regards,
--
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

