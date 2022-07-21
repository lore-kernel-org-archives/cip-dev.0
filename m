Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36765C433EF
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 09:56:24 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com
 [209.85.219.175])
 by mx.groups.io with SMTP id smtpd.web10.4496.1658397381236854007
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Jul 2022 02:56:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20210112.gappssmtp.com header.s=20210112
 header.b=BY7nHWvX;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.219.175,
 mailfrom: iwamatsu@nigauri.org)
Received: by mail-yb1-f175.google.com with SMTP id 6so1897301ybc.8
        for <cip-dev@lists.cip-project.org>;
 Thu, 21 Jul 2022 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Pd1XPwEnYD1pmAsDhkeCkf1FAYAbZRd0J0nINmicNpc=;
        b=BY7nHWvXqFTQa60OmJTXFcEOe16W2KkPh8ZkNDHTixtIqojQSZWEiLWJvLsmqroQLk
         4UlOBDxVGymjvg+Ks2JL884gtYcBuD37X4Hz8EhkNTu38PNPT3dJfaYjgkekVwcxJWdT
         /oClDCgRoda+AyRyBYbpTphNxHFxPnVEv1YSX3SFDUhhFFx5aWFb9zW05IjwT7M6qpzM
         gf7YI7I21HQ0S1ywBb9/yYXf0+cs2KBxNM2Rx+WrulHXQOxZ+GptRpks7xF37Tzzs8Pu
         3YsLe794z2ZwN2pZwA7MwGBT9ZceabzEHWgZECazKhU53G85SiWB4qTlirFh3ffeYbuy
         fxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Pd1XPwEnYD1pmAsDhkeCkf1FAYAbZRd0J0nINmicNpc=;
        b=x/+ubIvrqYZ1QpDrp5/6PCsMUmHlOvMJF7X2qLcCueyKlzsHNt1n1y++y+BtdJmL6p
         7EKR5b/qllMoWdZ7QSrfthNhGgZyhGyLDW9CYoIKxEU6NEi0cvYcq4rNjg4ifQpTiRXT
         FpZ8FZpIt99Z00giWaZhVaw9Av54WEZum/dMMUFyFW9lOM+smbk5QjOamgdqpsKcjRTu
         N4cpBbbdLIjGDkOX3PhwvpBqYqXIanoc+/OZhXUGJ9B2ZVC/EUUoFQPXBOZ3tlul2x9q
         1th9H0Q5RRNUBxslnM7EIgV/dsatIH/bkzEQlpgPjhyAES8wm3eJfUOGEU2NjwY6qbbj
         v+Tw==
X-Gm-Message-State: AJIora8t6Tyyrr00V5GpJ2ZqcroQG8IRFENONacBoXAaT02y+cRDm7QZ
	nLMgfo3r4UntOfytlaqfowl2XBhCIv15H5nTrsjzEOQKZhZp+q4=
X-Google-Smtp-Source: 
 AGRyM1sLeDzpR7IidQbZMZp1mESYJqFZByzAkcGrVSEruB3QDIu9yAoGAeRo4CfvcoxMwOJ9wAOwDP/xuaNA0I/j++0=
X-Received: by 2002:a25:2ce:0:b0:670:8e67:4e7 with SMTP id
 197-20020a2502ce000000b006708e6704e7mr8856555ybc.516.1658397380351;
 Thu, 21 Jul 2022 02:56:20 -0700 (PDT)
MIME-Version: 1.0
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 21 Jul 2022 18:55:54 +0900
Message-ID: 
 <CABMQnV+KYO9cTmt8tUcxW_UO0O+EnZhbRFMFAXErnNVCEVW+tA@mail.gmail.com>
Subject: NFS boot error on some boards
To: cip-dev@lists.cip-project.org,
	Chris Paterson <Chris.Paterson2@renesas.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 09:56:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8867

Hi Chris,

NFS boot is not possible on some boards.
The board with the problem appears to under to lab-cip-denx.
Could you check it ?
   https://lava.ciplatform.org/scheduler/job/714812
   https://lava.ciplatform.org/scheduler/job/714806

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6

