X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.9884.1650471607592595185
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Apr 2022 09:20:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=5/PrxF+0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id t12so2221642pll.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Apr 2022 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NCYPRqfRtQyMulo0+jy+srV6a6qouhPcr/3cqljAy3U=;
        b=5/PrxF+0e6PlKpO3Ysuw130brMV9Co0G7bDIMOWcQWg2k1mY3qKmoKicSk6vPO0QGn
         6HyInGx7KImI4itWP7B0PYx2p0VIGjkMATtEX5KprFbN3BXQW+cyrTQtXDiF533zJIOL
         Urx9dI+7Y7yoznL1DGuPNu/jynb6iWUZJVO8An0dAvneaahYI3KQpP2dBNyosu3Ucwzl
         6cNyYP/0I2L48C+RtVxtrAHAyfKbi7vZVw2dcoiVBeiLYsuglAKsaEbxxiVYlBW+AWyi
         1QqEf5syygfupW6jLwFMNetIhwvGTFIxBHdXXW1ItogxmqfVhUNNbcxiloqeOw309Rdf
         oyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NCYPRqfRtQyMulo0+jy+srV6a6qouhPcr/3cqljAy3U=;
        b=i+d1GzXpAvEahp1EXo2vbV9mim+NNvj9lnkO8r9mnGhMG34uKDxoSYUUpADKwU2zuo
         kTuTdmsMT9h+QGk04gv0T33OPSq9fVi0D6xRieOy24/wfCtE4gvyCRbt/Oa52CA9L7Yk
         f6XMPVy0n2WwcISrEb6cy32EWoi96B2x2lRRhKmWmAhrf6icUUY+d4XjsbzHVAwyAUcp
         QheTA2+xO7CkhOf0eoAHhPG5jGh54XUoxUeH+3hqVDlmbdrs4BEm9jkF/nRnN+5GO3TE
         x49TvlT2CTA2yniiJwoJL11lx2pWuiMJiOYdFUy9X84WmuSpMBBPN75jniXDRxymfBoh
         trsQ==
X-Gm-Message-State: AOAM533wzqV3TN6j3QemGgnZTjc/j6KTuwSMkTiW0DSfGXfXXKp8ALDV
	6leaVkSpS27xQdKzqJesFCgUXOriExWKYzBaX8U=
X-Google-Smtp-Source: ABdhPJw3b1DYPSK/aUx76L5Qq4i521DHid8Mb540urJI3952eYzmkiUVvmtIy3+QUO0xX6pvROTKlA==
X-Received: by 2002:a17:902:7442:b0:158:a253:b4d5 with SMTP id e2-20020a170902744200b00158a253b4d5mr21308473plt.94.1650471606576;
        Wed, 20 Apr 2022 09:20:06 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a637c42000000b003644cfa0dd1sm19869496pgn.79.2022.04.20.09.20.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:20:06 -0700 (PDT)
Message-ID: <626032b6.1c69fb81.83df4.e618@mx.google.com>
Date: Wed, 20 Apr 2022 09:20:06 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-875-g6ed0fe2c3e8b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 124 runs, 2 regressions (v5.10.109-cip5-875-g6ed0fe2c3e8b) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 124 runs, 2 regression=
s (v5.10.109-cip5-875-g6ed0fe2c3e8b)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-875-g6ed0fe2c3e8b/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-875-g6ed0fe2c3e8b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6ed0fe2c3e8b47b471924ff54d5cdb9d0afb1200 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62602984b4ab5c8f25ae0697

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62602984b4ab5c8f25ae0=
698
        new failure (last pass: v5.10.109-cip5-770-g2801336f0f208) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/626027aa98a7664231ae06d5

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/626027aa98a7664231ae06f7
        failing since 42 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-20T15:32:44.147705  /lava-6133208/1/../bin/lava-test-case
    2022-04-20T15:32:44.158108  <8>[   61.140213] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

