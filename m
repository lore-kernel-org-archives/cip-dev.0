X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web09.33140.1650907405179059603
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 10:23:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XaHZ6gmC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id i24so15403785pfa.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+LJdYpvGUy6XgaWxAjG4YYSrqVqeZlgD+u2af/zQgrQ=;
        b=XaHZ6gmCvhdM8FuECrx0qUMptoJsujo52ebTWiwLoZANzUF66NorbhLzd0n/Dd+Tk9
         O+vmyWG2ZTK67b5i4nbPpNywtQV1XREq8EbqzvhUXEiBIF+Gh5znDKgL0p+iOYD5JnGq
         4VhBNcpr3KwoITJey8T+sOLQ2Rxmbydxka6emvE+J70ES7iIIlb8oqD5MZgXmabwtKqB
         d0z1FbigIRJg2SC/KTW7YQho1BDDAzf/2HJ3/597BSaYoe7ZFymnNmWmmIN/7yl+TNsm
         UeqLVSPp9o9q7dcNG5Bnm/GQ4GsV+NSc590iEmjF7CNERKkEuPXRSbaCH62/cKroxmRZ
         mIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+LJdYpvGUy6XgaWxAjG4YYSrqVqeZlgD+u2af/zQgrQ=;
        b=FWL4ARmKynL3xSix95TF7TjFg6JCpIZFQ/yrX6twXye2EVQ3ZL1i+HPr/b4ZX8jd7m
         kpMwmxVlHIl5t9Mvll0u/Gse/FYdfWhAhYaIYcCC9YGG1eRMqWaWFufVm4UtmRBfQdRP
         490NdepcmaH5TOvo1UPUfC3L460hjdN9QYn/9MGgl8htOf0utOOgl4P/UpQS9RIFk9Sy
         mdj/RtJLQ1A+egT2t+JmxxrOn6d2HQUwZUCxS6aLmPWFlKsEGKDsiPdacp4vMIAOnYkR
         WI9NLfXc2RDGky/QRmZMBcFMceK/jI0di3PVadcGbz9n0MfrWGHew36bLiCkw45Gt0dJ
         RJdQ==
X-Gm-Message-State: AOAM531RcWd/ksLm1FKiYSPGkGk8ucn9UkiH+TrTlPz/JJWt7KRlq+uA
	V1B92xKMqsWAfKueFkYeSZ6SiMKeh8QHE6Og4i0=
X-Google-Smtp-Source: ABdhPJzUBaDZEwWBKXDPx4sRiMVeq41FdXQnaj7hHIpkQP2LHwIaKajBDIviO2l/yt+7hLo8VNUUcQ==
X-Received: by 2002:a63:101:0:b0:3aa:b7e9:6708 with SMTP id 1-20020a630101000000b003aab7e96708mr16127488pgb.111.1650907404389;
        Mon, 25 Apr 2022 10:23:24 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p64-20020a622943000000b004fdd5c07d0bsm11860565pfp.63.2022.04.25.10.23.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:23:24 -0700 (PDT)
Message-ID: <6266d90c.1c69fb81.1343e.c1e2@mx.google.com>
Date: Mon, 25 Apr 2022 10:23:24 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.109-cip5-899-g234e7e7d5bd3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 15 runs, 1 regressions (v5.10.109-cip5-899-g234e7e7d5bd3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 15 runs, 1 regress=
ions (v5.10.109-cip5-899-g234e7e7d5bd3)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-899-g234e7e7d5bd3/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-899-g234e7e7d5bd3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      234e7e7d5bd36004288823dfb36ce5e3d2f6e940 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266d675d66c9b9cdcff9469

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220422.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6266d676d66c9b9cdcff948f
        failing since 47 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-25T17:11:54.103160  /lava-6173357/1/../bin/lava-test-case
    2022-04-25T17:11:54.130746  [   37.468135] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

