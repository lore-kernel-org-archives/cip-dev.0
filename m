Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F53C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 17:55:39 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web09.1025.1659549330657544577
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:55:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=BNo6YEaM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id
 15-20020a17090a098f00b001f305b453feso2798051pjo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=OOkZ0VUgjBV7meeRh5oixD17Rf/ng3D6Gp3ysEilPC8=;
        b=BNo6YEaMsbgVhk0SE+tQprGnBMHLJSZWjUGtXqVK3rs4Ytj3XqMuoESvKDcACPKKkH
         ezjw3MGUCjLmctnRsJQlWeWzgp1XKFvn+sx++/b+AAfUs020RAirvXUb5jP3D7fQo/G0
         HDtR9fAA/O1NCu30LculJ9oklaIy87uVWEFyOLE/CdmxCCf7CeQg4r+aMjGrHfM5J716
         kzMjRn3P0KdPLuBmTiKumiOzMrlsWY8D0zXjXkFDPqqEcQ2qKzXj+GFTR2QPRNcLtbzV
         8UUBTaux2x5pVJMZfef/QfgpSvGuJMqZxl6YWGL/NbXP5kKEjvj09b+mzNU1JRCX9Z+W
         mIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=OOkZ0VUgjBV7meeRh5oixD17Rf/ng3D6Gp3ysEilPC8=;
        b=ZHGSt27RBsjmCZn6bhcoXS3AT+0O4kmv8LQX0H5BaXWLM3H6tzHoh9zb74tbHHrqIz
         amdKFHAyrI2u0ewUgvyrcMduSMCVzkf22hza1DjwG4+PMh84fJsNtsWtKkPFeQu0fqnt
         SX0hstiZRaBB7cC40l/G4ajPMmrlQ0OLxDIX8UUBcgGBpJdkvteUeXGgjbLm08YkhfA5
         TRBqqdOEhuPqfiFyJaAdz6V91VZ8eAyd9r7O3Pk7Cb2FuNvvUeViBhNOYIZwjcYDpgMS
         nWC/cy3HWMOYDxetkvyR3qxisCW7HXvWrvk02E7vwt/JJ2stHeVCxWn4WCbUiP2JiZ6U
         rgnA==
X-Gm-Message-State: ACgBeo3GwTbthDL3Df/mV0C8KHWXUw3m9UvAzxRlBqbR7MCpQVlOuTHL
	Tp8cTen1CzzakxTCzbcA3H/AzTVUzv7Eq7VvpZ8=
X-Google-Smtp-Source: 
 AA6agR6HfTlVQQrkg9zZyGNYctbPE7zXXtVAqcKj0uuDzPzDFzuPcaz7egheh+WFMgIfJYmuvcCX0w==
X-Received: by 2002:a17:90b:3849:b0:1f4:89bb:14dc with SMTP id
 nl9-20020a17090b384900b001f489bb14dcmr6147478pjb.144.1659549329956;
        Wed, 03 Aug 2022 10:55:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z67-20020a626546000000b00528bd940390sm13348199pfb.153.2022.08.03.10.55.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:55:29 -0700 (PDT)
Message-ID: <62eab691.620a0220.e83b0.5611@mx.google.com>
Date: Wed, 03 Aug 2022 10:55:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-74-gc99f2b257bde3
Subject: cip-gitlab/ci/pavel/linux-test smc: 6 runs,
 2 regressions (v4.4-st20-74-gc99f2b257bde3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 17:55:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9099

cip-gitlab/ci/pavel/linux-test smc: 6 runs, 2 regressions (v4.4-st20-74-gc9=
9f2b257bde3)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-74-gc99f2b257bde3/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-74-gc99f2b257bde3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm-virt-gicv3   | arm   | lab-broonie | gcc-10   | multi_v7_defconfig=
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa48c49858ef35adaf077

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-=
qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-=
qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62eaa48c49858ef35adaf078
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa1089c848044b3daf058

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62eaa1089c848044b3daf059
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

