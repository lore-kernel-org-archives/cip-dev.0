Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E70C43334
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:24:14 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web09.4701.1658399054010962109
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:24:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Y7nd79S5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id c3so1323474pfb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rfUjfEiyE9ZtONJd3DDeXSDHGQLErr487B3by18A48s=;
        b=Y7nd79S5gbdJJLr3H/6Cn7OPpOZiKrgq78R5vp01S59vlcmdSgvQn+VxLdd9uBymkj
         yIWIhLAMiHelTLJS7qiVXqFq4dbxQ6/3/t0aebMOBS3F6zg9ijx9TGVWLW0SVeEPyjcf
         yKJ6qQCdg683oYpMsHj2gr2dkHkI00h0Ol827AC33hoyKxS3JLY4T0gnFyOkUsG98V38
         ZFLqefV/CDUk9hXoVhBi1YxIxZrYMdC2pwe3tNe1dS7lDyjwJTPV5hmvNrf5lgpppOAg
         k6lYssMmxnrkUgynwaCbxRmRCbB7lVEuuldXMMSu/OjYLMb9Dd2aTjzuZ7xcoI/FGWkh
         EsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rfUjfEiyE9ZtONJd3DDeXSDHGQLErr487B3by18A48s=;
        b=56lmxGlCnNGx+xqtoAuM0YIkBDVj1CzB63P5q6oSzqKkt/Y+UktpmP2RnwH8VJOx7k
         xaDXv+TVBFREP0cxcNtivwM13pIwVcVFkES5cSxRDncZsE66qXdFy1RpfLamvy6Xy3d6
         9AMPutITDhuJqQXHl1QC6qHplSJmcWaD6/XMo2jKyGCYCWUGxylgTLEPrU1ebrR/ZTS7
         B6D8yRl/tNLaa69C03nubK69+7rdYrHybGGz0nDuWqrC6Gr2mKCxJ7Nav0bakB2gr2yJ
         WfsNYxx4u42cZHtk+1X+Ti51HugkDziH/nD21JS5CnuaVzNoxLtg1vrGLfU32GlCWbPB
         7MyA==
X-Gm-Message-State: AJIora9w5HEpnaiS7He2BFn6CD1ihIAXj4F054SRZp1CnWUrGuMEc+4/
	KvPNeasFka61uW5wDAlKVfxeF0k0hpVhMhkWByM=
X-Google-Smtp-Source: 
 AGRyM1uN//JZvTLje28gck7q5X5PPPlX/C0qUfqpxjWyZAKrNqeGUWMYaqYUfc48D2ysujE/WBErYw==
X-Received: by 2002:a63:4a60:0:b0:41a:6047:612b with SMTP id
 j32-20020a634a60000000b0041a6047612bmr7625282pgl.107.1658399053219;
        Thu, 21 Jul 2022 03:24:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t17-20020a170902e1d100b0016bf10203d9sm1257633pla.144.2022.07.21.03.24.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:24:12 -0700 (PDT)
Message-ID: <62d9294c.1c69fb81.9f6b7.1f10@mx.google.com>
Date: Thu, 21 Jul 2022 03:24:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 36 runs,
 4 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:24:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8869

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 36 runs, 4 regress=
ions (v5.10.129-cip12-12-ge4e007863cc76)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
jetson-tk1               | arm   | lab-baylibre  | gcc-10   | multi_v7_defc=
onfig         | 1          =

jetson-tk1               | arm   | lab-baylibre  | gcc-10   | tegra_defconf=
ig            | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-12-ge4e007863cc76/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-12-ge4e007863cc76
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e4e007863cc767efd75ca69c0b98e5daab0c20ff =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
jetson-tk1               | arm   | lab-baylibre  | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62d920a9b9349eb727daf07c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220716.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62d920a9b9349eb72=
7daf07d
        failing since 51 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
jetson-tk1               | arm   | lab-baylibre  | gcc-10   | tegra_defconf=
ig            | 1          =


  Details:     https://kernelci.org/test/plan/id/62d91e2a5a3d47fa01daf089

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220716.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62d91e2a5a3d47fa0=
1daf08a
        failing since 51 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62d926e49dcc4d071cdaf11e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220716.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62d926e49dcc4d071=
cdaf11f
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62d91c68e8e5ed5250daf09c

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220716.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62d91c68e8e5ed5250daf0be
        failing since 134 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-07-21T09:28:59.681660  /lava-6860834/1/../bin/lava-test-case
    2022-07-21T09:28:59.715143  <8>[   98.213802] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

