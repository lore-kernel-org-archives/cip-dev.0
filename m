X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.18550.1650526805143700458
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Apr 2022 00:40:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0NhfBfez;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so7034320pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Apr 2022 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=d02hZB+1JbYjTDeYvdjg7g+CWgpouMegt0T+stSlJ28=;
        b=0NhfBfezdBTfJcF2QUMS4175ZvkXcKA10pN7RzT3R+pCQ0caU1i8WRumzrgf/emvjs
         +CrGPms4SRKizXucUFvf7BCwDCm0rvbnaSphdeSj/kv4hkwlw35sv8rOAqItdYtP0hTL
         aqQfPPujl0LzaqSSN2BIi5jcML2qBQ8+0R5rM8ksVO+onG5LnnmhO49dZs167z8NmgHf
         d4gdAxKME4UZPCtJTinq6Bw5gf4wMF4P8EpoYmk2mS2uknLOBMTI189D/iWqj+ILWc4x
         t+KKDvBlV//HA+3X0Pw74KssAF+F+w90GBib24EdvM+KL4qdiV9kJ3sjto0Yv5qYOFUp
         btQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=d02hZB+1JbYjTDeYvdjg7g+CWgpouMegt0T+stSlJ28=;
        b=3TTHrUyuAjeHgD4eAQJ1ROzozyl5FGxQU22UG7coGzfFd4ajWqKxJvdjE9XDTjjEGZ
         MnC/kSv6Jz40rCU9RIrAj1HdCeqlJbhnwSchOVTOKZHTzPzkQvfWyo8LuPmBJOxVw3yW
         oB1cg/yXAwp5mmcL/ZOzJonLzx6FrNsl4XGp0yVs4/cPxgVXi0lBHlGhdCq6XDc0xpn8
         uKrpp8KfZ4UOAF/Y1GFes7bpi8rRJ0ID9DFoFfNWkusupDINKjP/Hr0iYJjPWi4Q9cGW
         SNO0P86YhD91aHsGszrl/zluK/IWF73Mc/ODb60MKKmdbpMKtdf0TuXrFkye6AK+aex6
         PVEQ==
X-Gm-Message-State: AOAM531sAQmxEPgF4Ejn1cvk/BYV2VvOiU1F46Xb1YMyhYne80NHIUT4
	6rlLcVu4Dwq14ICMHiAByL9R4HWqT5uk3nRCb/A=
X-Google-Smtp-Source: ABdhPJxj5I3+D9Lk9MNNTzHbN7UGu60m9+snrRlFZ0SrEfdSHX1eKFfruxKPm3hz3j7xRv8u4UwZdw==
X-Received: by 2002:a17:902:bd95:b0:14f:40ab:270e with SMTP id q21-20020a170902bd9500b0014f40ab270emr23753938pls.101.1650526804113;
        Thu, 21 Apr 2022 00:40:04 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090acd0500b001d5c571f487sm1646086pju.25.2022.04.21.00.40.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 00:40:03 -0700 (PDT)
Message-ID: <62610a53.1c69fb81.af28e.4479@mx.google.com>
Date: Thu, 21 Apr 2022 00:40:03 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.109-cip5-24-g4e205e4287c50
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 94 runs, 1 regressions (v5.10.109-cip5-24-g4e205e4287c50) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 94 runs, 1 regressions=
 (v5.10.109-cip5-24-g4e205e4287c50)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-24-g4e205e4287c50/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-24-g4e205e4287c50
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4e205e4287c50edfe5c1d4c9775b0670bf9bafb4 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62610422497136306d8f77e8

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/62610422497136306d8f780a
        failing since 43 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-21T07:13:16.851624  <8>[   59.688401] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-04-21T07:13:17.874623  /lava-6138283/1/../bin/lava-test-case
    2022-04-21T07:13:17.885469  <8>[   60.723543] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

