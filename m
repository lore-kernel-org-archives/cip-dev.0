Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039BEC4332F
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 11:25:20 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web09.6207.1665487514018098355
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:25:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=l4uW2kAh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id f23so12914493plr.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eFMyHTMX5qaRjsmuxUnHPMqPc6oQgUqA8b1HadUDXS0=;
        b=l4uW2kAh5m60rfEX4TyDprsG31suq6By1pufSM/aiVTko7PIC4QJVMpAOU4pI+96AG
         ny+OTIeq7GINEu1noRmSbXLEWsZOjEtpavmsYjgrkMmA5ufRA7HbEoJYK/la8/A5XXcw
         8z+tpLoiqc8OFEpEjv0XKrufEvzQR+b34peBKDKfwT/cOAJGV2AJaEYxD+ri3D6kU+1l
         0QkB8MMnI0Yd1ROH54v12xlcJuLmhXnTEdLxbXnX2YpbD8IF+uMCXYKDL6We+Ttd12TE
         BVjSeOCVXQyic5hb7s/euGksfaX0J9jtFtlhsMtl15GaCcNK12sR3/cQmtkufB4NfSQ0
         RgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFMyHTMX5qaRjsmuxUnHPMqPc6oQgUqA8b1HadUDXS0=;
        b=upU2H+o2KPPoq2pgNyunyp2AI77/PzZ49fQjk9QjKdYOg297gTG5Fhj2ITPkMqT34k
         mMu1wxbIWwSHZVhISasIe4JsGvWpSqDDb6tAPvIsLXsStZNgbnUudDeEaJFF06whHM+F
         UftiMjk+1v/D5G1ZqoJZPdcfKjMPc+S694T8rOd5GiRenu5aD8+NT405r70sIz86wymS
         XU65Jet376UsGfToC/SWXIg9t4vm36RhlOPaDeGN85lpyzANfOf7DWQXa/sFa7O3Xggz
         jSF3G/8zc6K3zvYR1zwzdAnNg9/gx1Q/Lb90P/9rF5zGj+8cAIFh48owx86v1B5Usg4U
         /4MA==
X-Gm-Message-State: ACrzQf2xJMbQF6C+JTbDjoHbYhoy1ky55nNHtGY79x1EUvhD/HsVfjaM
	Ve9Wnnq10xHFCvS21UJaEhKsOZR+JLtxZ3H81/k=
X-Google-Smtp-Source: 
 AMsMyM6rOYra/Lk7syRyF24hsEjNi0QcyPxb4Fnsjq6MIh4sD9DwEJsjtbg8flChS5phh+3Bu5DsjQ==
X-Received: by 2002:a17:902:ccc2:b0:178:29e1:899e with SMTP id
 z2-20020a170902ccc200b0017829e1899emr23656936ple.114.1665487502459;
        Tue, 11 Oct 2022 04:25:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a2-20020a1709027e4200b00180033438a0sm8122909pln.106.2022.10.11.04.25.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 04:25:02 -0700 (PDT)
Message-ID: <6345528e.170a0220.210c1.d566@mx.google.com>
Date: Tue, 11 Oct 2022 04:25:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-1-g92b5279a8e1f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 12 runs,
 3 regressions (v5.10.145-cip17-1-g92b5279a8e1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 11:25:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9717

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 12 runs, 3 regres=
sions (v5.10.145-cip17-1-g92b5279a8e1f)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
                   | regressions
-----------------------------+-------+--------------+----------+-----------=
-------------------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig+kselftest | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
kselftest          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-1-g92b5279a8e1f/plan/kselftest-=
lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-1-g92b5279a8e1f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      92b5279a8e1f1dd8189276753604ca74c0f32a76 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
                   | regressions
-----------------------------+-------+--------------+----------+-----------=
-------------------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63453f6f7a5ed8d027cab5fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm/multi_v7_defconfig+kselfte=
st/gcc-10/lab-cip/kselftest-lib-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm/multi_v7_defconfig+kselfte=
st/gcc-10/lab-cip/kselftest-lib-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63453f6f7a5ed8d0=
27cab5fe
        new failure (last pass: v5.10.145-cip17-192-gbe875d9d93504) =

 =



platform                     | arch  | lab          | compiler | defconfig =
                   | regressions
-----------------------------+-------+--------------+----------+-----------=
-------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6345402b98f68a7c47cab5ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm64/defconfig+kselftest/gcc-=
10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm64/defconfig+kselftest/gcc-=
10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6345402b98f68a7c=
47cab5ef
        failing since 17 days (last pass: v5.10.138-cip15-90-gd4130d0ee3c7,=
 first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =



platform                     | arch  | lab          | compiler | defconfig =
                   | regressions
-----------------------------+-------+--------------+----------+-----------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/634540fe5653df08e0cab5ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm64/defconfig+kselftest/gcc-=
10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/arm64/defconfig+kselftest/gcc-=
10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/634540fe5653df08=
e0cab5ed
        new failure (last pass: v5.10.145-cip17-192-gbe875d9d93504) =

 =20

