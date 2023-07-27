Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939B1C001E0
	for <webhook@archiver.kernel.org>; Thu, 27 Jul 2023 11:31:19 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web11.5123.1690457473820237090
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jul 2023 04:31:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=Q18RzCqS;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.48, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-56352146799so609987eaf.3
        for <cip-dev@lists.cip-project.org>; Thu, 27 Jul 2023 04:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1690457472; x=1691062272;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVwMU7L/K6j3QqYUq78726b7loa5JN5cw3ZyICcWg5Y=;
        b=Q18RzCqSANArvmYHJ2HZzfMTkIUfLOhdiFpIip0ht9K2xZejCDRxXV5OGHr5fC4hL+
         rkRSvdTE0555KME3tZS+3TapyLXbKwXuoBYmTtJUH9DM3LDMn3ziZZg0kQxnn2y/1Mjk
         AskvnVeZa6BZaHTnYpnVuf3cn+EcsNw/c3VzAyiISYwoLSX377T1MNQjX3BKkZn8H5m3
         iAQmWbuZKyluuXPa4HqN0R5rbsBHQjx4bvfZg4Qct2Iqk3RUoh4IuYUqahBUe9c1Wwqo
         bKLKrF/757dcd7fimxXXKDUvUzEZUEJ4Xjs3R2bN0tLWWfaz6O75L0dY1HBdWRGGRhp2
         +YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690457472; x=1691062272;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVwMU7L/K6j3QqYUq78726b7loa5JN5cw3ZyICcWg5Y=;
        b=VCAAFRrGVB6NbbTzqLfCDNiRKosHl/R9qogr7M2yYoTbJvFTDljkyJ9pXPqMp5Q1w/
         ksh6F5Fx2YNDMbehw/ZGBK4PzC6R9iEYFPRBtLImNHSwMNPtKJmfhVu2oSMsZatBNPf8
         QO4WtqTrSBC31t57V954iu7rrXe9L5WWRKHzhP9PG00C72Rv5W3PT+WWINfSfm7Rm0md
         uyFznYbufFOqLw75GSQCHrsclSHqEAiT8+9gKShCOXO2ZJCkUSimSD4ZSOEzQBcETQEl
         t123iP6kEAsqZB6BqbIeiVVwbI45eAf/1j+WbKRNXixxC6TgU2kFv0B3MRVyOnnr8jnn
         YxFQ==
X-Gm-Message-State: ABy/qLbry39IHJ6r7gOh6AJLTL8QirRfsxOdE5lZ2jtKwM1xXKXPw2eO
	q0W1Q7npMlUeklg7Piyx8hz5rg1aN8QRn53Qr+RG/YgP6Qwhyv5qiUg=
X-Google-Smtp-Source: APBJJlEY1puguf8vZG6/ajhGOudPgKh/U7KLfalCFnMTu4Wattp32aV73iAKfKTygWFHwNjkd2VRee5BTNAH0Y/lSLA=
X-Received: by 2002:a05:6808:302a:b0:3a3:95f9:c99b with SMTP id
 ay42-20020a056808302a00b003a395f9c99bmr3189670oib.35.1690457472163; Thu, 27
 Jul 2023 04:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9p4_fh21bZoSMyMiF2QKDqE09kZ0b7mHR99LEw0mCF=ww@mail.gmail.com>
 <ZMI4NgQK+Yak7o2A@duo.ucw.cz>
In-Reply-To: <ZMI4NgQK+Yak7o2A@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 27 Jul 2023 20:30:35 +0900
Message-ID: <CAODzB9pF1b7iup5PMtmjb0+xV+ExhQOBj4pr0aRXjn4Seqx2Qw@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jul 2023 11:31:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12509

On Thu, Jul 27, 2023 at 6:26=E2=80=AFPM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > It's this week's CVE report.
> >
> > This week reported 8 new CVEs and 5 updated CVEs.
> >
> > CVE-2023-20593 is the Zenbleed vulnerability which is not a kernel
> > vulnerability.  However, the Linux kernel added mitigation code.
> > CVE-2023-2640 and CVE-2023-32629 are Ubuntu kernel specific
> > vulnerabilities, so mainline/stable/cip kernels aren't affected.
>
> Thank you for the report.
>
> > * New CVEs
> >
> > CVE-2023-3611: net/sched: sch_qfq: account for stab overhead in qfq_enq=
ueue
> >
> > CVSS v3 score is not provided(NVD).
> > CVSS v3 score is not 7.8 HIGH(CNA).
>
> I'm a bit confused. Is this trying to say that score _is_ 7.8?
>
oops. Sorry for that.
"CVSS v3 score is 7.8 HIGH(CNA)." is correct.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12507): https://lists.cip-project.org/g/cip-dev/messa=
ge/12507
> Mute This Topic: https://lists.cip-project.org/mt/100381501/4520416
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

