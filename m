Return-Path: <masami256@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AECFC433F5
	for <webhook@archiver.kernel.org>; Thu, 28 Apr 2022 23:57:52 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web12.4206.1651190270959630891
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Apr 2022 16:57:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=aJg/TdX/;
 spf=pass (domain: gmail.com, ip: 209.85.208.181,
 mailfrom: masami256@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id bn33so8649316ljb.6
        for <cip-dev@lists.cip-project.org>;
 Thu, 28 Apr 2022 16:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TBOXZGRkO1TOCypx9I9ynEaSyp1wJnm6hEmW+vSIWvA=;
        b=aJg/TdX/Vfg8CpmkOvE2Zspcr7MHSkkZbUH9a/c6e2Sg2SJENNtZQCyqepTZFEgF/W
         gwXyj9JN+E91ffOH94WXGeDL2Zxv/b5VKjXQIyh7T23xNqsdq6TF4sXUIzcvukIa33c6
         8LH2f6Qu8f8tXteC5+RaeF8YnLvfNC6KrUKftS89UsaeE7KHY4RO1yVYJzMcBgH6VhI/
         MXJ720PYnVRH1HL4EJPGib0NJT5CP4tWZt0O5o+zS2Zx73ZdmpRi3xd+YL5y0K87oKCK
         X+4yS2vvYsrU7gXS/0Af25XD3tDBpoqUc9xPih201ICGOQUhVf1RgWQYRTKzxibcTPfj
         E20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBOXZGRkO1TOCypx9I9ynEaSyp1wJnm6hEmW+vSIWvA=;
        b=weqTE21cgjXbw6rfMEG7W05wtSSlwPjHKq8pTA0/Z5e9/6UHVPd7bwBqRl7oAY+2Vq
         KaDP3xpu/HIESVs3Q9V14/gKrT86xsL3ulMmfN01K1FQPu6mLlBAfM6CbDUPb+U6TyM9
         Wl4XvNj8iFYTmAKmbBFDYpF7w6O5zXupUppwxt3KXZAnx2GPXgMkOyn9Z0lRdYc6PUbL
         Fimqye+NGatfFR93i5ioWEdrPYzqb6ieI3kIln3/xscvUoQGRExr1Ar06f6WU1yJGjFU
         DU3tFwSCnMwhAR2mjdYynxX64m0EjgHsYU0KYIVttuGvL7aTWNlUNGN6Mua7Y9NBO857
         Nkvw==
X-Gm-Message-State: AOAM531YGSi7WmTfTz+V6q+AixLmHjcoW/gxK44oP3T/VJ9AFWRmnLAl
	zP5V1cxICkzQOKWMI2pbvBdo8bQpjGq9ppnzGdYeTGxI/Dc=
X-Google-Smtp-Source: 
 ABdhPJz4NEkuza1eE1OlpKGft1Ge2ZUjp0HQYFlD3WjbYKLoWoqkmr0LP2TXYD/zkqcaw1rqQvnYjnI0NfQ9zEfi1Fo=
X-Received: by 2002:a2e:a28d:0:b0:247:dce8:cecd with SMTP id
 k13-20020a2ea28d000000b00247dce8cecdmr22849561lja.415.1651190268910; Thu, 28
 Apr 2022 16:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <16EA1EC5D11818E9.15794@lists.cip-project.org>
 <20220428173525.GA32556@duo.ucw.cz>
In-Reply-To: <20220428173525.GA32556@duo.ucw.cz>
From: Masami Ichikawa <masami256@gmail.com>
Date: Fri, 29 Apr 2022 08:57:37 +0900
Message-ID: 
 <CACOXgS8EVEsHWe-548a3zQuYrTrXJp8EjcTJyr91L=2mTHLyZw@mail.gmail.com>
Subject: Re: [cip-dev] 4.19 oopses on socfpga
To: cip-dev@lists.cip-project.org
Cc: Chris.Paterson2@renesas.com, alice.ferrazzi@miraclelinux.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Apr 2022 23:57:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8229

Hello.

On Fri, Apr 29, 2022 at 2:35 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
>
> > There's oops during boot on socfpga:
> >
> > 4.19.240-cip72-00010-g0ffbb4b1066 -- https://lava.ciplatform.org/scheduler/job/669893
> > 4.19.240-rc1-g5e5c9d690926 -- https://lava.ciplatform.org/scheduler/job/669259
> >
> > This commit may be relevant:
> >
> > commit e2423aa174e6c3e9805e96db778245ba73cdd88c
> >     net: ethernet: stmmac: fix altr_tse_pcs function when using a fixed-link
> >     [ Upstream commit a6aaa00324240967272b451bfa772547bd576ee6 ]
> >
> > Let me investigate a bit more.
>
> I tried to do some testing, but it fails on two targets:
>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/522211501
>
> And failed test says:
>
> https://lava.ciplatform.org/scheduler/job/670508
>
> ob error: Invalid job data: ["Resource unavailable at
> 'https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing/linux-cip/zImage_siemens_de0-nano-soc_defconfig_4.19.239_e5e741fbf/arm/siemens_de0-nano-soc_defconfig/dtb/socfpga_cyclone5_de0_nano_soc.dtb'
> (404)"]
>
> which sounds like a test problem, not kernel problem.
>
> Any ideas?
>

It looks like the pipeline 522211501's build job didn't build
socfpga_cyclone5_de0_nano_soc.dtb.
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/2364180684#L2417

An old build job(pipeline #523704627 . kernel 4.19.239-cip72) builds
the dtb file.
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/2371451342#L2907

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8228): https://lists.cip-project.org/g/cip-dev/message/8228
> Mute This Topic: https://lists.cip-project.org/mt/90758298/6028936
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10394996/6028936/1199334894/xyzzy [masami256@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

Regards,
-- 
/**
* Masami Ichikawa
* personal: masami256@gmail.com
* fedora project: masami@fedoraproject.org
*/

