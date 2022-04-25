X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.31378.1650901719708363767
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 08:48:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zSsdE1Xi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id i62so1567940pgd.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NvllUyA9FZKonxr+eN2WqvDdfr3yUFleTVWBfuY6qFQ=;
        b=zSsdE1XiqqQ3kZPACz6CcJYSbPfRHPIC+9TPZ9hsvMr452w7BqZ105sUOYI1Gwnaet
         plrIJ8ncMTfdyvJs0GwoJdX4qM3soXNFtUcKh/s9Q+1I+0UgfOiRGWs02x+iIyiKHwgU
         1Hz5Z5kJe5+JQ7+6Sd9uYgvCAkuMJgBF1HOcZBYXv1PuhyWtVfQkV0vKNpib4AVIe1MM
         M93g1q/eOL7tmJgPTkgGLMMA7lwzIMTYA/FxU14JH2ZgVCxuBa90fj1q888wdrvWOmTB
         91XNYYYcNSHS1BGbVF8DQRPYJGJmx7gJRuSjEfT37RUI6gTP/SPWRyyoiyXC+McIRNmU
         sXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NvllUyA9FZKonxr+eN2WqvDdfr3yUFleTVWBfuY6qFQ=;
        b=3gBQmY0JdT1BTd348yLn4HkoJHyW7lsoS1X5P7zSdt5rKgYn9yTZ6rKReKPHPEoXRI
         sOAVM5YMXLgBoCgY6H8cIXUw7fXmbN8Puu/56AURRxwimSGQZc0UoQidhm1RXshUtSmp
         LvoU0YisRvVscqhDNitwl+gpugUe8GlD7SwGAliSHEhAT4cQpMhoXmgtdDRqRQIP0QVt
         HFbVsHKhmBqQ5hHqnnmtwuLYbi7fWvAaQtS0lnImNEQrR56mfyDnzeFyZY/fxrlQXRZ+
         jBzgUzsnPG8fwnPJJiv4c2zV7Ijn+YP1PMybFKtuoZBssYzZus/eIaNsKSRHkWycjNrw
         D5qg==
X-Gm-Message-State: AOAM530FH39GrpcFY5ObReItWRxmPyINMD6enFiJchTLDPeT0tkd/hi8
	R91SrnaxhBTO14eHWJTR8iUCaBhGrDMOQ3qHmvQ=
X-Google-Smtp-Source: ABdhPJwlnZg8IbtP4axHzk5fxF4EA0TzuKX3otIDnoIVVaoiOhg60j3MWDp8b6jbq3xXltUsDuyEqw==
X-Received: by 2002:a63:1c0d:0:b0:3ab:1a76:953f with SMTP id c13-20020a631c0d000000b003ab1a76953fmr7612036pgc.73.1650901719051;
        Mon, 25 Apr 2022 08:48:39 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t188-20020a635fc5000000b003aaf280525fsm7492734pgb.57.2022.04.25.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:48:38 -0700 (PDT)
Message-ID: <6266c2d6.1c69fb81.4496b.14e2@mx.google.com>
Date: Mon, 25 Apr 2022 08:48:38 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.112-cip6
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-pty: 6 runs, 5 regressions (v5.10.112-cip6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-pty: 6 runs, 5 regressions (v5.10.112-cip6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.112-cip6/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.112-cip6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8f6747dcd02a8f87731c324f4bc37bd120a8982

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  4e132c1f9e14f9eaeb4f9875eee3f97a4a1ac987 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266b197896d16b128ff9459

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-a=
sus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-a=
sus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6266b197896d16b128ff94=
5a
        failing since 27 days (last pass: v5.10.83-cip1-151-ga4163710a1dc, =
first fail: v5.10.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266b5b63914ad3cebff9594

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-a=
sus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-a=
sus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6266b5b63914ad3cebff95=
95
        failing since 27 days (last pass: v5.10.83-cip1-151-ga4163710a1dc, =
first fail: v5.10.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6266b7572a960e928eff9480

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6266b7572a960e928eff94=
81
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6266bce13176774becff94fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6266bce13176774becff94=
fb
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6266b166e14769db25ff9475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399-=
gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399-=
gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6266b166e14769db25ff94=
76
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.106-cip4) =

 =20

