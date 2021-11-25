Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4545C433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 12:02:38 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com
 [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web08.11273.1637841743339650380
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 04:02:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=stBTRKHO;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.50,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f50.google.com with SMTP id
 r18-20020a4a7252000000b002c5f52d1834so2000746ooe.0
        for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 04:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4cMo/6D+wEZUN5FSnxFbWmCcQXuFPKZg2j95DPArhXc=;
        b=stBTRKHOMVoSagnxQRxtM8XlYs9LoOmjQAbigjl1MonfnTUuDL6BLJ6VhsDneA2WhM
         2I+ZHxMzkSjjpfpXjBPhZ8SZAgbVJc5ark1ejsZoOWf25jFoh5ERJMbH+n4Lg79ohaC5
         t8vRy2f9an7gLae/KsXfcFsRKQFCo1IMLdsZesoZQgZJqVzjtf1aKqsipRDUaYRZI8K6
         N8+FdzlpIcXpf7+59lm3cvqGln/e4L8KAjyO2N4sZ3t0dEIVAEGmza5wnttP1w/7ISQD
         rqask6y0/z7TzG0iH7Ys2d2j3t3V+hs8BKXb8uudGbDqPwLQVQUlYfwVPKWUnyIuUl4v
         mYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4cMo/6D+wEZUN5FSnxFbWmCcQXuFPKZg2j95DPArhXc=;
        b=bcj1Fgao+PvjUHZT/i5jRodWI1SEqPNHQOmN7UfDzvYzfai/nChuT7u0GVqjhycAKg
         cUcOHNBCkNutOvsXK5UrvApNJhsUyYpgrj93f3L8ISzI4+zl8dZ4sWK94iAd0vSwEelb
         sI84OEF+JQDN4GRClAzOVtSdkHL9BJmRd20b6YSPbCzWCSYUN79N9AHqLsAy2/NOKIy9
         YJmkbUqy91ITFyyXLvXyjztjoL2rKciyeDhMS8YjtOuFMVCGWyD3GpwvKOXdlpD78L+T
         rs1zI6KA93w1QTk7412Uipt9A9rvtYkJbd8DN/AvRcbVc4bINy8kh2ehVNTEbqBy1/KS
         KcPQ==
X-Gm-Message-State: AOAM531qIgrk/3ZVwDXgGQ+U2asdmfcQElMRDrIU3jnbTz3uV7KC949q
	M+qtK8SWl0kTJtyZdPjrtO4doJJPlidkz3yOlHccHIB6gAI=
X-Google-Smtp-Source: 
 ABdhPJwBjMECVm/DCHjiQA/C/Bt+YBZwczDOpzLRj6ZOaFxPiZLYltfQ/78MPKYseztXzy2yQAqwZ3GhLc4aNILljaQ=
X-Received: by 2002:a4a:a5cf:: with SMTP id k15mr14276761oom.70.1637841742469;
 Thu, 25 Nov 2021 04:02:22 -0800 (PST)
MIME-Version: 1.0
References: <16BAA9D56D09F20A.23256@lists.cip-project.org>
 <CAODzB9pm61qjStFZ9_GW-w-M2nqiUyrk1aR3-fJhkzfSyNpx-g@mail.gmail.com>
 <20211125090911.GA3327@amd>
In-Reply-To: <20211125090911.GA3327@amd>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Nov 2021 21:01:46 +0900
Message-ID: 
 <CAODzB9p2zHF4i59NuKA+RJM=hK=VEp-ewW8i058vtLSFyjENEA@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 12:02:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7018

Hi !

On Thu, Nov 25, 2021 at 6:09 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > > Fixed status
> > >
> > > mainline: [353050be4c19e102178ccc05988101887c25ae53]
> >
> > I attached a patch for 5.10.
>
> Thank you.
>
> Looks good to me,
>
> Reviewed-by: Pavel Machek <pavel@denx.de>
>

Thank you for the review! I send patch to the stable list.\
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7013): https://lists.cip-project.org/g/cip-dev/message/7013
> Mute This Topic: https://lists.cip-project.org/mt/87295441/4520416
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

