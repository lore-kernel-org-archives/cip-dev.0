X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.32467.1638666073733842868
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 04 Dec 2021 17:01:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=M/CTDiiP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id z6so4674651plk.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 04 Dec 2021 17:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yyBNT+4EiSG17nm3umVALTheeRq/4zVhs8ItrXNhE7I=;
        b=M/CTDiiPVIMSZIcPEuSxLTEMv7+VMYoewxNmYe63EVn3Q5X3PYz8/0oXDhAbMAFhWE
         pNwstNxzkbqse0604cp/cxIK4KK+ksqmrA5g9SPG0kLnlcDTYtWmJqxqQAurPWyHZ/z8
         QHH9Z5RNbSfpUS/K8B/E5W60Sos397Cqg9OOyYtrHOCS7qePY151CAR6c2nveQEexOiN
         bFRMg0xs8JK8kV6xJ2na6uTpGUCqrc4ZHS0CUyg/Z0kvQBnUKCo1Ez91KaONcEsogcfV
         cFKC0NQHSZDw6X6ZrQi83CFwdzV4bmF7IDRpiTVfWqMKJjnZNX0i1ppDWcTNe8HH4Fwi
         UvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yyBNT+4EiSG17nm3umVALTheeRq/4zVhs8ItrXNhE7I=;
        b=vTOFwxCLKEnIUbsTGUD8f/O75mCjTv619FE39LJtz/lArlImPDyVOEL3S7w1BeL196
         DS0BURRwIMP7cVy6wd96zFRteyu2RfhfkmoMNlKU3HXuhBk43eYKtOQy9HwYCK3g8YYs
         x8XL9szt5WVNM4uac3DmKN9TcwXVXKH5YgKr+X1VuVRC4LitD4HWMjxsyGCFFO88kH+8
         R+h/0RiWP2TiMYvHSCLbYJGV3d9xqwf1xI7s+1kCUdShgeBemW05DSH3BGhpLuyCpjJh
         sr52HwFmFL0f1VNVYgxB3mGfwSRQIJ8iCln2f9yQOryZ8PcJu91UbrScLjxJ6y0U6m8V
         ErbQ==
X-Gm-Message-State: AOAM533XXrAjb+lqlyJyEH/A/wo0i8V+WDpNCzxG3E4qo19JY46t+7b4
	NRvJCcdXbn47Ddro7BWt9c2jAi3sH1zP7GqP
X-Google-Smtp-Source: ABdhPJzqAHtdHotlHF5fvUsM47IzJaUgyxAEh8xlgRYUJKWX8+qmHyAWVDZeSTWF70T3ZPx/MdFZ1w==
X-Received: by 2002:a17:90b:3ec1:: with SMTP id rm1mr6842059pjb.171.1638666072973;
        Sat, 04 Dec 2021 17:01:12 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a18sm7189851pfn.185.2021.12.04.17.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 17:01:12 -0800 (PST)
Message-ID: <61ac0f58.1c69fb81.3be52.5d0a@mx.google.com>
Date: Sat, 04 Dec 2021 17:01:12 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.83-cip1
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 12 runs, 2 regressions (v5.10.83-cip1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline-nfs: 12 runs, 2 regressions (v5.10.83-cip1)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig  | 1     =
     =

beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2332f07a324fd78d7c7436deeed23cd7db441ea7 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig  | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/61ac050fcc9fae60621a94af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211126.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/61ac050fcc9fae606=
21a94b0
        new failure (last pass: v5.10.8-8301-g3d6168cb89f6) =

 =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/61ac07e00a190a3f881a94a3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211126.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/61ac07e00a190a3f8=
81a94a4
        new failure (last pass: v5.10.8-8301-g3d6168cb89f6) =

 =20

