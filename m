X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web12.3737.1649211389023894008
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Apr 2022 19:16:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vJUX8X+C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id o10so731054ple.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Apr 2022 19:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+zW9cpA0K1wJtNi+zPzqFpZe79j9s/pgU0PO69AW1M0=;
        b=vJUX8X+CZPbm4SPhwt+/PUZRL4DCVENR/7zd1BG0Tz7Achm91jhXbh9JfqoBp8yYwv
         XgRUG8HRfz09ONhZnNikb4HuAzjXsDKSA33CYPzVUFdQlMjO4iMyNfVvZlETO2PZsnZ/
         c9piajuuKDxxgr/vD19PZmSxh8rckCwMiuV5KCMSTAA+xzflJqtajqUspyKC2pTVZw97
         NLcKwjfP6HtFaPFwjb2dIagB1gjUDQ+VdfsGNnujw8ZwyablRVwOskgk/NU8iGYjp5Wo
         SfXSrTEEiXlC0dHEw4DWI5+Ql+Bti5c4jkvXMqCoBt3ty9zdYTGc7a9+EKbM5m+giG4T
         Iq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+zW9cpA0K1wJtNi+zPzqFpZe79j9s/pgU0PO69AW1M0=;
        b=jV+G8DbCP5CPY7wVApfHOBtfFgAxk9Zqtxgd9QyNWWiAiLgLEbMngVUBM9vkMT9kUn
         7G/ykLSPTMbUIz1DlkJMKWhuKIY7343lhXGPp4rWxkmZb4AkAYwfrWoQEypFIOqogP1V
         jWInGwgH97AP/qG/tJoqV8aswyb9Yn5O08PzwMWJN8Y9dwtNuIHblEHeEgJ5M5QYLFJB
         +Ziy2w33pdb0X0njsdiSQTsn1TYl18wFt8rLOhyKH2hdeVGP695fJ99DqNj/FX8IINcv
         /ecoicKF9T2zS8TmafZg6zrghWwXt2m9SXf7j6xBY8/qJz19+jqXeuTWCN2nLf7+qmaQ
         C5gg==
X-Gm-Message-State: AOAM530xfyN846NXZn0RYJISqGGO5P+Q3WKmTtyluz726dttQWJL2QdJ
	whYRqws5yycBL6wfvO+u40sqaTEf78hM7vKSuW0=
X-Google-Smtp-Source: ABdhPJwmJts/GH+uLlsoA9Bg6QJzOuhQ4HDDMJSKqOVCMeTu9yYQhdD+1fKtNFRueFQkE5FigGDOuw==
X-Received: by 2002:a17:90a:5983:b0:1c9:ee11:76df with SMTP id l3-20020a17090a598300b001c9ee1176dfmr7429722pji.95.1649211388111;
        Tue, 05 Apr 2022 19:16:28 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm17814970pfi.149.2022.04.05.19.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:16:27 -0700 (PDT)
Message-ID: <624cf7fb.1c69fb81.152c1.fa87@mx.google.com>
Date: Tue, 05 Apr 2022 19:16:27 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4-66-gc8c4cc5cdb54c
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 66 runs, 2 regressions (v5.10.106-cip4-66-gc8c4cc5cdb54c) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline: 66 runs, 2 regressions (v5.10.106-cip4-66-gc=
8c4cc5cdb54c)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4-66-gc8c4cc5cdb54c/plan/baseline/

  Test:     baseline
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
beaglebone-black | arm   | lab-cip       | gcc-10   | omap2plus_defconfig  =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/624ceb93f52450e009ae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/624ceb93f52450e009ae0=
67d
        new failure (last pass: v5.10.106-cip4) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624cef32df45b54390ae06af

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/624cef32df45b54390ae06d1
        failing since 7 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, f=
irst fail: v5.10.106-cip4)

    2022-04-06T01:38:33.873576  /lava-6033354/1/../bin/lava-test-case
    2022-04-06T01:38:33.883716  <8>[   33.819328] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

