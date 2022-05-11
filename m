X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.154.1652305889652642374
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 14:51:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PnLsBbnO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id n10so3413860pjh.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YK/xhvXJ0jP1I2/dM4ib8eX8jBkhT42NDyeyOowQDy0=;
        b=PnLsBbnOqyGGiWPQFtYD38FVvp3yVCLSV/vcKGCYrydAi56pfCvtgBUSnRUiTRF6eS
         /ZIAPRnNUCaBOGhrWIGl8Y3XaNJJCWnzeKFpNS1LChmuu+KrweYxiXElz0hl3sjbxkJ0
         7JDiXJPbpbG0SueSHGN+m82CS8HVkve2zKqbE/TSsIKkwMxnE7iDITUx7Wma6QtJZeDi
         HaRUNYkmmOSb6cENNEggepnCHmR5oQJ5wa4JrLg5y+P5vhqUOPrwPmKiDFKuC7CQBjbW
         O/ejKjsOvBEJiSEBlpKWsmfAeCUHi92xIVOK3ZBlQTFmdjRakBDCSw7/dEaSlO3LUjkl
         RpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YK/xhvXJ0jP1I2/dM4ib8eX8jBkhT42NDyeyOowQDy0=;
        b=7cPcpu3c6//odxEWzXaEFrU5sxWcbJ0Um3//B7OnWuMaceEA4BcG2QYJWhhl+JKpEF
         64+ZBbnkG+qb7gayp2V8SrCTSO1J7OH+v9TRKhrUFAsrALMORleNO/7UPN6Vy2K/2o8M
         JvY6grWuPWM/R/b/2cqdI0vafazuZwTCs5yrgkTegwJAyGSNDG4zCQyqzO5w6S6XMjOS
         27j5BfzGNUYkVNGhvB7KBKithJHNzN8KDYasPzvY8D1GPM/gyrDuQv8M/RH3LGXLmFpZ
         TpEBj25tijX/BpA/Vyc320fKDdg/Y2DbZu/ZTxTC8QRcg6zEtMNTjKHoeevGY1I5gESz
         SYXA==
X-Gm-Message-State: AOAM5311pEFZwptifdYHRF29W8GXKw0fAi7MsP3BNlsOh+0cwU77k2Qg
	IHQlVsG87un5y0aWMz9iQGhe4ZrpyJQlbzMe5jo=
X-Google-Smtp-Source: ABdhPJzb7vgPOi7m6lbWaviUvW/uH3Pdi502RJsa6jOtOhG/Va3uwHo1c/jLMXQ4+FbtY4LOW9L6Lw==
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id l5-20020a170903120500b0015e8cbcfd2bmr27415870plh.99.1652305888805;
        Wed, 11 May 2022 14:51:28 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v24-20020a170902e8d800b0015e8d4eb272sm2352503plg.188.2022.05.11.14.51.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:51:28 -0700 (PDT)
Message-ID: <627c2fe0.1c69fb81.cec34.57ca@mx.google.com>
Date: Wed, 11 May 2022 14:51:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-261-g4f0b5ddda6cf
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs, 3 regressions (v4.4-st5-261-g4f0b5ddda6cf) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 3 regressions (v4.4-st5-261-g4f=
0b5ddda6cf)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm-virt-gicv3   | arm   | lab-broonie | gcc-10   | multi_v7_defconfig=
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-261-g4f0b5ddda6cf/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-261-g4f0b5ddda6cf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4f0b5ddda6cf91123ba71e05f9b8c6d129f6cc14 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm-virt-gicv3   | arm   | lab-broonie | gcc-10   | multi_v7_defconfig=
         | 1          =


  Details:     https://kernelci.org/test/plan/id/627b8b614a492ab4628f5718

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-q=
emu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-q=
emu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627b8b614a492ab4628f5719
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627b878d2bb06a9d9b8f5718

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627b878d2bb06a9d9b8f5719
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/627b89f99da181a54a8f5719

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm=
64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm=
64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627b89f99da181a54a8f571a
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

