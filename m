Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A9FA3741
	for <webhook@archiver.kernel.org>; Fri, 28 Oct 2022 15:21:36 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.753.1666970492740510027
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 28 Oct 2022 08:21:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=JXW11VXp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so10129076pji.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 28 Oct 2022 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bbNRKEmz+IBhRcGO4oSHlT1dHJQZ8MH/DLkDQbLVZuM=;
        b=JXW11VXpwAkcTqS97RPjtYUqLxgLXsPh6axvrS4aIsnpSXmGkKRr8r99I6VaCkq+21
         mvrcHeTswnOvE/Jbk7iWG6WBHYBEYLJKbuxGYj2huZqUiEozf3V1cW7K/Ry/RHHeVMZG
         MXTY1GxQYEMab8QhP0IM92sp69ZTYNlXzpHxVxcJY2y9i8/n1aj/myAWVZAFYX7OoToM
         9WJkE0Uo+Yh3poKg2pY1NowGthnANRhCid7R7jf/wZ8KcNRRrAqpRSi2ClsSn4lttKxU
         aVvTm+GkhZNuhxAgWw8E/h2aeYG65Xpd4D/tDhy35ZJ/fUzzO/inZQDmKuqyawvi6mXW
         fMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbNRKEmz+IBhRcGO4oSHlT1dHJQZ8MH/DLkDQbLVZuM=;
        b=EQRHLGBLSNGHq5VxLw/tXboL7TK3O/CfusZmZUAPk2xsL+CODVKjEFrAjVQuB65qMJ
         qf/PAdkBrbYL3Yz61t3eWnX99zuVCEN4czqhpsN6/ce3DtDhNwa6Iv0D1d/7CvPVStJ0
         +nTmxSwN22DZDYV0nHb78AuKITzF6lcTV58ZMVxahQK/ePeGKfZAmZHnu5SYSJ2aghdM
         Vtd22Cwa6MKUJEze3dx+OqETbbLgc26r/5Q+5Z+s2hlbMnLZsgxgPYcCvfNp0zDVGkAd
         ITRjmPQwSwLFRWrCsG2O6t+mtUeaoOFYe/31sEoNddpui9bPMhtD6VwaiE9/SMhRhxs7
         bFtQ==
X-Gm-Message-State: ACrzQf0NE/GvXiruLcvRoEi1Lqi4m5+6xef/ncaV/Qib+cuNMGJcSttZ
	66WRI6o/axDZ+ajc81RmG83oXuucYmBauGHh
X-Google-Smtp-Source: AMsMyM4we0QFAZH7fct6k9YBkqSRaS2w1FUNzH+LaRc5KxD1t+Ltf5mZvWILB7OmE+nlDgcxJmdh/g==
X-Received: by 2002:a17:902:d48e:b0:186:822e:d02d with SMTP id c14-20020a170902d48e00b00186822ed02dmr14549643plg.121.1666970491946;
        Fri, 28 Oct 2022 08:21:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7956e000000b0056265011136sm2970364pfq.112.2022.10.28.08.21.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:21:31 -0700 (PDT)
Message-ID: <635bf37b.a70a0220.732b4.69a4@mx.google.com>
Date: Fri, 28 Oct 2022 08:21:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-468-g86403a07ae1c
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 7 runs,
 10 regressions (v5.10.147-cip18-468-g86403a07ae1c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Oct 2022 15:21:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9891

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 7 runs, 10 regressio=
ns (v5.10.147-cip18-468-g86403a07ae1c)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-468-g86403a07ae1c/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-468-g86403a07ae1c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      86403a07ae1c0fdab3215fcaa06d157c20aee250

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/635be4d18c47aca479e7db65

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/635be4d18c4=
7aca479e7db6a
        failing since 1 day (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f, =
first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/635be4d18c4=
7aca479e7db6a
        failing since 1 day (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f, =
first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/635be42dc032030897e7dbee

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/635be42dc03=
2030897e7dbf3
        failing since 1 day (last pass: v5.10.147-cip18-56-g87bd4289362be, =
first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/635be42dc03=
2030897e7dbf3
        failing since 1 day (last pass: v5.10.147-cip18-56-g87bd4289362be, =
first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/635be6e799355ef70de7db6e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/635be6e7993=
55ef70de7db73
        failing since 1 day (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f, =
first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/635be6e7993=
55ef70de7db73
        failing since 1 day (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f, =
first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/635be3a55ba922a6fee7db51

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/635be3a55ba=
922a6fee7db56
        failing since 1 day (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f, =
first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/635be3a55ba=
922a6fee7db56
        failing since 1 day (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f, =
first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/635be739bf7cecfb02e7db6f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/635be739bf7=
cecfb02e7db74
        failing since 1 day (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f, =
first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/635be739bf7=
cecfb02e7db74
        failing since 1 day (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f, =
first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

