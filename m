Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6ECC07E9D
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 18:41:48 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web08.350.1663958500730959985
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 11:41:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=dyhNTgaA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id y11so830679pjv.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=PLJXKqfvkBAZcuhrvsigLYkayuB1KMHo/UHxwsT2lgI=;
        b=dyhNTgaAnR/8YCokwnwMRSngMqbZiRkL4vfI/t2T3e6N3c6VAXudYyrh6ShiYVEL+w
         F4F8TCFFoJyE8pmK/1iWgith78/SPGjGf1KhMspkKJIzy2uq0aQRWikPAovOBg8dT7dC
         0YkS8W+IdIzJ1rz30qYFTYsZ1QoRDjtCJxHz4AwnJx1xPkCl1KxqRRyPO1GT7fs2lCnq
         oy7O3HT01iTrNC+hpozzMXkxBHqrvegnMkF2vCQlP8hV8QgnZ37o/Nn0rt7Z2RGYWREv
         0k/JCyREgnMqcHxbbeOhMrFsPOHgScSuwyW/AXNmq2PSJbkNg7i9Pu1XeYBEsCFMDq9/
         65cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=PLJXKqfvkBAZcuhrvsigLYkayuB1KMHo/UHxwsT2lgI=;
        b=OiX6JlpYG65w4O+V2xemIvS5VVGOkpp3iYMm1hVKH3DCGNS19SSTsScGjfTAa1WaX9
         BFR/xaBXegRk00hIdjWfbrBp/N1ekcE4dopW5NIg5h37oJAlepTBO0YgYL4ATJCWPWkz
         iSxcxLsGTCqC/pRv+UfcB7yJk+4v4GkXt4j+tQQCuYYVgsexa3njGCOzJWa5kLlAKK7I
         ad/aOY0k9XStWW/za6EQl5Fy0z3a3F0J6dRtP2O4Bin6XTfhk3n8itgqMFaLHmMQ8zir
         SiTkYdPfo//zfKE2aS1JcbJoaNsO3MQzbumIyF+9TvmwEmW/8sHV6SRPuMmlTgZ19Uq+
         s+yA==
X-Gm-Message-State: ACrzQf1F99994BO92bpNU/OPPaa6aklwuXmtjFl31bceqMxC9JyUK32W
	SnJ9N29RDljcc1d4qbenrKljeoqugDsaw3e8t2M=
X-Google-Smtp-Source: 
 AMsMyM6OfWCFsLUlWfKx/LrU8a78l6+QJrm7ObLIfhTMpYvuO26rucDeAMExNop3eHyc2O+7cG4NKg==
X-Received: by 2002:a17:90a:fe6:b0:203:7c29:6e0d with SMTP id
 93-20020a17090a0fe600b002037c296e0dmr10805014pjz.181.1663958499949;
        Fri, 23 Sep 2022 11:41:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c204-20020a624ed5000000b005364e0ec330sm6775220pfb.59.2022.09.23.11.41.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:41:39 -0700 (PDT)
Message-ID: <632dfde3.620a0220.a2d72.dbde@mx.google.com>
Date: Fri, 23 Sep 2022 11:41:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.140-cip16-261-g8fa62effa305f
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 28 runs,
 1 regressions (v5.10.140-cip16-261-g8fa62effa305f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Sep 2022 18:41:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9537

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 28 runs, 1 regress=
ions (v5.10.140-cip16-261-g8fa62effa305f)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.140-cip16-261-g8fa62effa305f/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.140-cip16-261-g8fa62effa305f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8fa62effa305f81a2f52692a14ee690927819830 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/632df74c5162c369f8355661

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220920.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/632df74c5162c369f8355687
        failing since 198 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-09-23T18:13:21.148550  <4>[   38.245711] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-09-23T18:13:21.158636  <4>[   38.256082] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-09-23T18:13:22.131395  /lava-7362440/1/../bin/lava-test-case   =

 =20

