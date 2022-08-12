Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882D5C25B0E
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 15:04:29 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web12.281.1660316664649540710
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 08:04:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=zb5etqZE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id w14so973592plp.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=sSOLW3Naa69QBtt+UQk27dUXE2Ixw25z9oBsLQZT4zg=;
        b=zb5etqZEXcxMReACBvR08Vyygu8S8WYQbVInQiceBrALPfuB4XCvqHEZK6lcEi92Ct
         Ezx4jytKO+S3VLowW4dP4jmgLxDc+9DD7RvKtKw8Oh7IUzE4DwztIiARBDBQgHOuIVHQ
         S6BlEuA6Dyk3PDkkceOVg0OILbW4/bkR9nw6I+yXZSI7Q4TLr5q22YI/oFcF78SVwmmt
         5BBzEoXe9lZx6msPSV+fJPWfaLaC9DbRd+emPcCHdblpqTEGpwwaBNuz2Tc1FLrPQphP
         mZF7MDJrk7b7x46QZE660dPzDSsz9wawyLgUcSsnDf0mBaka3rofSFX71E0MoyfNhcIb
         GAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=sSOLW3Naa69QBtt+UQk27dUXE2Ixw25z9oBsLQZT4zg=;
        b=KLtOb4IfmiB+anaEoMRb2fZCBR462KFvqRKUPUc/WBZcNvXzvdhsC0HveMCCGuri1v
         w7qqXVmEK1BjvC6LZiRvQYM36XU0L12TvzI2Dt9dE4vbDOEmIvAZp4/10mXP5vybvhGv
         jo683exPi1/wupFUpPBlAG7VMhaRUSzZ3CUnxjfLa3x8xhGOiTn38EuvlpebUj9RhzQA
         ac6MqbpB0d42kQb4HSc03bTQpW6jk1hrE+mdXGG7tltgv6M6gh80kb7kYJDgcV/MyhZc
         qRj4gdkknVBEv4X5MMoKcpgwk8BHLnELSkqg9xrTTJf6wpiETAk57SCKxfs4coAd09YX
         WaUg==
X-Gm-Message-State: ACgBeo2Z7lWfdOCoQWsdPicF3Kunsv0k+dB6mTUR0/m79tkeqfhf5ZSF
	t53z5XOHRsutHeXxJRaq/uamJdYblsJsV9uW
X-Google-Smtp-Source: 
 AA6agR6tttif5/8c5KT+d65ehjKOq0udf/oCqKD0A5ZyRlWqAxQLnNPT+LgKd6v85JmEXyeoto1zYA==
X-Received: by 2002:a17:902:ea06:b0:16f:8ef5:fcab with SMTP id
 s6-20020a170902ea0600b0016f8ef5fcabmr4312766plg.69.1660316663834;
        Fri, 12 Aug 2022 08:04:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b0016c4fb6e0b2sm1846933plw.55.2022.08.12.08.04.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:04:23 -0700 (PDT)
Message-ID: <62f66bf7.170a0220.69418.3800@mx.google.com>
Date: Fri, 12 Aug 2022 08:04:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-35-gab58aa0904675
Subject: cip-gitlab/ci/pavel/linux-test smc: 15 runs,
 6 regressions (v5.10.131-cip13-35-gab58aa0904675)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 15:04:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9202

cip-gitlab/ci/pavel/linux-test smc: 15 runs, 6 regressions (v5.10.131-cip13=
-35-gab58aa0904675)

Regressions Summary
-------------------

platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig+arm64=
-chromebook   | 1          =

qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig      =
              | 1          =

qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook   | 1          =

qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig      =
              | 1          =

qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defcon..=
.6-chromebook | 1          =

qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defconfi=
g             | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-35-gab58aa0904675/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-35-gab58aa0904675
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ab58aa0904675bdc00cf17ebe4f1b5aba242c1cd =



Test Regressions
---------------- =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig+arm64=
-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62f65dac50d413da14daf069

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62f65dac50d413da14daf06a
        failing since 93 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig      =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/62f65f522e0f23ce69daf05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62f65f522e0f23ce69daf060
        failing since 93 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62f65d91da8ee7a6f8daf066

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62f65d91da8ee7a6f8daf067
        failing since 93 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig      =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/62f65f358a61b00f9bdaf089

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig/gcc-10/lab-collabora/smc=
-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig/gcc-10/lab-collabora/smc=
-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62f65f358a61b00f9bdaf08a
        failing since 93 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defcon..=
.6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f65a225c4aecd1d0daf058

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/62f65a225c4aecd1d0=
daf05a
        new failure (last pass: v4.4-st20-96-g74ff989472f09)

    2022-08-12T13:48:05.791668  <8>[    2.440978] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defconfi=
g             | 1          =


  Details:     https://kernelci.org/test/plan/id/62f65b1180a61018efdaf07a

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/62f65b1180a61018ef=
daf07c
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4-st20-96-g74ff989472f09)

    2022-08-12T13:52:06.756922  <8>[    2.338346] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20

