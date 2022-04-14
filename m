X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.6452.1649899346512508457
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 18:22:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AgiIUeau;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so7869162pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lfAqljAmrthKWVchOfvUb/6T5x2WX6Mdw/1WDoRl2JI=;
        b=AgiIUeau69uZg8J/XBxugHzI5hUtKW/UBY2+JhV8BSRBCvc1rRqjXPZfLvgHMtGj/e
         lhKxw7pWkZM1QJqwziI8pPNyEfULqR+Cu1qh/OhpPN8gWBB++MjeMUfPS62NmLM6y2wp
         hA5ey1z6tzeybGPOS22EbDD8AkS8gG2Do2/qZLEtuwD7JiYAT1dHXJIyd8JVWq0Biswt
         77QhcgdRET+OcrWYQzgCuMY3HWFlkR7CSjHQMkJX0DEDOH8jiNlxraaAcXgGLeTeTScn
         +FPQYId5Vv/avFc3KoRoNmkC1FkES732G0Zmptu2l3oAASWVgzWNGOAAe56LuwLTMapP
         7qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lfAqljAmrthKWVchOfvUb/6T5x2WX6Mdw/1WDoRl2JI=;
        b=rFYiYbXrL5lLAVqNAM6q2ZuA8gl8fUU66sV34BU6kqBTUGk9mpw0fE23ZjukPwuBaX
         0Hjb59HlwCj+KXmU4DSqPSxWZLUcGkFsTK0PT/CrjQ06exU+Pnr7W52OMlNcDF/uggLT
         ZNAXr7uh7NvoYl7mj6HZeYdoH/xmc1ACq02uSYIrH6GVY01AR8S/crYVV23Bj2AurPDE
         3V+pkeOFwuNJNUi8aCABhP8H6jR09uSSHeqZex6MhI+GOKQA79OKpv8iwIyck2Tmfm3P
         YQETIwRC/7YjEWWNL/r4dqwKq1nxftXiSw3eobgj3Wuk2tUbTyx1pUindz+nLNjHXbR/
         uhIg==
X-Gm-Message-State: AOAM530/Zz4NEj/pjja8liC2xnx5CXC2YGOaIsyvqRotXTF3//nMjeVU
	nDxEoGiwWvIpN85WG5go8KE/SIa21sa1bxFj
X-Google-Smtp-Source: ABdhPJzbRNiQHpc2kFCD1ZndVLbGmXezDu67ySoFaACKQoPg7/YC51e6HpD2PQOtEo75IC12WnUZXg==
X-Received: by 2002:a17:90b:4acc:b0:1cd:37de:3baf with SMTP id mh12-20020a17090b4acc00b001cd37de3bafmr1658468pjb.194.1649899345810;
        Wed, 13 Apr 2022 18:22:25 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id pi2-20020a17090b1e4200b001c7b15928e0sm4461447pjb.23.2022.04.13.18.22.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:22:25 -0700 (PDT)
Message-ID: <62577751.1c69fb81.2c26.c258@mx.google.com>
Date: Wed, 13 Apr 2022 18:22:25 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-770-g2801336f0f208
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 64 runs, 1 regressions (v5.10.109-cip5-770-g2801336f0f208) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 64 runs, 1 regressions=
 (v5.10.109-cip5-770-g2801336f0f208)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-770-g2801336f0f208/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-770-g2801336f0f208
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2801336f0f2089b0d935efe67d93eccaa85e4bec =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62576f72c2f8fd169eae068c

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/62576f73c2f8fd169eae06ae
        failing since 35 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-14T00:48:30.867654  /lava-6084517/1/../bin/lava-test-case
    2022-04-14T00:48:30.878978  <8>[   34.095151] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

