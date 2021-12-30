Return-Path: <masami256@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3FCC433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 23:05:19 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.4889.1640905518354192797
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 15:05:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kxmmGiQT;
 spf=pass (domain: gmail.com, ip: 209.85.208.174,
 mailfrom: masami256@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id s4so24757531ljd.5
        for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 15:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TxMNFhD94aZJ3oy4I7PC+C55Gy0ZyYaBfWG+OksCgP8=;
        b=kxmmGiQT73py4rlSIWY6KADDTza1vVsXan4Ni96eLfaRsg/+b/neW5Rav+3YHy9uBw
         XLX3c1DQ5Ly2+SXkbein1vZMfmdwAKpzmH5YQ6GR20dowPvUlx5pbbQiZwJVypG6dmhe
         ZSyibDoeh9KHSvEXLCgOS5J4T7EPYcooGbxYBHEcH+Xew1SROW0v3VgFXwXsIFewH+Mj
         mk+038dLxNR9iWFWxmPCofhmSv4rnZMEN+tvBWaw2GRYWcz3SKEbFz2XlcnhAIWZpr6O
         0WJkNlAx0UVROCkOauEADoxYDOP1AimtWBhWr7JsupkUZY/lB1+SVOqeUyVzaRuldIOr
         HS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TxMNFhD94aZJ3oy4I7PC+C55Gy0ZyYaBfWG+OksCgP8=;
        b=2LpMRZcd2eaj971oFRWxmf/qW7EyaX+UJidmhPk2Waulb3RPcbhUGda7ut1mGwBZFU
         UHmLoOrCtvGFAALD0cAq7vpl8lhBTVL3L4mwCBAl/wluTAg4Jkh5ptpGr+pjK7+bV7No
         i+TJZX1ycz6pfzxSP8UOOJUEzZP4jzTl9WmIC30NV4CztmCJ0p8tl7ywW9p24109op6J
         yUwwWN/hoNXk/M/LALcPKbPs62W+lJvdZdfJmOnRIRUTeT01n3yQtjp6ctUc2e6/MbBY
         GwBNJ0HX4aWJmaLVNqhWDD0AyznLV47XxpUltop0e9LJ432TjUIfGKi/CCLT+5tmA0aY
         b3Kg==
X-Gm-Message-State: AOAM5324tOJdgZznO6oSmry3prPinVBNlsmzk4e0xbdkzm16kmnjGC44
	jzGonwKv1eWrrhEPlGoKUiBsqdH6Vp1YZ+mbjezG9dhs
X-Google-Smtp-Source: 
 ABdhPJxP/0n3frc+YNj95ybwZDML+YEU93mgsEFaLJvIMiS1v3PBlcN7t1vTjwoGSXyXWOdiVvhCfrFFLbEvaE0r5vA=
X-Received: by 2002:a2e:b043:: with SMTP id d3mr23385313ljl.415.1640905516109;
 Thu, 30 Dec 2021 15:05:16 -0800 (PST)
MIME-Version: 1.0
References: 
 <CACOXgS9X11kXTPC+ukH2aommTWahwWSuAcuqXveZPpT2YiNBZw@mail.gmail.com>
 <20211230102038.GA7207@amd>
In-Reply-To: <20211230102038.GA7207@amd>
From: Masami Ichikawa <masami256@gmail.com>
Date: Fri, 31 Dec 2021 08:05:04 +0900
Message-ID: 
 <CACOXgS_1OiUhYqHfCLGPSnmA-8b0Ngp4RvHmPSXwPnrC7cvuLw@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 23:05:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7320

Hi !

On Thu, Dec 30, 2021 at 7:20 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > CVE-2021-45469: f2fs: fix to do sanity check on last xattr entry in
> > __f2fs_setxattr()
> >
> > CVSS v3 score is not provided
> >
> > OOB access bug in  __f2fs_setxattr().
> >
> > Although it is fixed in stable trees, the patch isn't merged in the
> > mainline yet at 2021/12/30. The commit 5598b24 ("f2fs: fix to do
> > sanity check on last xattr entry in __f2fs_setxattr()") is in
> > https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=dev&id=5598b24efaf4892741c798b425d543e4bed357a1
> > but not in the mainline.
> >
>
> Interesting. That's wrong and unusual for stable tree.
>
> > CVE-2021-45480: rds: memory leak in __rds_conn_create()
> >
> > CVSS v3 score is not provided
> >
> > This bug was introdued by commit aced3ce57cd3 ("RDS tcp loopback
> > connection can hang") which was merged at 5.13-rc4.
>
> It was also merged in 4.19-stable as 0a3158ac5999fe. That's why we see
> 4.19 tree needing the fix. 4.4 is not affected. Good.
>

Thank you for the information.

> > mainline: [5f9562ebe710c307adc5f666bf1a2162ee7977c0]
> > stable/4.19: [1ed173726c1a0082e9d77c7d5a85411e85bdd983]
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7310): https://lists.cip-project.org/g/cip-dev/message/7310
> Mute This Topic: https://lists.cip-project.org/mt/88025787/6028936
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

