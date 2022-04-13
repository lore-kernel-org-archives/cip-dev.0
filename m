X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web09.9.1649864899261382673
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 08:48:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=E6o/fd+E;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id y6so2326748plg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hO6dO8WUgt8To3kxQNdR6Zzn6Vqkkyr7LBdcoq9tOcY=;
        b=E6o/fd+EZS4gwr4H5p7V5adI4cgVRM0YWcJKlDkXPU+jB30ezMgOOJMza2ctT4BWHo
         YCBc4LWeaw9xH4sFZK3UnWbUMJCRLgDxH3cIarh3VJCgs2rMqaTFawDIMH/l2drKQ1Qw
         25NNe7mep1mH+vPKkbk0dBU2Sl6Fu185nXB2hvRxPakczWYYUJTJccNI+qYIzEqPPTxu
         j9vHJ2ykw62fuz6TM3OJW9YALlwanNIBSMzpow7BVtthcw3jeQd3eA+nQr6kJcwpNBeA
         euAUciMEDyOSWBp5m/gtRES0vXCfgVzG6rALfOne5vqppNnd71cI9F+y5/mQaz6FsaeZ
         vb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hO6dO8WUgt8To3kxQNdR6Zzn6Vqkkyr7LBdcoq9tOcY=;
        b=UHUhOpcD9ysMpXORjN3fCAJte+ltgDXgvELTcF7CQwCopMU4Aivp8mw9HVT+MooLWY
         pFQ059gqPnE+xy6yzkwmaNb4mSahx4feJT1Z9efq7c3D/ss/JTZ8wuZYwambxfliy3oa
         zgazhpkFove+GG/7HON7JgIjt7/j6gMEW3TNPgiEtstaA3iLjrVeciSSavFO9DXJqeKU
         KoNEPUGYPj9Letxz5IoRbgguicPXETaTwfaFpVHRe9fSp0ko4CJ6Xt1ewLZW9DRKYQXl
         fe5+c1rmHc2ZPmLz5nffk7SBuU2q87kzI+dzc4D789Hp2tu0pET43Z3dCBT6NRXFt8Oo
         21+w==
X-Gm-Message-State: AOAM530UmGn0H/3qQIwymEyYiVFtxd9TIS94lJNWO4S7VVuDXWi/v5kf
	4IK2nBVQqideZSov/kTCMlJXyCIbdE/dnzwd
X-Google-Smtp-Source: ABdhPJwMa6VrVXNot6f1Wub7+gF2q175BqrPN45XlP5IhRS7BGdEurg2uQX5euzyimuLv3Br6cUhpA==
X-Received: by 2002:a17:902:70c8:b0:156:509b:68e3 with SMTP id l8-20020a17090270c800b00156509b68e3mr43769380plt.113.1649864898646;
        Wed, 13 Apr 2022 08:48:18 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a001a8b00b004fab740dbddsm42778741pfv.105.2022.04.13.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:48:18 -0700 (PDT)
Message-ID: <6256f0c2.1c69fb81.500e1.ecd7@mx.google.com>
Date: Wed, 13 Apr 2022 08:48:18 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.237-cip71
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-nfs: 8 runs, 1 regressions (v4.19.237-cip71) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline-nfs: 8 runs, 1 regressions (v4.19.237-cip71)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.237-cip71/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.237-cip71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      281476f1d7ee9f59c39dc78e7adb7238cfa54bd0 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6256ea3b388b5ef1b9ae071d

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.237=
-cip71/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.237=
-cip71/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6256ea3b388b5ef1b9ae073f
        failing since 15 days (last pass: v4.19.229-cip67, first fail: v4.1=
9.235-cip70)

    2022-04-13T15:19:55.867102  /lava-6078896/1/../bin/lava-test-case
    2022-04-13T15:19:55.893127  [   38.415545] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

