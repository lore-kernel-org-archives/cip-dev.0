X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.9590.1648044139982174024
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Mar 2022 07:02:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ojp03oul;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id g19so1560671pfc.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Mar 2022 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=sgxuZbAX4UKJfgcA0R557ibedEpb5C1H9yW9xd63nio=;
        b=ojp03oulhtSGHtf1HFku9LzsOxSF/zZhdyfKQARC8r2oBtjwCtKBmt3hi8qjHwjsW9
         ORX9fmxowgOzTEpHm+goXtfWfVr9omZ/ocF7ASWU1CZyhZ4x1/qkHHp9X8f67QhQ9xeF
         55E7GJSEnMgPGTeGbA/ZHc3p35TM24wyO78dZ2Sz0Mq1HbHWSmIWQdrRfSH0NtlPAD8y
         LWYKaqK4YrhLzay9LTRVijfNrb+g3p110+mP/MJx0kYmyBpeGHvZmm1vHavQbp687UQx
         AeX3A7HaQnX40Y+LxiGvOEsEyiEptOcEiUUXraamTJqB6Rk2VaZSjYnRGiuvoAuaPRzk
         mT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=sgxuZbAX4UKJfgcA0R557ibedEpb5C1H9yW9xd63nio=;
        b=iKp+isQ0GGUXSkA6NDNTBqkKq9Ughb3uukP2OIGRrvhoHAA3lFZ42qeTb76hF5tCK7
         GpmR0vSdEqNrs6MXHgIW5vzc3dHPp/SXEmchM+rg4ggYu6wagYjiUmYiaFYeTmY6WoS6
         05+VfVQ2q+zUdMXqjGWepHkJ+i9de3n26FfL0MrvkIVgtDYAIN+DKEKWx54G5h7ZhKbT
         uxnqxBmeqMOKb8yhhN4YF2qEo60kE0aK4+RtT9eJzB3xe1l1Pj8H06qO0tPlzt46h2wd
         RlUOR4b8xbmq0v7gQnmb6QtZtCj3MXxdx9d5yFrEhQZiZY7rbyLv39N/VFUq/VNr6Dm8
         IiCQ==
X-Gm-Message-State: AOAM530KHdnF/F8Qtmn/P9DEby2EG1HqnxUZ0VUiLHcF92jLWhjmbgoD
	igcnLJQZI4HBCQNa4vZEfCNSuTKlwre0fw8EWCs=
X-Google-Smtp-Source: ABdhPJwS7AgI4qUhAkwfDbA9Q8tA7NJT752KjEc616yT+ieWHhaE2sl4YrCUpnFv0mXgqRIMaJuqyA==
X-Received: by 2002:a63:525a:0:b0:381:eef5:c9d7 with SMTP id s26-20020a63525a000000b00381eef5c9d7mr80924pgl.106.1648044139013;
        Wed, 23 Mar 2022 07:02:19 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k15-20020a63ab4f000000b00381eef69bfbsm29785pgp.3.2022.03.23.07.02.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:02:18 -0700 (PDT)
Message-ID: <623b286a.1c69fb81.3481.0104@mx.google.com>
Date: Wed, 23 Mar 2022 07:02:18 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.233-cip69-120-ga36ab9aceb93
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 4 runs, 6 regressions (v4.19.233-cip69-120-ga36ab9aceb93) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 4 runs, 6 regression=
s (v4.19.233-cip69-120-ga36ab9aceb93)

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

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.233-cip69-120-ga36ab9aceb93/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.233-cip69-120-ga36ab9aceb93
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a36ab9aceb937b317b1eb65a1405f5290fbdc6f8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/623b1ace4d274d4377bd91ab

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623b1ace4d2=
74d4377bd91b0
        failing since 14 days (last pass: v4.19.231-cip68-36-g01a8d14a9290,=
 first fail: v4.19.231-cip68-89-gd39fc5cc85ff) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623b1ace4d2=
74d4377bd91b0
        failing since 14 days (last pass: v4.19.231-cip68-36-g01a8d14a9290,=
 first fail: v4.19.231-cip68-89-gd39fc5cc85ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/623b1a74d223b7b06abd9198

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623b1a74d22=
3b7b06abd919d
        failing since 6 days (last pass: v4.19.231-cip68-89-gd39fc5cc85ff, =
first fail: v4.19.233-cip69-62-g10346bfb0fd8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623b1a74d22=
3b7b06abd919d
        failing since 6 days (last pass: v4.19.231-cip68-89-gd39fc5cc85ff, =
first fail: v4.19.233-cip69-62-g10346bfb0fd8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/623b20dfb091167819bd919f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623b20dfb09=
1167819bd91aa
        new failure (last pass: v4.19.233-cip69-62-g10346bfb0fd8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623b20dfb09=
1167819bd91aa
        new failure (last pass: v4.19.233-cip69-62-g10346bfb0fd8) =

 =20

