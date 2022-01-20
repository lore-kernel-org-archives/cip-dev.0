Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A657BC433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 05:35:06 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web12.7982.1642656904066064498
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jan 2022 21:35:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=GZCLHAgV;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.52,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f52.google.com with SMTP id c24so21379940edy.4
        for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jan 2022 21:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=WM0uA3PNegu9wlExML8sDartHeHf0bX3ky9SgRK9bAE=;
        b=GZCLHAgV/gXOFmTvLb00gcAZrXv9scMXKAu9eslJK8sDR1ka0Iszk2xyijUs6DeDM5
         imTXMe6xu3frXFwDxZj3rwpawwjgiT+p0IvBUFGDaovYX8ehIiEUFMtfUgo7PrrXJAer
         ypXAbe7PytGxIuiFT5h6XZDRyxRPQeYL7s3NW7YUBtI2Y1dohZaq/GDv9MhNooY86n9m
         dP+vwu0HMwF9tr8uiKkt7L4c0RPOEOiZeXeyUkCyPTvw53JOoaynBBM5vfykd5RR10Dc
         diwsi0h7JDHb9TevA3rldRn/c0RK0AWTjN4s0Fj+0t7VWUPg3lqPukrfnDAINZKj+hEa
         SbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WM0uA3PNegu9wlExML8sDartHeHf0bX3ky9SgRK9bAE=;
        b=uG0enbp6XCh4vmsXITRf7XUyOOUBpDVfNUEfvDewBCEh23po+Dmo0n/Ac32PcKKJ4W
         KhA2BJ0ZkEywtnXjOKbt8Fmd/sljA7NSuzQrP50eQCwh+5WX9Lji5cKIkQZp9wrWlBPu
         lezJ6iAPPlcw557xKd681Y1/zw6GCLp2tAJsWnK2jP9dvGLrRPsc9wl2MUmYl1h2+GLd
         6IDWqajQr5qPfttCy9qfwRxH+wlY6i4yPRpnyjmml63RdnkHvNeUNN/WOm6T1RnRdG0u
         JRmOydSkfWDqKdraQsVERP+YFVCiesRghPvcK4Al0Bsklg36uMf7dqp3q/PwpThf+5Hs
         1Leg==
X-Gm-Message-State: AOAM5335JlL+Xh63kof852bd45MXovkgFxprbgXrX6YvW4L94NPftzPg
	iZEkJbV/PMStnxMGOFdagp0MWFFQhNUO/dupnbNf2d/F8Ifm
X-Google-Smtp-Source: 
 ABdhPJypQW/ENH6CnXjayO8ojJS9oqAetAIZsDpJghrmxijHtsiZKL2EjCEbasDPD0uK/kXSnPGIPpDTmjslhuSiG1Y=
X-Received: by 2002:a17:907:6da0:: with SMTP id
 sb32mr28764281ejc.455.1642656902145;
 Wed, 19 Jan 2022 21:35:02 -0800 (PST)
MIME-Version: 1.0
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Thu, 20 Jan 2022 14:34:26 +0900
Message-ID: 
 <CANgtXuNta+nXNdsgb-Q+a1RL1uqyb=pO4=JHKiwsCx07EE27-Q@mail.gmail.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jan 2022 05:35:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7470

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

     irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=1&day=20&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2022/01/cip.2022-01-13-13.00.log.html

* Action items
   1. Provide v3 of kernelci patches for isar-cip-core - alicef
   2. Clarify with KernelCI whether CIP maintainers can get accounts -
patersonc alicef
   3. Meetbot situation - patersonc alicef
* Kernel maintenance updates
* Kernel testing
* AOB

Thanks,
Alicef

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

