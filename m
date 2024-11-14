Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD326D41C3B
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 05:15:56 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
 by mx.groups.io with SMTP id smtpd.web11.30893.1731561354474220121
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Nov 2024 21:15:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=OamYj2+r;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.175, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e5cec98cceso2200397b3.2
        for <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 21:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1731561353; x=1732166153; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrhMnt5zERd5669Xoe1IhdET+Wk7qo6gSDcJNRcZ0nw=;
        b=OamYj2+riJ1yQqAAw+JFlucceDVdgsntMgQMgkstqEcd/YmiVxOal4ZdUfjW+2PSSj
         8xNo+SJniwYSx9BQYWp16kjlfpdnP7u2zNp3GYrwDbUo9ppxHEqG2VshIL9a3SIWhWkY
         QI4v9XvZRd0slnoZs6R3IquPHEE/fDS3Lbw5om+bpDGuHVuX99+mce7xF2y9PKX704nB
         V3KmZWe9d2rZGmceb9LsdxD9geEiNKu4pzJMABRgkEgc7A2qMUE0Fu7wxKR9wttPqcLN
         djx8Yb5EXJHI5I01qGTlcfymLwILSeb2na0GjO8dKzA6g7kNjW0hwcLS9iw6uLJyvBo2
         ToMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731561353; x=1732166153;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrhMnt5zERd5669Xoe1IhdET+Wk7qo6gSDcJNRcZ0nw=;
        b=cxHRcZplpgRnwnrRMx6k1Xv466gKY44h1Subk30JizN1bo/781edj+39bXhZPcblzA
         MwtD/zj6U4jV1OxVhdcQ0grhCe8ccD2vHzbUCrNOeP3aJUlmCJg0fXfqKc1Sh6o2c26z
         kSwQjEXA9A4oOK+HvKRFQfxBImuvTuDHVYjf7RvsID6aOyQdHORqjYKog2qdhu+cv7LG
         Vuwsrq4AqzMfbaR8rLgyxXTwI4nm1UJM0/ltzqy1Qwxykb2iCpuzmyYMkkTICqSSlelI
         k20odyTNl7MODCCfVhfFlO4CLjrToB6d/62NDnlEekDU+SQMRVZaI2lHmt61SG2Ts9cM
         hrDQ==
X-Gm-Message-State: AOJu0Yx9uVIvglJBaqmE7iJzGTH7fpCnBB/5YNL1arEwMoXDOE1vdy1N
	WG7eI8Y0u55g5pdysui0G4xlqXT1tJLej3a0BcBExDHqtZWaTIvIZvYM18+GMJ7hqWgixseiSK7
	h4CLV92OXmbmTim86QOqPeaXNAVriC3FIbS6dB5kr8EStIFzCdfc=
X-Google-Smtp-Source: AGHT+IEkZo8DWQJ+0M8CL2/EniKYOtJvI805Qn0XLCWjSbu6pZ8HEwiBU2MayCTzynlJi/kk2X8cBMVhOC0+hO9Qwds=
X-Received: by 2002:a81:fe09:0:b0:6dd:fb48:118c with SMTP id
 00721157ae682-6ecb347fa4emr52019107b3.31.1731561353387; Wed, 13 Nov 2024
 21:15:53 -0800 (PST)
MIME-Version: 1.0
References: <CANgtXuMj3LAc9PNomZ=DXrX-nqRNWUGMGOkskqRY9BNawX5fog@mail.gmail.com>
In-Reply-To: <CANgtXuMj3LAc9PNomZ=DXrX-nqRNWUGMGOkskqRY9BNawX5fog@mail.gmail.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Nov 2024 14:15:17 +0900
Message-ID: <CAODzB9qE2eV0Z3OCsRpxx6+avD3E8j=yxRh5UX0m5VsnFR43Mw@mail.gmail.com>
Subject: Re: [cip-dev] IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Nov 2024 05:15:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17250

Hi.

Sorry, I'll also be absent.

On Thu, Nov 14, 2024 at 1:27=E2=80=AFAM Alice Ferrazzi via
lists.cip-project.org
<arisu.tachibana=3Dmiraclelinux.com@lists.cip-project.org> wrote:
>
> Hello
>
> for personal reasons,
> I will not attend today IRC meeting.
>
> Thanks,
> Arisu
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17247): https://lists.cip-project.org/g/cip-dev/messa=
ge/17247
> Mute This Topic: https://lists.cip-project.org/mt/109557255/4520416
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

