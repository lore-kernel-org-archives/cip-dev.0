Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AFAC43217
	for <webhook@archiver.kernel.org>; Sat, 26 Nov 2022 12:03:05 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.68800.1669464178468600693
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Nov 2022 04:02:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=T2teyOpp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id b21so6109226plc.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Nov 2022 04:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MD53rAsn/jBIgRzLS7tGarQ+HkU/Y3IQqqayBWju6W0=;
        b=T2teyOppVw0S8Vb4e+HD3op9oyd9LDksuBSqDsDo/FKf+HpCHFMunYjEP5vbEYlT/9
         /pTmuyyDv2XItf0JB31HLuwzjHr993N14OIb5vU2cFjaztyqtDJAtkCVkGk3NlPt9oQz
         4i12oAJqtbXvzAlQk57zEyLkpXhoEppq3K/WSFm88ZwmgmjexOzCGoIs27btdBwgNbD4
         gvi1IjojVbHLnW1CyuMMgUzRiQuAOaj99Sl9iR6AoVRhMmQMy8XgjanUkXIucWmkIERp
         g4wHE7RTrXLcqTZSxTG5vaDo16T7oeHmj+xuEE3rfiSabuS6vHId9TBGCktnzo5c99bL
         FY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MD53rAsn/jBIgRzLS7tGarQ+HkU/Y3IQqqayBWju6W0=;
        b=IHuzGa8g5rVXZyKtUGBcw7ALIhagGYSrvOsRekJxlrIRv4zEYOTnNW9nOcsZY+7PmB
         eNKeArD8Vvm//BvWigqDfcWpu6SfuBdU3lgllCqRQ6cnosSQ8+ASol7ycDAR9VJPR3TQ
         rdrVk5ePrE38WhmD/H4dSvZshERo9Sp7Ek2nLK7P8YawIGhz4FRBpec8DlVPDaP1h8qP
         NeY/uqncwZ8CBfVPOajqOtgsq8/hEzCVUDgAsUTFMucTaZ9Gf4ovpaRJ4l7s3knhTJO0
         kD1VDyYM7oEzY1j4gxKEHUsRErzJPHNvqxN31vv+CoaBV2bw5nL9yWMuHwyuqmXbSCzd
         OaGw==
X-Gm-Message-State: ANoB5pnyDfhmCVu0a8VOaOJAcIQrrEAwFQlYecJS1nC/3Vzw1HmqaOac
	FucsF+EMbj7e7gyH3SvIko0r1lJCZiW4VC2jSwY=
X-Google-Smtp-Source: AA0mqf71mt5ZODgYjHbN/uBtcPCX4amXiH67Me+vjt5TcyyhL/xlCF2iAWdhjFuJovHdZTu0wY57tg==
X-Received: by 2002:a17:902:7009:b0:189:71b9:6183 with SMTP id y9-20020a170902700900b0018971b96183mr4220408plk.121.1669464177619;
        Sat, 26 Nov 2022 04:02:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b1-20020a62cf01000000b0056b8181861esm4810295pfg.19.2022.11.26.04.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 04:02:57 -0800 (PST)
Message-ID: <63820071.620a0220.901d4.6680@mx.google.com>
Date: Sat, 26 Nov 2022 04:02:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.155-cip21
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-timers: 7 runs,
 10 regressions (v5.10.155-cip21)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Nov 2022 12:03:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10121

cip/linux-5.10.y-cip ltp-timers: 7 runs, 10 regressions (v5.10.155-cip21)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.155-cip21/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.155-cip21
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      02e30f9cbbfce3d687cb1ab288e46ad20079e8e0

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
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6381f25c17ce7e900a2abcfe

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f25c17c=
e7e900a2abd03
        failing since 22 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f25c17c=
e7e900a2abd03
        failing since 22 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6381f1694614fc772f2abd01

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f169461=
4fc772f2abd06
        new failure (last pass: v5.10.153-cip19-3-gc76f4e7e5c71) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f169461=
4fc772f2abd06
        new failure (last pass: v5.10.153-cip19-3-gc76f4e7e5c71) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6381fa8b14df6d9e572abd0f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381fa8b14d=
f6d9e572abd14
        failing since 22 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381fa8b14d=
f6d9e572abd14
        failing since 22 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6381f18e90e776de342abcff

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f18e90e=
776de342abd04
        failing since 22 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f18e90e=
776de342abd04
        failing since 22 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6381f5edd88682b2442abcfa

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f5edd88=
682b2442abcff
        failing since 22 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f5edd88=
682b2442abcff
        failing since 22 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =20

