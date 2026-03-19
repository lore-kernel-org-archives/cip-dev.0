Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7671075289
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 09:34:43 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7219.1773912877130888983
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2026 02:34:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R9E07fMv;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506362ac5f7so6802211cf.1
        for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2026 02:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773912876; cv=none;
        d=google.com; s=arc-20240605;
        b=WWSbXULxdNPuHD7fyqU6KvlErlJXl4T+K3oT97Vohb7IbiVrTCSpowJrHDDeXxTLA/
         DWOlhRS5/1Js7aAMPBPo2PMhuW8HIzM8aPWCnNN1+4eOaBmwF8iugioIrdMitTJSvM/n
         3/EwQjSXcWCh50IXEPvCDz+q4qH3+ishCS8KgFmgV+dmWwKm8vUeQIgsH1A4Wo7cW2Lc
         Lk1HRe07Qzztaq4/EFHgghkZw3sYYtBDf+4/GHxzIwPu/W7CTPOV5NxppN3TEFQC+kGm
         Ow25HwS0WoLhm7IfX8D38cLswHgew0ZawqCzQPG/V9ek3bKNfea9Q0E4UyBVToyh2PWJ
         Kvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NtUMTv/5ZIh4f/K+cahgm+fudChGVLj9Zs7zN11tq3Y=;
        fh=TKnUO5H0/SHOG5E2xt2hiOHSMeYkP2viblmO0veQLUg=;
        b=lSRRc+yATiW/z5JlGztCVlsdXlBVUuJ7ilDZOBuJjz4UU6zVTO02r0PDyZa85H0QNP
         XRCw9pwR8ggXJ8eDEZ4gKXGrZiMbvDA9hwVMT4/QNwJjFB7xFIo6YB6hUZL9zkrDCiNr
         b9zo0MqTRQnsK3+5smBlkO2P2YvLRKvWQOexRa5S3ZMYXSB3LD4kM5NbeQQOp+cGN4eO
         BH2PE2gxRYCdkHKv261d4sE6uCuzx9EJB/eJlhwJcP/FrqFHkV1m4ZOqedbzeucqBUo+
         ugVcasCaNReSXPDActc2iIZcAS9Y/cRGzFJRU4F3fUliWPMWa+VY2RuEJ9aNOTH9fI97
         5CGw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773912876; x=1774517676; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtUMTv/5ZIh4f/K+cahgm+fudChGVLj9Zs7zN11tq3Y=;
        b=R9E07fMv/BQ8T1qFRZt/Sou4mfd+YX7hjV+aOrM3I95kSvCTZLU+M1qQx5wp8BxbUk
         6WkUKS0Z1OHYWtSW4/bRtIV86BGlKHo7gm1PYi4c0SGoxGwjomLYUlCgzy2sQeBBEbX7
         b66i5VwL3UHeRyIRkn90tZEYHgbVb0l6fdcbp9YqfGGms4NMCVApnm7jymzQnSFoAa/6
         EDKVccz1z+s9oPn9u/IZ/EuTmj7xDspXHfvTVK/Z0SfWWyjoOajb2YLB62CSMLiY5faJ
         RTackknqTGXB4XSc6c61kZmxC3t89c7CC40GP8lT9f1y6l57mEECTXdBfo1fxaJL8CFh
         kr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773912876; x=1774517676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtUMTv/5ZIh4f/K+cahgm+fudChGVLj9Zs7zN11tq3Y=;
        b=JLONTJT/cznEof5qafRNcvKC2n0AVTENJyvpF3NdjFhfH6EVfCKrnZmyWq/QB6yxsw
         M2NObg2BCZPYGx2Abr/CxqIBoxZT5U/cF4vKPMDyccuxNYWmEuuf9MaJB80mJW3RLM0D
         7R0Kngc+vZzK1YHLYllG1fpryMoiXkxoWHDFDYRBweZmyoCQLlh0HqQvyUcEUcTZibRY
         nKPMor7tukC2o7zc8CvxAbVBerdd4lRa55h4qhBkjfPRET8HLNKivAerRTPSnZF/JAN5
         a3D/lpfr/yLuFYhfO0C8jc+Ww6TcGSi58wvCi13+6KW22u98LMlfyjyyW3vHk1J7B0Jm
         EizA==
X-Gm-Message-State: AOJu0YwgsUI7EeZvNPtSBuPMfz8hMtPVvbcur44ovE9rTPpNOE9Qn6rv
	o0VxHySciEyd0sGtxFLC9B2mCQpw4ZEYnJ7SMomXwVk4SGNGydOysPIPpuzio3ZoVcWhVk37wl0
	O5FiPiex4Z92R67a3RuuS2ngH5xkBXFU=
X-Gm-Gg: ATEYQzzaeUuy0Jq7By9vCA4SfUCBQryEkgQClaVEf5AParrOxzuI7nHhCiVsaWeRXkT
	6GyYd25wCKZlOc7zvJUq7CsLzzTciVMxjWdk6H1hlE77bqtbBgRjTZDd0/mDiIDanxz4Hlj5MrQ
	2i3FnrDqtGK/qXFrKnghP0T55v0JVSrQi5/Qe5bDziLatU9BPc+1XPp3b1ZJxe1WfufiN6nIl+U
	c6OokLFLNbZBOq5NL63sKODs65T6CGY14UmMliu1MFMbh0rciGywcBE7Kt98bSpUsuVT8WyzQAI
	Hls=
X-Received: by 2002:ac8:57d2:0:b0:509:3d06:967 with SMTP id
 d75a77b69052e-50b148ae88dmr85641921cf.54.1773912876083; Thu, 19 Mar 2026
 02:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <0e9496b0-7cf4-4351-a830-841966d172ec@siemens.com>
In-Reply-To: <0e9496b0-7cf4-4351-a830-841966d172ec@siemens.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Thu, 19 Mar 2026 18:34:24 +0900
X-Gm-Features: AaiRm528mK1TssS4_w2D9yPYwxbLnIS4qC7914VnjcJOzcyyybD-AjXJGXBLOoc
Message-ID: <CACe6DC7aaJCsQ0qeMm+WwDFY_ugqpO6pXQEknGMcxyKXU=i7Cw@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: jan.kiszka@siemens.com
Cc: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2026 09:34:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22509

Hi all,

I can not participate today's meeting for personal reasons.

> * Action items
> * Kernel maintenance updates

I am reviewing v6.12.75 and renesas patches.

> * Kernel release status [*]
> * Kernel testing
> * AOB

Best regards,
  Nobuhiro

2026=E5=B9=B43=E6=9C=8819=E6=97=A5(=E6=9C=A8) 15:03 Jan Kiszka via lists.ci=
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
nth=3D3&day=3D19&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     12:00     13:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/03/cip.2026-03-12=
-12.09.log.html
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
> Date the data is created: Thu Mar 19 06:03:05 AM UTC 2026
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Wed Mar 11 03:13:57 AM UTC 2026
>   limit date: Fri Apr 10 03:13:57 AM UTC 2026
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Mon Mar 16 09:03:44 AM UTC 2026
>   limit date: Fri May 15 09:03:44 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Wed Mar 11 03:05:13 AM UTC 2026
>   limit date: Fri Apr 10 03:05:13 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Wed Feb  4 10:41:33 AM UTC 2026
>   limit date: Sun Apr  5 10:41:33 AM UTC 2026
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Fri Mar 13 12:18:31 AM UTC 2026
>   limit date: Sun Apr 12 12:18:31 AM UTC 2026
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Sat Mar 14 07:04:13 PM UTC 2026
>   limit date: Wed May 13 07:04:13 PM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Tue Feb 24 08:55:46 AM UTC 2026
>   limit date: Thu Mar 26 08:55:46 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Tue Feb 24 11:47:33 AM UTC 2026
>   limit date: Sat Apr 25 11:47:33 AM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Mon Mar  9 07:35:00 AM UTC 2026
>   limit date: Tue Mar 24 07:35:00 AM UTC 2026
>   Status: On track
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#22507): https://lists.cip-project.org/g/cip-dev/messa=
ge/22507
> Mute This Topic: https://lists.cip-project.org/mt/118396138/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmai=
l.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu

