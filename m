Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D08C76196
	for <webhook@archiver.kernel.org>; Mon, 10 Apr 2023 08:36:08 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.39542.1681115766497589971
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Apr 2023 01:36:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=ddtRJMlE;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.50, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lf1-f50.google.com with SMTP id e11so5485015lfc.10
        for <cip-dev@lists.cip-project.org>; Mon, 10 Apr 2023 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112; t=1681115764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnNXmetGANywDlXiJsY9j4ICy38/c16NosVZcTXFics=;
        b=ddtRJMlE7YtXJdWiX0nRb0zXV9D97feNK4NYAY+H2xj4WzaMFer64Z5C7V5/JDBRi6
         5W+gIFUB0on5Pa4A/B/BfKsa78bjNpLtfIljwV1C0dr5dtA1m9dcRJsM/l8BvpshbM0v
         UFjjjr7EEAYzsq3vhPBz5/raIwThCFIitGPgkLlZHaIU93eUTYCcE2oPX/qL9OOJjWf8
         Kf0SD0K0+WWRzzYF9cCu4gRxEqkmSS/sy4qwKc8yMpBLTr8w2UWTfHyVdW9+++HGRb+T
         F6ayOA/XU234UNAbNqCG4w4nW6oRPI4qTIQecrevgUJNMzLkc8TyoDGjxGivbPQeTd7k
         kkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681115764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnNXmetGANywDlXiJsY9j4ICy38/c16NosVZcTXFics=;
        b=um94Lb/p3kiXWxkARyoWLAOadXt5+k6uyCw8M+QnAtazHYE+hwnS514HIoqeOIqvqS
         iVWg72JAVmQo8DU+KhnqUNpdBjkqVFm1tX4JHryrRcoDTrSLbvgsiesGaIB+OJJwHMO0
         SjTZggTlWcjLXrt8JS0RnrnCf8x75HYhicvJC5VLMET5AV1k2L5w2fcBqoP1u8wPcmen
         /gUhR3hyStAsh7oEzwZt41MfFK3Fg50NNX3Jpt2Oo7hubEIIYXA8QqU07qKj3ZEBGYnB
         efejJvwBx322GRX3R+pVBC852Xlwkp5In3KxE/2IYjTcd/LISVhCAS0HcJ0ZFIgei7G1
         r+Yw==
X-Gm-Message-State: AAQBX9dhMrLIWA+ny7fB+B2CPulvIaiXytpc4kYfDxrurF2xss/vZTPU
	2Lbbsz5aFNSfERLOpAvV94j2y3gvx8TeCNkCWn4j
X-Google-Smtp-Source: AKy350ZYFrcXp/rnTSqOfbMFVbVNRNyK7qmLeKNQsl4Zqj0ULeWEMJ8hxR9dv5S24LD28lLap3OWmmGnlcoUU7U6foM=
X-Received: by 2002:a19:f717:0:b0:4dc:807a:d140 with SMTP id
 z23-20020a19f717000000b004dc807ad140mr1787488lfe.10.1681115764304; Mon, 10
 Apr 2023 01:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANgtXuPOyqXGzeoFMRTyQ63zFrFJL8nDc=DE+JEJ2E3ARF_3GQ@mail.gmail.com>
 <d2f8d9e1-65ff-d50f-7eb7-d725f5a1f52b@siemens.com>
In-Reply-To: <d2f8d9e1-65ff-d50f-7eb7-d725f5a1f52b@siemens.com>
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Mon, 10 Apr 2023 17:35:11 +0900
Message-ID: <CANgtXuN-uGXQ4wDR=npLqUVRO-+KmnO1F9U_qTXwkhhCS2MvCQ@mail.gmail.com>
Subject: Re: isar-cip-core distribution versions
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Apr 2023 08:36:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11190

On Thu, Apr 6, 2023 at 11:41=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 06.04.23 12:53, Arisu Tachibana wrote:
> > hello everyone,
> >
> > the update to a recent version of isar-cip-core on KernelCI is
> > currently in progress by the following pull request:
> > https://github.com/kernelci/kernelci-core/pull/1656
> >
> > While updating the pull request I noticed that in the current
> > isar-cip-core version,
> > we have changed the distribution from buster to bullseye.
>
> To me more precise: We changed the default distro to bullseye quite a
> while ago. You can still select buster for your image, and bookworm is
> coming as well.

Yes, I'm aware of this. my "recent version" of isar-cip-core was a really
bland indication of time of something that is happened in the last year.
As "recent" and "quite a while ago" are not time specifics.

>
> > Do we still need the buster version together with bullseye or we can
> > drop buster?
> > any opinion on this?
>
> As discussed in IRC today, the risk is that a too "new" distro may no
> longer work as expected on a too old kernel. E.g. systemd may start to
> complain about missing features and maybe even refuse to work then.
> Would it be possible to keep the images kernel-specific?

We can try.
But as I said on IRC we need to know any kernel-specific image version.

Thanks,
Arisu

