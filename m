Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE72C25B08
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 00:45:28 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web11.36449.1660783519326904816
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 17:45:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=KRnltkln;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.47,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f47.google.com with SMTP id
 v12-20020a9d7d0c000000b00638e210c995so235024otn.13
        for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=O+zS4VNZSQjEkv2NtF0NBxV19DqfYw9v5qhTEIOR+HU=;
        b=KRnltkln3EGcMMrYRyzzrrW8HtGivwZlSJlBh+iAVyahgHbGX+MwP4wzAIP47hhhPb
         UwFjPj22nUPsRGmoHXTaD/tH3E9/vhNI7OUjNdQPoS7DhDN16+RSb2McXVzjx1gB8PQ5
         MysextbcnjLEiLP11qX7mTwIr2AMcGcnqX1Zg7CyqIozNWCa184vsN0GluHpQOkvGBS0
         u3u3funXQgtJ86TgISFOeTjjGItVsrncHHJdGvb2yuYXRvoTJ9p6C37WrJCcO7eI0VVc
         z0E4T3RFnMog7n1i1fyUrPR5DY+8JHbOFJVpJb+o7kcr8jnt89s1C9bCiFWxb/xArQmH
         pd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=O+zS4VNZSQjEkv2NtF0NBxV19DqfYw9v5qhTEIOR+HU=;
        b=a6eVX1Fnf55zRgZzspeaBvzG8262nr4haMxtqSTaToVh6hrMu9HvhjFm3axPVakjVD
         6RNsW44R3ja/XFhTYIt9Zs7Z1AtiKVrxPzfPIHgFSH0ZpZfSZtTRf5uVLQ7GYgpmRIKA
         Naq/tAUZTWUYoSX0Qgfktk5ztSzGhubueCZkQqvJtPhKwIp5N/NKoeOWz6EOwQabwvs8
         IXODiB39xL6Jw7MOM0l7PBMJjrvB85AVWtFdsvb4PA4u2BI0fAJ0dt4sEm+raHMXj5ud
         Dd/oHyR9ZHO36RUoD+To3eK/3Yo0dOSHzXEZ2cyQTK1jBmo3RJ2PjntUMfhf21LMfxR5
         dalw==
X-Gm-Message-State: ACgBeo2pQI1WotgvCNyh05O6Dkov3WJlXtlAEY3RAu52z/rt/1iEf28t
	KWLJCOsy5Bm5+Hq2DPawi0+ID2GFSzxMqi2EgEKDHiVwB3IcHQ==
X-Google-Smtp-Source: 
 AA6agR6ydnlf5WOmlMfMoxWq9qDd/xOUjD7g2HG4ajO/YcFIjsx1mIukQs+wao0Rrt3V2NC3TuEM3bGWtyeXO3yOaro=
X-Received: by 2002:a05:6830:40c1:b0:638:a5d9:4c8c with SMTP id
 h1-20020a05683040c100b00638a5d94c8cmr329085otu.2.1660783518130; Wed, 17 Aug
 2022 17:45:18 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Aug 2022 09:44:42 +0900
Message-ID: 
 <CAODzB9r+9wpAoNphjgqF8cDjq+BvnPjJ-LxnK3db9JGkAeZ34w@mail.gmail.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 00:45:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9282

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=8&day=4&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/07/cip.2022-07-28-12.03.log.html

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
  2. Check cip devices on kernelci old pull request - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

NOTE that I will have to do some multiplexing with a parallel live
meeting. If I should be late, please start without me.

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

