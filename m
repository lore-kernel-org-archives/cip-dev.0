Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087E2C61DA4
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 12:18:14 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.51742.1675685890930528220
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 04:18:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OqKh3owC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id a5so5197014pfv.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 04:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b5EN3zn240JCyz0jW/rjjLDrPXDxX/f5H45ZUeJNnv8=;
        b=OqKh3owCU2wKWTA4I7Kpe36uPW7fbuhSWaYvgMdDASNye+9gU1el6sSJVAP5ut4XsV
         ATZStwl7HldA2P/h70KYetNpsHgkwTxdVGgZSFjq2WbyPkimWqOQSMgCqq+c93kzenm+
         cUkIfU5erQPKKZY+4ArRTMUflUT2vzrFlLcsq+nIt0cq71DpHAxzHJICNGekPAWtt6ui
         sIJSIs+hyY+EOcA5Nfn+pyDITjYcLMQU9i72H61i4uH+BlsdYvfikNb6OPEnTuD5b9ZH
         7JMm83vh5hy7Upl0//v9KYulu6q/YwUlzPn8IJKyeuzxvAuvP/muaoWvAkV8RbIVcI7f
         w7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5EN3zn240JCyz0jW/rjjLDrPXDxX/f5H45ZUeJNnv8=;
        b=Yd/TVEmx1AHI+AfJMGgVI7ancQReRCbVvOILSlAUDVXp5IC+XcutuLNcKIgKFhUJLk
         nkHsLaDByTkQXTslzCjHKSbD9eJBSIXU3xjmh+uhc/czfkkK63WrV/GxBpTsB8MRlNdw
         r34cMmvBLisnAChxnXIPyiXllXELC42uAoabXiQPpcbylBaBTwlJEecy4CLsdCRAUqzS
         sBB22sKnfB4NDmJZHJMKyew/dXsbc6N8QkVtd81+RFbpyalT2fhoTa99efBFysExkFxT
         jlKVa+ni3dq6g3j+S9Dt2Q+GNYQfP+mrPQYTpfjtT5ylKtycTKIjBaNJ1GOf3rZCKCXN
         Knqw==
X-Gm-Message-State: AO0yUKWUBT14A0MchcmZaahcf4WcSa51Xe4s17pdi+whq9adCirpB2cx
	V1/RJBXJ0k4jvBNsd9OTU5DOIvwYhyIxKhGSCOUgaw==
X-Google-Smtp-Source: AK7set/EOLiGdrcq8twCJivIshGKbwrkNfGpzD56ReI91y3o1/ouo6mGkKptW/FqiqInhapJPPCSyw==
X-Received: by 2002:a05:6a00:4c10:b0:593:adea:6805 with SMTP id ea16-20020a056a004c1000b00593adea6805mr18711081pfb.12.1675685890095;
        Mon, 06 Feb 2023 04:18:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u10-20020a056a00098a00b0058d97b624f0sm6890224pfg.75.2023.02.06.04.18.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:18:09 -0800 (PST)
Message-ID: <63e0f001.050a0220.f8466.ae55@mx.google.com>
Date: Mon, 06 Feb 2023 04:18:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.165-cip25-154-gb7e05ba4f61a2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 76 runs,
 3 regressions (v5.10.165-cip25-154-gb7e05ba4f61a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 12:18:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10599

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 76 runs, 3 regress=
ions (v5.10.165-cip25-154-gb7e05ba4f61a2)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
jetson-tk1                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig  | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.165-cip25-154-gb7e05ba4f61a2/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.165-cip25-154-gb7e05ba4f61a2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b7e05ba4f61a238b39854406f0889bab2b4fb757 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
jetson-tk1                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e9f25e09ed83f7915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e0e9f25e09ed83f=
7915ebb
        new failure (last pass: v5.10.165-cip25-144-g43e1d8dfbb26) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e7975300418bf4915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e0e7975300418bf=
4915ebb
        failing since 100 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-468-g86403a07ae1c) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0ea17ccb664fc75915ebc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e0ea17ccb664fc7=
5915ebd
        new failure (last pass: v5.10.165-cip25-144-g43e1d8dfbb26) =

 =20

