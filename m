Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75CDC25B07
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 23:30:15 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web12.517.1660174210154483154
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Aug 2022 16:30:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ePMMRKwA;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.54,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f54.google.com with SMTP id
 s10-20020a4ab54a000000b00435f410bbacso2859306ooo.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 10 Aug 2022 16:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=vvXIRk12whFLbnb2I/vKhOBMkf4G4Hem/5QcD9qKes8=;
        b=ePMMRKwAV6zzuK8I5Atkwg09VFkKtprPOZYwSBE7RBYHR1WTy0cxAdKzISO9nWgOlC
         brssQfEgE/A/IRNopEqZIqCAsxgKDZ3fjx9W5GIVuvCFxMKC/Pi5IZzmzO5fIakyIhuY
         HBhe3LA4NqfCsBdCuwaeKUmDfubiC5z9qfQUJtQUcu5765NpeGUAa5CmhUKlnBB8cKRx
         VAeCW5gxwph5gRgjjVLgnHn9uP7Ifr+dQ/WB6A8lJYu4xiuC24ZtIObjrBUOBJBCGxPy
         61mK/gZ1Ca9sbKtSbzc7yp6VFrLj6UkOg/UvDbGegxQWCULEz8q5J9XkjZbDVYwIlgV4
         gBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=vvXIRk12whFLbnb2I/vKhOBMkf4G4Hem/5QcD9qKes8=;
        b=wOwZ1NGKmPm0dbxGE2S0ECFxoxvF6roN04HBxJvebJwC6oxhZFqPXc1FPUN8F5VbYm
         JXK5eAaKGSH6qH0wCHh9AI2Gz+wyBmGWRqveGuThipiXnAzsGYjMfdzE3y2J2jfHm1Iw
         2/V5NWa5fbIy+v6eWnqnJq+vn/U+7dA5+9a4PLe5Isb4Zsh4ACG1CINnMAU986EbOcMZ
         9jt3yGHk/iP+uVdwBc62rZmP6DrQ2RWI2eQp6QCKvExAvPCHDg7a6lkKVOlymGIzYyIX
         3/QYNwc+WfuDy5+Gs3Qj00Sn36Q4y1jJdXiRbwM6tTf8Ekre5vJABfWMg8simmJmmQLN
         mVAw==
X-Gm-Message-State: ACgBeo37zarx+23T+DID3M3qeQ7O7/nOEvW4FmgwBsl+laKbUIzU9pqc
	h3tfGqmIadtOezv2KkO7bk64zZkkKvfiLaWqQYOa/5syLg3fMA==
X-Google-Smtp-Source: 
 AA6agR5W4GblITcx86XJ3s6hjpCGsuJyrb4OTHp+KZWW8/FlygLP0GE4mgNnOeagCBK+dwfdXsmq0XHy4WjUS4L+4YM=
X-Received: by 2002:a4a:3f41:0:b0:440:b3df:3e04 with SMTP id
 x1-20020a4a3f41000000b00440b3df3e04mr10144885ooe.92.1660174208932; Wed, 10
 Aug 2022 16:30:08 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Aug 2022 08:29:33 +0900
Message-ID: 
 <CAODzB9oEG7mvCFrm0OA6mkSYQYNf-BMR3Zmm62fojVT+n-tE6Q@mail.gmail.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Aug 2022 23:30:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9154

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

