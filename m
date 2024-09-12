Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A186EEEB59D
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 12:11:32 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web11.46378.1726143091007805237
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Sep 2024 05:11:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XAJUKDLf;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582a0b438aso6927481cf.0
        for <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726143090; x=1726747890; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHoGPhu+kiLzyeo3c09SAecUO1Cevq23jmpm83w3IVY=;
        b=XAJUKDLfoU+kE/6vIBd7dPE1CPTcpTVhfESeqjucN1s/WGWvmqdINGgyN9VfacMReB
         PfCHG5DhlkxSwiRMZBUBpB3MgZuUcuO1ZlZnU1n2UU4zNDhz/k2ijvZlZ11dL4nNScyC
         Zmez67gKAmH9j8SWaS+FAsvJk/rjiAhmNXeR7LBUagNPGsU9LekLebdki24tFCmOYvbk
         D2o0RceocuXmfCdDmzjYemUu1UqaDReZNPenaTP26NyKi/lYXUXpc1YqP4a2dr+C09J9
         F2wsFAWpE5vel33yautqqxlK5wNeJiFeI0rx42q53DnVIk7wGM3Tgnk8MrUnnJ9/Os+M
         tjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726143090; x=1726747890;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHoGPhu+kiLzyeo3c09SAecUO1Cevq23jmpm83w3IVY=;
        b=qdXAAHNPu+rfR2gniRoHwaA7iEqu+9KeCK1QOJoHCi218Rq4bxoikQhpkSKK4tUeHJ
         XDgerWS4ZIg1BYIyOTdPoh6yY5Hiya8WcX4fW0z+Wa9XSLvjRQncSgA0MzfvN9lkx/NE
         6JF7kNigVcK54cTv2NnnXXV31XkyrVsiFUJz7D+WQL0lpXluj4CFc0fBHtpNpAW4E0zR
         b4H0g1KeSC9+/K0xAo5O3mlV2QHP0ii6mIf94BepO/y5pLd4LtqeUvKOZSQauBEGKAHC
         Q+YWdhcMNAiJevPIgmY1gi1I8eAR5FAnLv8oGckhYIVv2ahXYb1+I4MPr1kKog5Xi3dM
         jmbg==
X-Gm-Message-State: AOJu0YwGaahbcBANzALlG9lP07ha/jfuu3+/mx4cql7AzJTNWrg2uldC
	wi9iHXjxreLLYOrNiB5Rhbnr3YMsCSzFBHjn+ibUftjytk1m9ymJlqqeKOKMpJ78QkqFNTJanB7
	91vIC8I/v//Rxdu+dwHg8ovOJQLiqhqVc
X-Google-Smtp-Source: AGHT+IFc1IvshSFtkFRj55BAGTvdPu3mshQ7Im3xB1rsgKu8h8gZskuXY3saXrklpIi5inKFcuJlQiNI6tS4bR9V/OU=
X-Received: by 2002:a05:622a:491:b0:458:4aec:2749 with SMTP id
 d75a77b69052e-45860462832mr44381761cf.57.1726143089512; Thu, 12 Sep 2024
 05:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <23531056-b2d7-4b83-9df6-797d7ac6b814@siemens.com>
In-Reply-To: <23531056-b2d7-4b83-9df6-797d7ac6b814@siemens.com>
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Thu, 12 Sep 2024 21:11:18 +0900
Message-ID: <CACe6DC4pEX8L20Dsav5toHORnWNVf15F2Tiov4TS=aSJczoY=g@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 12:11:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16895

Hi all,

I can not participate today's meeting for personal reasons.

> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
> * Kernel maintenance updates

I reviewed 6.1.108.

> * Kernel release status [*]
> * Kernel testing
> * AOB

I look forward to seeing you in Vienna.

Best regards,
  Nobuhiro


2024=E5=B9=B49=E6=9C=8812=E6=97=A5(=E6=9C=A8) 17:29 Jan Kiszka via lists.ci=
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
> The IRC meeting is scheduled to UTC (GMT) 13:00:
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&mo=
nth=3D9&day=3D12&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     14:00     15:00     21:00     22:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/09/cip.2024-09-05=
-13.03.log.html
>
> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
>
> Jan
>
> [*]
> Date the data is created: Thu Sep 12 08:28:23 AM UTC 2024
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Fri Sep  6 01:15:20 PM UTC 2024
>   limit date: Sun Oct  6 01:15:20 PM UTC 2024
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
>   limit date: Sun Sep 15 01:30:36 PM UTC 2024
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Mon Aug 19 09:14:08 AM UTC 2024
>   limit date: Wed Sep 18 09:14:08 AM UTC 2024
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Fri Jul 12 03:18:17 PM UTC 2024
>   limit date: Tue Sep 10 03:18:17 PM UTC 2024
>   Status: *Late*
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Fri Sep  6 10:08:05 PM UTC 2024
>   limit date: Sun Oct  6 10:08:05 PM UTC 2024
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Sat Sep  7 01:56:36 PM UTC 2024
>   limit date: Wed Nov  6 01:56:36 PM UTC 2024
>   Status: On track
> linux-6.1.y-cip: interval 15 day
>   latest version release date: Fri Sep  6 10:03:04 PM UTC 2024
>   limit date: Sat Sep 21 10:03:04 PM UTC 2024
>   Status: On track
> linux-6.1.y-cip-rt: interval 30 day
>   latest version release date: Sat Sep  7 01:00:42 PM UTC 2024
>   limit date: Mon Oct  7 01:00:42 PM UTC 2024
>   Status: On track
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16888): https://lists.cip-project.org/g/cip-dev/messa=
ge/16888
> Mute This Topic: https://lists.cip-project.org/mt/108409609/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/13258555/45204=
94/222682861/xyzzy [iwamatsu@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu

