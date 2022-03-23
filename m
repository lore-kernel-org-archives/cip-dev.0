X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.10039.1648046203821282537
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Mar 2022 07:36:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=swBe7SWn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d19so1646697pfv.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Mar 2022 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XJGCV9xmMVsricmSvh1JQoJAfILCsZEwTS9rt5AKxSY=;
        b=swBe7SWnhIUvfzdAz83RQmrNV4tm/QhbK7uWPSklc9Fn/SnIE89ZFeBsL+itTy3Vr9
         2Yn0qoi0Ltj0EYXzrQj8SZCRtkYOJZr9t3gmD1LhMWdRItz4w6HDIH6V3vOipBX5JfwP
         GG+GSw7WpJ12L2Vm6VvlGaUD/09GcCEbiDSb38GBp5zyGpuBF8ehjw85/TpLcQ6ml2Hs
         zURXZm+GutP3JPTW3OiQUymj+HCewXmCi0TTr4SKthmAlA8TZfb5rs9TrAF3DIHfl+Tz
         ekGWGvq30+xVZOlLpG9A3xnCjZsaWyWYEqRjAgbCCXYCBAiH4iJn1DX08xL2wi5mRei6
         epIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XJGCV9xmMVsricmSvh1JQoJAfILCsZEwTS9rt5AKxSY=;
        b=WM/+ELqH5Cn66bxTjatjdkj0UuqRyJlxEws1UIKhkaN8gbFC6GDDdx/89E/EIpUPe2
         90PkoflYdZXk/scIu/LcMaYoUwz7WuRYRHkE5HmaYuBrdUTxiGdlRi5Tuzei4iPXKh7o
         wCtPCHWQn75HowkmudQKBEHNdmA/0X3X10i8Zq05GQrxFISAWLts1lpLzuBq5A70OxmL
         lAuacpvedL/Z/eqKREeaOXkV6EcCfPDNib+hLBeiuR6+qNeTtWGDzMg6PmEi1WE72Viv
         6z8iKH8BSqmUeVlRP/USA6JVbUOeyT85rN1C8hLNecHbmPkUUlMqr3ntV46ook29GpV3
         KjGQ==
X-Gm-Message-State: AOAM533CYM2TNskcDYFMuU/zHvIjv55qdQMWcXTn4lnTYYHkRfW7ary9
	amC+7gVaO8yldOzyXJlwaUE9D63/6FuX+1v13Ek=
X-Google-Smtp-Source: ABdhPJxeWz95XERo53MjAVLiOZGCui3r62CfiOCIGcUsshIr3trAWknk08Q/ELatTQNpA1Amwby83w==
X-Received: by 2002:a63:9d48:0:b0:378:c359:fcbf with SMTP id i69-20020a639d48000000b00378c359fcbfmr155516pgd.371.1648046203168;
        Wed, 23 Mar 2022 07:36:43 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b124-20020a633482000000b00382347caeeasm103556pga.22.2022.03.23.07.36.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:36:42 -0700 (PDT)
Message-ID: <623b307a.1c69fb81.8931e.04a8@mx.google.com>
Date: Wed, 23 Mar 2022 07:36:42 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.104-cip3-186-g758e0f22e236
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 7 runs, 1 regressions (v5.10.104-cip3-186-g758e0f22e236) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 7 runs, 1 regress=
ions (v5.10.104-cip3-186-g758e0f22e236)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-186-g758e0f22e236/plan/kselftest=
-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-186-g758e0f22e236
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      758e0f22e2369c3d29d49c89c4ab585390c74a82 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/623b2a53d5ec79adf4bd918c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig+arm64-chromeb=
ook+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig+arm64-chromeb=
ook+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/623b2a53d5ec79ad=
f4bd918d
        new failure (last pass: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20

