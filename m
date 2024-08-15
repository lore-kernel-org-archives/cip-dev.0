Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A6C3DA7F
	for <webhook@archiver.kernel.org>; Thu, 15 Aug 2024 10:46:48 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web10.120042.1723718801893938107
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Aug 2024 03:46:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RiftsIiq;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: iwamatsu@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d7a544e7so49913385a.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Aug 2024 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723718801; x=1724323601; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7l3LOJtWeNnCUDLSEfLOMIly421dE4iYHu9UhJugU+4=;
        b=RiftsIiqk9D0wYNKA2qzgGyCNWjFHgqYUKV1n6ZB+VTZCWfliDbCF6vUZ2Q4Dix0G+
         lGsnAadqvulmRS+Hoqhwf9/myb1Oc/XLGg7um6TM4vM6UOH1M03vwo3Dl7sWFayYN5z7
         uTP3AN1IfMpFh84j4OoFpPKxlIhj+dfhfNAwePkN5FZVv7xmBO8x3CVSQZq13IPbmvhW
         EY/DuHubVsHYe+XwaBpr+rcnt8MZ2fDDZW+1SFnrqiGwg3HIlf8EnQ+M2XVtQGh+coMY
         1vl+Vbjp+546ZzuhjlreyU3p6kl6j7n/3emL4wzfw8cGa9p/1xT5OoYNgRcHMpFKTTGt
         b33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718801; x=1724323601;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7l3LOJtWeNnCUDLSEfLOMIly421dE4iYHu9UhJugU+4=;
        b=eCt/x8gP1kGx27Yg78vPf8zELuyl6OU+Sh4np/5lU2G+5+N3d6qJxDewN0VMr/bGjT
         AlqNjWs0wRii74eYa3WBlXWsnO695t8z9RGIDqbjwbY9zcQ2wPUp08hxGT0T77gbbsNv
         zQn9W1VCakhNt8Y/eZZdbqmdhj3RWnOFMr+fVoK/mUKUySM0NCvWEMO0Vlb/eWEVf0sd
         PNVISjK0JXwTX5uwszncbaOJW4IyOeEJmshnjiW4x0t0yRu1qvpEMRRMSR/Fb72lz9AF
         CMa4IkNgvFmfypuiZ8cWNTE5UIUbaF2oxee7RuJ1ABxKMmmwXkm4KnnNs6xX8sVIhPpK
         anvg==
X-Gm-Message-State: AOJu0Yz6RLVlTV2wSr3cWDuwwXfEMApnmyn8zPeTESvgr3p8c2WkR0vy
	CBCL8y1Lqnu9iONHlBbSEekXPifM+lZD/q/BSGNyM3JbGX1CyBjvwfYHJtHp72LWKfJyEK1S0L+
	Qbr3IEVe0ViEROzt8dafHRDRzCDdPIPfu
X-Google-Smtp-Source: AGHT+IGgUNWFRcvyYaJ0K0aW4I+or/Gd5HIHKkktv0jRcjuVzJF1ffIL8eaBFjsTJijAY6aIN1gSuCAZsNMFmZ69w0A=
X-Received: by 2002:a05:622a:418c:b0:451:b7b6:3573 with SMTP id
 d75a77b69052e-4535bbaccb7mr70896111cf.50.1723718800502; Thu, 15 Aug 2024
 03:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <d9534eed-0fec-43a8-a245-6e5edbf62c68@siemens.com>
In-Reply-To: <d9534eed-0fec-43a8-a245-6e5edbf62c68@siemens.com>
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Thu, 15 Aug 2024 19:46:29 +0900
Message-ID: <CACe6DC49FtrUyQF3qEaRtx+9T3zZ+yS=sSidv3C+P_WQevkZ4A@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Aug 2024 10:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16790

HI all,

I can not join today's meeting because I am on vacation.

> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
>   - look into CVE triage tool [iwamatsu-san]
  No update.

> linux-4.19.y-cip: interval 30 day
>   latest version release date: Wed Jul 10 07:05:27 AM UTC 2024
>   limit date: Fri Aug  9 07:05:27 AM UTC 2024
>   Status: Late

I will be releasing it next Monday.

Best regards,
  Nobuhiro



2024=E5=B9=B48=E6=9C=8815=E6=97=A5(=E6=9C=A8) 16:19 Jan Kiszka via lists.ci=
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
nth=3D8&day=3D15&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     14:00     15:00     21:00     22:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/08/cip.2024-08-08=
-13.03.log.html
>
> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
>   - look into CVE triage tool [iwamatsu-san]
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
>
> Jan
>
> [*]
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Wed Aug  7 09:06:02 AM UTC 2024
>   limit date: Fri Sep  6 09:06:02 AM UTC 2024
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
>   limit date: Sun Sep 15 01:30:36 PM UTC 2024
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Wed Jul 10 07:05:27 AM UTC 2024
>   limit date: Fri Aug  9 07:05:27 AM UTC 2024
>   Status: Late
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Fri Jul 12 03:18:17 PM UTC 2024
>   limit date: Tue Sep 10 03:18:17 PM UTC 2024
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Fri Aug  9 01:12:59 AM UTC 2024
>   limit date: Sun Sep  8 01:12:59 AM UTC 2024
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Fri Aug  9 05:08:44 PM UTC 2024
>   limit date: Tue Oct  8 05:08:44 PM UTC 2024
>   Status: On track
> linux-6.1.y-cip: interval 15 day
>   latest version release date: Sun Aug 11 09:13:17 AM UTC 2024
>   limit date: Mon Aug 26 09:13:17 AM UTC 2024
>   Status: On track
> linux-6.1.y-cip-rt: interval 30 day
>   latest version release date: Sun Aug 11 07:14:28 PM UTC 2024
>   limit date: Tue Sep 10 07:14:28 PM UTC 2024
>   Status: On track
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16789): https://lists.cip-project.org/g/cip-dev/messa=
ge/16789
> Mute This Topic: https://lists.cip-project.org/mt/107909979/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/13258555/45204=
94/222682861/xyzzy [iwamatsu@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu

