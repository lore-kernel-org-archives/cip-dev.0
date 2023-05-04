Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AEAC77B7C
	for <webhook@archiver.kernel.org>; Thu,  4 May 2023 08:40:05 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web10.45094.1683189595851273205
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 May 2023 01:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@nigauri-org.20221208.gappssmtp.com header.s=20221208 header.b=DyHMSJOC;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.210.46, mailfrom: iwamatsu@nigauri.org)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6a981550a5bso34619a34.3
        for <cip-dev@lists.cip-project.org>; Thu, 04 May 2023 01:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20221208.gappssmtp.com; s=20221208; t=1683189595; x=1685781595;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUuZzWjBYvX3NYaq5pdSJYesnZjOMxB0s29Ag5Awck8=;
        b=DyHMSJOCfBgh9xIJPejfrQyuyGAPKx+E5ITWSXnhrtK+IrfHa9kA6dVkMAmoaTpR8R
         9p5+U3TlunsCufr9XTFyx7e4wPZ+Ec+eXX4HhPwKUfdywuIAri7XiwIX5/YYkDGFA/vA
         7+GJPFv/loteL5YyCitXQajDyQGTr8EizLMr04ARlP5C/T+8UMP/gi84UXV/iYHz0j8p
         pYJA9+ZFjLw+O3CaxotS2+JoBXjYBjUYOxBazIHMIwXeVySOZk2ga2+cyRdbwNfrrJeJ
         ux7z8+taDEdBx7FdgWmY+jD10JAJ8bGC0NJUTIKf8We7k1l6XPmoGexJcp8LThmjMO5Q
         48LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683189595; x=1685781595;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUuZzWjBYvX3NYaq5pdSJYesnZjOMxB0s29Ag5Awck8=;
        b=GFEqrji4MH6/efb7GO16c9V9GZtnTEWRtyyVTlb4fhX36+RPgvPVLVJX/CN5ehqSxi
         9wNmucpceAdWbxJcuKX0Ra1hYmRffH10EOQ28ds1mFiwrJmoBsJ6YPFTKsm9poN3u9kV
         G4ZUurvP0lPIE4blWYR+RB4aQzXhYcfGGtnXh/mv+16p1SrBtwuP9aNdJ/geIr9ggao+
         bXBVdo4X1onxcBRRBSZa7fQNNmaW+VGG17jv9DGST+y7juB6rV6C5M1jxMWuBgEwlsq3
         jjJo9twau5bMASXEcyFz0AhIqVZfp0Xm3rMaWCcT1xuwQt9D4QlQ7P8m8GcgEZdGMrCe
         MJzQ==
X-Gm-Message-State: AC+VfDywmMZ+i0A+gNkLYj0oHSDMb8jjaybb3M+6ti6wxg6SHkz5oUd0
	sIMjvL3mcC5Yi9U7yyOfFUpz0lCHzqFJso+FtKvR0ALDheI0Oh6gEw==
X-Google-Smtp-Source: ACHHUZ5WZTkgFE8bbRUqijGTX/H+Yzup6vpDplhssE9DfJVqgh/SeE1sK+PwdJljp1OcueFIe06IlxJT5BHFQ3I9lc8=
X-Received: by 2002:a05:6808:218e:b0:392:763:7af6 with SMTP id
 be14-20020a056808218e00b0039207637af6mr1361808oib.1.1683189594918; Thu, 04
 May 2023 01:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <6ab481ca-108a-17e6-7e96-08245f603de0@siemens.com>
In-Reply-To: <6ab481ca-108a-17e6-7e96-08245f603de0@siemens.com>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 4 May 2023 17:39:28 +0900
Message-ID: <CABMQnVKaXGQJP8j93WDtkG=zpqsZwYFreKEcxLjXAiqS9E=EoQ@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 May 2023 08:40:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11411

Hi Jan,

I can't participate in today's meeting because Japan is closed on
national holidays.
Below is my work and report.

> * Kernel maintenance updates

I reviewed 5.10.180-rc1.

> * Kernel release status
>   - 4.4
>   - 4.19

 No new releases for RT. We should release cip-rt within this month.

  - LTS: (Target Releases/Month: 2)
    * Upstream 4.19.282 (2023-04-26)
    * CIP 4.19.282-cip97 (2023-04-28)
  - RT: (Target Releases/Month: 0.5)
    * Upstream 4.19.280-rt123 (2023-04-24)
    * CIP 4.19.277-cip94-rt29 (2023-03-22)

>   - 5.10

  No new releases for RT. The release of cip-rt is delayed.

  - LTS: (Target Releases/Month: 2)
    * Upstream 5.10.179 (2023-04-26)
    * CIP 5.10.179-cip32 (2023-04-28)
  - RT: (Target Releases/Month: 1)
    * Upstream 5.10.176-rt86 (2023-03-24)
    * CIP 5.10.175-cip29-rt12 (2023-03-22)

Best regards,
  Nobuhiro

2023=E5=B9=B45=E6=9C=884=E6=97=A5(=E6=9C=A8) 15:49 Jan Kiszka via lists.cip=
-project.org
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
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2023&mo=
nth=3D5&day=3D4&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/04/cip.2023-04-27=
-12.02.log.html
>
> * Action items
>   1. create kernelci pipeline for buster images (arisut)
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
> * Kernel testing
> * AOB
>
> Jan
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#11410): https://lists.cip-project.org/g/cip-dev/messa=
ge/11410
> Mute This Topic: https://lists.cip-project.org/mt/98679121/3616729
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129081/361672=
9/2027256985/xyzzy [iwamatsu@nigauri.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

