Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4098DC433FE
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 02:59:11 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.2506.1668567544229453230
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 15 Nov 2022 18:59:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=lPCDDhBe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id b29so16176945pfp.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 15 Nov 2022 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx9RXupEOIELOt7IAyjYx1KtJVOPeoo1pj6NTxQv1M0=;
        b=lPCDDhBejv361cfW2RSk3I/uSMTyqATvX5B86Muu3o22YlFPKzcsTsnGaLMYseAJsx
         5ZpOXrP+GPKoVEjman+yguZhaFzwn5DDv/TLwzeE/GxjXO8pGSPVVhfCUcEvg6ag/1UD
         BcVwFci+8DXRU+6jAQGFhqI0V/LqUwVL7aziz6ZPhqMumzMLXxCpB4EoUeO/ONjkLmfP
         eBCGHl6ols2gzefy7M+AZtIga9A9GgSsiJqNTGGpN5Gevz4lnhU9l41hhnw7WKAbio7x
         UUd/n01zwzP9wUC7ZnBuuzoykVwZ2gXoiKi8+o46OlrcmCej9NzOoYLihDg2F1lmEfAd
         jFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx9RXupEOIELOt7IAyjYx1KtJVOPeoo1pj6NTxQv1M0=;
        b=VcFy1RploqZT+nHdxS2iC0pfhU1lJ/sS1jhIOxZWP4kko2A4EQRzQNtocrz/eVRNy3
         gudW59WXVbSepiuLikP3dr+DhBtRrYNlcPOligMUNzIIwcr+SNzgYyxGzEG8mxEaEp9k
         m4U87xfr+YF4cFB6T8xYbju/kDSIkzMzdNAdRZdgofcFIxO9tohEovSzlnOijfwZKLyr
         nq4OUNcaf83+VllRvQX1xf1OXjtrAfwQS5JBsmNPAV7jeszhNEOEBCEYaLwKKlcvsSGD
         agYbHTOZIpQsqoSYSzB1NtID1R4thC9HDBngY9jBK0SkkJQSWgTU3SFCj3U1NRCy0njn
         Rf4A==
X-Gm-Message-State: ANoB5plhv0eHowBP+Tlkz29rPhZZnyan5rhtMGpTUDWNIkXEFzz5IYs6
	UQD2ZA2k3sq9IzoTzhD8soJNWKQzZqbLzssh0a0=
X-Google-Smtp-Source: AA0mqf5e7wSNySj6f339zZTV17QCL3I1vNwy29O70OHxsGgurpET9QZuH3WatF2uEd9EBx+38oNb2Q==
X-Received: by 2002:a63:fe51:0:b0:459:a339:89e0 with SMTP id x17-20020a63fe51000000b00459a33989e0mr18785898pgj.300.1668567543491;
        Tue, 15 Nov 2022 18:59:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b0016dbdf7b97bsm10591929plz.266.2022.11.15.18.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:59:03 -0800 (PST)
Message-ID: <637451f7.170a0220.6e289.07e2@mx.google.com>
Date: Tue, 15 Nov 2022 18:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.265-cip85-rt27
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip-rt ltp-timers: 6 runs,
 6 regressions (v4.19.265-cip85-rt27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 02:59:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10037

cip/linux-4.19.y-cip-rt ltp-timers: 6 runs, 6 regressions (v4.19.265-cip85-=
rt27)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.265-cip85-rt27/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.265-cip85-rt27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7b2b3defe99e6a33cd295c5120b96288f81f8bd7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/6374468083c92feafc2abd28

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374468083c=
92feafc2abd2d
        new failure (last pass: v4.19.245-cip74-rt25) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374468083c=
92feafc2abd2d
        new failure (last pass: v4.19.245-cip74-rt25) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/6374475b65d40b9a222abd0e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374475b65d=
40b9a222abd13
        new failure (last pass: v4.19.245-cip74-rt25) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374475b65d=
40b9a222abd13
        new failure (last pass: v4.19.245-cip74-rt25) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/63744824eb56fddbec2abcfb

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63744824eb5=
6fddbec2abd00
        new failure (last pass: v4.19.245-cip74-rt25) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63744824eb5=
6fddbec2abd00
        new failure (last pass: v4.19.245-cip74-rt25) =

 =20

