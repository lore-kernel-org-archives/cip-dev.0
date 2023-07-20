Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F78C001DC
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 13:47:46 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.13389.1689860860621089749
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 06:47:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=P9nsIMT/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b890e2b9b7so4540835ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689860859; x=1690465659;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ct2K86JEo7AiJ39isf8XlIXg8KjhuwVeCl3HZxQF72k=;
        b=P9nsIMT/DuZEI7G1W6N7/jz1rNPXMY0Y4fPFmaOtVZ4wP6wcQqhtKFBQVhhm5pE9Mj
         SeAZFFBJ9zYXUIeDJIGsWxQXEA5payBdGFY43fEEwt8Sg+v5az0zOHq1ah1Bsp3wYTVz
         8vJKyXEy3OwPELuJjSON4UfQr5AYF2uRmcilU4uK6uCI7QejT2axLVnvHOLLextJLnt/
         qDADBIL9PcV3oHP9YlLv+xrAMNHCbdIQ1VCbKd0vrFygz9V5Reeeu3j5XkHMpvXyKtgp
         t6fL8nmVJ3lAM9NhRPfAdN0oLmlkSZVovEqAGwozxZCGyr3Ga6X+xpXt0GVUL5EMGciG
         /dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860859; x=1690465659;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ct2K86JEo7AiJ39isf8XlIXg8KjhuwVeCl3HZxQF72k=;
        b=j0SuE3V5qAqRl40Q38BCMJ28Ye09nBtkKOjl6qoP44N+DHaX8JxzbUcur80RoCVODE
         YvdGAhIM75kiHom1DsuB0pL3nmffM8ldhdGLa34mw6zdsSAUuwS50F0h7SGfiKd+7QKi
         tDkPWREExzO1kh/fXdNsdH3ddDjWj1HMuI50mI322P+lsUsjv16ViBPu2P3fEJtEEpQG
         MZPVN+JUD8KMGJQlJxXN1u0noA2Ltql6hhFQHqxJntSI+kZUVrdbmhnLKCntV+g/Cthd
         Jad/1oaEvGdv/3Z/dovaUZtwWB7z2yaEywtNlh5OaXpe7qwwF3UuXkL1N/Ypm/9Ch1xC
         vUfQ==
X-Gm-Message-State: ABy/qLZCTwuAoROL+kPVpyYA5VreKZMYTzV4WAdzf6F1E7qQW4bEBVEH
	FEhEwcbZg4e3y1FplfPIAOdAV62rCdo4pxUUQErzDQ==
X-Google-Smtp-Source: APBJJlEZM2b1Cp/i6xNFr0VwNCkP/yNuGu6zN4//EKN2ZGKWbBSCBdcRrOYA7JRxZXl5/gqy5G05Zw==
X-Received: by 2002:a17:90a:840f:b0:267:a6c5:e60a with SMTP id j15-20020a17090a840f00b00267a6c5e60amr6471858pjn.0.1689860859414;
        Thu, 20 Jul 2023 06:47:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090a3b0c00b00264040322ddsm2863560pjc.45.2023.07.20.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:47:38 -0700 (PDT)
Message-ID: <64b93afa.170a0220.bbba3.51a8@mx.google.com>
Date: Thu, 20 Jul 2023 06:47:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.38-cip1-7-g5cff59cac977b
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline: 75 runs,
 2 regressions (v6.1.38-cip1-7-g5cff59cac977b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 13:47:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12471

cip/linux-6.1.y-cip baseline: 75 runs, 2 regressions (v6.1.38-cip1-7-g5cff5=
9cac977b)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
odroid-xu3       | arm   | lab-collabora | gcc-10   | multi_v7_defconfig   =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.38-cip1-7-g5cff59cac977b/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.38-cip1-7-g5cff59cac977b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5cff59cac977b1b5b2762b500623602540959ab1 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
odroid-xu3       | arm   | lab-collabora | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9265ee496dbc2638ace54

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-7-g5cff59cac977b/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-od=
roid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-7-g5cff59cac977b/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-od=
roid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b9265ee496dbc2638ac=
e55
        new failure (last pass: v6.1.31-64-g93fc2d0f5008) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b92e0189f834d3418acf73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-7-g5cff59cac977b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-7-g5cff59cac977b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b92e0189f834d3418ac=
f74
        new failure (last pass: v6.1.31-53-g486caac40d06) =

 =20

