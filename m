Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABEBC98314
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 07:19:40 +0000 (UTC)
Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2374.1790234375245835596
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 00:19:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=a3J9h8+o;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.170, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a45b788a71so17496607b3.0
        for <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 00:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790234374; cv=none;
        d=google.com; s=arc-20260327;
        b=r9mIWn75lHpb4FpIObL+0mx6ikvkXSDjrZHtM0JcJMkN3BJ1CzcBQUzyjPYYdzLT3t
         Tq5X4OxT08G/+CbZQGtvhM7IGpNoAqitjRhlvsdTIF6mW6Ug1dzjcmvYA/+UIrmPD1XW
         6e4BtLq6bD5E2e1dutUtpk8FIj4RG1ttc4aw7QYt9qXQbNlO5AdYucIIvLUGVeKcC1/I
         CpV7yCkoc8LX5EMXmZfMcNxaRfvLEiXZPQ8MG9akjdqlRos94bZkXdIzINo/QWQWjwZz
         a81aMNFd9+4N6CVmr270kEQxyttYbawE9GOOyubrOsHj83qEEHUyFdTkPjgnzuLa8X0f
         tp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ip7vSb3Fbjr4T6rz/Q29ehXyNPjXTKm7gujOck0Wrg4=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=m5GS2VxwT42o7DjdAu10VuOKSppNiuGMYqkmKkX7broA+rgJZHW8bFnkN2AySqEPGc
         zWXGsKJreFkCe1p6jPYUY+HE/7J7hRoqUkprhdUZX4dW29AipS3U4y3rlZQ2p2CDw89j
         4zMb9vk3pG5FcwN2g30NxShWSau0GT38U9ifgnJIll1Vs7Xgg+gwWNIq0zgG8JgFnTn8
         n2nN6vYcg8+604wXUaWkX7Yi/ZpLRu43IXhZMg5cEa9Gd7ODeSAVIsLCin2TJgq9s1XU
         5X5viTQSuQkf/UwRvxrLCZa8Y8sYKQLjltc5MeHwIHhNV0n6xHyVoRaLM3adBqePj1PH
         LgNw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1790234374; x=1790839174; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ip7vSb3Fbjr4T6rz/Q29ehXyNPjXTKm7gujOck0Wrg4=;
        b=a3J9h8+otNBcI1xm6OdfC1R5LS1qIWEi48GNJowM5Tx/DLMZa65+YX/aMyURMn99Zs
         QhC/QwVPiGxm/8gJ+n9sSvI/60++2jAejUEn9weeqh76ROCjuSvn2VO32tNYLFphevuV
         Tz7GULV4eb2rt99edmGl0JkxcR0t49kD6A+CSmIcuLzO2iGEh6AZNX34IpJRAG/WPgII
         zQejJWbqvUFueIfU47JS3vnJale2Yudswp4uWcM4O0wPW/cpmV5A8LQY5Jo/5t2IaumX
         HMQssqXKwqwV6AoNzceWqwVyRR0wWsR3ifGTuYA3ysDBSb3xhmRVM6C45lrX3DZ7lBg0
         +N5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234374; x=1790839174;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ip7vSb3Fbjr4T6rz/Q29ehXyNPjXTKm7gujOck0Wrg4=;
        b=cK6JEVGJLpbZeV7Mvoz1q4cKgBCIympQHmd1Us5t1yaYl1X3J9X9iAQ+KHsSFhDnE8
         /R6MHCH65qxqfE/m7qhtwZV/e573TQN+E0cKYN7UTAnwmEcADiY/tf8wl85DTd60FzeZ
         LBgLUmVtEpp+tYjLqRyB8sKPH8apGDWQA5+11xQeCGrbL36lI96QJynAMS/k93EF8YK1
         zfj84fT6m28C9dLgo4fFazMt9z+AaQCQLiUn7roVtGQP0kpfWDw+dZFpWszHcg8+wtOR
         1IGljv/9qhEg8nC25OjP/w0NqU/x3aJYw56vVC66yhznqkiHLjQTQulDzgHq24g5g0oo
         Xn4A==
X-Gm-Message-State: AFuF++nb7xMKm14BH8a4AIr2c44FMxwgIN+V6KuaGk5rEiFc6FP2q2/v
	DWHhb+UohlVtjWp7yG4VI7bR2a2L3wY04RARTZ6Mvjib3EatpHOF+4uTPqq6k/sGM0bByDOoz9G
	/ComgAjsU8oj81lgEQ5hqAylhH1yQWNm7B8optzUxdQX1mS4Fl8V6vqZMuQ==
X-Gm-Gg: AYBFou2N2VxHBOWypgXOOASriqd+fvW2718CM4+SmdIYJuA2OYY6JK8cYEOo5osAzO4
	bTLyr3CATknx8nw2D6XSpoXej7sQWqdbfpcDI4d1YRCEkWRsjOUOCg62UFrxch+t0yTni5zb4P9
	jm4RNeR8IJUghfsWvapPj1oQD4Jy93JI6Bs5IdQRMbxeMgwJSpMAdhsOzvFWHTPpPwR4zZ9EfWB
	ODvtQCIUKKGugP2X6dUF5q5uzpJbylgCiG4lomj24XxEHHbO4zd+9snkfwXiqalC2cB90+Fh8FU
	IqbdhRxTrX3PiOw2CzP+mMq3LD5wCJVMe0+Sbd/Mwu8Wtqg6zzJcao8vZSFjZUAkXQGnaAj9FIX
	HHbJbJ25NZ3wqR92fciU1krrs6MDE7sx7iep+sA==
X-Received: by 2002:a05:690c:e3e6:b0:866:7724:3bcd with SMTP id
 00721157ae682-8a648fc1493mr8444387b3.16.1790234373969; Thu, 24 Sep 2026
 00:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <1859c4aa-3da8-4a00-be0d-7234c6db0076@siemens.com>
In-Reply-To: <1859c4aa-3da8-4a00-be0d-7234c6db0076@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 24 Sep 2026 16:18:57 +0900
X-Gm-Features: AclHuK8Lhja6qdhlibrz9MueNNgC3lf8WtRraL00fKns4pSAQEvPro12IN7yOkM
Message-ID: <CAODzB9rYxOoBO7-1vCc5BY5SU0BSj9Nn19BUs6yxXtXSJFq7Rg@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 07:19:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24286

Hello,

I'm sorry, but I won't be able to attend today's meeting.

2026=E5=B9=B49=E6=9C=8824=E6=97=A5(=E6=9C=A8) 16:03 Jan Kiszka via lists.ci=
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
nth=3D9&day=3D24&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/09/cip.2026-09-17=
-12.00.log.html
>
> * Action items
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
>   - SECURITY.md
>   - LLM review tool: updates, feedback
>   - /me absent next week
>
> Jan
>
> [*]
> Date the data is created: Thu Sep 24 07:01:12 AM UTC 2026
> linux-4.4.y-cip: interval 30 day
>   latest version: v4.4.302-cip114
>   latest version release date: Wed Aug 19 08:54:45 AM UTC 2026
>   limit date: Fri Sep 18 08:54:45 AM UTC 2026
>   Status: *Late*
> linux-4.4.y-cip-rt: interval 60 day
>   latest version: v4.4.302-cip113-rt62
>   latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
>   limit date: Mon Sep 28 09:07:13 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version: v4.19.325-cip136
>   latest version release date: Fri Sep 11 08:53:07 AM UTC 2026
>   limit date: Sun Oct 11 08:53:07 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version: v4.19.325-cip136-rt50
>   latest version release date: Wed Sep 16 09:32:17 PM UTC 2026
>   limit date: Sun Nov 15 09:32:17 PM UTC 2026
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version: v5.10.268-cip77
>   latest version release date: Fri Sep 11 06:54:50 AM UTC 2026
>   limit date: Sun Oct 11 06:54:50 AM UTC 2026
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version: v5.10.268-cip77-rt34
>   latest version release date: Thu Sep 17 09:59:47 AM UTC 2026
>   limit date: Mon Nov 16 09:59:47 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version: v6.1.187-cip60
>   latest version release date: Fri Sep 11 10:35:49 PM UTC 2026
>   limit date: Sun Oct 11 10:35:49 PM UTC 2026
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version: v6.1.182-cip59-rt31
>   latest version release date: Wed Aug 19 06:16:01 PM UTC 2026
>   limit date: Sun Oct 18 06:16:01 PM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version: v6.12.108-cip31
>   latest version release date: Fri Sep  4 12:46:01 PM UTC 2026
>   limit date: Sat Sep 19 12:46:01 PM UTC 2026
>   Status: *Late*
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24285): https://lists.cip-project.org/g/cip-dev/messa=
ge/24285
> Mute This Topic: https://lists.cip-project.org/mt/121405957/4520416
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

