X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web09.1416.1652904674221466914
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 May 2022 13:11:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=muHD/uR4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id i24so3135927pfa.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 May 2022 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=B4myrQUfdJhfdJ0MUr54KNjen9uOhtlNMG+aTTZaYRU=;
        b=muHD/uR4W6gCrf4vl4d/YMvXtoRszjuCHpO4xj3Y4l/r/1lSSBnijBbsOM1D0ZwYh8
         zwUyeSQuYUMP2K34yMx8NyQUv/AffJULt9l9Z+RuZksgu5kz2kwL4ZFcI7ehEHMbHe0M
         03480bgaGhV41VjB8z3lt4dFoV0khbZ5pPb6AyQWh8sXiyxmmrPkkOn1MyTe2dtWEC0f
         FBTjjObSKzozVAp3u2gggzAZxbTXjVUZZNT3wvKhXhIBZy51Gub1B6CgetUBGB+nXQP5
         ysH2lj7cZNzykJWQsj1rQsKbErNLmL0RPiPsXPjHah9exHiIQmGJUb+h+e7xqMcxPOoO
         usEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=B4myrQUfdJhfdJ0MUr54KNjen9uOhtlNMG+aTTZaYRU=;
        b=tJ0dSIi+/2bs1PomrtsMznMzMq7qWMfEz4BbWjHicFXrVW+m8U8T8kweCe8AxbuYZ0
         DgUjzmv52ZcNd3pE5O+wkZZl07cyMbcQoETxjKjjd0YroiMFEo8KHvtEm1Qpk0GuLtWK
         Ub8OA1pgEk/9G/aL3VJ3buz8C0Xyu4p5zh9uXQx7iwwGZtmanxiN/BJ5qPUSBk79Px1G
         sFMfbFuAFFhogJkPdXSXbJ0l31REYRW6VWNZfPOoy6kxleOcr8L5T9CPhWzDCPNQzJ+A
         fSl9e34dcfKcCn3u08CIPREZ8zl3Gj5XbWSPvf+96qNKnKThuqGnntR/2G24SG0iKg0s
         RnuQ==
X-Gm-Message-State: AOAM531fbaTq0Grl/pqBf+tO+5SKiEOLa7/Vay3kvLP2jav3asCojhn9
	FOGcr/wEeJQLCF/56x9faB6Ev483ntRzu+V9Q1M=
X-Google-Smtp-Source: ABdhPJwMKIerfYQUbYhf16OBXxic7Eay6v/gfbkaa3Sl0YoPeOuVDLosWBY+JwMNRpRBqjMsXh5TCQ==
X-Received: by 2002:a63:5b01:0:b0:3c6:4935:589 with SMTP id p1-20020a635b01000000b003c649350589mr938487pgb.314.1652904673422;
        Wed, 18 May 2022 13:11:13 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k22-20020a170902761600b001614cd997a8sm2093096pll.236.2022.05.18.13.11.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:11:12 -0700 (PDT)
Message-ID: <628552e0.1c69fb81.dd544.5063@mx.google.com>
Date: Wed, 18 May 2022 13:11:12 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.115-cip7-81-gd05f72e501084
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 29 runs, 1 regressions (v5.10.115-cip7-81-gd05f72e501084) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 29 runs, 1 regress=
ions (v5.10.115-cip7-81-gd05f72e501084)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.115-cip7-81-gd05f72e501084/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.115-cip7-81-gd05f72e501084
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d05f72e501084803c8658a71668fc1aadb075165 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628550d287317cdcf2a39bdd

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.115-cip7-81-gd05f72e501084/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.115-cip7-81-gd05f72e501084/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/628550d287317cdcf2a39c00
        failing since 70 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-05-18T20:02:13.005065  <8>[   36.531013] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-05-18T20:02:13.699469  <4>[   37.224958] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-05-18T20:02:13.708741  <4>[   37.235458] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-05-18T20:02:14.055084  /lava-6417484/1/../bin/lava-test-case
    2022-05-18T20:02:14.085559  <8>[   37.613314] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

