Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B6DC433F5
	for <webhook@archiver.kernel.org>; Fri, 26 Nov 2021 06:23:55 +0000 (UTC)
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by mx.groups.io with SMTP id smtpd.web12.20823.1637907832880180912
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 22:23:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=HFe7UNix;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.65,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f65.google.com with SMTP id y13so34315846edd.13
        for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 22:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=6m8Kd+9fPKO2s74gap3hovMGihqozjmeAhmIgq9l5h8=;
        b=HFe7UNixKPt/9d/WhsfuN8gY6/lSHdre35214cmZ24PEG6WaaxImhtss/LU5jTgkMm
         VBOv7pQF3h8KVyIgfboTM5OI8XeExkdMMX6j4hFZrc496hkd57Q16azKnV/d4pJ0Skw/
         rSqssMcdMDI6ZkL7gd+Rv9UiomUY45XXFz5/ZCsiG7Pgzhm5O2xfYLPxXQcgW2KSqYPE
         EDY9LdRh0gD2iGqSnA71rx5UmNtcfYV5pVJ9Nn/eHpJUrAQTvpLIOs61rCsG4tvQrUUN
         Z7/jJFHdScLMq1S1WmDeLANKS9I1vcKZfJpwnl2unZK6aNNptM1cjxvTfkgNKwFO2Dq6
         4WCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6m8Kd+9fPKO2s74gap3hovMGihqozjmeAhmIgq9l5h8=;
        b=iGiQ4Im1lql0H5JWZsoeOmEJE3tlD+MQDHEs1Sjv4PoEmmTAIKaTReUXWQxzZ3BVaO
         eFZrgqVkfWA6r4og0JjiyDzvJMUXY9/umyZZj9IrXwn19c0tjG7Y1I9WsOPa7Ukry4wf
         7ZS9f/kNpyzpRF1UpRDUmqiWRjyouHvkaXpSNWNSVJnDO3K32J2/j0mXabTRH/c3QKRy
         QWP1W6UTfrr8QxijpZV4oNB21j5VZ2sce0dQV2lgpht+Wnucckvmbvx0VLpTJrDSmsLv
         2f2MivKlR6c3jKcJykDgzlrTC8v5SsVm5DhUPR+OcYk5UKoNDTkCFamws8u230T4YdFq
         +6+Q==
X-Gm-Message-State: AOAM530k6q2imqgno2IMyDdTlwNA029SnmR/ay8o/mVMXY8ADglysR/j
	KMaoNAFJ7Z0JuUKNi7XYgkQ0Exg8UF42g2ExF/SuFU79a73V4zo=
X-Google-Smtp-Source: 
 ABdhPJxCYtnipa32YrxasiLRIbFcUG8HRAYgnRCRBDPm1QmJed/Qr+kVSLJxnVuDYjWt8TNxmLDc/TlC1bo5BELO3pA=
X-Received: by 2002:aa7:d80d:: with SMTP id v13mr45632057edq.7.1637907831132;
 Thu, 25 Nov 2021 22:23:51 -0800 (PST)
MIME-Version: 1.0
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Fri, 26 Nov 2021 15:21:03 +0900
Message-ID: 
 <CANgtXuNiuHWS+QkrogB67ytimmu0ua7dn0Lz3Hv9_qeW2ebaCA@mail.gmail.com>
Subject: example cip/linux-4.19.y-cip and stable/linux-4.19.y results
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Nov 2021 06:23:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7020

hello everyone,

following on yesterday topic about difference from cip-cip+1 and lts-lts+1
I just made a diff of what was requested yesterday
v4.19.216-cip61 vs v4.19.216
the diff can be viewed on the link here under:
https://www.diffchecker.com/W4dpv6ep

the results are get from:
https://groups.io/g/kernelci-results/message/19033 [v4.19.216-cip61]
https://groups.io/g/kernelci-results/message/18808 [v4.19.216]

thanks,
Alicef


-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

