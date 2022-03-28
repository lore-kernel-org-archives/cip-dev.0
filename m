X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web08.415.1648510320997836177
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Mar 2022 16:32:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0jFpgWTp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id c23so16110726plo.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Mar 2022 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=snkAlSENGwCnkN/GPuizQdmVCszqDRafvHhj+MqwPEQ=;
        b=0jFpgWTpT7xLGeWXuvl+gbI3fdHBkO8geOMroUxoD5enYzJzqRTBeSL856BJOVRhBm
         +mJ2kUj0uXuGbxuQfm9WRIbh1BOwKELkrnPN8913hqWBozb0AI8NrEus79zzZ4lwpPXj
         DYs/wmzIQ7IGmS2lWL0whKTI7MSnSvn8zu0PbB9elilJ4OQh71HC2LkEAXmO8gRkSk9l
         mXKPKczEvIVpISMZnzf9d/voJlf4o/6CoQaWyiRnm79JnlYXby3EAoVt4Pznq62e0n9/
         W4Qf/cF6tlcOAWkFOsKQqubkZQeGYByvqFiIJZl72F/3IMxxqJBcysi+rxGTWU46nCU6
         s18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=snkAlSENGwCnkN/GPuizQdmVCszqDRafvHhj+MqwPEQ=;
        b=bOTKKF6kDXQ2MGzRFnwVEhEz3TMBoY7bNMU/FeElqup/Sm+hwS1e/NEf1kcDuA5wR8
         C0Tlj4T1+UjYTKce2gUTsqUXNws9rhd7RENZf/3B5p+KQP0qjXkntla1R0Hd3jAoODQh
         jIFm/ASlue7TtMtSLz+ftBhxK/sNGxDdZF3nGd8G0o0HrjhQRXx6eoOxI0IgqcbttNPu
         YTfvCCHJbH+NJWvbz+lWu7695KQnauzgje5OHUv/KYZDid8axIUn0bbyPaeetBSpCLyk
         m6x4s50RfTfzQRHEYQ3y08ktxYBDzqHJZMWWiV+P16ramp6C82eIc4IXAIBALP11ws6h
         jSVQ==
X-Gm-Message-State: AOAM532vfgkis9OpnHyP8BMZxpN2mqI02yMWY4jqgrkCgl6yU43OrlB+
	SzUz2NxJX3h11XC1yW9KqqPYNi3aoy4OM39ItAA=
X-Google-Smtp-Source: ABdhPJySxlz7JmFWn+/7CMO23Mz1v+PGCPcKDjJRc4ZAsVXJsfkolMI25NqrfT0wD82aKDtvInYivA==
X-Received: by 2002:a17:902:708c:b0:156:1aa7:e8d5 with SMTP id z12-20020a170902708c00b001561aa7e8d5mr4641084plk.11.1648510320219;
        Mon, 28 Mar 2022 16:32:00 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090a454a00b001c96a912aa0sm560495pjm.3.2022.03.28.16.31.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 16:31:59 -0700 (PDT)
Message-ID: <6242456f.1c69fb81.bb3a7.236a@mx.google.com>
Date: Mon, 28 Mar 2022 16:31:59 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.104-cip3-224-gbc5581d50c4e
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 17 runs, 2 regressions (v5.10.104-cip3-224-gbc5581d50c4e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 17 runs, 2 regress=
ions (v5.10.104-cip3-224-gbc5581d50c4e)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-cip       | gcc-10   | omap2plus_defconfig  =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-224-gbc5581d50c4e/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-224-gbc5581d50c4e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bc5581d50c4ebee1d73a29e0e3e0ce12e959112f =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-cip       | gcc-10   | omap2plus_defconfig  =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/62423bdf2da01e1e54ae06b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220311.1/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62423bdf2da01e1e5=
4ae06b3
        new failure (last pass: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62423db89443c01774ae06d5

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220311.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62423db99443c01774ae06f7
        failing since 19 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-03-28T22:58:38.571921  <8>[   96.042807] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-03-28T22:58:39.616050  /lava-5964598/1/../bin/lava-test-case
    2022-03-28T22:58:39.645654  <8>[   97.117565] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

