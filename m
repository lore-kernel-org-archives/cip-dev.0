X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.766.1647453607275475704
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 11:00:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=u0lu+/Uc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id t22so2470424plo.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zUmbeUx2Y2ZjlXtykSlgLIwX+opwwwwctVr+QIBk8Iw=;
        b=u0lu+/UcHioYWHUYF5J1x3vUCLXHihWpoZivg+xlZpiEfzoZHiBjI7DradLVbpR0iu
         X13tFDUzo8Umfihgo0xkNm07aAR8UWNwx604iTGrH9nRCdCrV9Yo68Qc3u3SDZFe04I3
         ZoyJesRN1+6j5WFqAQIDYcIpxAksFB7pZXOKfB1GjXDvD7mvg5bLQl87P5v+tqojBFi7
         rrX0sIqUG36e5gmA1FoVV3+yAQPdoG1Qz/5le0sElO7fJasN7JMcPQQTqWsP5DgEFBHt
         scohf8VXx4JtBNDxTkHc6eiqY4bgdBgthMSPg8DbbP33quuLh/XA6qhr1eEKrmKAeQOR
         4aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zUmbeUx2Y2ZjlXtykSlgLIwX+opwwwwctVr+QIBk8Iw=;
        b=46aFpMMPKNbLQmxktrrVlobUpzzPUvN3UVL2k+h9pP6yuXYKtIfAlbE6I2D7BqnV3d
         OvGGWTiSj8byoopVIZDQhfUZ72O39UU3ZmVSFpUEiFhFIvPuIqNgnAG/lPlmK9/GGJf1
         DWC0dNwkg9juhJk1IGlWnnHe4OYulymvBOkyblgMuDEmpDlhpDcfU8YnBXgwSYwdOLRg
         mK7QFj6nBg/sidvI1FIa9CYxQZTubos6nYo0LgSIgbbI++D7nkAcRGyS6D60qCJY5x5d
         malMcneZnQX91EP6iIBRYRQn9ple6LnaVVDW/2+yY6utl9ZQbGFTEVQMgbaROcNzG0lM
         VlrA==
X-Gm-Message-State: AOAM533HwvUVL41cGwqoFtXLia9X62j1LH8ZfE4Ny6XzdRQpqs3LfnZB
	M17Qwu8i9UYvuu81Hk+oO7Y8d74amflyLGsIT1A=
X-Google-Smtp-Source: ABdhPJwtcNpfWxbyrRYYScmNjh3YSLSCZOEX8Zj36lqjlO0+2Fj6pN9O4RA+xGGo4wbQ/GKGIygvNQ==
X-Received: by 2002:a17:902:c611:b0:153:a7ba:ab69 with SMTP id r17-20020a170902c61100b00153a7baab69mr779769plr.99.1647453606296;
        Wed, 16 Mar 2022 11:00:06 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z22-20020aa78896000000b004f7b0e1b16asm4340104pfe.38.2022.03.16.11.00.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 11:00:05 -0700 (PDT)
Message-ID: <623225a5.1c69fb81.fd902.9ff0@mx.google.com>
Date: Wed, 16 Mar 2022 11:00:05 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.233-cip69-62-g10346bfb0fd8
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 14 runs, 1 regressions (v4.19.233-cip69-62-g10346bfb0fd8) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 14 runs, 1 regress=
ions (v4.19.233-cip69-62-g10346bfb0fd8)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.233-cip69-62-g10346bfb0fd8/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.233-cip69-62-g10346bfb0fd8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      10346bfb0fd860c9b121a80924fa29d4100b7e49 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62321d7602265cdb18c6297a

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62321d7602265cdb18c629d4
        failing since 2 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b,=
 first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-03-16T17:24:57.528625  /lava-5892180/1/../bin/lava-test-case
    2022-03-16T17:24:57.554804  <8>[   38.669333] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

