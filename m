Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB01E77184
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 09:35:32 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web11.126223.1734600930902065381
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Dec 2024 01:35:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=i8xJuZcx;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6eff8289d0eso5323517b3.0
        for <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 01:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1734600930; x=1735205730; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SARMJ0Hq40rEkFTYGHpZRQD15LtjRdYa20eIF7RAuSU=;
        b=i8xJuZcxNzUEBY5W8FBFxZef+OU/AQN5aDSxDt+5GV5al983QJSEdv953DvbU0aIm6
         RHgBMLM/F92wfU1fDZJNp4cK9rzwNxBpIEKhXFpPWQ5gKiHSC5sEsZ1kzvT8Qq1z5aan
         +YKr29ysxxCXDx6r6qgY1YezPjlNNuRRd/Ia5kTifSXq6qE/QKZk21OOpEvShBO7O+w9
         67inZzIByQlepWIL2KU2XYwsutkq/dTzOlF8QZ15uMIwzX9pntiImjiK5JovJT2c/YHx
         haWrEmeBSJ3o1XJZQpX3AYm+Cc3ktrtCKSbkvpPwk4hUMbwY1Uwykvp1mBJ2FKKqXhNr
         5pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734600930; x=1735205730;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SARMJ0Hq40rEkFTYGHpZRQD15LtjRdYa20eIF7RAuSU=;
        b=ujpST23ZEbsUG9DmNfEGSxVGW4IPknVXKA4kiB6idUXCvSTJIoXg/ZZnWkMJ0CvCOa
         fDz27dZickzyZtwt6NtWXeCfSHtrHQ62fO8zyooWgfJupKx+A/3dL3SSvTFdKtNDQOSi
         dXPnJl1fw+7JobRjoXjwlHsXheQpGHTqyf3UrqyFdqHFsuNSjCTl2A76D7UCXpNMq7BT
         vgLTXGQ2FHLumErLrT7L3y1/iCc6pSpNcSlkVfTNsP2w3l5Xs8FpIeB+Ir9teKf+QTpY
         a/peVhNWdexHc12mo2DAHWmT/rRmUyl7TruVU75mQ3fXsQp57nfraTWf8ler5FNbi3Uu
         Kt8A==
X-Gm-Message-State: AOJu0YyjD4XisvvRCnDhBwLnCW6C5gFevfto85GEOLy9zDayelYoMyqx
	exnIqdZZjcUeXRrUfbxG2gU5FFFcxsVa841WPZdvxUtW4NtujBEljtr7EczA1EcOtVDcKNhXijL
	LHlYxjJ9OpmJuZrhCJiFQlmCcLxjiPrU7So3Fi9oenK5NL712qcs=
X-Gm-Gg: ASbGncunuRHmfm1vQwRjHJNgkmbVZIpXasP4QbiaQh6aMWQK3RBAvcxRii5Y6TM/O+x
	X9xSgBDN8C9xjCbGgw6CnCDxWbUH5BaxpocFknpA=
X-Google-Smtp-Source: AGHT+IGAttbWS/8LjB826I+t2usaA5UCUP6s/pY5IWBXii/tr3/ERi+t9O0pyJqDqHWDQCyKmu028+2aPAP5VChp7wc=
X-Received: by 2002:a05:690c:6183:b0:6ef:6d61:c258 with SMTP id
 00721157ae682-6f3d2680392mr44167367b3.27.1734600929776; Thu, 19 Dec 2024
 01:35:29 -0800 (PST)
MIME-Version: 1.0
References: <OS3PR01MB6391EE99BC84D03BF2FC38A092062@OS3PR01MB6391.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB6391EE99BC84D03BF2FC38A092062@OS3PR01MB6391.jpnprd01.prod.outlook.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Dec 2024 18:34:53 +0900
Message-ID: <CAODzB9r+viBGZRXrvFPYcVQr_JzMirRiXOa4i=o=F+pAjDpJhg@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat / 20241219
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 09:35:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17476

Hi.

Sorry, I will be absent from the meetings today, on December 26th, and
January 2nd.

On Thu, Dec 19, 2024 at 6:09=E2=80=AFPM Nobuhiro Iwamatsu via
lists.cip-project.org
<nobuhiro1.iwamatsu=3Dtoshiba.co.jp@lists.cip-project.org> wrote:
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
nth=3D12&day=3D12&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
=3D37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     13:00     14:00     21:00     22:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/12/cip.2024-12-12=
-13.02.log.html
>
> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
> * Kernel maintenance updates
> * Kernel release status [*]
>   - all green
> * Kernel testing
> * AOB
>
> Best regards,
>   Nobuhiro
>
> [*]
> Date the data is created: Thu Dec 19 09:05:47 AM UTC 2024
> linux-4.4.y-cip: interval 30 day
>   latest version: v4.4.302-cip94
>   latest version release date: Thu Dec  5 05:21:08 AM UTC 2024
>   limit date: Sat Jan  4 05:21:08 AM UTC 2025
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version: v4.4.302-cip94-rt52
>   latest version release date: Thu Dec 12 10:45:41 AM UTC 2024
>   limit date: Mon Feb 10 10:45:41 AM UTC 2025
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version: v4.19.324-cip115
>   latest version release date: Sat Dec  7 07:05:01 PM UTC 2024
>   limit date: Mon Jan  6 07:05:01 PM UTC 2025
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version: v4.19.324-cip115-rt39
>   latest version release date: Mon Dec  9 12:30:02 PM UTC 2024
>   limit date: Fri Feb  7 12:30:02 PM UTC 2025
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version: v5.10.230-cip55
>   latest version release date: Wed Dec 11 05:28:57 AM UTC 2024
>   limit date: Fri Jan 10 05:28:57 AM UTC 2025
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version: v5.10.229-cip54-rt23
>   latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
>   limit date: Sat Jan 25 03:12:05 PM UTC 2025
>   Status: On track
> linux-6.1.y-cip: interval 15 day
>   latest version: v6.1.119-cip33
>   latest version release date: Wed Dec 11 01:47:08 AM UTC 2024
>   limit date: Thu Dec 26 01:47:08 AM UTC 2024
>   Status: On track
> linux-6.1.y-cip-rt: interval 30 day
>   latest version: v6.1.119-cip33-rt18
>   latest version release date: Thu Dec 12 10:20:12 AM UTC 2024
>   limit date: Sat Jan 11 10:20:12 AM UTC 2025
>   Status: On track
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17475): https://lists.cip-project.org/g/cip-dev/messa=
ge/17475
> Mute This Topic: https://lists.cip-project.org/mt/110195188/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/452041=
6/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

Best regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

