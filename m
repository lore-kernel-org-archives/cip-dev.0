Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E764C433F5
	for <webhook@archiver.kernel.org>; Thu, 30 Sep 2021 12:12:17 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web08.11365.1633003935587017888
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Sep 2021 05:12:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ygsxPKML;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.169,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f169.google.com with SMTP id w206so6962220oiw.4
        for <cip-dev@lists.cip-project.org>;
 Thu, 30 Sep 2021 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OUmLZ8IjAMtQaOVoc7bTkAQ725QQdJh0c+EsRktVlaI=;
        b=ygsxPKMLfnONOFyEah5iYw40TDZR5rBRwtcFl5OWHDtou/7zWZf2SIgkTPW00qJk++
         NZLlSRu6Mn2QtI9MsShdpF4B/a4kqkCOA/FlmGvwaYoYu7bxD+TP0e6jFExgMuOYtaYv
         8ygNqu+Vnj1xT2aapV6xbpGnGdQE8Pzn3hLxPFCmVmDa5sZNjv63fRfXLR4EvgI//yxi
         K5iCZwQGxNgqDMBo7Jw8/9h0QgPcdCxUs/ogC7pGU9zY87MWgMpOkyCyCj3tP1LdMXXp
         ZoIJ2MZpZzc4FDspWrrYrY73zdst/T0/doEd4S4p6xmofpmLm8QSaYh+ohAGb0FGoWJN
         F4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OUmLZ8IjAMtQaOVoc7bTkAQ725QQdJh0c+EsRktVlaI=;
        b=6j4EZiGdfQ7Uh+hzph+z3rtrQL+UBJUAUSHHCvCSiOzptQp2FkSmBO9Vkt6GfU2pBS
         HVRrWc5dO5Wo67R4ydQKBXiKdCkJnSSrRkq1DOZ3kJerNj5MZjJ1rfONgJLIQGSkI409
         j/5ndPX8cRr2Vfe5wQguiyAkMYWMthSMJ8SjLAXi/TvSiyV4CwKshRCb9YqBTFYKht6O
         emOZmsbwXM3s7F4kfhV25gasWiMY4zbzu1EnBMqFfBLVRhU5zH4pT0ojQUjRZ0v6yvG7
         snmD8VPG6BDRri71KSnCJQq8jtwlzKFLOtxRKiJPd867NUlaogSWA2BLdcPhqj2w2hR8
         MYEw==
X-Gm-Message-State: AOAM5319ce8ob+u1xsAjTD2x0BqK0e8gNu2JpTT7Olh9fsiM637MoVQr
	V/2/+iD9J4KWe21rif8keCevW6dM4W6w3T0SVyWNCDVJMFU=
X-Google-Smtp-Source: 
 ABdhPJz2SvH7SYxhsCcz+0v+TSx7kLZLhqHiPJyPf8tWjZvUFb4fo5GjnXAjnQsC7+wCM+5U7kFi3Ew5UtZAvSGRTM4=
X-Received: by 2002:a05:6808:1709:: with SMTP id
 bc9mr2415255oib.116.1633003934561;
 Thu, 30 Sep 2021 05:12:14 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAODzB9qObzKXuh+WaSqh_KD=T2NfZw79d-NnXFX1vmNGj5wsqQ@mail.gmail.com>
 <TYAPR01MB625208BDE921AFB1D540B83D92AA9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB625208BDE921AFB1D540B83D92AA9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Sep 2021 21:11:38 +0900
Message-ID: 
 <CAODzB9rM5dcTENMez8tm8FvhAgBR=2DCx7NK1xMevEnP53KP8g@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Sep 2021 12:12:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6765

Hi !

On Thu, Sep 30, 2021 at 3:33 PM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> Hi,
>
>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.org] On Behalf Of Masami Ichikawa
> > Sent: Thursday, September 30, 2021 9:12 AM
> > To: cip-dev <cip-dev@lists.cip-project.org>
> > Subject: [cip-dev] New CVE entry this week
> >
> > Hi !
> >
> > It's this week's CVE report.
> >
> > This week reported one new CVE.
> >
> > * New CVEs
> >
> > CVE-2021-20317: lib/timerqueue: Rely on rbtree semantics for next timer
> >
> > This bug has been fixed in 5.4-rc1 so that before 5.4 kernels are
> > affected. For 4.19, patch can be applied without any modification. For
> > 4.4, it needs to modify patch to apply it.
> > According to the description in
> > cve.mitre.org(https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20317),
> > it describes "This flaw allows a local attacker with special user
> > privileges to cause a denial of service" so I think this vulnerability
> > severity may be low.
> >
> > CVSS v3 score is not provided.
> >
> > Fixed status
> >
> > mainline: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
> > stable/5.10: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
> > stable/5.14: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
> > stable/5.4: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
>
> This commit can be applied directly to 4.14 and 4.19.
> However, other LTSs need to be other commit or fixes.
>
> I attached a patch for 4.14 and 4.19.
>

Thank you for the patch!
It looks good to me.

> Best regards,
>   Nobuhiro
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6764): https://lists.cip-project.org/g/cip-dev/message/6764
> Mute This Topic: https://lists.cip-project.org/mt/85963258/4520416
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

