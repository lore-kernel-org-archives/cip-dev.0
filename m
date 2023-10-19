Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703B8CDB482
	for <webhook@archiver.kernel.org>; Thu, 19 Oct 2023 06:48:08 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web11.21522.1697698079166187037
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Oct 2023 23:48:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=2iactlgv;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1e12f41e496so4714239fac.3
        for <cip-dev@lists.cip-project.org>; Wed, 18 Oct 2023 23:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1697698078; x=1698302878; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wq3WeHYX/OznNWNHUmu1y2h9Lz5OSs+M4rEySxD/EA=;
        b=2iactlgvJZnNAyMfXMZpSO4+oY56qWcqsEBV7qcJ+hu7L3mPwRZXmt//lfTe6BShLv
         goaMz/ImJPzPGYY4/I2Xjs3Bm0nq4Z8OC9x/GBvayBwDRWHa3xZoqt+BR8c2/bDsFi5F
         vrE4nHyO+1GZb1jsWlaqNZ0IX1Rz0xF7JHYIqRERirFEQCkVyOM5fKS11XtlTSJZUnpA
         Gzb9IvSQfPAROeE9O2gxk8ZTboI+/RnOBDzVe3D73RtPEE89mJP3OqrYMleTww96dCpn
         MTgEx/8kFXV4ckBxWMOQT4iMEKPjpfC0/8Ae/ctEF0qXFLu/s0V71WrwTy51T6nHpuG/
         tnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698078; x=1698302878;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wq3WeHYX/OznNWNHUmu1y2h9Lz5OSs+M4rEySxD/EA=;
        b=Xo0uaJxAK6cpSUnlMCri2bejj1WE9Vr8Y6MNzKciDHXLYNAtAqVOt7kys9SpY5K/tc
         qdOpYH6KMlf8fKxX5opOxSRQziBGTNcJrMyZsY12BSp8ztKBJCYlmpLLZQUK/N/sCIDE
         fOBRKTKJy56E1rhYIwfAgXw7oeiABn03c0ma4oW944ayCBjpHExozO9AMSzwiY8NYR4T
         7GsWj3o0WKdY5YfKKeBOYAaj2Rn1IqObXCGOwcBTgXVQcC8FHYteIfQAPlEOGOblNtEe
         MbiQzGgr8PLPq/1IKHZV73nwgTbx08uAFfr2zk3Petp+VEqBmSufLDeC8Hao8AYcXxKI
         aprw==
X-Gm-Message-State: AOJu0YyIFib0x+8sBOVCXMHpdJ/zRgvPAQTG1VyD1Cb9q710ccVGoMpW
	6EKbGQ0HzEl6v5QkFXxMlEvVRxRCN2qSSQOf0pr36z/u/uQrmBzmHSw=
X-Google-Smtp-Source: AGHT+IEzbCPAefV/6V10S/uOT3Y4DSmYG0FAGxVzXtl5UaFSgOoj7McssdPfgvC2pXNCseYNPEWAQBYHV4Llcu5+uD0=
X-Received: by 2002:a05:6870:9a1f:b0:1e9:9f9b:eb80 with SMTP id
 fo31-20020a0568709a1f00b001e99f9beb80mr1656563oab.46.1697698077824; Wed, 18
 Oct 2023 23:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <e75ca86c-f07f-4c9a-8a28-ef1b0696682c@siemens.com>
In-Reply-To: <e75ca86c-f07f-4c9a-8a28-ef1b0696682c@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Oct 2023 15:47:21 +0900
Message-ID: <CAODzB9oMKro=x4UqvCQAr0GfWb-kmtFLmH-VfTKHEM0RxM_zBg@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Oct 2023 06:48:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13405

Hi

I will be absent today, sorry for that.

On Thu, Oct 19, 2023 at 3:27=E2=80=AFPM Jan Kiszka via lists.cip-project.or=
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
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2023&mo=
nth=3D10&day=3D19&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
=3D37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/10/cip.2023-10-12=
-12.02.log.html
>
> * Action items
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
> View/Reply Online (#13404): https://lists.cip-project.org/g/cip-dev/messa=
ge/13404
> Mute This Topic: https://lists.cip-project.org/mt/102055452/4520416
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

