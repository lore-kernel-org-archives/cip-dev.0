X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.19319.1647204820844957427
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Mar 2022 13:53:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=e99jfXUG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id r12so11942591pla.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Mar 2022 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/MthddlzhMTkqjH2MZsLcYA7IsZOrIcRxaPiAqhN9xw=;
        b=e99jfXUGC7l3lLtd/O93eQyrQn7RfhZ9w0YiOZZ2CnqWcGYGwUg1k+k92XL1uO78Vj
         S2JDR6n4dlLpQI6YHRqN/TSRCB2Hkp7Ehummh2035Npp3a5M5YC4zYxuBTSrWcwdA9mO
         MSzjizEckaL49I/otqCfKuNmQuDou1EWAHF7OHCEjmcsNbRnHj++OLmi+sFZOdSalbaC
         BE8gjvFBgedUHahXqSjlA83ouRkGhAy4xiOsFLz4xCAcgJTxZ3ANKfDTr0ulaMKYmDO2
         TbKez9Qay4xpO5bQFKGQeoDPgZUIFsrCyKDvHde4C60VrVgB8XL191OucFSxQxxukVMi
         sPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/MthddlzhMTkqjH2MZsLcYA7IsZOrIcRxaPiAqhN9xw=;
        b=E+vXPlaHJVwrFsP0jzeaKHfXva4PhxFrNKjAqINUkJHxnrKdUpMnpC7eDPahMSamkx
         dglxOaH4RDe5bvhEclzDZFybJXj04WhppiZP9PQdsZlHg+UIUfEsaIjOOPJqC364WRoH
         akfqBH1eoiULfdpH7EQQytf9i5P9EC+4MqH6I7JxKnx49itBwDu1XRd2+hXV8EKqAOAX
         YpTxuf8lmdLAJVS2tPCAAHi91o4oYguVsSB2PZbKIvCx2DAhJl9/+WTEu5oMlUBV4PXk
         bFvh9oL+QfWYI1ecrM6DgS+W8QmYB6YXtLiJUHGmugE1cKJwoJVDO6j1D+89rTWf4mT1
         xegw==
X-Gm-Message-State: AOAM531Awpyn/NtnOHMw97mY8JRWITZWTGt+gRuBuNpEA88NRiG68iG1
	yqF3XstbIQSERRmKly93fu8im5xQlfcFKMk0Qqs=
X-Google-Smtp-Source: ABdhPJz3Ob3WRhJuDcZoSom9gOy3KzsEewa8FrZLmte15zO19iYVsl9hPJhExC2jETV7Qdn7TpUbYg==
X-Received: by 2002:a17:90a:fd98:b0:1be:eef1:ef40 with SMTP id cx24-20020a17090afd9800b001beeef1ef40mr22031992pjb.143.1647204820049;
        Sun, 13 Mar 2022 13:53:40 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a00238a00b004f79504efc1sm8873966pfc.214.2022.03.13.13.53.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 13:53:39 -0700 (PDT)
Message-ID: <622e59d3.1c69fb81.9562d.4dd5@mx.google.com>
Date: Sun, 13 Mar 2022 13:53:39 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.231-cip68-123-g92e3e7f3d4df
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 70 runs, 1 regressions (v4.19.231-cip68-123-g92e3e7f3d4df) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 70 runs, 1 regressions=
 (v4.19.231-cip68-123-g92e3e7f3d4df)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.231-cip68-123-g92e3e7f3d4df/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.231-cip68-123-g92e3e7f3d4df
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      92e3e7f3d4dfeddc69231ba7a1a4f6b0bbece2e6 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622e4b3a83c02d3c7fc62970

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.231-cip68-123-g92e3e7f3d4df/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.231-cip68-123-g92e3e7f3d4df/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/622e4b3a83c02d3c7fc62996
        new failure (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b)

    2022-03-13T19:51:02.877483  /lava-5872190/1/../bin/lava-test-case
    2022-03-13T19:51:02.885700  <8>[   36.859889] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

