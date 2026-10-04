Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D632BCC6B30
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 02:59:58 +0000 (UTC)
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17555.1791084995899821979
 for <cip-dev@lists.cip-project.org>;
 Sat, 03 Oct 2026 20:36:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=j+Lsobua;
 spf=pass (domain: miraclelinux.com, ip: 74.125.225.99, mailfrom: hiraku.toyooka@miraclelinux.com)
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b059eae96so590445f8f.0
        for <cip-dev@lists.cip-project.org>; Sat, 03 Oct 2026 20:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791084994; cv=none;
        d=google.com; s=arc-20260327;
        b=qJigJvn9tVvIAu9KIyh5MsWmBaeV9enSheay601mGmXOnLcU/6h64JAA7ozaJlqr+4
         pFuiLKvnz5a4VDqrKpXys7dkYJuYMVYo+HtuDDSKwMj4CNDBxu2xjseSFxRffDZBAbpu
         T6RXTD6GkMqL/DH/c9kO3H6bbe/YeqhJ8r+OuMdyMlD5jhBLPVE3sqHTPuw0X/OeL/ax
         hsZR4+FYe5XwD/zY8RtaBOjmdHAyhDnaGpn5R4KSbL55BtbYVQoqRjt71c2pIz3z9Js+
         KK8+2AGDZeLmgyMaEZ8XIN2zJwMCq2TEdaLryRspdYvN+glEgJn+gekH2QzY03aBDD8b
         9UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bml0r5+brw7848B9VOziLBdSQEPpcuJydDVFxY472go=;
        fh=1iWBQiuvm2qZVWDLQ7zjrJ8j0emlOe4z7PagA0qHzqo=;
        b=NoqL1oWS5Bfm56oz0SNMD85Glv/wuRnaGX/+SXU0ahMWf7C9ZAwZjbx5KdJ0diD7VZ
         AoH9JX655j1/Z4tLThpqmhTSCSdWjQew802RsuHGzZ3cl9G9XNmp2ztubFiqSLhJkfk7
         zncwjJ5KBboVxXU7iNtElXWyAl9HsNXOG58vP8aIQBUl+kLnSenipQJTEDfosXYJc6I1
         Pu4urJMUL3+PWfIw+nr8yg+UhHmNl9/Ul9F624FR8K6URAxZElQQVyCwJseKJ9NiRZmV
         GOn795CpVvULgLWG4P3YUlHOGe8Sdz9pAShMgm6pHYH6h44AB42VljG7kx0Nj7gLUVVi
         deYw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1791084994; x=1791689794; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bml0r5+brw7848B9VOziLBdSQEPpcuJydDVFxY472go=;
        b=j+LsobuaFreK/ruNcU0QKnJNHwHWgBg5t+JwIQjRTjk5romtwqR9mrQ341xzSEzQEo
         zPvdAhFX4QAK/OuOS0BfTA6yO8A3f0oKm+b2fO/md3XQA3eOeHcko2+bax9QIfEe7GNZ
         EiTUuXggYVvdzko2+74Ydsx98Hr8PSRmHN1uEHD84qsgkiV42zd7373ITMyqPV6atGvk
         TSKHKXNfkVAitVdop4p7SBR03Z+LpYP6wreiZCABoMtVkLJrOSb++I67RJ6uozkxsMmW
         JU/eBCHDrIlNZXF7YaWcJR8PQGdWkl6L2eMDYcUfpwnODGtTl3wVG08wb84l9chBg0Oq
         35pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791084994; x=1791689794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bml0r5+brw7848B9VOziLBdSQEPpcuJydDVFxY472go=;
        b=rsPpFb8GdnzPBRfbTHHS0bneAa6KJTjZs44IpJ6MrJqQztmY+vW1hQU7uhEbpGFFCh
         W2pqIur0CvN5rRBEeKxZ+y1zbVrp407P3DWAkYrh4pXyqQavfyQku0atVGeGztLNr9Fz
         2mmdKrK+udqjOCnV3tUh3ZUjmSgxv3kv+CSXXNCToYrQ3OgsFmJE2f0a9N/BOrVl8nHn
         peCO+YnTm8C6pbsUTRhr199qJfWgzfl7NhEshFPHa3SPBoNU3WyLkHuCcd5ea2C46Qzo
         KI5MdagOeOX6HVdJ/Eh23Bzi2epPudyW+CLwmIcYa9IJKtCvxIpCbvNB4lS50ctDs9a7
         b3tA==
X-Forwarded-Encrypted: i=1; AKwUvBy53UlEt8NDZSF3BoKlG2OiF8PT4Qjnz+n1GyHFTFrfOfQy8rrUFaj8tI0CMap5EltuUjzxoJ5W@lists.cip-project.org
X-Gm-Message-State: AFq9FYL3051oTBbznw/qfqIaxLMzBqo1aOTPuMt2fK9kfL9a8jTe4p4O
	SzygJERimwOjmiHh3tL4sAkhYrIL8BzJCjy5U2QRDrjhag2ptEUsJLUAI/9OOLpM7Un1FmBID7G
	weFSNYrrWvlsT7cKySubJ5d6OpWLaZ9ra8moeAI1dqRuxU8NdF5UTrsN7Fw==
X-Gm-Gg: AYBFou1SXa7JXQM3uv+aPys4MeFaDvLJOlZorJ3mskFTnWiPB7sjaSPSSSwZ1MHm6on
	r55jKYNHscP1FV3KLsBvzGNeROq7Bo5pLJD3lBRAXYyMb4ubm6/ylz/3lFX/zk/c0QOVashdG5f
	ehssss7v0N34S3pzwfGJjnpWyPae/Z7bh5+7D0c7u/z9lXS1/ZaIOBBRkruq0pZWkNfcpeaNk2/
	+CBKr5HeF+iJivLYZBzSMD4SILJ69Ft3JXBnkPcxMGARb3jQ44AvfOAs/IG3VJqff03x/boPcM4
	B9CNL+b7NJAYXpinUKUMZ27vhybcdSqqD/lLxSQQkJ2XrXPsz66Fa1uwC95ekDte70Y=
X-Received: by 2002:a05:6000:2207:b0:48b:e50:714e with SMTP id
 ffacd0b85a97d-48b12734465mr12090057f8f.36.1791084667404; Sat, 03 Oct 2026
 20:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <c9a0c64f-5341-4983-8020-32144e5fd0ca@siemens.com> <243f9dd8-960c-4c9d-ab65-4821d8aca1d7@miraclelinux.com>
In-Reply-To: <243f9dd8-960c-4c9d-ab65-4821d8aca1d7@miraclelinux.com>
From: Hiraku Toyooka <hiraku.toyooka@miraclelinux.com>
Date: Sun, 4 Oct 2026 12:30:31 +0900
X-Gm-Features: AclHuK8j_mg1GKJliYQauQz5IfAeAceF3VB6AddyNY2ZwkoqvSBHlGg_EVWfdTg
Message-ID: <CADPJy8UhBXwXXDsiCg4DopRNXS26nxhxf1U0abncnr9L9zmMaw@mail.gmail.com>
Subject: Re: [cip-dev] lab-cip-cybertrust
To: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
Cc: quirin.gylstorff@siemens.com, cip-dev@lists.cip-project.org, 
	hiraku.toyooka@cybertrust.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 02:59:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24466

Hi Quirin,

I'm sorry for the late reply.
I rebooted the lab and resubmitted the jobs that failed previously.
They have now completed successfully on qemu-03, although I'm still
not sure about the root cause.

> > https://lava.ciplatform.org/scheduler/job/1514767
> > https://lava.ciplatform.org/scheduler/job/1514772
> > https://lava.ciplatform.org/scheduler/job/1514774

Resubmitted jobs (executed on qemu-03):
https://lava.ciplatform.org/scheduler/job/1521324
https://lava.ciplatform.org/scheduler/job/1521326
https://lava.ciplatform.org/scheduler/job/1521327

Best regards,
Hiraku Toyooka

On Fri, Sep 25, 2026 at 3:56=E2=80=AFPM Hirotaka Motai
<hirotaka.motai@miraclelinux.com> wrote:
>
> Hi Quirin,
>
> Thank you for sharing the error status.
> We'll check it out.
> Since it's a holiday week in Japan right now, we might not be able
> to get back to you until next Monday or later...
>
> Best regards,
>   -- Hiro / Cybertrust Japan
>
> On 2026/09/24 20:04, Quirin Gylstorff via lists.cip-project.org wrote:
> > Hi,
> >
> > I disabled qemu-03 as it had three times in the row the same error:
> >
> > *Job error:* Decompression subprocess exited with non-zero code: unxz: =
(stdin): Compressed data is corrupt
> >
> > https://lava.ciplatform.org/scheduler/job/1514767
> >
> > https://lava.ciplatform.org/scheduler/job/1514772
> >
> > https://lava.ciplatform.org/scheduler/job/1514774
> >
> >
> > The test works one qemu-cariad-01:
> >
> > https://lava.ciplatform.org/scheduler/job/1515037
> >
> > Best regards,
> >
> > Quirin
> >
> >
> >
> >=20
> >



--=20
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

