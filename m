Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F94CC77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 12:25:53 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.6172.1685967950484220238
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 05:25:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=XdUC+mvX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b02497f4cfso23197495ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685967949; x=1688559949;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p0bRIq85nOuFojuwNU/lIlO8qksrhwuIEngLjUcF1g8=;
        b=XdUC+mvXMs4RwwyPSzrrCKwhOsBfPsXP63cc7rkvgqYoe6jnu9VQ3YyZLzmTMiysJH
         cnJAc56Ijzu6MO0v34cuHuQ/2VjLPIp0bkD0tvg8e3FhKmPoVZ7cMmV9Dzb9VFyX5JoS
         Tq1PJTWdjszwFyPp3ToA71+4wU3NkTI4kVntsWsUUWuv0bJuzERJXdViUYOffe/l0PrB
         8GD13vWi9/6EwaE3dupzMyu+N5902RNcKTl57i8Zp9gesB3pZsqO+Pfkl7cH/njqkmKO
         3sM6QPhYXw2dGvxlBcRWHO7WRp076Gmw+/47Pw9iBSpT3HzUi0BSfDH9Uo5sHL/xdAH0
         +R9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685967949; x=1688559949;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0bRIq85nOuFojuwNU/lIlO8qksrhwuIEngLjUcF1g8=;
        b=EdP8rtgUGAxGF/5QCjrjmedUs7OK7nMZhkl9lZ06/7n5bfgkK9KSzN3/CAZB5eCyEP
         re/ieC/rcvWVqKRhdfPA0PHBdKJH1BBFRZj+qRT7e/ILdpOl+eyZT0j6MaHmeFRx6q89
         mUMNhsH+ZWVE6kZ4T4mpP5Wj5SRK1ExAgMpB+N0GDm4TDE85ElzPHcizdEjw+4rdERe6
         rN3NrL6B12gU0uWrtICMy7nrontuX47bQqeFN4nENdgZ/G9zyM4O3wzP2dyCnhgBYcU9
         2uEZ8kgOlHlp1Z842x2kNSx7WFmnuEG+XU82N97k0tZctU7Lw1e3Zec+R6FHGtSFr+I4
         CM5g==
X-Gm-Message-State: AC+VfDzxnt6fiKAitYSEsdTlXmTHSPQb9TTOahX/6ynNpT27PPh+VOQV
	vsV+rFoCJ60fvZEUMYEJwN6NFMINkVrVHlpRVgv15A==
X-Google-Smtp-Source: ACHHUZ7BGdpBoLHSi37EonZK6f/CYxwZVXopS5cz9p2QnvKO1+DiQMt070Cv63BMaBVMHKCwKI7BOA==
X-Received: by 2002:a17:902:728b:b0:1ae:2e0d:b38c with SMTP id d11-20020a170902728b00b001ae2e0db38cmr2710355pll.12.1685967949422;
        Mon, 05 Jun 2023 05:25:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b001b027221393sm6466172plh.43.2023.06.05.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:25:48 -0700 (PDT)
Message-ID: <647dd44c.170a0220.d3c50.a3f6@mx.google.com>
Date: Mon, 05 Jun 2023 05:25:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1298-g61395b9756bd5
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip ltp-timers: 7 runs,
 2 regressions (v6.1.26-1298-g61395b9756bd5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 12:25:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11811

cip/linux-6.1.y-cip ltp-timers: 7 runs, 2 regressions (v6.1.26-1298-g61395b=
9756bd5)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.26-1298-g61395b9756bd5/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.26-1298-g61395b9756bd5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      61395b9756bd5614e204ba22b9c75fd47c24a999

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2     =
     =


  Details:     https://kernelci.org/test/plan/id/647dc2d8c12d8f3984f5de25

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-12=
98-g61395b9756bd5/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers-q=
emu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-12=
98-g61395b9756bd5/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers-q=
emu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dc2d8c12=
d8f3984f5de2a
        new failure (last pass: v6.1.26-1281-g84d5372e0f314)

    2023-06-05T11:11:12.192561  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dc2d8c12=
d8f3984f5de2a
        new failure (last pass: v6.1.26-1281-g84d5372e0f314)

    2023-06-05T11:11:12.192561  =

   =

 =20

