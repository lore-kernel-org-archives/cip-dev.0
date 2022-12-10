Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2794BC4167B
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 01:49:39 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.5615.1670636968891761010
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 17:49:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ZI5v9hw0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id p24so6694307plw.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 17:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eM6aZp6d+fTVvi6KpPF1Ql42EJioCy45aBkXk5npBoE=;
        b=ZI5v9hw0pBBVNaeHu2bZk7c6eGqhFCJ1/G9pIcNYsKvtsaOkGK3cyVSuQmHVJ5wDsp
         oEWCX3VbU8Y12rFZ9XlKeSFDnb2v3mSTGtN2deAWLC5wOn1Nh15J3N+q13qeHjVVelOk
         nuHfJUIzORYdbdeEGTsW7fDqh2SYNsFo8F/GbeE8EPVjx3nJNyv9cyi3qr0Vs7S8drBo
         UhkSEZHWNFQvHgNKv2UQJrQAmFTdMfuVIVE6lU6hIB1k6xIQ58cp4osx/5WN9xG1y855
         5rvtIaL5T+V8RojM0BcTEP7oG2HIcI7FgpgNqbKQrOVkvGs6409cuCYwIseEtJ8Lc2sO
         a37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eM6aZp6d+fTVvi6KpPF1Ql42EJioCy45aBkXk5npBoE=;
        b=Osyi5t44izY7GoqiiiAMfG9KB6/b6r9joKuFdxVKX3em604kYrzOEwYWSZZtyIxuV6
         iv0PWw5TVO9KLvZhL1mAVbQIbZhMZEfvGmod+4+UVRakzoqtUnLCCl5UL5mGEd0Q8nNK
         r7DIlw+eNCfQqiLHiw9jMkHjU4o74yILbiHRid/J+oaiyG/55kcx3J2ixu4DKKhaeOn5
         BUKg6Gv5CnwLcfcAXB5lROYpsAMW35wUBac21DypLeVTaqYyYCkKFTo8p2uyEEQ3QFzf
         6aOW1JdHCg8dxfr/wsOEUn/KnXLhPDQlssDIuuiZtv8byW0yrMMuR4o5gTRfmGMpQEDK
         XlBw==
X-Gm-Message-State: ANoB5pkKMLipLM8UBL46bNmIBuYtqMwZR7b2UcRfQoq6uoSC2inmA9PK
	8vDacIN1kP5ynPNWDzsRJzNbKrHMLlS+fLRPPjc=
X-Google-Smtp-Source: AA0mqf6+WgY75kSB59pMhKU9f4VJHt5ziGjqxVlIzNJQb4DBOUbvJ+h+dFTwNJeSkC0Ovw0kzrOTOg==
X-Received: by 2002:a17:902:7001:b0:189:760d:c5ed with SMTP id y1-20020a170902700100b00189760dc5edmr8164931plk.28.1670636967982;
        Fri, 09 Dec 2022 17:49:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja14-20020a170902efce00b001897d30143asm1877858plb.289.2022.12.09.17.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 17:49:27 -0800 (PST)
Message-ID: <6393e5a7.170a0220.6b200.4b0a@mx.google.com>
Date: Fri, 09 Dec 2022 17:49:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 135 runs,
 2 regressions (v5.10.158-cip22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 01:49:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10182

cip/linux-5.10.y-cip baseline: 135 runs, 2 regressions (v5.10.158-cip22)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
r8a7743-iwg20d-q7 | arm   | lab-cip       | gcc-10   | shmobile_defconfig  =
       | 1          =

rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f37e570b7c4ab8bcfacf36780a9e204878f2c181 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
r8a7743-iwg20d-q7 | arm   | lab-cip       | gcc-10   | shmobile_defconfig  =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/6393db351e569d8bfa2abd11

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6393db351e569d8bfa2ab=
d12
        new failure (last pass: v5.10.154-cip20) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6393e0312a93aad5172abcfe

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6393e0312a93aad5172abd20
        failing since 255 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-12-10T01:26:00.811683  /lava-8315151/1/../bin/lava-test-case
    2022-12-10T01:26:00.822295  <8>[   33.779427] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

