Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE11EC54798
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 03:49:43 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.43052.1709351376635827705
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 19:49:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=kSmlCiuD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6da9c834646so2439859b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 19:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709351375; x=1709956175; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QSh0lVOrBduudPA6eVaX3yr3H6hRhOQIjl6RrkiHUno=;
        b=kSmlCiuD5DdQxYKzjX6aO4rnozs1byIHu8laVadsFi2+rC/CLBsXj8nFxtXsJ2ygEJ
         6BN7ImBh6KtYGLND0ffvmGSVOoopj3XCLsMVfPiUlzHGP/lv27qneRhYrVfML5oez3CQ
         bBp0S1j56yaotu2gQETQ75FeMGrB3vdHMT+vBugvevkxtFqBLO9hWg9y6imwU9mkHDxv
         XKAKXoSFHhRs8OwYvWKW34jOcjLBqYELGYIjqSjEVXB9PeReQvKwrqP4A34TfFro5e4+
         dKE/s4gK5wZe7o9NosuW5XuX96mWSi7IQAgH7Tx/GNN/Gf5IYhtwm6tT9ZDOuGiK2/6D
         Iing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709351375; x=1709956175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSh0lVOrBduudPA6eVaX3yr3H6hRhOQIjl6RrkiHUno=;
        b=j5QfeO9Zp7jaxtGiNze8scWnkm/pKboImBJu1d4p3izRPu9RRSn6024iA33Y2AV+wM
         J53+8BvNhB1jZQpMOpTg+ypkGABdg3FB3/j5CWkMnPRoD/N1Zg41XMzxhBSeYeEhsBIM
         gzP1WQOJgni8R+JHnmOEpv8QMJ4XWXXnsEDreZ6leXb7POZRUjxsWir7BYKI2iRUFnvL
         j287mw8jWa2H9fo2H6p3a4jHPy5mSSCTmNd3qfUbwVtgP9aLiUCV/Uj6tWQNpZ6hTNOa
         FosQ0Kh/cgMx9DrSYUJidiWVBCmSmclB3RWMHwf8N4NR1n+jyzoz1bk4XczsbHil+zjo
         +44w==
X-Gm-Message-State: AOJu0YyZ/vzKcqwctQz+z5FXWZoT1vKum8/d8kySMnr/SqqvMHrH01nv
	G7cWctVOpGVN4t+Xf7FtyTA91773d7P9/1tPnNeTbRwyKUptDyn271YVesp3IFA6j0PMiMnRxHQ
	9On0=
X-Google-Smtp-Source: AGHT+IHCmXU57myPOHjoOyfxRTdabNsjyWpgVZwm5zvimA1NIaX204zvkAhfVDjO03VnaJTxWHpdJA==
X-Received: by 2002:a05:6a00:17a8:b0:6e3:3bd7:6f23 with SMTP id s40-20020a056a0017a800b006e33bd76f23mr4876939pfg.8.1709351375207;
        Fri, 01 Mar 2024 19:49:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h9-20020aa79f49000000b006e46672df97sm3654242pfr.75.2024.03.01.19.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 19:49:34 -0800 (PST)
Message-ID: <65e2a1ce.a70a0220.d34ad.2123@mx.google.com>
Date: Fri, 01 Mar 2024 19:49:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.306-cip107-rt35
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt ltp-timers: 8 runs,
 2 regressions (v4.19.306-cip107-rt35)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 03:49:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15161

cip/linux-4.19.y-cip-rt ltp-timers: 8 runs, 2 regressions (v4.19.306-cip107=
-rt35)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-board          | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...d+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.306-cip107-rt35/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.306-cip107-rt35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-board          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28dd783134a0a55637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/defconfig+x86-board/gcc-10/lab-collabora/ltp-timers-=
asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/defconfig+x86-board/gcc-10/lab-collabora/ltp-timers-=
asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e28dd783134a0a556=
37013
        new failure (last pass: v4.19.299-cip105-rt34) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...d+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28a1d15dd940e9b637035

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/x86_64_defconfig+x86-board+preempt_rt/gcc-10/lab-col=
labora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/x86_64_defconfig+x86-board+preempt_rt/gcc-10/lab-col=
labora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e28a1d15dd940e9b6=
37036
        new failure (last pass: v4.19.299-cip105-rt34) =

 =20

