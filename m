Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1B6C47074
	for <webhook@archiver.kernel.org>; Thu,  4 Jan 2024 09:12:31 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.50209.1704359541239714672
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jan 2024 01:12:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20230601.gappssmtp.com header.s=20230601 header.b=QHNohHiF;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.208.50, mailfrom: iwamatsu@nigauri.org)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5553f251e3cso230411a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Jan 2024 01:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1704359539; x=1704964339; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gWMqmV8cCiHS+DOp3uG42rdM/2iTpjYKEgcZn2vkQg=;
        b=QHNohHiFTsuAhDE+n+sDmokcWM8mlLUEYaEM7tPH9JwvftJxgSA9CebPA9qbfXbDAn
         mw+jJy6LoA7TwPxJ342upjmA6wAuQLgncf4xuicj0Q5xakPHQQI2vN9SO6Ilg2fVbjhH
         fIy4m0dv4YdQ06p+GbQSwIBXHR4dwH4K00/js3coEF/yzlRQ6HKRjfnRO98q/0Trw6Wf
         SiXIKxSDfXWQPS90iiLWF03Mk/zSkHqqUw1vQKttZlts693k616oKYDS2SWkdfsRgmi1
         Ynhl6ZuQhorjiT/AzyLNMD4J3+vJucjo7BJt77yg8d4OJ8KQsKB1NxDS0qPtX7Pid0+w
         Sv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359539; x=1704964339;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gWMqmV8cCiHS+DOp3uG42rdM/2iTpjYKEgcZn2vkQg=;
        b=MwATlp7ASXUdKWeQ9RWZSR/KhITn3kmEEVQiUI5luxp6zsLayngvI4LDkCrJHNKAWv
         jJ6G9Xf2Du6XaEYAV9GA/p9QmdJZ2dUlblQks5bkUw1st9Trc6CMKjEidhpU4g35v1Ng
         zJoIyRF66JIcZPhE/9E6rViiRVqdS/UhUCqn/etxvdrdyrQSW5ahg+u3bKHjPWRRKit4
         VoOcMt29hsYHqVk3Fq6SpNZtd3ZSyfuyzRDjxlt8cL7RIlx2ooTBhYdQPk67CRK67ly9
         +UfVe7G3rDhiBeShq5InXHsSK9UUljLGfZtRtaNNWT2cCBgAAkszbH12+IhMxh4oAI7S
         3wEw==
X-Gm-Message-State: AOJu0YxpPjFV8/Z0KrhLI0OllNuZioj5r74nmLXSNHpCBBJKPlHYfR7C
	Vccv+tUdmB/syrvPgT/biRobm18ZWP7Z4bW0Z7LY2R2wNlw6t1I1xmq++1uj
X-Google-Smtp-Source: AGHT+IFajlWmO+3OvLKGpyLkEdBY1OjmsD13y7U89RiM4YPk4vyMBAYnsM8KJyTtAFx/rZhhn/H/Syw+ulTJrN8LXoA=
X-Received: by 2002:a17:906:b050:b0:a28:e626:adc4 with SMTP id
 bj16-20020a170906b05000b00a28e626adc4mr174201ejb.37.1704359539202; Thu, 04
 Jan 2024 01:12:19 -0800 (PST)
MIME-Version: 1.0
References: <be7ff984-301b-4133-a696-6d5dc9c6c278@siemens.com>
In-Reply-To: <be7ff984-301b-4133-a696-6d5dc9c6c278@siemens.com>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 4 Jan 2024 18:11:52 +0900
Message-ID: <CABMQnVLf80wmxh4pbCVau9ePuOPZTaMWgGJXffeLYtYpg-6bnA@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jan 2024 09:12:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14255

Hi Jan,

I can't join today's meeting for holiday vacation.

2024=E5=B9=B41=E6=9C=884=E6=97=A5(=E6=9C=A8) 16:07 Jan Kiszka via lists.cip=
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
> The IRC meeting is scheduled to UTC (GMT) 13:00:
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&mo=
nth=3D1&day=3D4&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     21:00     22:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/12/cip.2023-12-21=
-13.02.log.html
>
> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
>   - 6.1

All branches are on track.

Date the data is created: Thu 04 Jan 2024 09:04:42 AM UTC
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed 03 Jan 2024 05:59:46 AM UTC
  limit date: Fri 02 Feb 2024 05:59:46 AM UTC
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu 19 Oct 2023 03:30:18 PM UTC
  limit date: Mon 18 Dec 2023 03:30:18 PM UTC
  Status: late
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu 07 Dec 2023 05:37:21 PM UTC
  limit date: Sat 06 Jan 2024 05:37:21 PM UTC
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu 28 Dec 2023 05:34:49 PM UTC
  limit date: Mon 26 Feb 2024 05:34:49 PM UTC
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu 23 Nov 2023 11:51:14 AM UTC
  limit date: Sat 23 Dec 2023 11:51:14 AM UTC
  Status: late
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu 23 Nov 2023 06:12:31 PM UTC
  limit date: Mon 22 Jan 2024 06:12:31 PM UTC
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Fri 22 Dec 2023 08:15:47 AM UTC
  limit date: Sat 06 Jan 2024 08:15:47 AM UTC
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed 27 Dec 2023 10:04:59 PM UTC
  limit date: Fri 26 Jan 2024 10:04:59 PM UTC
  Status: On track

> * Kernel testing
> * AOB
>
> Jan

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

