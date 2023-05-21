Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386EFC7EE29
	for <webhook@archiver.kernel.org>; Sun, 21 May 2023 09:55:14 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.5175.1684662908023537425
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 21 May 2023 02:55:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=wvLklwbZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-52867360efcso3388581a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 21 May 2023 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684662907; x=1687254907;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q0ZuE9IVmhVeXdzIfRJwEOuxKD2TmQfoqHMok2b2LVU=;
        b=wvLklwbZE21Me0b1DwsGNDlKsYml+bCEKwvr2QROH+d2IxTkgCqNJxBdsxBo2nEd2U
         i8ATysfORMTSHHIyGjYwJOnbJJ1T3QMc2P190omnVE4IiaIExhXHIknRvks7eJd4TNua
         Ld9nTCgeXo2XQ4eECUlCYQiVVrJK7tf9KYfAH8xiy60WoebLTRf0/nOT700eDq1KwyG9
         wzDY5ltLfe1B4pFfJDfyA/LLbA2G3X4VL5z7zJnwjFhw8Mu+h5EyfGjJ0edZbJ2+NsXU
         y/3TyzwKajEDjyX0Exk5t6Gy0DC211/UQDMSjPogqxB4ir/kCKSaPwDm4Y9cbXjfGGZX
         Q81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684662907; x=1687254907;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0ZuE9IVmhVeXdzIfRJwEOuxKD2TmQfoqHMok2b2LVU=;
        b=ToGXBG+pYPe6DkFHqiFO7EXSehe47JFV1tatuGUv6EBsEeZqnihhaReGOhy38yXNl1
         0r9FSYQW+yn8e4ZwkReFWvnY2AGSZeUmzDfkRwa7mRS12h0p2dSnKh0weCoUEbtXFDUc
         hgPkIsRT+326uStsG3mY/Cn6QfKtoyixq58C/AnuNbWoFBvzKjNBLnin34v/i5HGp0NX
         7bGzXOb2AGQeo+wNSGf/nWBsE84rbJ3JJFBREskvBwlzUJv7W59g74G98CXOKJOrTYqS
         cuGShIW8cxXV38tIfuWIje7OqvpfNY71kfNqwqV9HIRKyXaQLPlTWrIeoSDjtsRvzA6s
         0Clw==
X-Gm-Message-State: AC+VfDy4Ht9kHp62a8o3HWJhkxOLRC3rqHAeursWJ1GEbKszh/POFMny
	wxSbEuJ62S9Xgh16KhA4/CFZnAMGsCPdmCklM/4EXA==
X-Google-Smtp-Source: ACHHUZ69e/Rzc4g0xx6Q09GR3l5DbbI38YxhEa2irMERMU5etzkPP/QYNzeZ5fyGItynkXva64WtjA==
X-Received: by 2002:a17:903:11c9:b0:1ac:63ac:10a7 with SMTP id q9-20020a17090311c900b001ac63ac10a7mr9055130plh.68.1684662906872;
        Sun, 21 May 2023 02:55:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b001ab0083c6c9sm2683119pld.261.2023.05.21.02.55.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 02:55:06 -0700 (PDT)
Message-ID: <6469ea7a.170a0220.49e8e.40cf@mx.google.com>
Date: Sun, 21 May 2023 02:55:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 32 runs,
 4 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 May 2023 09:55:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11576

cip-gitlab/ci/pavel/linux-test baseline-nfs: 32 runs, 4 regressions (v5.10.=
180-cip33-11-gfea7994097935)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip33-11-gfea7994097935/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6469e0c766a1dea7cb2e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6469e0c766a1dea7c=
b2e85ed
        failing since 4 days (last pass: v5.10.177-cip31-33-gd59f246891e73,=
 first fail: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6469e5a7add0838b272e869b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6469e5a7add0838b2=
72e869c
        new failure (last pass: v5.10.179-cip32-471-g18129e1b68691) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6469e4306c6effc6982e86dc

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6469e4306c6effc6982e86e2
        failing since 59 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-21T09:28:10.441555  <8>[   98.681394] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-21T09:28:11.497832  /lava-10402841/1/../bin/lava-test-case

    2023-05-21T09:28:11.530104  <8>[   99.771674] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6469e4306c6effc6982e86e3
        failing since 59 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-21T09:28:10.403386  /lava-10402841/1/../bin/lava-test-case
   =

 =20

