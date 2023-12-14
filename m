Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1761C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 08:45:46 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
 by mx.groups.io with SMTP id smtpd.web11.17682.1702543536764179613
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 00:45:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=jKRhoYCB;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.48, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-20292b5ca69so3814300fac.1
        for <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 00:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1702543535; x=1703148335; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bt7O+MQ6/4HvOEWT/PJG+LDghoHZazQKuwXzTUdHg7k=;
        b=jKRhoYCBRMbnuKqUmaOoaCkjWsOYLsfnCQ7st6gfHibRETowvR13Gc4X0FcPsbsyvW
         s8nmVQuW+txPMRuJvUxBC4vgoLj5fR9H5bJfiCobPnXIY/AWeOKpRzZJhSjHVkw4iW0e
         0j0FjWDPaZw54E96FhabitOdNeZu0PQs6KBLA1vuDWs7+epVk8gPQ2DHB1EwNF5t99LD
         TaRygZ6pILLM+Cer4BgPd5aRFPJGVrrJ1fdoupddwt7p9TbCOQasEU2bGa0x/OF5nCNd
         RHxDpN1lJKgoTkUXfB9b0myvdsOtdS48KSX9Pupv5I6QIjJYiNPWwh1k+f+1yLysntOC
         cqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543535; x=1703148335;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bt7O+MQ6/4HvOEWT/PJG+LDghoHZazQKuwXzTUdHg7k=;
        b=cQiqbBQtbzbnwUUbmqy/TGTjPOTsrKjsilMzpUeJ7IkLqDAiDg6Lp/MYGpil8ZrMos
         T0fW1LUEvvbnlNiRbPY4pxtPKEGqq3NuonnEigfAOEoMYg6Op6gj73Cf7VXa1NlVN+SU
         cwF7gPE/VI/4tQogwuaqE0fD2LGWznn1/axWdSeReTRgbV9QZ7TiwZ8lTM0JhY/FuP/I
         pwvTt8CONIZTTX2L1QXc+ctuoD0YO13srS3is0qf6xvGF1B3sq5OFB2B9anW6W1zV8v7
         z9iFkFiwIBWANyXBInIiigG+aXMEFOpMlWDU6sA6DNEcH6GTMtk4hMrQZUKtA50bFYNd
         5vYw==
X-Gm-Message-State: AOJu0YwRxI8J4OFenF3u3XpOirTNXGx1SvjjIr9hyJMuSNhzEiRKMy9F
	LPne9jw50KBv5kOPOH51wN3j7SXRxOWldHPfBVhpJAPVcO4xp7zB
X-Google-Smtp-Source: AGHT+IFc6HZVMZD4PMCLUtnUr4Q87Bz0bSe3f4GmC4SVNvMjK93pe8AsokCPayGk5wynjn706tHlYFq5iERKOdu5gBY=
X-Received: by 2002:a05:6870:2305:b0:1fb:75a:de4f with SMTP id
 w5-20020a056870230500b001fb075ade4fmr11802250oao.61.1702543535585; Thu, 14
 Dec 2023 00:45:35 -0800 (PST)
MIME-Version: 1.0
References: <d1055a42-e31e-436a-ae87-8b253a55ecee@siemens.com>
In-Reply-To: <d1055a42-e31e-436a-ae87-8b253a55ecee@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Dec 2023 17:45:00 +0900
Message-ID: <CAODzB9o-Tp_UoqTuhArUbZvuOqGYZYrxFFOc1ktKamphwUM8-A@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 08:45:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14092

Hello,

I'll be absent today.

On Thu, Dec 14, 2023 at 5:13=E2=80=AFPM Jan Kiszka via lists.cip-project.or=
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
> The IRC meeting is scheduled to UTC (GMT) 13:00:
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2023&mo=
nth=3D12&day=3D14&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
=3D37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     21:00     22:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/12/cip.2023-12-07=
-13.01.log.html
>
> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
>   - 6.1
> * Kernel testing
> * AOB
>
> Jan
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14091): https://lists.cip-project.org/g/cip-dev/messa=
ge/14091
> Mute This Topic: https://lists.cip-project.org/mt/103166574/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/452041=
6/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

