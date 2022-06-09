Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778DEC433EF
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 12:07:12 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web10.12246.1654776425607657932
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jun 2022 05:07:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=WheyxRa/;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.47,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f47.google.com with SMTP id
 h15-20020a9d600f000000b0060c02d737ecso6834569otj.1
        for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jun 2022 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sXBJnhlmB6Oks62u8f2sWZbaBEyHIA3HWDsMxhCcshk=;
        b=WheyxRa/vP86PSA0y8NT/5bXis+R1skV6qHRwGpVdPEXmckC+jl1UmOgcae82jtfSI
         spRXfHUuVFJFFL1QzZ40CNWgRBmfRE49J1RwaEt70P1Tusm7GYbhTq65N/eIMBIr9A/C
         0jiDt2iD/fTyfnIIS/TBME5YS/tMdxkCQX1N7R5LhfgQD+xFTbrPbHoRbNIEEnwyT8yY
         PVAHmHfpaygxkp1gWpkn6RDLP8VL5aVIsoaUDVXqIu8IOnaII9YlIzr8D51Y5CnTHHEx
         kOS/1j54ZYb8VuiaQKybjiDx5WfLDZaN0m5yNwLNcyJi6z6qjUbWfPB2E79x4wVR4dRV
         4MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sXBJnhlmB6Oks62u8f2sWZbaBEyHIA3HWDsMxhCcshk=;
        b=zsiLLJYXAtEoYZNMPrsYqRLdl27nh2mqTha8yIFOBbXLIe6f1DZdg+UsId+PJ+VUlu
         Da3USwBE2FyAM10vxcAton6QKXZ1Zeu/oBi0ergCuLiw8lP/Ij9QL8l9i31cjkHWmGF5
         K50Mj69WKXs0i5s2I83nepoPjta6jXyBxVgX+vpn8+vXgMs2j45ibNrZ+84I0YJuQ3gj
         XYx4/vf/sXek/cUe+gUoE5LqFbR6RZVYNTkoUwtr4pc/9bODjrLXbofU0P2AGbNh7qq3
         EdMG+aoorRtQt6BnOfBMWaEwaD1I5R2yma6/K91Cg/K8n+30Q6h2qWbT1w9FqDtQ8h1v
         zhBQ==
X-Gm-Message-State: AOAM531v3rb+x+CuH3AP64eTv2ukMKOsxjIoVXq/2C441qiUjrQAjhML
	KLlRxa0pF2i+ygeSGNb9aJQ+prPnim6+qDWebstbTr4EBUDp6w==
X-Google-Smtp-Source: 
 ABdhPJz4NOWKpKMW8gp9n8SpZFhTxxaTFjr/3UGYDYU5YESnKymuYhgPyi2RA6RP9YHrWT277yLsqFi1NsQcmWJhTCc=
X-Received: by 2002:a05:6830:1dad:b0:60c:126b:a68c with SMTP id
 z13-20020a0568301dad00b0060c126ba68cmr4051077oti.336.1654776424458; Thu, 09
 Jun 2022 05:07:04 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAODzB9proCGmsbhFuuOhx=pgwqsGsXEjz2Smd+S97_gFL-A5Dw@mail.gmail.com>
 <20220609094139.GA21103@duo.ucw.cz>
In-Reply-To: <20220609094139.GA21103@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Jun 2022 21:06:28 +0900
Message-ID: 
 <CAODzB9p3cL=3zLY_X+uJDHVNTc13z=T6zJDErtrB2v7x9xYBzw@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jun 2022 12:07:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8522

On Thu, Jun 9, 2022 at 6:41 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > It's this week's CVE report.
> >
> > This week reported 12 new CVEs and 5 updated CVEs.
>
> Thanks for CVEs. I think there's another one we need to track --
> CVE-2021-4034 -- kernel vs pkexec API confusion leads to easy local
> root. I created an initial yml and pushed it to the repository.
>

Thank you for adding the CVE-2021-4034.yml.
I got it. The commit dcd46d8 ("exec: Force single empty string when
argv is empty") will prevent CVE-2021-4034 like attacks.

> Best regards,
>                                                         Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8521): https://lists.cip-project.org/g/cip-dev/message/8521
> Mute This Topic: https://lists.cip-project.org/mt/91635778/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/4520416/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

