Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F80C77B6F
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 10:43:40 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.6078.1681469010840127291
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 03:43:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ejgooDZD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1a6862e47b1so3650815ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681469010; x=1684061010;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mixOse13j9OY/eBiIHVQO5838GIeWehJpDvmps7Zlw4=;
        b=ejgooDZDNMR8z0RAHAWT7RJB8Z/8Vtn2l3N8LfGkZIXhz6m3Q/WWYg6qvGEZ4x9ibI
         g7tVuQSgB6E9UGSSoVX1kSzai7FKreDTOFuPe6wOC6PJ0c7X91W51Q33i+07hAVLpuUt
         jMB509gqx9UVpO9PiN70V1YFfTrHpX5IyvKpGSDAArA9J8r7W2d7OTt9zCW2E+KNeWKN
         s6Sqj3m+iC6kf5t3lpNTK4oaNuqBHPnROh0BNnJopqATOyJ+LAh/8lvFQO5hrVpHdJAZ
         y/My0VlUseMDZuxXtDoEvXmdaELQ0ikVDVarst4cv1n7ygb3IsK/hItKTk/oKtzhsoLb
         5spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681469010; x=1684061010;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mixOse13j9OY/eBiIHVQO5838GIeWehJpDvmps7Zlw4=;
        b=gegapzBRQHbrESaUY6RKaHQOzpKHnevCnQyF3eQb6cgrpzIRtB0e1yPAubn4Bv/3e5
         Pg/PEIPgAvI127WFVTyE+U5zcAyD9aOigzQNRqE6dRJoKnknyJDN6FlvGyIIO+hW+9Xr
         RYqFKcaVrlRYAiZVHxPZdpK51EaypgW4i0U9WhacObajj3knLWtmJJmRyz0Ki9VAIMBO
         uIsXPMHAgNjEVjPiWn9POwunzgxr8RKZFXK55bIP4cYLaGX9LndxfQry/YjhcGMhJ0xf
         NXpUoBdu5R2kYbBRUlIskF/BlU5Iv7jQ7NPs/bn8EC5gxSEPHUPZvSMCY0i5Pkg6XYVg
         VPgg==
X-Gm-Message-State: AAQBX9e0+fFhzKUhlIHkK43F839oziZBLAGj17f7xGsB4Mv/R1ZfGkZe
	0aSMK3YxSytKXi0N4WUQmYGxB9Lv5EMW3k3leZztcEdI
X-Google-Smtp-Source: AKy350YagM6nUFhsVObCYdh3T/y6aMIN1CKctXBe2KI8U2lvr3vWtFjnJkeGiL+NvS9GgKeg0Xl8Mw==
X-Received: by 2002:a05:6a00:2e27:b0:636:f899:46a0 with SMTP id fc39-20020a056a002e2700b00636f89946a0mr8150659pfb.15.1681469010004;
        Fri, 14 Apr 2023 03:43:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r22-20020a6560d6000000b00513468106d8sm2630402pgv.1.2023.04.14.03.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:43:29 -0700 (PDT)
Message-ID: <64392e51.650a0220.6366d.695a@mx.google.com>
Date: Fri, 14 Apr 2023 03:43:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.280-cip96
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-nfs: 38 runs,
 3 regressions (v4.19.280-cip96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 10:43:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11206

cip/linux-4.19.y-cip baseline-nfs: 38 runs, 3 regressions (v4.19.280-cip96)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defconfig  =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.280-cip96/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.280-cip96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f5788ca10e5121ce62a8a58a84c723b7d99607f =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defconfig  =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/643928da3e6824f1662e85f5

  Results:     28 PASS, 5 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card-probed: https://kernelci.org/test/case/i=
d/643928da3e6824f1662e85ff
        new failure (last pass: v4.19.279-cip95)

    2023-04-14T10:19:54.259290  /lava-327697/1/../bin/lava-test-case
    2023-04-14T10:19:54.429097  [  105.780642] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card-probed RESULT=3Dfail>   =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6439267eba5fb7e9cf2e85f6

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6439267eba5fb7e9cf2e85fc
        failing since 23 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-04-14T10:09:43.821044  /lava-9975498/1/../bin/lava-test-case

    2023-04-14T10:09:43.848685  <8>[   39.648134] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6439267eba5fb7e9cf2e85fd
        failing since 23 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-04-14T10:09:42.760243  /lava-9975498/1/../bin/lava-test-case

    2023-04-14T10:09:42.785713  <8>[   38.585926] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

