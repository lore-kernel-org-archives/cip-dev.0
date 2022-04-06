X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.3784.1649211388764726474
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Apr 2022 19:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=V6aihw87;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id j20-20020a17090ae61400b001ca9553d073so1293968pjy.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Apr 2022 19:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WpFqAqgtpxD3LJ4wdMfT1N98XsMefj5fZ+m88JNzZTo=;
        b=V6aihw87kj/GXNa9XdLLSXEBfki7mjRZLhAseNkJTEUII0RDHjywDTWIBoWbV3iysi
         Yvf/jMcA3sNYM7YfzEEwg0vpBvqfa6iSnp596zCNdILzwb8gPYosmS1P3bjbdoVfQYJ8
         Yk7oGCdrYZVAxfmMfrc9/U9PKlr9Tbksp6sHqBBfLpefjY7Ct5z6tJFPXL01gB9HmoIB
         wX/UQhU8ERJNW8rHmzJNiex78A3zybDDGIo6WN4YaAj1kVUyqVXXKo50DBhKl5NAB/L9
         Z6sba5BLohcMn1TtEpzlle5UZBmD4LN0x/UgFq8NJ263pSM0E42+D/ujo6X55ATofl7z
         St0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WpFqAqgtpxD3LJ4wdMfT1N98XsMefj5fZ+m88JNzZTo=;
        b=tP8V00CJ+KH0TFuCFucG9XWya5K+NdmYZq1I+D9eMbkfhCbzP4aWQAmxBjreL1ZeKa
         XYwjfcHRASupV/alqx5RDpu6sHAVcYtYwRQP6F+6pc5441SjHuaLHm5Qrk6VTtJbD7Us
         sNbbWyBTUR5GSrxZjippFj2IuJR3xsa+iEKHfQWFTQfPZHpWte4QWXg1Uicx3CmDpkrB
         uSMIRawausGZpffnlSwS0pZIUkJkQIcGMMnL4I+F0pfw8IO7CrBLEwYEsWB3W6FMft7Z
         It/kP6rdub6tLWJaBg3X2W+54wvtrjX+0FYi53UmmdimIAjgHzVf3zU+VHsloU46IKI8
         A7YQ==
X-Gm-Message-State: AOAM5307/+dnWU5wZCO48sFL2RDV1xSHDAbxdoPJou3z1qFybKlN9xWy
	qpkJw9z7Z07wZNVXMwjGTFMHDtjcLanN/OpGNog=
X-Google-Smtp-Source: ABdhPJz9+WHewzxEMJxeE4ThONmmGdYdId4vK+U5a0HhBQfmlKYIpx2H1F0LhYGDp0ETt1BcvxeLIw==
X-Received: by 2002:a17:90b:1a85:b0:1c9:d81b:33f1 with SMTP id ng5-20020a17090b1a8500b001c9d81b33f1mr7277893pjb.212.1649211387944;
        Tue, 05 Apr 2022 19:16:27 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090adac100b001c67cedd84esm3576400pjx.42.2022.04.05.19.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:16:27 -0700 (PDT)
Message-ID: <624cf7fb.1c69fb81.b7d2b.ac12@mx.google.com>
Date: Tue, 05 Apr 2022 19:16:27 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4-66-gc8c4cc5cdb54c
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 14 runs, 1 regressions (v5.10.106-cip4-66-gc8c4cc5cdb54c) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline-nfs: 14 runs, 1 regressions (v5.10.106-cip4-6=
6-gc8c4cc5cdb54c)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4-66-gc8c4cc5cdb54c/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4-66-gc8c4cc5cdb54c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8c4cc5cdb54c5d2534c7533f0cd8a10adff3ba0 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624cedbe79c8e7862eae067c

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/624cedbe79c8e7862eae06d1
        failing since 7 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, f=
irst fail: v5.10.106-cip4)

    2022-04-06T01:32:23.034200  <8>[   95.858192] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-04-06T01:32:24.069590  /lava-6033347/1/../bin/lava-test-case   =

 =20

