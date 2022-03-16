X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web12.834.1647453606771611957
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 11:00:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=FJhntn8S;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id kx13-20020a17090b228d00b001c6715c9847so996981pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=PJW9Ux1lepCUTQXWi7XLeGHTb6ztH68+lmihwrHStIA=;
        b=FJhntn8S0YW/bLPZ9bu4438TJkPtFGTIvmJR2OaVTRlizcCdtDIyumyG9sctv474FP
         qiwGbHrctBKx4GzSH2OkIJnRLV6MVmgIksuBrJiDn5F/1HgyXwZWvvxumw4fN4WCEPCg
         CXuJzIlLjYsQFI4EEJc09Gyd2iFBMNVWp0GPjAs6OVpuA8sktuXfMgK7hDzbitlqFw0N
         Di0RurRgJM707sjCNzwqNC8WxbuOnioZ7ErhC2ioZOER7DMScbuqNsAvsRlZidl8z3/D
         dk+ZTJPLXbD/pdsMgFC48fwwM5mlP2hcxegw5DsIJweQth09MnblsbaQdrMDTFAaXn5K
         liEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=PJW9Ux1lepCUTQXWi7XLeGHTb6ztH68+lmihwrHStIA=;
        b=2bnVgfln8xmK8qixZ5pCf8CY3CMAJcZ0ltCkO8R9z2jhjD0wDcTrdc2mQSn6d0aJDN
         dBo6IWcTaXpsU3SExSbLg1TWmQrBHUEcVTROX77lXTnt8oJlIj4IzNg204M70tJIfTMI
         OL0oVVRl3OlHCyeubVJCxg5EjK01Ugw76UqmjaUHWe/i7Md4K7ymE/Tbo/OFB8kSHpbM
         PttvAL/hiajSkp9RXV2r3UjzGyBVGZqSg9oDVBfwaONDkaHfz5pHUk32fJw181739AF6
         nmLsC1lUOZ3CkBlg9dEOKLIvSu6pd5x3HIcaecdtg/oU/x8/t7pj1Ymu3WzSuzXVxlHo
         5STg==
X-Gm-Message-State: AOAM532qj8ZVfk6lCP6PxpOpzfAl9aUe+tScVBCZuSx3XDX8OYxMe5pv
	b8sVE5MrC3I01MiPpOdcb5i+FtpAGP7pwh8uBcc=
X-Google-Smtp-Source: ABdhPJylawqQHmp628Jjs7SwjAsIpHmyGecUVDEzOySa686W3J9bnCm8Txhu2zM3LwIKnjc12BMQGQ==
X-Received: by 2002:a17:90a:1197:b0:1bf:65ff:f542 with SMTP id e23-20020a17090a119700b001bf65fff542mr11288639pja.5.1647453605801;
        Wed, 16 Mar 2022 11:00:05 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b001bf6c74bdd2sm3257366pjj.1.2022.03.16.11.00.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 11:00:05 -0700 (PDT)
Message-ID: <623225a5.1c69fb81.f0d0e.83f6@mx.google.com>
Date: Wed, 16 Mar 2022 11:00:05 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.233-cip69-62-g10346bfb0fd8
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 64 runs, 2 regressions (v4.19.233-cip69-62-g10346bfb0fd8) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 64 runs, 2 regressions=
 (v4.19.233-cip69-62-g10346bfb0fd8)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
meson-gxbb-p200  | arm64 | lab-baylibre  | gcc-10   | defconfig            =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.233-cip69-62-g10346bfb0fd8/plan/baseline/

  Test:     baseline
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
meson-gxbb-p200  | arm64 | lab-baylibre  | gcc-10   | defconfig            =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/62321d6502265cdb18c62975

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62321d6502265cdb18c62=
976
        new failure (last pass: v4.19.231-cip68-123-g92e3e7f3d4df) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62321c8a2320136709c62968

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/62321c8a2320136709c6298e
        failing since 2 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b,=
 first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-03-16T17:20:55.860287  /lava-5892177/1/../bin/lava-test-case
    2022-03-16T17:20:55.868916  <8>[   36.842690] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

