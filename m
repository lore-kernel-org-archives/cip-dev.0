X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.5167.1648551976067035312
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Mar 2022 04:06:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1w5mQSWx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id s72so14504622pgc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Mar 2022 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rDYBb7O9SBKCdlvqgQdIpEtIHBJAwPgnBeJV6UeLITs=;
        b=1w5mQSWx0LYZH6hpA6HUtdyiCSlR7D90IT4Kn0gfDT0nzlSc95UIiVA57SHHi/zNjI
         dFvyGajHI0krcE/lrOqtbETccqOHZLPl6lVDi4lpHqKH7AUPnTmfFKx1HaSYjVZXwmdv
         fiA+RHP9bVocTfSiqt3FB1XNKpyerI82Wa0PgnoUBo5qtNKJxXsj1BLzdW3QCVHe9gpm
         3bC7GocO2m4QcJtqJRO/CRMWNomBsWV6n7wV/YwPF0qs9oMRUBjhe7wY1Z1A8J7f0hpX
         XHoR4XD/G8eczOEU2EItW9mp6qWV+AxBpQoloz54BvkPWoRnhiexlD/3n/ZXL5T3m2N7
         6yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rDYBb7O9SBKCdlvqgQdIpEtIHBJAwPgnBeJV6UeLITs=;
        b=3fzanX282mLqAFciNrn/qRoaqZUfgC9qkSxqXequ02PuWupQuI6aZmM4AZUOCQ8210
         bmyegqS862iF5QxHwfxPU4u7S8COAAWu7FbkhP4i1LbYoFJN7BZ62OpKtL/5LQ1IA2XM
         yaHqu5mwsmz6NjUI16LQbS7uBpLqOWFHUE7V55aogRN3ry1WRQ0Fz5Beqy9mlafF6exL
         W5CkpiSzqWqdCla8lgklmSAHY+FI2ZJ4Wa1qPJjBC9obvoT4rTWuYIilV40cJppk2erx
         wD5oiLcrii442+XV1HUEuJsncCVLLD3I8Ru5yy6iqreI+ZZinFPACRoGHfQRwyZScbKe
         tJuQ==
X-Gm-Message-State: AOAM532oDWkm5y56a6AlmhTdnudIVb573wyDdV3gUvYmb/4Q8O5WACwd
	lBLbXzkw7j0ImqHdBCQxDJn/EODIdHAJOkaF2Do=
X-Google-Smtp-Source: ABdhPJw68sDWYQQKp1X9/E8p771YxRrX5nCBGLUmD5CpzRRxwakbJMu/b6A25L8x5b/cdVOHV0W5eg==
X-Received: by 2002:a63:4e:0:b0:37f:f3f0:2d24 with SMTP id 75-20020a63004e000000b0037ff3f02d24mr1602105pga.526.1648551975329;
        Tue, 29 Mar 2022 04:06:15 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a680a00b001c7bf7d32f9sm2535563pjj.55.2022.03.29.04.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:06:15 -0700 (PDT)
Message-ID: <6242e827.1c69fb81.31338.6d4c@mx.google.com>
Date: Tue, 29 Mar 2022 04:06:15 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 16 runs, 1 regressions (v5.10.106-cip4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline-nfs: 16 runs, 1 regressions (v5.10.106-cip4)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8bb6e30b765989a3c0924158316d689e16317cd1 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242e06ce5676f1b00ae06b9

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk=
3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk=
3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220311.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6242e06ce5676f1b00ae06da
        new failure (last pass: v5.10.83-cip1-178-g2cf1d12aab81)

    2022-03-29T10:33:00.689071  <4>[   37.252292] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-03-29T10:33:00.699099  <4>[   37.262907] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-03-29T10:33:01.504897  /lava-5969081/1/../bin/lava-test-case   =

 =20

