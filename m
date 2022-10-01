Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE41C4332F
	for <webhook@archiver.kernel.org>; Sat,  1 Oct 2022 20:01:58 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web08.1199.1664654513150752241
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 01 Oct 2022 13:01:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=AMqtIvND;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id a29so7024295pfk.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 01 Oct 2022 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=dxDDAF7EDbhmL9CzRBqdCsgA1owBtu4miiX+DxNOhnQ=;
        b=AMqtIvNDQA8M/lHw/m5V2sYkv1laT4mGTVsdUp6OyTkM89wSvvTtJB8MU2WAxkj/U+
         wwwaukOF3ZdZJ1Hmy3974WgXK2SljfXLFvDuh95R+ZaWyWbmuUX2GF1ozHN4pSnEJ/8l
         aSBQk3ezh1XKup2rl0J3Uwm6TbDakleMixI2BZW4eT/C4xLna0HvlUIml4r12wvnDcmb
         NIc5M6FYCTj1Qw8rXTBqbUz7pa+Icm+IxYdf1BQcpbQ+x5fZXuy0sUG80PvnQsUF9Prv
         zszWBh6BJZxN90ZJFWFQti25CNL9bBbyk/BJGpS+f6QYytQJSkByP894nWL3sTxVXf/k
         waAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=dxDDAF7EDbhmL9CzRBqdCsgA1owBtu4miiX+DxNOhnQ=;
        b=KSlfNF1v7XmYKQ47dosVSQznTncekoVn6Y42er/A3uDqOl6VajhJgzQQp62wWirEuT
         YQCtp8QSekhdSLhXTDUgEyhDw0zmpai0cpfSulaQ9Lnf4DKXXurv2femxoX3FneiaTtP
         MtMrzaHZi9cD9a/d7Opi42qbfWqN9xmgCXjKdYaD2sOpdCkayqAvPtNd3g0s/fYPaE7n
         B1Yt5+v6WW84arMVn4EYEHT7vtbV+KVucFeEbn12qWPl8QN8Wjxcbk9nxh5j8t6PJNSZ
         J1BvpGWh7MYY+OwPBoHUu6MXkK7XduMj/xL/zZceXaIAOKAk+6zn4pV86vMNhV+4bH6a
         qXbw==
X-Gm-Message-State: ACrzQf1pldlPissc10TfNCWkuwBajU9HRqJy2XgQ7R29si7PA1r3SyLR
	69OawBXU/vhoTbdIUnx4sTGnlBPPyxjU6UCh9YM=
X-Google-Smtp-Source: 
 AMsMyM7VKqfTvBqJNKy2n13NILtUxyfPf26ck3AytKk0J4t0JQqR3RyFysKwZdnyQ+HMmvt5mlcXmQ==
X-Received: by 2002:a62:cd4a:0:b0:560:1ded:4037 with SMTP id
 o71-20020a62cd4a000000b005601ded4037mr2528830pfg.73.1664654512533;
        Sat, 01 Oct 2022 13:01:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 195-20020a6217cc000000b0055f98a2c64bsm1819644pfx.142.2022.10.01.13.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 13:01:52 -0700 (PDT)
Message-ID: <63389cb0.620a0220.96a29.28eb@mx.google.com>
Date: Sat, 01 Oct 2022 13:01:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt baseline: 176 runs,
 2 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Oct 2022 20:01:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9608

cip/linux-5.10.y-cip-rt baseline: 176 runs, 2 regressions (v5.10.145-cip17-=
rt7)

Regressions Summary
-------------------

platform   | arch | lab           | compiler | defconfig                   =
 | regressions
-----------+------+---------------+----------+-----------------------------=
-+------------
odroid-xu3 | arm  | lab-collabora | gcc-10   | multi_v7_defc...g+preempt_rt=
 | 1          =

panda      | arm  | lab-baylibre  | gcc-10   | multi_v7_defc...g+preempt_rt=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.145-cip17-rt7/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.145-cip17-rt7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform   | arch | lab           | compiler | defconfig                   =
 | regressions
-----------+------+---------------+----------+-----------------------------=
-+------------
odroid-xu3 | arm  | lab-collabora | gcc-10   | multi_v7_defc...g+preempt_rt=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/633893b0a9c030fc53ec4ebe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baseli=
ne-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baseli=
ne-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633893b0a9c030fc53ec4=
ebf
        new failure (last pass: v5.10.109-cip5-rt4) =

 =



platform   | arch | lab           | compiler | defconfig                   =
 | regressions
-----------+------+---------------+----------+-----------------------------=
-+------------
panda      | arm  | lab-baylibre  | gcc-10   | multi_v7_defc...g+preempt_rt=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6338946b01978b7e4cec4ebc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-baylibre/baselin=
e-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-baylibre/baselin=
e-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6338946b01978b7e4cec4=
ebd
        new failure (last pass: v5.10.109-cip5-rt4) =

 =20

