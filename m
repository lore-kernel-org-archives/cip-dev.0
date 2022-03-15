X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.4622.1647303664723266718
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 17:21:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6Cp2xE4n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id s42so16871660pfg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1BS7cbirV7hZNr1f4e3ZKf4jLbM0i89L+tuDcjNUQDY=;
        b=6Cp2xE4nHltv/H8Gh6/Imb6JiAjWUKigSMGLmgI4tWlWdKPcqdALhtDZBkucL8yuEb
         REG2cjdKaamPEu9fY38MXJVU3vbEESqIXHu78OwQ09efA0I6glZJL5WiZaHKvOUzesR3
         5uUUG3LzikpkqXYkgFBujL7T5V0XZtZ45ASXZw0G5iccfovXFamPjnMrqe9aek1V5ZZC
         7W+XSSrJlgQ0Awh/ru6KAS6KuhMWidWS3+oAw68/efx0V7qh3MJsr30XVs2hkasjQWUv
         zVISuBO3Ta7cjTveLiSUOFzWC9JDFT4v4aIkUfdcd2DzNisuOsJFDTcX1xcFDpbVt8FX
         ISog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1BS7cbirV7hZNr1f4e3ZKf4jLbM0i89L+tuDcjNUQDY=;
        b=ikp0IW1uUQpSh6DknmcGuLFWOZ4PpS06sLU44+y8MyeSxTG+VX+UADcxx21sCOoC0Z
         Z52P14BQgyDN/K9jVhMTxuuWZXfbZBtUm6cmGK1r4bR5vqycMlenm+BA8II1ftD2nRiu
         WRDSlCeQgW8gJs0WNOdIsMV8mhB1/COKqLI4cDFfvSVBEkBlYwxWZOp5c3AuOrfw29+G
         4OxSR3QUI0a9vscdctbsIff63lcdEQmj5Z+k1PKeLV0I19aTJLvdP2SxlC7Ut+xXQI1P
         6bN+kyzRvHfjYHBzM1zATyoB1CsbLrrWpkfCz1BCxhJT2t+7c2jOSsVGC74Q6tU23r9w
         aPGQ==
X-Gm-Message-State: AOAM531fbSiE+sNcolghiefdQR0/qrsK0EXWpAPC7EOwdTyJsAec0rD0
	Pdj4I4jn2GoAvQGUTWweUAfQ1FaF/LMm8x4HxGU=
X-Google-Smtp-Source: ABdhPJxXtq89CHPyLz10/villCqLDgr961v8fAVU+Kjj4hpTeLL3w/KRVSdeQP8hQTOKLFuQBaazbQ==
X-Received: by 2002:a65:6e09:0:b0:380:4723:b4e9 with SMTP id bd9-20020a656e09000000b003804723b4e9mr22645961pgb.346.1647303664030;
        Mon, 14 Mar 2022 17:21:04 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r32-20020a17090a43a300b001bf48047434sm637154pjg.32.2022.03.14.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:21:03 -0700 (PDT)
Message-ID: <622fdbef.1c69fb81.52456.269c@mx.google.com>
Date: Mon, 14 Mar 2022 17:21:03 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.104-cip3-rt3
Subject: cip/linux-5.10.y-cip-rt baseline: 44 runs, 1 regressions (v5.10.104-cip3-rt3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip-rt baseline: 44 runs, 1 regressions (v5.10.104-cip3-rt=
3)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.104-cip3-rt3/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.104-cip3-rt3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1105279cf875fdf297e0225252cf3e595105a831 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fcc8f2e1b3e2142c629f8

  Results:     88 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
104-cip3-rt3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline=
-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
104-cip3-rt3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline=
-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/622fcc8f2e1b3e2142c62a1c
        new failure (last pass: v5.10.100-cip2-rt2)

    2022-03-14T23:15:21.421902  <8>[   31.567338] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-03-14T23:15:22.375495  /lava-5879827/1/../bin/lava-test-case
    2022-03-14T23:15:22.388799  /lava-5879827/1/../bin/lava-test-case   =

 =20

