Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E3EC433EF
	for <webhook@archiver.kernel.org>; Thu, 21 Oct 2021 12:06:03 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web08.8326.1634817961268123913
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Oct 2021 05:06:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Z4z86fia;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.175,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f175.google.com with SMTP id r6so585992oiw.2
        for <cip-dev@lists.cip-project.org>;
 Thu, 21 Oct 2021 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PAFxgiL7XC75qLRbESazb6I7YfI4E9BRATUzqkGnJY4=;
        b=Z4z86fiaXXwPAbCKk8XmOlAL1lTTRy5+r5UMJv/kQS4CEqCI5Fo3NDW2piO+o+HaeM
         NdPPpCoPdrlC+CDCa4q2IuDFFTv70t9e9i+7UW3qFgYwf7+Qn5pWjoOCBRExOpfWZeRw
         xWIEId2krZCsms2zvVBTTfiC3vx2yUB4Uuy2oyQKhc0zVPufMTV4lphdcq98JBmoHxUd
         eMcPUon4T94e4Eoe8Mm/w7SxLggQht5BEv2mrI3XcBmFbre/RvHHwb2tgDd7u3LzQkbg
         AZeh2EixCSsHihBI9FW1/Tekhz/twft57fcjgkbAbqwge7M8tet3COVBl3Du0DfRQNJ0
         oSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PAFxgiL7XC75qLRbESazb6I7YfI4E9BRATUzqkGnJY4=;
        b=FqDIKSTRgDIZafy+cqsOXTQzImejhFT2Z45njSaYYfQ9lpxyw6g2U9SRcg28pfp5B/
         RTwucsghshF1KVOxH0eQNjfX3n3tNiUmKpWC57ca+YXhLyobZaEf7rxwXcLWafwpy5RK
         67Eqzp1kaE8hpSeRMbpTs0lVmKLQkaYQQ+kPgZDKsTE8zBMA13wPEb7nYkhR1tnPTnXa
         lM5//dkJIu9trZinvnciTPcz5AgbOjh/dtua4PTtAKm0y9d8zNdYq25WQS4HJ8fC1nxr
         TPddNZLduovWGu8GSjLOVMmczwZVGEdAH69wuP+I/U47R1e2icx0F30WoEau6BJDnWel
         lSwA==
X-Gm-Message-State: AOAM530xmPeTpYCkfYqPn8wv/f4lFQimkuIfayCDyqQXOt+Re8u05Skx
	ndznsaJ7mVfNdz1szRHq9YItWHRL+1WlSfw+gfGfwaVffjI=
X-Google-Smtp-Source: 
 ABdhPJzzLb8Au83TSRXhSl6wgnxkAkAwOQRK7jZY/dRBXlXAzuln7MsRTB3UDzwLDMIjNFooLzGfy04f4Zs/0NMgbyQ=
X-Received: by 2002:a05:6808:144d:: with SMTP id
 x13mr4029123oiv.132.1634817960039;
 Thu, 21 Oct 2021 05:06:00 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAODzB9pMmbJugyNLdvOOifW1Tm+1NhnsUi+zQBdRaj3Z=aC+fw@mail.gmail.com>
 <TYAPR01MB6252AC6CD63FCF8BEC76A78C92BF9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB6252AC6CD63FCF8BEC76A78C92BF9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 21 Oct 2021 21:05:24 +0900
Message-ID: 
 <CAODzB9pTFaqdUHXJLw+yqN4B3zLSxzZES3dwcrJ+V+Vi76ToUg@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Oct 2021 12:06:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6835

Hi !

On Thu, Oct 21, 2021 at 5:42 PM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.org] On Behalf Of Masami Ichikawa
> > Sent: Thursday, October 21, 2021 10:21 AM
> > To: cip-dev <cip-dev@lists.cip-project.org>
> > Subject: [cip-dev] New CVE entry this week
> >
> > Hi !
> >
> > It's this week's CVE report.
> >
> > This week reported 7 new CVEs.
> >
> > * New CVEs
> >
> > CVE-2021-20320: kernel: s390 eBPF JIT miscompilation issues fixes.
> >
> > This bug is in BPF subsystem and s390 architecture specific. Patches
> > haven't been backported to 4.4 kernel. However, according to the
> > cip-kernel-config, it looks like no one uses s390, so can it ignore it
> > until someone backport patches?
> >
> > CVSS v3 score is not provided.
> >
> > Fixed status
> >
> > mainline: [db7bee653859ef7179be933e7d1384644f795f26,
> > 6e61dc9da0b7a0d91d57c2e20b5ea4fd2d4e7e53,
> >   1511df6f5e9ef32826f20db2ee81f8527154dc14]
> > stable/4.19: [ddf58efd05b5d16d86ea4638675e8bd397320930]
> > stable/4.9: [c22cf38428cb910f1996839c917e9238d2e44d4b,
> > 8a09222a512bf7b32e55bb89a033e08522798299]
> > stable/5.10: [d92d3a9c2b6541f29f800fc2bd44620578b8f8a6,
> > 4320c222c2ffe778a8aff5b8bc4ac33af6d54eba,
> >   ab7cf225016159bc2c3590be6fa12965565d903b]
> > stable/5.14: [7a31ec4d215a800b504de74b248795f8be666f8e,
> > 6a8787093b04057d855822094d63d04a2506444a,
> >   a7593244dc31ad0eea70319f6110975f9c738dca]
> >
> > CVE-2021-20321: kernel: In Overlayfs missing a check for a negative
> > dentry before calling vfs_rename()
> >
> > CVSS v3 score is not provided.
> >
> > A local attacker can escalate their privileges up to root via
> > overlayfs vulnerability.
> > Patch for 4.4 is applied
> > failed(https://lore.kernel.org/stable/163378772914820@kroah.com/). It
> > needs to modify the patch. I attached a patch, if it looks good, I'll
> > send it to the stable mailing list.
>
> Thanks, I checked your patch. LGTM.
>

Thanks !

> Best regards,
>   Nobuhiro
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6834): https://lists.cip-project.org/g/cip-dev/message/6834
> Mute This Topic: https://lists.cip-project.org/mt/86480633/4520416
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

