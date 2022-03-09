X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web08.1453.1646793365623655663
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Mar 2022 18:36:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zaJiV9FT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso3938591pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Mar 2022 18:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=liVCncAbvCzw1HfgGvTIg4IEYANXRqX2f5BQXvM8OIw=;
        b=zaJiV9FTqF3uIaTwIDvF31lS52Kz02LxfKCvaDYeaflDII0rr6jaHeH/1H33zSXZXN
         /XXK7eRGy944fA1IOQlRNBLDAwlqnYy1cNr95PJTUlrvbftPt4HR6XcFEIyJcgtkgeaG
         Q7Eqj2Yfi7TEN5imGOhUF5BaD7aBwnUG7G5oq6yjRD83KIp0/T7TAhWYHchbfb/1dUVX
         OkMu5POypUb+91Vc7N5OMwsH9+Yd7bEgpVu+3zXgC688iOJDnEPFeDZrvVdngv1XENmo
         IDI5oOwgjS4FjvDIgUXfMPKziu46LuYnlrqS5WmGfUqVQIKyyYcsUvQrVHPj7o3JfuHu
         qT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=liVCncAbvCzw1HfgGvTIg4IEYANXRqX2f5BQXvM8OIw=;
        b=PLCTNTA1puBxYaBWYf58PhT/4nhSmKBfhkDcHwu2pbasekobEF2/V28LuvukP9KwzG
         cG5xoRl4JE+vBYq9R71x0lhIlhfVvSk4dtCX8kZRz1VhnrC/8toQE4Qg3ah9kOPNp50E
         /lEsoOtVrKFiKn0hhrhdp6X2en7G5vXGJP1UPjznf/fmwe2JxEKiY6R91UGU088zyZr/
         ZoAhDBV9xAZkiHJ4AzSzQd0golOtYkbVIbLP3BB4MPqaRcANi0iCsTVZJINhZVHl36pR
         6YND2j8Zrgx+NulrFMCejSpXzfRaoHeUPHxo0eezwOYrxLRUI23JsUs7QQ/S+7X9rDSU
         5E9A==
X-Gm-Message-State: AOAM532hRF+6ZcFcXwft6KpPVY1HT5lkOFjeO/FyYPTRYFOR5BDy9lCj
	JIvj2Z7isw/Mwe92y6MARXcM9MqJuo/8EIapJvI=
X-Google-Smtp-Source: ABdhPJyulV9f9z1cfIts63LOWRJA/oP3iOcj3rVF+xJSbIAhyc1USEZZ/x6tWsYw/604IedSM/zZnA==
X-Received: by 2002:a17:902:d2c4:b0:151:d1ee:a627 with SMTP id n4-20020a170902d2c400b00151d1eea627mr19757794plc.59.1646793364762;
        Tue, 08 Mar 2022 18:36:04 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id mp10-20020a17090b190a00b001bf8453aea8sm410298pjb.42.2022.03.08.18.36.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 18:36:04 -0800 (PST)
Message-ID: <62281294.1c69fb81.b8aec.1c96@mx.google.com>
Date: Tue, 08 Mar 2022 18:36:04 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-425-g0a0d92194f39
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 89 runs, 1 regressions (v5.10.100-cip2-425-g0a0d92194f39) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 89 runs, 1 regressions=
 (v5.10.100-cip2-425-g0a0d92194f39)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-425-g0a0d92194f39/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-425-g0a0d92194f39
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a0d92194f399a5095878cd6edf9060eb4244d81 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62280570639701383ac62968

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/62280570639701383ac6298e
        new failure (last pass: v5.10.100-cip2-319-gcbff87047566)

    2022-03-09T01:39:31.563840  /lava-5842559/1/../bin/lava-test-case
    2022-03-09T01:39:31.574784  <8>[   34.188849] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

