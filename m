Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F4C433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 01:32:50 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web08.1633.1658799163247389752
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:32:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=EhSJ9afA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id ku18so12079714pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=w90qXiXmTq466WiVwNGMvezLhbiaOgIUjBf3M5IopyM=;
        b=EhSJ9afAva8laD6rTZoisfof69yge6LDlJKQaPzLSJX/r3fJvnf5p3D+ApW6QE+ItZ
         3G5OvB3iqZSF1yfFVA4fEQ00nASTaXegV/ODAEPNDCBiD7BOZhI6Gf1zzmY8RE8vTQy5
         I1AlgM2s0rKkbnS4caUwKvsZpJIR5xenKp3909fQKl21mQiJsJa54DUUcBl6yPAiptDY
         yZYoaSw/6+Dp1eSSWsjAot9lVZYdAisfFjRu+b3pP8rR55Tc7245mLRrpDmongOyVqSu
         HE09JLgFF+Ofi3TlEwKEkQXpCOF9i/nN69fDULpkIOvCnoOxoXWZ9BrVT1qKoKTUqeAj
         2yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=w90qXiXmTq466WiVwNGMvezLhbiaOgIUjBf3M5IopyM=;
        b=M3/ZPpRQr/wmajqW56Xw6K2WSGIgbXFXYAiaLrCtJhbVGFeIlQXja8lD9mkmlBib7O
         v/Pa/Tvey1OPBBy163msNEkyP++e3Mt/sjxuHibpkUv/VBaozB+G+KcZGz8CrgsxAqjC
         H0Ct1yiPy9poHDVyovW33UlpTNbiD3qvZtsUi8McpJbFAhvkTwRL8sP6mkLEVANm6ohW
         Kw8PpmIVq+TbsJiYbdwnPbBHjSBPTvtnjO+uQZR2Ud913bDlECha9ivvPigqKtzGY1Vz
         b1Wy9RuQWuIRvAjMCWbd9ekz2mtmuXOBdaIPQfYrJWk05A9aa9xlF0/DZ0GcapZdqTOz
         +nQg==
X-Gm-Message-State: AJIora8cK3qw+8xZrjsTonw3Rrh+coMjn6NT2CL2z9cU/7I8LKo9zM2Z
	/ahka8EPRXsfy4iblYifBrk3X9F1Yygf+U/5
X-Google-Smtp-Source: 
 AGRyM1svKmHBlmK9jU5YsAl+dSR/qKqoDiBTW/oSnVE1gPnmmQlmGNG5bl9bds5pPwS1tkWEbuDASw==
X-Received: by 2002:a17:902:a382:b0:16d:9b15:83d5 with SMTP id
 x2-20020a170902a38200b0016d9b1583d5mr1545567pla.101.1658799162531;
        Mon, 25 Jul 2022 18:32:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 ik18-20020a170902ab1200b0016d9a17c8e0sm472830plb.68.2022.07.25.18.32.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:32:42 -0700 (PDT)
Message-ID: <62df443a.1c69fb81.3b6dd.1261@mx.google.com>
Date: Mon, 25 Jul 2022 18:32:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip-gitlab/ci/pavel/linux-test smc: 15 runs,
 4 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 01:32:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8917

cip-gitlab/ci/pavel/linux-test smc: 15 runs, 4 regressions (v5.10.129-cip12=
-36-g21d9d56f4de5a)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.129-cip12-36-g21d9d56f4de5a/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62df3572a022ca189adaf066

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62df3572a022ca189adaf067
        failing since 76 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62df3573a5f09021ccdaf05a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62df3573a5f09021ccdaf05b
        failing since 76 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62df337dbf38f24917daf05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-collabora/smc=
-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-collabora/smc=
-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62df337dbf38f24917daf060
        failing since 76 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62df34e6593fcab452daf074

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62df34e6593fcab452daf075
        failing since 76 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

