Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07944C3F6B0
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 17:49:10 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web08.884.1659548943238151011
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:49:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Modw5W2H;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 12so15790621pga.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3h2guHxnNaKr+kcwdqWpvXB4j2HZaAyZ8YFUScI+m38=;
        b=Modw5W2H7xEzYFsiPizR96Bxzh6kw587sk32J6JEhoUS0FeZLzSGztJWBDBqgZgvkX
         OTDSGFYc2bOUtWAvuePrdNAozPoeDVPe+svU2DUdbyLg877etWjFCG7N6wk3Mtr25fYq
         6awE6o66iyL/MdE23QL+mKRU/Ce7M90NQk1Nmpuk+cBSaXK0ctYIJ5ILCCk4I50pFSUi
         S6sisRlQECFUwsQAl23MNQzjsokML5guB2I+3KAieM9BG8SnFaL5HYbQmVUPhsmg5g4f
         2CQpYr/NOxifaRAC/kx0KBFpepADaVq/mKm2Xnx8u8sVpDnrDe+IT9pQozpCvjAt3oe5
         48Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3h2guHxnNaKr+kcwdqWpvXB4j2HZaAyZ8YFUScI+m38=;
        b=UZSQdGXoMO4IqbUfl30PWBqu382EUGZr5qFsGUhypXukedsD8j/J+gyZ2x61Z8+lr4
         dVuXTxdf9DKRYL2isd/joAJsjlZM5cKuJGRt+dp9yQG8Np4JvjI2VVQh3QGOD4qUPxLN
         AfYvvW1hI+xexUdyEsTGbhJtee3KX5l4yYKTdDVHOZtctEQTZMKi1DwicMIpMHDEogKH
         hEsdAMLJ2XWjORvVBoZhc7HKDRG449Evl+4h/4jjjPLYGnMSzAcukKUiWdfW6yF3S6ju
         Wk92T2kkRFwzVvctjlfvmv8oCRKESDbm78P9+Ny4UzDx+f5oG52oBnCrCANpaeF94A1p
         65cA==
X-Gm-Message-State: AJIora+sFoPzr7suzP7ICDE3dcxHjlgr6mBuNqTZdlrvCw0uhQE7Dftd
	8v0nRCgLFW35db1s3yoIYakk4PFyS6h20v0xHDg=
X-Google-Smtp-Source: 
 AGRyM1vSYofu0kPv+vff7iSq62uT6qH62ftjfxthMYNwZ6KnGajTwO1J0/AkjhJ4nBsUtnViyLINAQ==
X-Received: by 2002:a05:6a00:240e:b0:52c:81cf:8df2 with SMTP id
 z14-20020a056a00240e00b0052c81cf8df2mr26356521pfh.40.1659548942372;
        Wed, 03 Aug 2022 10:49:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m14-20020a63710e000000b0041b667a1b69sm11294986pgc.36.2022.08.03.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:49:02 -0700 (PDT)
Message-ID: <62eab50e.630a0220.42adc.0258@mx.google.com>
Date: Wed, 03 Aug 2022 10:49:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-24-ga6f4ea41fe167
Subject: cip/linux-5.10.y-cip baseline-cip-nfs: 8 runs,
 1 regressions (v5.10.131-cip13-24-ga6f4ea41fe167)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 17:49:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9089

cip/linux-5.10.y-cip baseline-cip-nfs: 8 runs, 1 regressions (v5.10.131-cip=
13-24-ga6f4ea41fe167)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-24-ga6f4ea41fe167/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-24-ga6f4ea41fe167
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a6f4ea41fe167f956d4000eaf276a1e383603071 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/62eaaae026a7e50100daf058

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62eaaae026a7e=
50100daf059
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20

