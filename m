Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1305CD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 06:15:00 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4976.1779948897177873841
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 23:14:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=LZixLvPd;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7cb345cb5bfso102958517b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 23:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779948896; cv=none;
        d=google.com; s=arc-20240605;
        b=WphQ2NUr+/I6cMVkYUzrMI/PRVkVPHVXa+FytMfDp6r+ot46SDiC4Q6eF2ifrlCp3I
         c+w7FRMYKc4GXps0jSCVz29YISPuODmWZRB1JeU65dc3XxKpxVK+WfNBafCXhJ9q2z/M
         n20C18O2CFzA/HKnoVJhKuaIHyVvYjirICFi+MUOAgPKJYO+iYHU1XWGi3JbArSbNIHn
         POZiOkf0dS1iriphpESk97XjXECSRfzkJfCKItKjuDwnpqhgsjUgqEDc6uY0yrHvP39Z
         SyASigRHfIhoRzLulOeRVHuuZ7zPiM5Anpwn6JyIDNvZVr3D4KukCJLhvwo/gyCuv0wT
         Cs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qr89JlD77C0UWpqX2KvkoAUY8k8apDciDqtQriSl2yM=;
        fh=TKnUO5H0/SHOG5E2xt2hiOHSMeYkP2viblmO0veQLUg=;
        b=BoOAo61qIO1AJ2Z4O37kCfsT/K87uMyvkBuyHNRjDg+2iWkbHo10/ndARjHMhn909c
         tkUd3CMTZpDw8xKzinE1FfLMNlnANmXxKgD4JCuAGSLFes2t5oMKI+X6W0vPwQ187bGx
         qVY4/c6p40QtwUQtg6MiQACZt2CUB7cekiqsKIkLB6ZOJ9OtiHT2Vwwjmtcwlrl99wQp
         KbXr3jmG1gLpGxcNXFYbL8z3BPS3ev4xcjsOeAFTd9Fx84fhdZndFZ4f0Rr/mw3VucGS
         ltPs1NmtXp2R4Av1OnTDXH1MMuoeUqvPPPwKLddjXIhXRXaMLN3d2998GYIWCqRdVn9l
         3oIg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1779948896; x=1780553696; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr89JlD77C0UWpqX2KvkoAUY8k8apDciDqtQriSl2yM=;
        b=LZixLvPdKrnTO8TXx0dgp6dq8n3hxX8/kOe5GnFZorhSUrFQxFok1fWEWiQqFMg3rg
         ijOJZ0SbXj3ccsJ80RV6DYFE8YuULRHB8kFjXOX+UCh+VSrF9cuWb8OOnrQmhsUH5oHw
         m/pO0uuXiql0ysr8xtuPXyW02ViU//F1i4mP3ETFtl2l78MdNMpLLIhjqszmJxNMiw4Z
         E8hQ2IC4pZjDuCXwaWqscuid4EnNW8oaiUDqUbewYK0ui6YejOoUNw+NRfWbddSAC+KW
         WaKJt2T7qSqKdmduI5m21++4EKPupPrQpKx58AX/FfV9RTiXkU6bXwoPK7KYFmh3U3RF
         OaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779948896; x=1780553696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qr89JlD77C0UWpqX2KvkoAUY8k8apDciDqtQriSl2yM=;
        b=O0AfhOuM3keyKdZOcsMb9cxtxzWBjssTDY/MuEOhkst7ngj5hMqmtJ5GswVaiPdCDG
         OI6xenTAg7NeLbxB5a5ThQknpNlxMKmEzwKVP/LAu4LwpP3KOjVkpcJeWk393Ae82QDO
         zxUmtjyINn6m76wWk+WHkNzZXLKXwX+joJu9hqTWRTEtKDriUFWjAZxMcdFMUm7n4j5U
         X0Bq5JG2KKnxb55RpH8bBPMkKYeDukv/hnGuAKV9R1plvaM3zn7Kiz8CZ5EWLD7rUtVU
         bcEMtMa78OjsSILrOujNNeoQ0v+8hsyef3RbaT6P454jufttwzv/RvV8ZnCLc9/FKPk3
         1HZQ==
X-Gm-Message-State: AOJu0YxWzLbFv6EFoGUsdVu3Z+8mBeK1jXwetgotY0XibaOTeyCJKT4I
	T/AJz6zi9FSERvQoph7YjUJ4R307DXq19K2tAZEaeuqf5/GcGU44cG6Pw+BlFX4j7cUMQ34+baO
	NOzOdueVccMYHAFG/kpa7+OJZGA89UfG/W4tLpcWqGw==
X-Gm-Gg: Acq92OHTkTnr26WBPIndi9jFjsd6jp1tp8MPPIMloHUDTtVPUU7TahFTJubTrnNAVy/
	kLqF8/NdevjBKinsNbqUxJ1HTUiDxfLKaVcWUoVL0lCO/+LW0r2CbwMKeR3on1yg4GEPPIEsNjC
	fcEimPokVT/s369As9SfUJGrCMQG5AN3GuRceqvz+M2Tl7xnvR1mbKckCVFpKZRAYOZfoKuy8vn
	SL7sY8khWQhrkPGY0cQXRTZwWHqobl5bFesGz+Q0jeq4EIGzKLPQGSF06b4LUHN4rH9kv2EUTa4
	CbE9TiwEXfcdSR2/7rY=
X-Received: by 2002:a53:c04a:0:10b0:657:656d:5680 with SMTP id
 956f58d0204a3-65ec998b473mr20210316d50.53.1779948896197; Wed, 27 May 2026
 23:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <ee790f7b-6e1e-4dc4-91f3-f93c3fba4d33@siemens.com>
In-Reply-To: <ee790f7b-6e1e-4dc4-91f3-f93c3fba4d33@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 28 May 2026 15:14:19 +0900
X-Gm-Features: AVHnY4JbtT72hqprGuZ1-BYZXn88oazC01rmRN3f7wpJythuMiQIBaMLVKfSA5Q
Message-ID: <CAODzB9qywnQFn4O3WH+qttjarsh5=q7uUxpd7NXLVFXUJJTZcA@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: jan.kiszka@siemens.com
Cc: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 May 2026 06:15:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23031

Hello.

I'll be absent today.

On Thu, May 28, 2026 at 8:18=E2=80=AFAM Jan Kiszka via lists.cip-project.or=
g
<jan.kiszka=3Dsiemens.com@lists.cip-project.org> wrote:
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
nth=3D5&day=3D28&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/05/cip.2026-05-21=
-12.06.log.html
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
> Date the data is created: Wed May 27 11:16:26 PM UTC 2026
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Tue May 19 02:53:20 PM UTC 2026
>   limit date: Thu Jun 18 02:53:20 PM UTC 2026
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Mon May 25 11:40:18 AM UTC 2026
>   limit date: Fri Jul 24 11:40:18 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Thu May  7 11:06:48 AM UTC 2026
>   limit date: Sat Jun  6 11:06:48 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Tue May 12 11:56:37 AM UTC 2026
>   limit date: Sat Jul 11 11:56:37 AM UTC 2026
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Fri May 15 10:25:33 PM UTC 2026
>   limit date: Sun Jun 14 10:25:33 PM UTC 2026
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Mon May  4 10:49:51 AM UTC 2026
>   limit date: Fri Jul  3 10:49:51 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Fri May 15 10:28:23 PM UTC 2026
>   limit date: Sun Jun 14 10:28:23 PM UTC 2026
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
>   limit date: Fri Jun 12 11:43:31 AM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Thu May 21 11:47:46 PM UTC 2026
>   limit date: Fri Jun  5 11:47:46 PM UTC 2026
>   Status: On track
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23030): https://lists.cip-project.org/g/cip-dev/messa=
ge/23030
> Mute This Topic: https://lists.cip-project.org/mt/119522314/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [masami.ichika=
wa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

