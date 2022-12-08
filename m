Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815BAC63703
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 15:50:47 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.17854.1670514638562341497
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 08 Dec 2022 07:50:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Y1ZmZise;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so6300031pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 08 Dec 2022 07:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1+YuYQz3tu13icPGB/7QmzqKYtLbZwlL0GpyVKjfkDc=;
        b=Y1ZmZise0F0GUiZSFEHxgx41PAVONg7kE3PBLpHXbyAnGeGEpBiCow7WC2nMGNHIp8
         nctIKbydLcfGKvySvegsJWDGMZAwhwCXtfP2nCbRkKYy9joCfbVTkOmK3LcKuQL2KhNR
         LZyMng9FWSPDgZkd9b7Qo1/gBKolte/vNyLZjw3ZtqZs015SF6d96Hj+T4PLF3utVWhT
         peoYoIe7Uf40Pa6lGLi1oPSA2F2pjjqj0WWzKpuTIsQwLIFJmnMX7xdShsVnv1trUoav
         XeoGr2sRkLw5ZwewKwy2LfKDrIjo5o7fdWMJro/drgaOkA+bqbFl5d+xWDK+vpwkc9Nt
         J/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+YuYQz3tu13icPGB/7QmzqKYtLbZwlL0GpyVKjfkDc=;
        b=vuHfoJtO2tn6VMt38XVYCYHCGYAHfHjhSqqf/B2ezbQn+LNpQHpM8v2wHzwHbaS7Ti
         K3XUM+naEk9CZinOFVDP64uZ1YENG4GcyT76ygx6ArHt0pZaFLsi7ZToUrcw0K3Z+++a
         eDaIgo+9f247LwnOwbhRz3wM0noMMNUbCLJUmVhSlLpweNu9cpQ9eiaY6t1Shjo8JGA/
         LEXS5y3ZmbwJzfRJK0BXd1lJC4mkkSgQDQC8bDUYqUM9Vjgl/6O0e9pUf95nMnOrThKB
         lNHiYUxKsdX4XQc7JnpqJDqV9Y012yx60nwvWS1PeJAR7CDMi0uIrDwSFJVAHJNDigta
         qZcA==
X-Gm-Message-State: ANoB5pnWfAp8zL6JMdqD3VpRFNfjkCywjtFLP5/rrBcR9vEhQST24jas
	JKmd8WWXJvroISXVwLQ9Wd2eOKKtCR+TausxdAM=
X-Google-Smtp-Source: AA0mqf495oNBDjg2CdS3lTMbyavPRH0r5AO/IUcpjRPwxPiBZ6Df/drQh3QhoPk7+zpaa9lF3PuUEA==
X-Received: by 2002:a17:90a:7383:b0:20d:bd60:a0ed with SMTP id j3-20020a17090a738300b0020dbd60a0edmr2630807pjg.30.1670514636787;
        Thu, 08 Dec 2022 07:50:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090a8d1100b00219752c8ea5sm3021736pjo.37.2022.12.08.07.50.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 07:50:36 -0800 (PST)
Message-ID: <639207cc.170a0220.65652.5f9e@mx.google.com>
Date: Thu, 08 Dec 2022 07:50:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.155-cip21-405-g26d566555c3de
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 106 runs,
 2 regressions (v5.10.155-cip21-405-g26d566555c3de)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Dec 2022 15:50:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10168

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 106 runs, 2 regression=
s (v5.10.155-cip21-405-g26d566555c3de)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.155-cip21-405-g26d566555c3de/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.155-cip21-405-g26d566555c3de
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d566555c3de5796328380cfeda5b2372f45010 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
r8a7743-iwg20d-q7 | arm   | lab-cip       | gcc-10   | shmobile_defconfig  =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/6391fab4f86f4a20f32abcfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.155-cip21-405-g26d566555c3de/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.155-cip21-405-g26d566555c3de/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6391fab4f86f4a20f32ab=
cfb
        failing since 43 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/639206c3cf6297ccc72abd0a

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.155-cip21-405-g26d566555c3de/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.155-cip21-405-g26d566555c3de/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/639206c3cf6297ccc72abd2c
        failing since 274 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-12-08T15:45:52.341988  /lava-8290515/1/../bin/lava-test-case
    2022-12-08T15:45:52.342913  =

    2022-12-08T15:45:52.352452  <8>[   34.010189] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

