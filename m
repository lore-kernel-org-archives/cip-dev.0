X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web12.5093.1648551016965607672
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Mar 2022 03:50:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XsNF7qKx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so1664663pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Mar 2022 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ms2fDw2C8mCqMmkC0e+2nhgZCmIYoI33hJ4ydw7rfBU=;
        b=XsNF7qKxhivFqFL7TRIuGq2g6w1au6HIepZ++g3bp9L7Xlui0slHJOWjhnfu7mnVG7
         LloArzKiR4UmOThwgTo0mXkUCxw21LVXNuPuuf2WI6HbQUdehIT6adcFh8Roe9Ompso/
         39NhyhyBawzsNz0h9AKMkKiWtNOEuuuwTYv4IPIZ6l9RbB8Y7XdPyc2JpEUUOGhlw5f6
         dhOW2t4hLNZhIhgf9fb0DbU7TcsSOEOZij2JU7T+zOlnizm1ePvK9j/CUxa2bt5jKQsG
         wgaZVR5HRqzA0v7vPBvmN7X4xuP2BmhQEA7GrkFrpGFSzXFUnOlPd/RtuuEHzSkdDCtI
         xDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ms2fDw2C8mCqMmkC0e+2nhgZCmIYoI33hJ4ydw7rfBU=;
        b=JscTUrQogW/71naX1TSEcxc+7BXTZ1WZFbCV4NUK21R4Y9MDx2/DX0b54K3igP9DHq
         BNp3mff3geBImq0apDIKNqPCX/FfZDbruidGN52pIaFCwieu8lwYGKzr8qFAplPwjPGe
         5F/54F4RdqJPDfnsD0meE4lY0zl+uD0GibvmwDrgVXn9BctHU0ezRcItUMfazTs7Q9Mt
         RTfYiv5AjgCWYEM4OuAagWRdzN7gUJXEbY+ulUyDECeM4wXbpuvNKwHexjXENxMFt2JR
         L8huFiKSxA+sO17B1FA8MwrrixumPO4xWVueyk2IQS00wL3cwYVgIVmPuJ+40b0x64/G
         Hxpg==
X-Gm-Message-State: AOAM530pX/qCqWH+Tec5+SQsCb9QC3ISlVDM2WyMiH1FFx0Rwog7vha1
	DtCXXXmiA3Fx9au26iF2MFI3TKS2B/hATB71F14=
X-Google-Smtp-Source: ABdhPJwW34yEWX6K89QVYJhKAP5Rmv1PMLuoOy/QlOp1ikUXF7fah6llBdMZ3YR78c0YwK+uA5UOuA==
X-Received: by 2002:a17:902:e551:b0:154:48d5:4212 with SMTP id n17-20020a170902e55100b0015448d54212mr29478288plf.5.1648551016339;
        Tue, 29 Mar 2022 03:50:16 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id oj16-20020a17090b4d9000b001c709bca712sm2601643pjb.29.2022.03.29.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:50:15 -0700 (PDT)
Message-ID: <6242e467.1c69fb81.9a032.6d19@mx.google.com>
Date: Tue, 29 Mar 2022 03:50:15 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.235-cip70
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-pty: 3 runs, 3 regressions (v4.19.235-cip70) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip ltp-pty: 3 runs, 3 regressions (v4.19.235-cip70)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.235-cip70/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.235-cip70
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91567a6adc2cb5217b6d7aabf7da3ac9ae6f1a79

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
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242da926f5f446e37ae0687

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6242da926f5f446e37ae06=
88
        new failure (last pass: v4.19.233-cip69) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242ded291b74ccf79ae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6242ded291b74ccf79ae06=
7d
        new failure (last pass: v4.19.233-cip69) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6242db3b721c4ffc31ae068d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6242db3b721c4ffc31ae06=
8e
        new failure (last pass: v4.19.229-cip67) =

 =20

