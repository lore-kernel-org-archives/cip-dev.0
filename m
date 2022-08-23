Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD16C25B08
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 03:59:59 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web08.27816.1661227198661972769
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 20:59:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=UbslviKF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id 2so11752291pll.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 20:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=NCVG9Rvw6nE8IlvY0UWgYoYpEqNVHaQ9LvYb3uIIqic=;
        b=UbslviKFKSJB8a4ZO49DrUcxjyf1Boa8dsFixkNGioq+SgRiaSi5Gjzg+jR4G50SeX
         YQlc2LVpPXufpYzRGVLEUUtlBXQ4owkdSQ4BisvJWECFJ/9QqetMRegh38Aj38xMxjgR
         4F6HuKns7Iady2lBgplby+JnQgr/2PmbLWo2WPIuohPo5WMxm8z3gLcZQ2o7Mg/iJPTJ
         91WN9b/Xa5VTM2r8+lkbOfTty2zaPBBUcbkkJya9nMTV+jArzi8Ru3IdXaLl/bKWoUeq
         b1lCl6pMupSDbz38m7XzVYJur791rzLZvA0YpEMs3W5663xTsyK4Ub9fz0w9REtW7N+E
         XQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=NCVG9Rvw6nE8IlvY0UWgYoYpEqNVHaQ9LvYb3uIIqic=;
        b=24fLUdnQI0juZsAxQAc8HMTUxve+RIV31KRdwskgtcPknv8AyCZALDSeGm+Cek4zoq
         ZdoaB3dYK8zmYZrDDHqAgvvaS+GxFl/dgKL1apxCYzBXFgv9nfL1JC7ENuHYDzrbnG74
         9lin7Sm8eFLrmwqG9XGOjRnWCNv+L36e+wS3VEA+xn6eQO8gIEI7r127IJy17jz833xp
         IA67UbEbxHmUlUtuLwh0uw1Zs3JAc4vZkFwySnpTY+deTTAk+bQAT92yZL7AegC4T+f2
         W0kSYQZj7b+kD80h3k0wlDvsnQXwJG7LEjbzoQtFOexCNDmUHAfd9iY7Lz7BmNBXIFHr
         6A5A==
X-Gm-Message-State: ACgBeo3ePvt43vZFXHnBJD8XrX0QRnXopLMTSFUGR1DEM5kWybyfDBnu
	MrJ+AvqVhlzulsYPBpiINmu8Q98tapGCIFQP
X-Google-Smtp-Source: 
 AA6agR71Uge7+Viv39Ohmza3z6Tzfk3ctW2LyeTEjnr41guiJ6y3/3Pi50Tr1sDM9gL/Xi5qtCm40w==
X-Received: by 2002:a17:903:134d:b0:172:e199:bb39 with SMTP id
 jl13-20020a170903134d00b00172e199bb39mr9730666plb.154.1661227197827;
        Mon, 22 Aug 2022 20:59:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u3-20020a170902e5c300b00170a757a22dsm9148339plf.253.2022.08.22.20.59.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 20:59:57 -0700 (PDT)
Message-ID: <630450bd.170a0220.98644.04e8@mx.google.com>
Date: Mon, 22 Aug 2022 20:59:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.136-cip14-542-g97767707d3d0
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs,
 4 regressions (v5.10.136-cip14-542-g97767707d3d0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 03:59:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9303

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 4 regre=
ssions (v5.10.136-cip14-542-g97767707d3d0)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.136-cip14-542-g97767707d3d0/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.136-cip14-542-g97767707d3d0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      97767707d3d0aa36cbf6620b216d0d19b9314417 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63043cc320b3a4a43b355669

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63043cc320b3a4a43b35566f
        failing since 59 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63043e7851d09ba081355658

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63043e7851d09ba08135565e
        failing since 59 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/630441bc641703caf6355664

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm/multi_v7_defconfig+kself=
test/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm/multi_v7_defconfig+kself=
test/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/630441bc641703=
caf6355665
        new failure (last pass: v5.10.131-cip13-493-ge129308279043) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6304407b2e4f522b3c3557f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6304407b2e4f52=
2b3c3557f6
        new failure (last pass: v5.10.131-cip13-493-ge129308279043) =

 =20

