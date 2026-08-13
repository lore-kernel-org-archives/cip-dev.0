Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4546C5B572
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 06:11:10 +0000 (UTC)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13120.1786601464657258985
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2026 23:11:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=xsEvE0D6;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66843304cbaso2498135d50.2
        for <cip-dev@lists.cip-project.org>; Wed, 12 Aug 2026 23:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786601464; cv=none;
        d=google.com; s=arc-20260327;
        b=S3lHhCJED4wvm2dQ58/fKjydEBwogUeQJCluUVmD+HOCB7Pko5vDy1c6htIQ1NuQXr
         6JueuVi06rjkQul1PSaC9iJxeSSLsdSEtrCPpTX8VCSATLFY8Drz3c2Ui2V7YKRiO4zJ
         lU9I7WLGT3CfSRwfb+U6I8UrPHfo5E896Fzwo+XIlFRUfMoCDe88vmmBklF3XmeVoqEg
         fp1yM1/tWMizMtD5+4EMG/3nTc46bB3gpcDZj8WvsmM/v9C315pMV9yDY9wIg0G8fbez
         U4yiYs4paHQ0UFBEVxy7iBNG7sJK12SOHKz6XYDMPUjNfxkJ6Y/o7ET4DOKd4iitXFeu
         kEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P4CZgQgtqSgEBIByF0ba8/VCvfRJbi3Foy+nTK4t41I=;
        fh=TKnUO5H0/SHOG5E2xt2hiOHSMeYkP2viblmO0veQLUg=;
        b=Ml90WG+o9aUcBQpnu/YbYwty5y9hFZudy6oKjp39sMrfosUuqzZ5a8mU4H4BkRzvpe
         DZqL+zKMvo2kdIQxgxFonB5RyKy9EfO23To87S34aUCV6nOCZxV/0MVnnUlRwLWrbk2x
         pFynxJ30LMDyjpJ2/TuzKaodtiQaoJ4bxBvIBj9EqPWc7LegJqERlsVUiBiLvzpdUfce
         YCtbvFDIlKUUpctyTnasvQLSgVStA8//2KmlmlnyNjYg5dDdX7Cfn24nufIXbHGIzGqB
         2xANpRfthtmPA1KXNMGZCyJUW8DcbdMAoyhJDZb4IaHpQS0WwuYWEb3ZgNscjqxO+i+z
         Q9jA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1786601464; x=1787206264; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P4CZgQgtqSgEBIByF0ba8/VCvfRJbi3Foy+nTK4t41I=;
        b=xsEvE0D6SxYcvbetDB7/qFt0vlly10pGk0bMa4UQefaAhO1LfafPilhDCdaWSYlWbR
         hBMVv/QuN7iMKY6mk050KoPv+NF8PaHjjsDRAyag/jFEFmi1HMQMcQwKAklUanUw86Gv
         u+If8t1uoZ1uv++Bfnp0bw3aJqQ99xEzXlzvmDa3sK1N4ffxHDrRXu+m5PIH/IKSUauu
         6TWryL+pv3LE7GvmCiuGcJmKNVra62GW9pQ+B1mZlK5mpHgKNCqfwyzxusJN6wtcxXi9
         mSuVpa3lSu7AuyLl2qtcBVWKs1Hu0IEAcnys0+3II+KJxTdzscP1hJQVYhd2RHsz9+jy
         AKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786601464; x=1787206264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4CZgQgtqSgEBIByF0ba8/VCvfRJbi3Foy+nTK4t41I=;
        b=nTH0hbFVtNs1z20CEAs9YUPrph9WhC1kLUrEONUx57bdu53z2dRtnyXZEzzzAWH9A5
         zuStqo0iHaoFR1vBlgod6WqAW5eEzZ1irhknqvzaBZc3hK4ERR9t2VssBn+4tWD+/MuK
         wO3e/U3nkI7p+7ymgNz0bet9ucbD/O9V2Gq8GZWfzwe9qz3YvQJiczn7plSYJppqc/Pg
         iNvKPEoSAXbvlnntq/i8LDDRjlXpCtDRssGR5cWH9fuhBcZUNBpr8Nyq3hqUJR5pF/gb
         NVbYUrZA3NB59aVXxb2OdFkfspT9fp635JKkH42v+vc3jdwLP3IKUG30O4TaniE08g/K
         3mSw==
X-Gm-Message-State: AOJu0Yyp0cTH7TTe8UdboKTgr8q94PmueonaCBfxJFC9N7Ci8CKQTZid
	nyQWLNu5deNPygqUmD37/mYT6j6O94ibakISCFVjsElomBa9vcCRULMYu/0mYGFH2tihZGmWmSb
	2d472xyvrgPPxU8h00con4Yg7fNrXyUc9IqEZ3TQCoA==
X-Gm-Gg: AR+sD11cJM9tbsLHJUm5kd2tk5qqFVd+cN7eWAlsyFQzb5lZ9T/X+AXU54j02Zmqzcq
	2EJYZom+zs9zaYP2peTdYEwdRSyB17di/0qPqkoJhFG6RTrK41KcAsHkunYvuI0hh5yxRGjpOFz
	JEi4eicZNDDUuyZx0UCqUC/5xNNFZEQzXmeC5nD5HaRjkqXTW1xEzwIZYfPjNaJp9qJJBah81Ck
	5ar7xMsWPJodYvyyAs081lW/Mz8R6ieIp+zU4a3Oe43OABk1DtyHUjaljZMDwV3LPzfPY2f0mub
	Gduouli1quy2uqa842jZDn1nIVBKBt2HWe1eppIU1J8LbpbEOL8yu4v1OSqhn08izx9mO71T0wv
	kEQWxG7wvzPmky1IkEz0pVA==
X-Received: by 2002:a53:d003:0:b0:66c:51c5:61dc with SMTP id
 956f58d0204a3-66c51c56c29mr1225261d50.14.1786601463405; Wed, 12 Aug 2026
 23:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <7a99ab77-bbab-46db-bd0f-159cc493da02@siemens.com>
In-Reply-To: <7a99ab77-bbab-46db-bd0f-159cc493da02@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 13 Aug 2026 15:10:27 +0900
X-Gm-Features: AUfX_mzrS3TtJqtDPbegyYkOY2g7CKGfHurOruOdSOV-PNQqGwb1UKVRNRBL6x0
Message-ID: <CAODzB9oN7LCpUYLmPdKJ0oRHsi6prbcNSK4zkFQZ1BbO5JpXww@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: jan.kiszka@siemens.com
Cc: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 06:11:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23909

Hi.

I will be absent from today's meeting.

2026=E5=B9=B48=E6=9C=8813=E6=97=A5(=E6=9C=A8) 13:55 Jan Kiszka via lists.ci=
p-project.org
<jan.kiszka=3Dsiemens.com@lists.cip-project.org>:
>
> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>
>     irc:irc.libera.chat:6697/cip
>
> The IRC meeting is scheduled to UTC (GMT) 12:00:
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2026&mo=
nth=3D8&day=3D13&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/08/cip.2026-08-06=
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
> Date the data is created: Thu Aug 13 04:51:28 AM UTC 2026
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Mon Jul 20 10:00:31 AM UTC 2026
>   limit date: Wed Aug 19 10:00:31 AM UTC 2026
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
>   limit date: Mon Sep 28 09:07:13 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Tue Aug  4 12:34:28 PM UTC 2026
>   limit date: Thu Sep  3 12:34:28 PM UTC 2026
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Wed Jul 22 07:47:57 PM UTC 2026
>   limit date: Sun Sep 20 07:47:57 PM UTC 2026
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Fri Aug  7 04:22:30 AM UTC 2026
>   limit date: Sun Sep  6 04:22:30 AM UTC 2026
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
>   limit date: Fri Sep 11 07:40:40 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Fri Aug  7 08:15:19 AM UTC 2026
>   limit date: Sun Sep  6 08:15:19 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
>   limit date: Sat Aug 15 12:51:56 PM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Fri Aug  7 03:53:04 AM UTC 2026
>   limit date: Sat Aug 22 03:53:04 AM UTC 2026
>   Status: On track
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23908): https://lists.cip-project.org/g/cip-dev/messa=
ge/23908
> Mute This Topic: https://lists.cip-project.org/mt/120729273/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [masami.ichika=
wa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

Thanks,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

