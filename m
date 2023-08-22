Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4245EE4996
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 03:39:25 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web11.888.1692675564429337295
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 20:39:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=kI2p1MM+;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.181, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso34121401fa.3
        for <cip-dev@lists.cip-project.org>; Mon, 21 Aug 2023 20:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1692675562; x=1693280362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeU5udM43Y5rbK+eTb+/jH/nOfph3W2FQk1Mf7v8Vz8=;
        b=kI2p1MM+CBLNmRe2fnSmWx4UQ4Lb0XsdEDncHhZ+XJMkc/LT6902r2eSwyezrtOISV
         ZqSslgFftebJY1uyFe5rBzRQVOoX6VHa27IetP0m9e6EPT1HbMXPTW3Y2SGDV3B5kxI7
         aNXffe10mKJTh3CMGBM4zpqZmdVYxG6oiuckNzaRABluUWqmjAaO5ZXnZqIB1ByeOM7b
         gPPfXBnSqU9hrJVe17IBwOvKcNE/nDvb/LMGM95OMBq7aCwJDSuAEiUTnznxMvcyW0r0
         odJmEsnp0ehWnIC5UXgdAXXnN46uN5ULV8vre43ZHDlxJEx4PrbteKWze/VoqCJdN/+V
         wIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692675562; x=1693280362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeU5udM43Y5rbK+eTb+/jH/nOfph3W2FQk1Mf7v8Vz8=;
        b=RerFItDiU7fCrz7gqlswQvYaUv7yHPRFkVJcChSKrLmQ5VIPvhTq8dgIGIVjzrbaaE
         isu3KtHSw9BYvd27Cbxp8Jz3uX+xVewpXNLl8gyVlZr/it1vKF1YGFuBGJy6HXSwMQiN
         +q7NsqlDswaUMsBbPp6pA5havN2OaEndIscpkoXOjr0ydRU101JighH+3kH7k2U+V76/
         emcZd7iyVzqheguDMm9Iu7ENlCRPH6gOqnfRL7CfP8pvj5iC9YsBDboSRLAv0Q7wrl0R
         rhnN0kDI7HIVOWgoCc1yHqCpegUBtwC9wQEDFCgigKxETxhGJsxqm31WkEPWh0boVr/p
         1kRg==
X-Gm-Message-State: AOJu0Yyy0Hst9ytk+KSvJNcuZDPRQS2CPEDTwEFEN2pHKcJKoyEA3sn6
	wWJ+loBY7Dt1CwacGBDrbwCRyxFERVcwUH1u0l9d
X-Google-Smtp-Source: AGHT+IEouhkUuSk/JnHBxvPNCVTXZmRj1SLBbf/mNgvS8Kg9/v6vqZCJk3FGLARLS3wDiGYdSc3WiziJn0vicIjvx8c=
X-Received: by 2002:a2e:8899:0:b0:2b9:ee3e:240b with SMTP id
 k25-20020a2e8899000000b002b9ee3e240bmr5998069lji.41.1692675562370; Mon, 21
 Aug 2023 20:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230816080300.5559-1-arisu.tachibana@miraclelinux.com>
 <e4fb5477-18a7-4c65-9caa-4d647dae6a07@siemens.com> <CANgtXuP_=UBMwaVu2UOwnzmJpQPJdsJh2tJKqDP3LCoWy_Hbkg@mail.gmail.com>
 <1c4494da-028a-449c-b796-280fee653bd7@siemens.com>
In-Reply-To: <1c4494da-028a-449c-b796-280fee653bd7@siemens.com>
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Tue, 22 Aug 2023 12:38:38 +0900
Message-ID: <CANgtXuPZd9zzQL=TX0fgX3-A+551iFA4wcW98U_0-FNkUokB_Q@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH] .gitlab-ci: Create amd64 release
 variations for KernelCI
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 03:39:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12810

On Sat, Aug 19, 2023 at 8:53=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 16.08.23 16:40, Arisu Tachibana wrote:
> >> Happy to add that - just wondering if adding those two targets may all=
ow
> >> dropping one or two others which are implicitly covered by this now. D=
id
> >> you check that as well?
> >>
> >
> > sorry, I'm not sure of the meaning of your question.
> > could you explain it better? what are you willing to drop?
> >
>
> Our CI tries to cover representative combinations of isar-cip-core's
> configuration variants. We can't cover them all - too many. Now, when we
> add these two, later on also for non-x86 archs, it is worth to think
> about if those obsolete other CI targets without creating a relevant
> test coverage gap.

Can you specify what targets do you retain obsolete ?
are you saying to skip amd64 and do only the non-x86 arch?

>
> We currently have 33 build targets. Makes 33 runners that are started
> when even just a simple change to isar-cip-core is pushed. That can sum
> up to relevant costs if we just leave that running, adding more and more
> targets.

During the CIP weekly meeting we decided to proceed with KernelCI
testing of isar-cip-core in the following way
(https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/04/cip.2023-04-06-=
12.02.log.txt):
```
12:19:26 <alicefm> sent mail about isar-cip-core on kernelci
https://github.com/kernelci/kernelci-core/pull/1656
12:19:38 <alicefm> to cip-dev
12:20:14 <patersonc[m]> Thanks Arisu
12:20:59 <alicefm> about if we want to just move to bullseye or we
want to keep also buster to be tested on kernelci
12:21:41 <patersonc[m]> In the gitlab setup, it depends on which
kernel version is used
12:21:57 <patersonc[m]> To map with how Debian does it I believe
12:22:10 <patersonc[m]> Do we want to do something similar in kernelci?
12:22:23 <jki> yeah, likely to avoid surprises in userland
12:22:24 <patersonc[m]> Older kernels - buster. Newer - bullseye
12:22:31 <jki> exactly
12:23:16 <alicefm> how much older kernel?
12:23:36 <alicefm> 4.19? 4.4=C3=AF=C2=BC=C5=B8
12:23:43 <jki> 4.4 would likely be better done with buster, though it
should work with bullseye as well
12:24:15 <patersonc[m]> Arisu: I need to check
12:24:16 <jki> doing 4.4 with bookworm one day could be risky, if
possibly at all
12:24:36 <alicefm> ok thanks.
```

Debian is currently doing:
```
buster with linux-4.19.y-cip
bullseye with kernel linux-5.10.y-cip
bookworm with kernel linux-6.1.y-cip
```

Are you now suggesting to proceed in a different way ?


Thanks,
Arisu

