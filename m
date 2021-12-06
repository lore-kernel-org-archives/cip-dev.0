Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7827C433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 09:25:16 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web09.49146.1638782714030117636
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Dec 2021 01:25:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ERRGw1VH;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.43,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f43.google.com with SMTP id y13so39982594edd.13
        for <cip-dev@lists.cip-project.org>;
 Mon, 06 Dec 2021 01:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7yR+y+dL3oH56GQCNBdcU4P9UPnRmTKa5m5mwJfefc0=;
        b=ERRGw1VHT7ekgSfdbv78mfEk4wYpGqt6wQWvoFF9I54ibK6FtlRicRuPc8Zraq1KmF
         zDxhLTTNCge+jonkYMnC/fvBDYzJSa+VnP4yjOleSPPYRPxz3YBeN7aFXh9paJJQGCgZ
         CtEwI/VDxbqfBBbod0WN/SAw4rH4sy39rTRM5dOku5DcZKlNo2kuPdfW6ifx1eLnb0cS
         5heNnusHpEGcJzxXyJl20zyewDZUw+r+349TFQ7bKdAz44UDFSRhtP/pGRWCPZkJAwAA
         yxHnRfZ14z7v+hgbibtXMRRfQfEhz/3G/MDBF/F8KK+MfnAw9lmI7r/ntdED9z2syPEW
         nasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7yR+y+dL3oH56GQCNBdcU4P9UPnRmTKa5m5mwJfefc0=;
        b=cDgex0A8MtHu1CgNrjHqFNoKVRpiS9jfdDsXkbe6LrjNlhTeP1tA+m4SxS52kal99e
         obAOc1GJeccM+XnOpWKY8WGTzYkfwL57QeR3pUn+LXB8/l0PlUNoonnXCkJo9YgVYVS6
         8SgX+lI7WqQKVD3mh7enb19/Uc72BfZL5APYXRfLutKZt5flcL+hdUpDRmkvgUNrpuaO
         v7sN1A/KqGIyBXi2U+GIZKk4AZeofz7gBV4hQTflspBEc3Dsu2YE/BPFs7bZ2PgG6fj5
         wZveW3kWfY2oxMoNJVnTuqRGEykx3xROOK7PpV9PN9dsE7h6yslo0vjFuOjs90ioB3DL
         mvbQ==
X-Gm-Message-State: AOAM533fxXNGrh4YtEO72qogBBlbHdXMuqtlisr2uYWsXH7Hv4XLjqT4
	+RoMR3HFF4/ljlmPyjZCe3U+y00cg6L3nKNRt6z89oHN2irE4mg=
X-Google-Smtp-Source: 
 ABdhPJzb0xKqHSYBWeM/7hD8+Yft/d8k36rT8mU2a322G9RMtQjWV9t2brOUuHTQoUlSE8aE6ndbiWmZ3hFrneHrrac=
X-Received: by 2002:a50:9510:: with SMTP id
 u16mr52564793eda.134.1638782712379;
 Mon, 06 Dec 2021 01:25:12 -0800 (PST)
MIME-Version: 1.0
References: <16B8F29B24FD30B5.32206@lists.cip-project.org>
 <16BD574183886849.11393@lists.cip-project.org>
 <OSZPR01MB68771C64F1E64D3A47F3472AB76D9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB68771C64F1E64D3A47F3472AB76D9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Mon, 6 Dec 2021 18:22:20 +0900
Message-ID: 
 <CANgtXuNW1uTwGNKLx95s8Dpz+1pkoPzSu0_iLYsWWJabp7DKsg@mail.gmail.com>
Subject: Re: [cip-dev] Planned maintenance for lab-cip-renesas: 4-5th Dec
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Dec 2021 09:25:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7068

On Mon, Dec 6, 2021 at 6:08 PM Chris Paterson
<chris.paterson2@renesas.com> wrote:
>
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Chris Paterson via lists.cip-project.org
> > Sent: 03 December 2021 20:03
> >
> > Hello all,
> >
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > > Behalf Of Chris Paterson via lists.cip-project.org
> > > Sent: 19 November 2021 12:33
> > >
> > > Hello all,
> > >
> > > Just a heads up, on the weekend of the 4/5th December the Renesas UK
> > > office will be undergoing maintenance on its power infrastructure.
> > > As such I will be taking lab-cip-renesas offline for the weekend starting
> > from
> > > Friday evening (UK time).
> >
> > lab-cip-renesas is now offline until Monday morning (UK time).
>
> lab-cip-renesas is now back online.
>

we still have some devices offline with no machine available:
r8a77470-iwg23s-sbc
x86-openblocks-iot-vx2

As I'm adding this devices to KernelCI,
can we get it back online for testing ?

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

