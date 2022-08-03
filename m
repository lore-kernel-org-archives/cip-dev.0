Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38992C3F6B0
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 15:39:44 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web09.10426.1659541180242309942
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:39:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=z04melPt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id 17so1262239plj.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=a+XRIc3tGc/ttuRUw1N+vBAEQNT0iGlU78x9s8agwgM=;
        b=z04melPtxlRGf/nojtVx9QwI6ciz89i6R7+3hApyby6CEbxQKth+5FJy8CRgAdYC4I
         n15GaAk1g4R+6iO1AZrbiHQ1HrIjGxQK9vdhcdXcY1Lu0qgIgpsIHXtzWfLd9NIWuh1l
         aYXn1CSsK6WvGH81cADoo7oRChqEHZ/WowKrRhpt3dXpYQ70TNvqInkhEfeoLXgo1Gxx
         xVZ/HnxwW4Qnt4i14Pt95xMEZstmcuwEYtb8YpPZmW9gYHk/9mbJMg2TMzhE2Ydg8o3L
         XMpopf3a0AsZSEv1fm+Ift5d/iur7caOBV/ampEsugd2QZVvkkTBctKHhS7esijDtu+V
         BZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=a+XRIc3tGc/ttuRUw1N+vBAEQNT0iGlU78x9s8agwgM=;
        b=h63l7C6fgRd8gZyosx4xQVxkMqzYFa6+90415SGsveq+GXP0aiCye7xVo6k9QPRK+8
         5RyKpOaiw0g81bjhiymRsbWhNS+KjyTD05NLg8olnEEHkXZLq5EZ55vBaLBdU6vMjcmW
         2UDRkuCtoJzsvnbxPXBl2Mu5tSRdr2CPB2UDsfLv3kxvOgQmzyE5sXMpSRRWTVa4ni5w
         6+TsT6I2jA0gsJyqoZ2r1QXIlBtRY0p90J1orPQIu4fP5K2zr0Lmp3xWRCIt0wx1zN/F
         /YvY2HIuwmAXjHCmE4D3Iqkj+2l4sxTtE6J+pYdMm03D5JXWPUp+BdxFW7KrsQO+37S8
         jKBA==
X-Gm-Message-State: ACgBeo2zc4TMMob9CI5GTc0nrbrDMcjLHGRq+yvUtMcXsYH89mr58kNp
	4EbKprmLRbXcvkvZpH3LSM3aQGiITI0g07ukiKw=
X-Google-Smtp-Source: 
 AA6agR4qpGbvQv2A4YXXf/6DGmJNmmqEzO0Rgb3uv3UQf+nHhSQUsVVEyRLmuAh7h1eUiUC6NI8VTg==
X-Received: by 2002:a17:902:778a:b0:16c:a1c9:7b14 with SMTP id
 o10-20020a170902778a00b0016ca1c97b14mr26911413pll.116.1659541179489;
        Wed, 03 Aug 2022 08:39:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 l16-20020a170903121000b0016bfbd99f64sm2135217plh.118.2022.08.03.08.39.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:39:39 -0700 (PDT)
Message-ID: <62ea96bb.170a0220.afd40.3739@mx.google.com>
Date: Wed, 03 Aug 2022 08:39:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-rt40
Subject: cip-gitlab/ci/pavel/linux-test smc: 8 runs,
 4 regressions (v4.4.302-cip70-rt40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 15:39:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9062

cip-gitlab/ci/pavel/linux-test smc: 8 runs, 4 regressions (v4.4.302-cip70-r=
t40)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-rt40/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-rt40
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6b137ed6ca3666fa2abde3e184426bbb203b5bfb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea8249ddf4be063ddaf07d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ea8249ddf4be063ddaf07e
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea862247a6014545daf057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-qemu_arm=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-qemu_arm=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ea862247a6014545daf058
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea847e17f3487206daf077

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt=
-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt=
-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ea847e17f3487206daf078
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea84a83ddbbca2b9daf098

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/sm=
c-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/sm=
c-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ea84a83ddbbca2b9daf099
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

