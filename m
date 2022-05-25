Return-Path: <hannah.kiekens@essensium.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99412C433EF
	for <webhook@archiver.kernel.org>; Wed, 25 May 2022 17:35:07 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web08.9939.1653500103177265930
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 May 2022 10:35:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@essensium.com header.s=google header.b=cMPP/vps;
 spf=pass (domain: essensium.com, ip: 209.85.128.46,
 mailfrom: hannah.kiekens@essensium.com)
Received: by mail-wm1-f46.google.com with SMTP id z17so6033342wmf.1
        for <cip-dev@lists.cip-project.org>;
 Wed, 25 May 2022 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZOjhAr69RJYLq4LFFpPYmGEf6+GSF7Wl1VbolnH5LY=;
        b=cMPP/vps19ZAZFaoY5CJ0xTIQ7dViOVuxikXx+VwbDghWjEjQ1sRHAIuUmT9zzn2k9
         XQucDvP0mx/4AYC6N+nyVFzF3ZpPcmJ/7igrHbHzrT92Cgoimb+uSK7PMC7Hg1CXvlWV
         HBKkO16Dm7s7SP6Uio1Uz3qvMEA+rUz+JT18wRCBQtvm41+sZKcvhbLEbIs+IgKiPWK8
         +o/wUxfIpu+SJSUF3Ax+Qp6XN97lZjjq1ZjCWEy4CkL5Nx4FyGsLIrMIkX86pZN88o9c
         aMSAvRLEQoZ6hRNE1mGDaZhQbXAeDb948Z/oq5hzcuRCJxbfelrxRgy3gY1n7IE/qbBm
         q4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZOjhAr69RJYLq4LFFpPYmGEf6+GSF7Wl1VbolnH5LY=;
        b=74pkBU2plSeAalArOfEKa1C/ochdkSe/4rh0Cw0lP1YNR7zoV2brv0h+xCN1w9dbjW
         pXQpT1Xx4Lt/5cTrPmuwh2GyQGlX+/R1jW37V8meGFG4jmMs5RAR5UvAPKjKCl7awzPW
         fKLK404lge7oiikp1diVKFeeNLAmQ3oCUG3HR0AKkKu5qoyxpo1VHm9dls7vLAjscCOz
         w92jqTWUaBb4RVCZCwhTQ0mP4aJ+LKOQrBreOyjZnN1ngNWe1TM1VjjsBBX9YwnQd+i5
         4Dq3WjxqImpwMdoFMd68ZBkXtMIDb/ZRiuxa0w4AkmSl+OBkyFLmVd/mrl7Vv520hwFp
         HTpA==
X-Gm-Message-State: AOAM533kBSVunW5OV7Qc7b69xfIUZRYXmMrTGrlTyMLfmTb2BxeGrfi/
	xmUDg1L1BlWy/g81UOKPXWqSAwEopnLcZYcpog77Ag==
X-Google-Smtp-Source: 
 ABdhPJz4n1CCilS+KNxQ5QYoEUPh2I+z4dr6zf+g3knFF3U5GplCtgkhL2+S8uFJ5OeuvV9mFNaywmYmhqERqnrmd+Q=
X-Received: by 2002:a05:600c:4f90:b0:394:970a:71bd with SMTP id
 n16-20020a05600c4f9000b00394970a71bdmr9301270wmq.158.1653500101248; Wed, 25
 May 2022 10:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220525092017.445653-1-hannah.kiekens@essensium.com>
 <bb00ccb7-8098-942e-e7d5-d7edbd35ca4f@siemens.com>
In-Reply-To: <bb00ccb7-8098-942e-e7d5-d7edbd35ca4f@siemens.com>
From: Hannah Kiekens <hannah.kiekens@essensium.com>
Date: Wed, 25 May 2022 19:34:50 +0200
Message-ID: 
 <CAP07BnkUBJ85TbiWy_QLfD2pQUgp-ExoExgHT3vQw+bPw+6Uvw@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH] Update README.swupdate.md for bullseye &
 5.10
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="0000000000002bdecd05dfd97e0b"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 May 2022 17:35:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8438

--0000000000002bdecd05dfd97e0b
Content-Type: text/plain; charset="UTF-8"

On Wed, May 25, 2022 at 1:41 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Hehe, someone actually read AND tried the manual :). Thanks for caring!
>
> Would be good to list some reasoning for switching to bullseye here.
> Buster should still work, "just" not with 4.19 anymore.
>
> In fact, we should think about making bullseye default in kas-cip.yml.
>
>
There is no real reason why I am switching to bullseye.
This combination worked great, what it was before did not
This patch is currently doing the rounds at our site for evaluating/demo
isar-cip-core, I needed a working, easy to follow guide for regular
techies.  I am not sure if the technical details matter in this case


>
> 5.10 becomes default when selecting bullseye, so you could drop that
> option.
>
> It's probably also worth noting that some of the build configuration
> issues are "resolved" now via "kas-container menu" and its dependency
> encoding. But it is still clearer to describe the actual configuration
> the way it's done here.
>
>
Sorry, it's not entirely clear if you want me to modify this patch or not.

Hannah

--0000000000002bdecd05dfd97e0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 25, 2022 at 1:41 PM Jan K=
iszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
ehe, someone actually read AND tried the manual :). Thanks for caring!<br>
<br>
Would be good to list some reasoning for switching to bullseye here.<br>
Buster should still work, &quot;just&quot; not with 4.19 anymore.<br>
<br>
In fact, we should think about making bullseye default in kas-cip.yml.<br>
<br></blockquote><div><br></div><div>There is no real reason why I am switc=
hing to bullseye. <br>This combination worked great, what it was before did=
 not<br></div><div>This patch is currently doing the rounds at our site for=
 evaluating/demo isar-cip-core, I needed a working, easy to follow guide fo=
r regular techies.=C2=A0 I am not sure if the technical details matter in t=
his case<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
5.10 becomes default when selecting bullseye, so you could drop that option=
.<br>
<br>
It&#39;s probably also worth noting that some of the build configuration<br=
>
issues are &quot;resolved&quot; now via &quot;kas-container menu&quot; and =
its dependency<br>
encoding. But it is still clearer to describe the actual configuration<br>
the way it&#39;s done here.<br>
<br></blockquote><div><br></div><div>Sorry, it&#39;s not entirely clear if =
you want me to modify this patch or not.</div><div><br></div><div>Hannah<br=
></div></div></div>

--0000000000002bdecd05dfd97e0b--

