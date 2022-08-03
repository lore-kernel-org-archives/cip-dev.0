Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0225CC19F2C
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 17:49:10 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web10.871.1659548943989696016
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:49:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=u1Wxm71S;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id h132so15763173pgc.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aN6ZO+/TGwtacb3+5kfSNy0pVkS9HemKtxKs+CC+vk0=;
        b=u1Wxm71SfowSez7JQaH487sNQwBEdOjNTZ+l8Y/hD6L+Hgkv4WvMP2JoUu0g8TcXe+
         UJatkxQkYTT5/ErcMA3V73EoArVrOWpxgzZ/c2511s/mK+QVohxioOeyFD/HmcWgbjW5
         sqvCtXxnJFNrDlEL5k+VT+OqSmMlyxTAlNVS3Hp7Zq0GnkN9Ralfb4VlowYj6sm4cv4b
         tC/V8ibF8e9xgoEwB70Q4IEsflKgq3Shk9AYa3legMsim+2WiXW1OVYDAoxAPVoWaQce
         bd3EQKyRABVgpvANUQdZVzRWqpWu1ldruAmUziefOy+F/p+7JczYuZFdp3lTEKeSgKQz
         811w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aN6ZO+/TGwtacb3+5kfSNy0pVkS9HemKtxKs+CC+vk0=;
        b=ZQHtUEG9tRusRqmSNaDyB2tP3bJeQGdTHvZQziQWimwVGwFEnWNA0qnLste1Kgxjaq
         2qNRFRhejskvcepNQMadWcLDOK+iNrcz+iU0Uy81G/jtJEEBoU+EGCEp9ih8BRN1F51C
         70AMVYXy03TapC1hlnDJP5SOZEd39paQY82/3RoS/C089ZqXQRZSI8vpALN/IkaoXul9
         SB3aPHKaTNakMLSN1JMwRmATwb0wuZ22MS0ZFiRkOuO6Nfpq1jxCuymU8/Wm5rK5BKEy
         JTCDMGlY8yu1OClPvo6se/vKgGhsNSvz5sxMmdfmdi2K0UPxxyzNQLZLs3378dc+oGLv
         uqMQ==
X-Gm-Message-State: ACgBeo2jG/sELQkGlDKNGyIvU/IS7WB1TpK+GDsh2UFgQZnxoakQ78WX
	hlr97dTPPYEOkzxa8l2xEChCsaFQb+bLth78ddg=
X-Google-Smtp-Source: 
 AA6agR4k/recEj0sk/y4pjDfThTciDatzBheQnKjtmkl3LYPzD9beEsoR8RsHlWZJZsRbQAq4bAkHg==
X-Received: by 2002:a63:91c4:0:b0:41b:e873:98ca with SMTP id
 l187-20020a6391c4000000b0041be87398camr15677099pge.323.1659548943160;
        Wed, 03 Aug 2022 10:49:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p9-20020a63fe09000000b0041af82dacf7sm11330612pgh.73.2022.08.03.10.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:49:02 -0700 (PDT)
Message-ID: <62eab50e.630a0220.7f96b.0f6f@mx.google.com>
Date: Wed, 03 Aug 2022 10:49:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-24-ga6f4ea41fe167
Subject: cip/linux-5.10.y-cip baseline-nfs: 34 runs,
 2 regressions (v5.10.131-cip13-24-ga6f4ea41fe167)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 17:49:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9090

cip/linux-5.10.y-cip baseline-nfs: 34 runs, 2 regressions (v5.10.131-cip13-=
24-ga6f4ea41fe167)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-24-ga6f4ea41fe167/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-24-ga6f4ea41fe167
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a6f4ea41fe167f956d4000eaf276a1e383603071 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa8d002883eb07adaf098

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62eaa8d002883eb07=
adaf099
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaac3c7f6d242667daf059

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62eaac3c7f6d242667daf07b
        failing since 127 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-08-03T17:11:12.641628  <4>[   37.477747] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-08-03T17:11:12.650517  <4>[   37.488177] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-08-03T17:11:13.346905  /lava-6963172/1/../bin/lava-test-case
    2022-08-03T17:11:13.386988  <8>[   38.225015] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

