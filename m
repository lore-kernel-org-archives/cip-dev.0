Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3A1ECAAD3
	for <webhook@archiver.kernel.org>; Tue,  6 Sep 2022 01:39:26 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web08.32261.1662428358385759907
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Sep 2022 18:39:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=PeLIgT9n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id h188so9280583pgc.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Sep 2022 18:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=9j13Lsw/QaFQVHRB9r4dTxnFenJCRdOuPrm4ckLLdco=;
        b=PeLIgT9nr9IvvoDkJ8Y81L6eadPHFZ8YEXiCARyA78K/EEtEKSYpNEvlgsOeNk50dm
         1ygqySGUqXKjLHqDyD6oZVrvx3Ay65Ngh1wC1vjr/oUfBtHRHe7ESeG90Ntb9jPvKhVy
         6pxl5aEPCxqEF0zlc1Rhh318tzfz47xvIqRRQS0XCEJ1KgmyT5ZE8h2wyOA1Bq52tcM6
         wblOkSS6j5A0+ScZTEUv8BERkp84gCVK/y19icT/7i0jXR9RANqJxLG2DhzYBt3u3Qpe
         mgzxuP6tFDkkJyrer5rbt+89VYhQBl9W8lyXJyAPMIJM3vzI2VYjNP3h4nqnt3huEG6m
         Zuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=9j13Lsw/QaFQVHRB9r4dTxnFenJCRdOuPrm4ckLLdco=;
        b=dpRkDkBTWFTxoSdQU/Elto4qO8DvbFJAg3+T6zaDtBg+T3aBmnJz83vGrhPrHbJpxV
         Svhwsh7pBOttpNkER6+DnzrkiGfHYvhhGWtIAdLbumz11zHKdTohuy2V6CY01usYuZzo
         dqq8B0O5ep0Xga9d4QZwo2XVZQWOpmziNsOe4J6ozHB32tsZ928XornItc/1vQRNeFvI
         Qo5+bJJwgo7JNgciszAfrh2c7bpf/m8t17kpnKBV9GzUjgR6G5kahsXzaFdkWWMsRprW
         8C/9Dbu3WvQ4LLru1+pByNX20DOY0hRgBvG/xaxdhr0LlY4M8Z52UEGIdzRBqnIj6Ml4
         SJYg==
X-Gm-Message-State: ACgBeo22a7iNk/rQsG7xWisE42BZ6ETKXot5kPpHp0IwC5oXbe36OQxP
	viJaroHcIqWR3WF2mlLsx/GY3MtUp7Tcz3I7fRc=
X-Google-Smtp-Source: 
 AA6agR44IFWY8EQb5oS0VK2KkGK/GnTLGXzGvNz7JMrPoZMi6lMXOwi3dj7bf1obvZ5REy4Em1MYSw==
X-Received: by 2002:a05:6a00:21c8:b0:52e:3404:eba5 with SMTP id
 t8-20020a056a0021c800b0052e3404eba5mr53397213pfj.67.1662428357582;
        Mon, 05 Sep 2022 18:39:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e23-20020a170902ed9700b00176c431e7e2sm1293857plj.13.2022.09.05.18.39.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 18:39:17 -0700 (PDT)
Message-ID: <6316a4c5.170a0220.b5dd0.2111@mx.google.com>
Date: Mon, 05 Sep 2022 18:39:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15-10-g52cbd8ad1543e
Subject: cip-gitlab/ci/pavel/linux-test smc: 14 runs,
 5 regressions (v5.10.138-cip15-10-g52cbd8ad1543e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Sep 2022 01:39:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9465

cip-gitlab/ci/pavel/linux-test smc: 14 runs, 5 regressions (v5.10.138-cip15=
-10-g52cbd8ad1543e)

Regressions Summary
-------------------

platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig+arm64=
-chromebook | 1          =

qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig      =
            | 1          =

qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook | 1          =

qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig      =
            | 1          =

qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defconfi=
g           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.138-cip15-10-g52cbd8ad1543e/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.138-cip15-10-g52cbd8ad1543e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      52cbd8ad1543e12ef69b428c8535df3b2e60fa86 =



Test Regressions
---------------- =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6316a28bf2dc37d8ec35564c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6316a28bf2dc37d8ec35564d
        failing since 118 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/6316a2c7563f4a454f355652

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6316a2c7563f4a454f355653
        failing since 118 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/631695fca9a019501e35564f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/631695fca9a019501e355650
        failing since 118 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/631699f5dfa9130d763556a4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig/gcc-10/lab-collabora/smc=
-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/arm64/defconfig/gcc-10/lab-collabora/smc=
-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/631699f5dfa9130d763556a5
        failing since 118 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/631696601ddeb56a3b355645

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/631696601ddeb56a3b=
355647
        failing since 20 days (last pass: v5.10.131-cip13-49-g1145e9c6352e6=
, first fail: v5.10.131-cip13-84-g5fcbe4a63ab4d)

    2022-09-06T00:37:40.933383  <8>[    2.552757] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-12207 RESULT=3Dpass>
    2022-09-06T00:37:40.937890  <8>[    2.557610] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20

