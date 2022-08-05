Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E82C3F6B0
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 03:24:16 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.3068.1659669848008979531
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 20:24:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=XOFr+97J;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id t2so1555316ply.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 20:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Q1hR610NG2JOrF51WWZd1xG+nYxECAOndRdc+hZk068=;
        b=XOFr+97Jnq0gDiewkYZksqnPfkDlEGarcUGT8WIRmeyUNX9k3CxwaQ6HzG0rxvF2J3
         E0bm08mqUamShp4G3Qskm27sIsZoWMsf4mS+7Cx6KgVqj5DGT6GV6h0nRhBTKKmzp+CS
         04Y8PI6WarkgA6h3/RUwvcIypszzjJx/6tgeDbmt/CxNR+pfYc3ty405Q/w1k+MydADg
         lVdIuWiwNpNMJ0bC+oo5itKZmlmuc8Oo+GRkMPOqgou55wktNEbK3deN2EA3XOoqNr2Z
         Vuf2IBKs5YF9uyRirr389nveMFYNyYDAGHlMDRzyCwWuXljlCK2TsTUAPzdsWG5zOc5h
         /wvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Q1hR610NG2JOrF51WWZd1xG+nYxECAOndRdc+hZk068=;
        b=x/rI49sA0X7rdjBOhFin4CrcnSAvq7tKQ0I2XL/pfwUZfv5HX5hWXueK4vOCiHkUxP
         nZ8agvAak4uHtyUTwaR+1OAGHNoEGsI4so46ikBd2OwdKYKnAQMMauUmRQjIM53+//5M
         req/d7p06apvcu6sI9+tGJPs+JKrxI2JBRjPeRA35/oP+aj6ijJtx/aNbLUskXrbsq2E
         nvpgSKEByTTBajln9sn8ETkhcB/nmi4qWzcZOqhWiPf6VO9wgx4aXRGP7Io8OzI0s7qM
         igICppJ9orWsw19nsxBJu/EdU+wMMKgS2Wad0+XbX3B7tuXNTm0FrW8IJSC1TACwqgJw
         dElg==
X-Gm-Message-State: ACgBeo3Zrpz5QrHsD21BBuGWNyxoHCN+KMbI4b6dO6ATNljtkJyhDwhW
	LtNg6SX0Im8BRP5sx8t31buNxJfn4bf9i4mjlXc=
X-Google-Smtp-Source: 
 AA6agR7VRaIByedr+oYaDOwKaMdn9OYV2iBFylgyyVFq4EWVK0VgPN/cDQd3vedANL6JqiqgqkI9Gw==
X-Received: by 2002:a17:90b:681:b0:1f2:147a:5e55 with SMTP id
 m1-20020a17090b068100b001f2147a5e55mr5378158pjz.159.1659669849994;
        Thu, 04 Aug 2022 20:24:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 k92-20020a17090a4ce500b001f506804af3sm400147pjh.52.2022.08.04.20.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:24:09 -0700 (PDT)
Message-ID: <62ec8d59.170a0220.a9188.1065@mx.google.com>
Date: Thu, 04 Aug 2022 20:24:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96
Subject: cip/linux-5.10.y-cip smc: 10 runs,
 4 regressions (v5.10.131-cip13-37-ge3a52725ce96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Aug 2022 03:24:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9133

cip/linux-5.10.y-cip smc: 10 runs, 4 regressions (v5.10.131-cip13-37-ge3a52=
725ce96)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-37-ge3a52725ce96/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-37-ge3a52725ce96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62ec797fc046c3b624daf058

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62ec797fc046c3b624=
daf064
        failing since 31 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-08-05T01:59:18.387022  <8>[   12.854709] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62ec797fc046c3b624=
daf065
        failing since 31 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-08-05T01:59:18.368939  <8>[   12.836658] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62ec7b74809f05e170daf077

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ec7b74809f05e170daf078
        failing since 37 days (last pass: v5.10.112-cip6, first fail: v5.10=
.125-cip10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62ec7c787c13064e17daf07f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ec7c787c13064e17daf080
        failing since 55 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =20

