Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FC1C4345F
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 12:16:56 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web11.11911.1714652206027532855
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 May 2024 05:16:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Xpl3ZQWY;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23d15e31cf7so1220357fac.1
        for <cip-dev@lists.cip-project.org>; Thu, 02 May 2024 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1714652205; x=1715257005; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhWCtFg4d733fHGJZ4FcqMiY1fUMh484rmeqnH5i4yY=;
        b=Xpl3ZQWYBGsbPb+SWdA7Gjb/bffiT23r+OnJudapTNGDBfblVF8Gx/oCm0s95KUiXn
         MtPTvGqR9DsPgrcj03DJ/EVVo9ZNUMcu1zGjQytrS64WAjjOUbH+xnefjzfgCIbT2Qod
         3o0Z648M266WvI/Hi4FBZ83xtYuppBuAS45Gvq0ZQy1Td3xUIbuZ8R7Pn/pFfmJYNhwp
         PqINRbQmtS2bQEF6qGpQTOIhqzxrlHYESwqinN/MwlfZI1gFHHkdyeoeP23hBSmbTPWL
         5zE5TQhn6qgal0cTrfkSO2Un7lwmyzNiVXFTRFyEhLpVN3hNpQYA0YBza974DY/T8/7y
         z8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714652205; x=1715257005;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhWCtFg4d733fHGJZ4FcqMiY1fUMh484rmeqnH5i4yY=;
        b=ae3YgFcWwyzvbQ+qQmgpJGloeJrwjrBvGDZaaVyNI9M9boVEyKZdm9i9RE9lffU8OD
         +a44ccYL9ymuukYj3DA/bXQOCuBrFdIWZkySVMwm0cxMlBeCGKT5NR4de6oVYW7y7CKH
         S7sh+y6rrdlcsaIuGrTgXcEEyf+RipuRCzGuIXMBeXmvedQv0tesB49UqDTruzA29xIo
         mAMLCJAv4OWXalM3MY8rQoYLTErX8cSZQ8vBIRjr16Lq2gLHnXLBOJCl41FXpjGGolS2
         hBzms3uH8o0r7w9M5gsGTNJVcD4y0MagMwCYGK6CD6s30tsYVDN+JNQOYKTj5ex16VId
         kC1Q==
X-Gm-Message-State: AOJu0Yy3q4y9c0JfVMB4lITUlHKKWzIdd3b4Pj+nFTMkfJ/MCLLmBone
	LFQsIMEzYdx5dFzNBP84/u9QgoiiQwsvkWkNtrFxDFwxV+h8djJi5K78cisxXSlOsTTlvhN+yIr
	wQw1YOl/eaGhHCM4jNbhfcau5U2/qSeGq31S9mMVAEoiXmMcuQmE=
X-Google-Smtp-Source: AGHT+IEJD9Y4KtBCNmj879ztNCEowmu04zLuqnkgf4A3cuCfM8pvX4Cm7uNgnOAF0yBl0nJ2VeZs5gd97s5G7um3BHM=
X-Received: by 2002:a05:6870:171d:b0:23c:5a47:9f75 with SMTP id
 h29-20020a056870171d00b0023c5a479f75mr5940676oae.48.1714652204769; Thu, 02
 May 2024 05:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <b9153a9a-78a5-4e7b-abed-6be10463fbc7@siemens.com>
In-Reply-To: <b9153a9a-78a5-4e7b-abed-6be10463fbc7@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 May 2024 21:16:08 +0900
Message-ID: <CAODzB9qQJxQAJPp_Nw4sefWwycb=UEWz2OTDFbq4s5XdeP7q2Q@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 May 2024 12:16:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15807

Hi.

I'll be absent today.
Sorry for that.

On Thu, May 2, 2024 at 6:14=E2=80=AFPM Jan Kiszka via lists.cip-project.org
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
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&mo=
nth=3D5&day=3D2&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     14:00     15:00     21:00     22:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/04/cip.2024-04-25=
-13.02.log.html
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
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Wed 10 Apr 2024 08:14:20 AM UTC
>   limit date: Fri 10 May 2024 08:14:20 AM UTC
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Mon 18 Mar 2024 10:21:04 AM UTC
>   limit date: Fri 17 May 2024 10:21:04 AM UTC
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Thu 25 Apr 2024 11:55:36 AM UTC
>   limit date: Sat 25 May 2024 11:55:36 AM UTC
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Fri 01 Mar 2024 08:49:23 PM UTC
>   limit date: Tue 30 Apr 2024 08:49:23 PM UTC
>   Status: *Late*
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Wed 03 Apr 2024 04:45:35 AM UTC
>   limit date: Fri 03 May 2024 04:45:35 AM UTC
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Fri 19 Apr 2024 09:32:00 AM UTC
>   limit date: Tue 18 Jun 2024 09:32:00 AM UTC
>   Status: On track
> linux-6.1.y-cip: interval 15 day
>   latest version release date: Wed 17 Apr 2024 07:29:58 AM UTC
>   limit date: Thu 02 May 2024 07:29:58 AM UTC
>   Status: Late
> linux-6.1.y-cip-rt: interval 30 day
>   latest version release date: Wed 03 Apr 2024 09:29:14 AM UTC
>   limit date: Fri 03 May 2024 09:29:14 AM UTC
>   Status: On track
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15792): https://lists.cip-project.org/g/cip-dev/messa=
ge/15792
> Mute This Topic: https://lists.cip-project.org/mt/105859443/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/452041=
6/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

