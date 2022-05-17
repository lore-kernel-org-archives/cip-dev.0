X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.6991.1652793363071936680
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 06:16:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=jO8sAmEJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so2379304pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3wnzt+yYeeoLlgLDdo2lwiePR52UwZNhGLqBV97JHZQ=;
        b=jO8sAmEJ2x+XhEwyljuiEx8bRjJpxHzcVEcH1BDqiPbMlkRvZNL8uTaQV2y7bLF8P/
         wzMkQpV4WRZmgyQiD084YLDKnVLG9BFUnmFVCLbQRo+734xcUXiUfm8i5LzE+8/7feRW
         o96ea72NKoWgXTr6ySatHEE9JqPWcrwq9zAcIw6cggxxMfnBJ28E03ECUqOjbOgFCudO
         oh8kXyNFRmUsA7xNNF0YVQHaZYQrrfz24uKZ1VGZ1mcKaivl+QIYtw/hZy2ojHbP9lWh
         jc7Cp9caxhtAk1vVnt9E3P4lVdLmXrHdve/Gb0BYcvYqI8RhywdS/GJiyjNZ/mue6uB0
         ba6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3wnzt+yYeeoLlgLDdo2lwiePR52UwZNhGLqBV97JHZQ=;
        b=daWKK60hcZwoVTy7W1dCmbXToPBTs6dqBMB7oejwty5xUhMmZbnUVStqJDiX7BVKLo
         hOwBuTe3miG8jEKeE+R2nui33Pr6bZK1rNqMCVcev4IOMc869FsdDhmD3MomlCv8fo97
         Pr/f2BsQmO1Ef+YExBQiLbFDDoOE4WwYvAhuVzDgXyj1Gq6IoxrMWULnrcHR23JX1joh
         h6C3LxqwmQtnQNMGb769sgk9KWNzX3YeKJCXtmkPFDkjBUHLMeX8aNGLHU8GGYpAhV/R
         3fXasIlF7tTwdNhikvg+Z0PeXmAxuDDsnCwIRSDxcx7VKmFRx7QNQes6dw+ruJg0axZd
         LKyQ==
X-Gm-Message-State: AOAM531k+zhhtuoTXkY+0CXUqaoK78igv1bIx1xlm3844w4BG8RwgKOp
	u/HPrJBwqwnSXIrP0Md1aKx3dSM8NE7KEjp7Sf4=
X-Google-Smtp-Source: ABdhPJyPIhccb5pJgF83d8rtJz05oEBhLiXiqEO6DhEbivts23dK2ItALM/29tOzNTHhtNTt1amElg==
X-Received: by 2002:a17:902:9303:b0:15f:446e:dccc with SMTP id bc3-20020a170902930300b0015f446edcccmr22587728plb.35.1652793362334;
        Tue, 17 May 2022 06:16:02 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b0015ea95948ebsm9027966plj.134.2022.05.17.06.16.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:16:02 -0700 (PDT)
Message-ID: <6283a012.1c69fb81.59e5b.6090@mx.google.com>
Date: Tue, 17 May 2022 06:16:02 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-293-gbfc4bd11718e1
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 3 runs, 3 regressions (v4.4-st5-293-gbfc4bd11718e1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test kselftest-futex: 3 runs, 3 regressions (v4.4=
-st5-293-gbfc4bd11718e1)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-293-gbfc4bd11718e1/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-293-gbfc4bd11718e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bfc4bd11718e111c2344c45b9237855beb947e3c =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62839cd092f6c6dc0aa39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62839cd092f6c6=
dc0aa39bce
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62839cf94130dda27ea39bdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62839cf94130dd=
a27ea39be0
        failing since 5 days (last pass: v4.4-st5-17-g04a3c17cb526f, first =
fail: v4.4-st5-49-g02cbcd6511d4) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628394bf6f36f33a37a39bfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/628394bf6f36f3=
3a37a39bfc
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

