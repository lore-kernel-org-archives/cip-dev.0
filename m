Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0504CC6FD1C
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:35:55 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.19970.1678714550979360003
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:35:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uJAamnjY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id i5so12958835pla.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678714550;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kokN+yLXjswcuHADrYh8aHKCnufBCMdiN4XmHhjPitE=;
        b=uJAamnjYf1f/+poymVximuZMl8r52Wit6dV+4Xfno6v3x2/aduf53HIbTHPAgxhtwC
         kqtQOUn5Tc56k4YKhDW8IdVQrcl5DeP/k67twsjiHQZNHHGX71TTCNaKSTBNUi/NT7NG
         MOJo08j1y9GjNjPaKl4gATNtQbtcA6+3PGEjZGZq+X3kAC9QZQHWoEWD4gKWletDgYMR
         wTJrfcSflGBZ6NQVOsNQm8DfRg/UdPL/7QR92y3HkwI01sYYWJKPcJpcT/26DcbWdSLx
         g+IqKcIGTMbCu3NlRbXj75r51Hk8Y42KyewZ15QOFAixWw5t1n8RpPsWb+HTfnlGLV2M
         PuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714550;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kokN+yLXjswcuHADrYh8aHKCnufBCMdiN4XmHhjPitE=;
        b=G0yHaof+bWrK56y00qL1Lu7TgymOtCGfJoD6GbVKJezWDpoTor9phaqJb8xIs7Jvwe
         xve5Rt5QyOsi4g07qxACxycGOYSdTdmp6/IfjDNSOLQMnU+AZprg0Wy/HvD1v6bBah41
         ys2fc/3v/W9FxmfTZNgFHSgeNDf5GTBs8WR0g2YriD5o+7E2Qq9jOik48322Qut8Ncvk
         U+eIBEZyB54YeFN1NM1mYUB7GDiYgh4rZfiGwKUCobfw1YAGx+Iol6aOVZ4J2IpQjPlT
         ksDl4Rj+XUtog0NSTTnmK+sjX5p3ZtTUJ0eydgA6QoGZKCP6raidT4ex8AZ/l8KIIXIL
         DmvA==
X-Gm-Message-State: AO0yUKWB+W6d4SpS/kUnVlT1FW7cIuOH9IGwfVWa4/wTJQoIEbTzsX82
	t65vXwxuvtK5+5iWDuzOeFIorhsoOjwHu1AlOPGSfoz0
X-Google-Smtp-Source: AK7set+WPzklvCZ9H2+tbpEStCf57mz9kcaUzTyYZS2BrpMS2OR+MPKyXii3VOLspxdIwMfxWHEMwA==
X-Received: by 2002:a17:903:2282:b0:19a:a9d8:e47f with SMTP id b2-20020a170903228200b0019aa9d8e47fmr43363002plh.36.1678714550299;
        Mon, 13 Mar 2023 06:35:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b0019a7c890c61sm4766220plr.252.2023.03.13.06.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:35:49 -0700 (PDT)
Message-ID: <640f26b5.170a0220.fc72e.7a7b@mx.google.com>
Date: Mon, 13 Mar 2023 06:35:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.276-cip93
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 6 runs,
 6 regressions (v4.19.276-cip93)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:35:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11011

cip/linux-4.19.y-cip ltp-timers: 6 runs, 6 regressions (v4.19.276-cip93)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.276-cip93/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.276-cip93
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      849e6920f9039d78588d7ab644573c58cca7e64e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3cbaaddf6f785d91aeb370beb75d0623f8c48624 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640f18d1613c9564628c864c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f18d1613=
c9564628c8651
        failing since 107 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f18d1613=
c9564628c8651
        failing since 107 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640f221e061bce4fc98c863f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f221e061=
bce4fc98c8644
        failing since 107 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f221e061=
bce4fc98c8644
        failing since 107 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/640f211799e824ebbd8c868b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f211799e=
824ebbd8c8690
        failing since 107 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f211799e=
824ebbd8c8690
        failing since 107 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =

 =20

