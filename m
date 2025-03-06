Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A779C282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 07:08:01 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web10.7181.1741244880321071496
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 23:08:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=lxdu3Szh;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.170, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e608b2698fcso205212276.1
        for <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 23:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1741244879; x=1741849679; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9haQGaVYFaJVaIHpCiZF9FRUWxeHVX9tmyVP+1q7JiA=;
        b=lxdu3Szhx3QFPIi+jXrlkLjjKbPI53JdTNgSYoR4srXYOqsO40HJjLRFjV57M9gw6V
         2rnACJfoRsJja4q44BNYnk+Yg6b/kYrmLiuuXkDUuyeF2lCQRVqxW38H/luMgvVr3nd+
         LMWzxMnZzXS6bU/KzTLBv+MM8r60Bq1ibBcdW5qw+RAFartqkkZbFAxZwgDn8ZLrWXjC
         36lGsB5cT+Zumt19yQxWQ9O+Lp+y7ZxtWHZ15BCHlrHJQag9ut/dLlwe1W8HSmLe1pnU
         q6Ptm4PNSqZM+O1ZlRPOPlESk6gDsjd3eljaItISBVrYfqwjiqLXhBjZ5VdJVnLKEImB
         kSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741244879; x=1741849679;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9haQGaVYFaJVaIHpCiZF9FRUWxeHVX9tmyVP+1q7JiA=;
        b=EA4jCrpB8PptutpWZM8TKS95Wjbn6MTBOHPiRMVNxCCukx/+ocUASyvmbKQT4gsVIf
         +KYoJNOxn4ZFn1cx1S1o+ckB3GsRCqiSs/5ukCetFYtBE2FksnpXGBRKIRZBDCmcymS5
         nvpSi3kTAPiZG7gWh2bVAmBjJ699yRPQ1XCecDEpHrjZEJcVqzxnSHoLhkTRB8OOxwxJ
         GEkVELN3A2lmSI8RAQMlaYHqFaYCgPLQku6cQ+AnEv79OvS4GX3FZguXfHZ3XByig6lP
         FeQ7y/H6KmNNYB5Kqv6GF/EAB9sVg52iKSAAg0Vn9UpzWsaRUyBYuRZ5Urnjal/eBLhY
         e6YA==
X-Gm-Message-State: AOJu0YzwjwQ5ha668VAyNaeuDUISsxTiqmA64x/Xi8MUGQnTyyyfqPqE
	Zp24Vo2qGasxXmAHIYeOEC3JufdxPR37ETuJ5X3yxAZCc6Qyo+YJEUKBdIajSj7EV5HQ/V492DX
	Ol23TiJ9tQSsgbW3GxaucDn57QcyZcoW/4zoXSobH2XWD60yE
X-Gm-Gg: ASbGncuLFCngNDon43M6lMTK4DDSVwfGgNS8KOD1OhuOnOMKMcT/KXeDxrlNuD/awaJ
	RGaV9F+emNV9lxhJ+F4pLjGuWzHimlih8sN7FC4AiGHGcoVU3WeVJ+b+asHKtD9tjnYechO9Rhu
	cf1HShId2pHgxP6urXbq0umva+HEY=
X-Google-Smtp-Source: AGHT+IGY7s0bni1A8PMMnKNIXmQY9m9ZNn5H/zAyGRGhq6SiLoXXHcsf3SCYTrwZ43WvdEHQuJqmPLwPpp5YBO5ACJg=
X-Received: by 2002:a05:6902:1104:b0:e60:ac55:a68e with SMTP id
 3f1490d57ef6-e611e196b25mr8268448276.3.1741244879171; Wed, 05 Mar 2025
 23:07:59 -0800 (PST)
MIME-Version: 1.0
References: <0eb43241-5211-4dff-87db-cd6086e69c2f@siemens.com>
In-Reply-To: <0eb43241-5211-4dff-87db-cd6086e69c2f@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 6 Mar 2025 16:07:23 +0900
X-Gm-Features: AQ5f1JqM16etDb4qUMoqknyusNrqKy1TgkHlyDWM_nc9lH1ca9aNnzr8pA7IjZE
Message-ID: <CAODzB9qEbPKMpb_CpwiMstYKpn315UV1fSj9a07PG6yhojvq1A@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 07:08:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18051

Hi.

Sorry, I'll be absent today.

On Thu, Mar 6, 2025 at 3:49=E2=80=AFPM Jan Kiszka via lists.cip-project.org
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
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2025&mo=
nth=3D3&day=3D6&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     13:00     14:00     21:00     22:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/02/cip.2025-02-27=
-13.00.log.html
>
> * Action items
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
>  - input for extended TSC meeting
>     - status/reflection on self-maintenance of 2 kernels
>     - status 6.12
>     - feedback / next steps CVE triage tooling
>     - anything else?
>
> Jan
>
> [*]
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Thu Feb 13 07:52:32 AM UTC 2025
>   limit date: Sat Mar 15 07:52:32 AM UTC 2025
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Tue Feb 18 08:21:29 AM UTC 2025
>   limit date: Sat Apr 19 08:21:29 AM UTC 2025
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Mon Feb 10 02:15:53 AM UTC 2025
>   limit date: Wed Mar 12 02:15:53 AM UTC 2025
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Tue Jan 14 11:41:15 AM UTC 2025
>   limit date: Sat Mar 15 11:41:15 AM UTC 2025
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Thu Feb 13 10:01:34 PM UTC 2025
>   limit date: Sat Mar 15 10:01:34 PM UTC 2025
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Tue Jan 28 02:45:55 PM UTC 2025
>   limit date: Sat Mar 29 02:45:55 PM UTC 2025
>   Status: On track
> linux-6.1.y-cip: interval 15 day
>   latest version release date: Wed Mar  5 05:05:09 AM UTC 2025
>   limit date: Thu Mar 20 05:05:09 AM UTC 2025
>   Status: On track
> linux-6.1.y-cip-rt: interval 30 day
>   latest version release date: Fri Feb 14 05:24:30 PM UTC 2025
>   limit date: Sun Mar 16 05:24:30 PM UTC 2025
>   Status: On track
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18050): https://lists.cip-project.org/g/cip-dev/messa=
ge/18050
> Mute This Topic: https://lists.cip-project.org/mt/111543867/4520416
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

