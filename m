Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B051AC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 04:50:05 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web09.81060.1656996595523500605
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 21:49:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=HCXoCKWz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id
 v4-20020a17090abb8400b001ef966652a3so1141056pjr.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 21:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gWXJOeODFh1xgsbBpsicJfRhP8ZRrFbiiCC0M6Tc6m0=;
        b=HCXoCKWzXiQOLuRLY/wTq4W9bssivQZmt2D/tBelXtw+5aJsc0Pu/4BBSg1b6co4Tu
         CB1khLPvjaAg0uKNmMr6bak//b2EMB/Y7d4IdZUviJbcPbggf86ELQpFB7K3ELiHqf/z
         bMAE5FXQjwuZnf8pEhXQaErl7ha2nPW29leT/8SRnlXq9bQSHGTCkCAGLWAoLyOhs71l
         uTBrxkmHErZHP941Q8JOIHV1KOR+W6cN/+eGuOzN+Vq19NLWjUCaVIqHWa8HdxDKoWSW
         Z28VdYtJUL6cwQ8nxTF/eK/hmobY8EbWBB7/bimzHUiKziiZ44JZIOwTyY/0lIXM1YAD
         YR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gWXJOeODFh1xgsbBpsicJfRhP8ZRrFbiiCC0M6Tc6m0=;
        b=DKRsThMWu6PZXEbrE29Gxvfqj2UO1I06TkD8SKlaPyk7wNG5eGDMH3KJfB1pSe0+Ul
         bTy4R+gjrMtu5uOqeYrjWVNFwVnWcu1AcLF0jRBfw4AZ4/mQRrPseYXq4TV1oBmw8JiM
         fNCCK3h2qBTQ0n5xQXJjmnUgdskcwJv7+Ktyksqux+VYW4U5blY7X+72xUO+NvCeDHmh
         Y7devxnYxzKC9eRbf5AtWGTNEhDxPxGRkgnQVotjRsD8JmyyeFAdeXRYKAAmA/CEJB+3
         ZJ1wW2X398ld6uRzgS5DvFStBQpEMaN8tZLtvUAqv794BYS/3LrmClN1I/YSUKIDXaAw
         +qLQ==
X-Gm-Message-State: AJIora+BjYf2pplAW9zyFCrqQ900IgsUyddvzChsMG2Npf2ZHHIp0WBH
	i7ZJW6b1TvFmyH/thtrqorSO+eFAr5mCs9zr
X-Google-Smtp-Source: 
 AGRyM1uRWV957EhziHm7e9bYgvvP+/l+b84K4QzUpfgRr2gXbj9nFPeizBaOC6pu7zSTeKYwMg7Gfg==
X-Received: by 2002:a17:90b:4a82:b0:1ec:bb6b:38d0 with SMTP id
 lp2-20020a17090b4a8200b001ecbb6b38d0mr38773074pjb.213.1656996594649;
        Mon, 04 Jul 2022 21:49:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x4-20020a1709027c0400b0016a04b577f1sm22129267pll.246.2022.07.04.21.49.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 21:49:54 -0700 (PDT)
Message-ID: <62c3c2f2.1c69fb81.5422.ff4e@mx.google.com>
Date: Mon, 04 Jul 2022 21:49:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.249-cip76-54-gb41c396e258f
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 44 runs,
 2 regressions (v4.19.249-cip76-54-gb41c396e258f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 04:50:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8673

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 44 runs, 2 regress=
ions (v4.19.249-cip76-54-gb41c396e258f)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
jetson-tk1       | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig   =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.249-cip76-54-gb41c396e258f/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.249-cip76-54-gb41c396e258f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b41c396e258f2fee2f17d7d65e4e03a629ba380b =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
jetson-tk1       | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3b8201119a34480a39bf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c3b8201119a3448=
0a39bf9
        failing since 28 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3b50580683c3d7ca39bef

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-54-gb41c396e258f/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62c3b50580683c3d7ca39c11
        failing since 113 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3=
b, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-07-05T03:50:17.805914  <8>[   37.849662] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-07-05T03:50:18.832660  /lava-6750436/1/../bin/lava-test-case
    2022-07-05T03:50:18.860208  <8>[   38.904037] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

