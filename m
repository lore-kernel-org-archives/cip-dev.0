X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.5191.1647305996710024004
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 17:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zJ2U3dRt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id r12so14965687pla.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 17:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jl6tBEnCWopQeL82Va+Mdq2cnlKudgneN44zk458pPQ=;
        b=zJ2U3dRtMcAHKhCu0ohBL9naaFNKQpd2UKEZNOpl770vm7k2i8Pc25ImoExMCvJ1lL
         O+A2q2Jp/Thjn0jgN0oDAliRrWFERML8hq8DS/mqS59V0CW6skEeACQwQcVKNkBpYput
         NbCNWj9NvPVkOzNpkUBEqcZCvR36xim+fytWMwfr+yXzZcqTW9npwmVuPXqq+isBcP2v
         BZ2TBPDhoHXuytHQedHqsAm+sEp/FQ0MkW3W0E/Tcarwc8EPouqb1Dm9hSROD0tEM0+e
         2Z4dnkF+Zy4YwuKg+Y0rMo5p3xs4WTmGQTXtjA4GY+aJUKrnHVNKIMC5PpoD4vWSwQUv
         eXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jl6tBEnCWopQeL82Va+Mdq2cnlKudgneN44zk458pPQ=;
        b=N9XWgfzceKKb1nTl5pf8coGwqwVf4+Aw04gv/R3pWOMKiRV35AVhjzGzd93PABOr8u
         vJ0fcAUj4H2D7H9HqKNAtH0vPlXQhsrRQBv6y4YpoA1zheInArqkvmCetmb8xBCzM4YL
         YQnNgHX1kvUTy5crkbia3pJqCaAxl2KQo1STj5eqR79Ne0StQn7Sv+PaAYY24Hd3sjYD
         mG03TIvWoCa/j6JJgilsyHQt3IgODC6WOtY/Cwz2Vo82Y0sXMSQTq7iUIceauitUQpYS
         zrSPoWBOziihXy14O6NwctO8sOnATOD8EcCOp4yPcTjKxXxKJ4t7GeYdPWN8iss1Cish
         bQ3g==
X-Gm-Message-State: AOAM5307bb/o7UAM0v+qLYePHaoDYdROX3R4WoX/+F8LEtHC3a4GDrC6
	vPA5pqZDw7aQI3j2GAr+VDyBHtC9CFsMh93G8Yc=
X-Google-Smtp-Source: ABdhPJxpVTi3tWrixYEkJVRU5JLpdSHrueDozT2Jb1GW54usKkm8aV0nUC2oZiQI65GaWkVl5c7YkQ==
X-Received: by 2002:a17:902:a704:b0:151:6d3b:946e with SMTP id w4-20020a170902a70400b001516d3b946emr25958086plq.130.1647305996034;
        Mon, 14 Mar 2022 17:59:56 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p186-20020a62d0c3000000b004f6fa49c4b9sm20553563pfg.218.2022.03.14.17.59.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:59:55 -0700 (PDT)
Message-ID: <622fe50b.1c69fb81.48ddb.4f4d@mx.google.com>
Date: Mon, 14 Mar 2022 17:59:55 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.233-cip69-1019-g2e5815777e975
Subject: cip-gitlab/ci/pavel/linux-test baseline: 71 runs, 5 regressions (v4.19.233-cip69-1019-g2e5815777e975) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline: 71 runs, 5 regressions (v4.19.233-=
cip69-1019-g2e5815777e975)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

panda                  | arm    | lab-baylibre  | gcc-10   | multi_v7_defco=
nfig           | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-baylibre  | gcc-10   | x86_64_defconf=
ig             | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-baylibre  | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.233-cip69-1019-g2e5815777e975/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.233-cip69-1019-g2e5815777e975
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2e5815777e975e9b2702739a96b2af41357c95fe =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fd7347f3e137290c62968

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/622fd7347f3e137290c62=
969
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fd73d499a907f26c6299c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/622fd73d499a907f26c62=
99d
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
panda                  | arm    | lab-baylibre  | gcc-10   | multi_v7_defco=
nfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/622fdd0523f7a232cfc62976

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/arm/multi_v7_defconfig/gcc-10/lab-bayl=
ibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/arm/multi_v7_defconfig/gcc-10/lab-bayl=
ibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/622fdd0523f7a232cfc62=
977
        new failure (last pass: v4.4.302-19-g2fe7e363b1b1) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-baylibre  | gcc-10   | x86_64_defconf=
ig             | 1          =


  Details:     https://kernelci.org/test/plan/id/622fd496a0b4b95223c62971

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig/gcc-10/lab-bay=
libre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig/gcc-10/lab-bay=
libre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/622fd496a0b4b95223c62=
972
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-baylibre  | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fd9d278ac2aa9ddc62975

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-baylibre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/622fd9d278ac2aa9ddc62=
976
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =20

