Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF807C43334
	for <webhook@archiver.kernel.org>; Fri, 24 Jun 2022 16:44:18 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web09.10097.1656089053314971427
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 09:44:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=SRELckcz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id 23so2903956pgc.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9gv1eHJJLW2v0ojDczojNurx5H0YDQXYvJDyZOwl41Q=;
        b=SRELckcz6jeEcUN2xwAI31FYEtjb2YHov7NKpJ97VkDydKprNf7OUNE+VdTLxmst6u
         y5pB/9p2bhqN9kaQhDpUjb4P+3LYZq6OFxTT2nlcLs1T17+YEEFHG6YvGXc/LXpIKL4m
         iF75Py4Ud9KlGmterkSIepZ3OoDLfcs3h8nZlgapalnEpacvOEHO/Z7PmqFO35zUy9s7
         nMzrXZ4zugYmrEltG+nt8a/KchjfQN7k/+I7HYzq3V12PMfS0kn+SR8TZisv4Sc3UTry
         50P4uxq40o6OL+W4s/n6PePBEZS25TcpCy6nC8e/5ae9sISwNWeVjTWjETiOTODA+1VW
         SpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9gv1eHJJLW2v0ojDczojNurx5H0YDQXYvJDyZOwl41Q=;
        b=JQ1d6z37Gs2e1x+gRmUPUFIfup2HVtC2T+cU1oKfxRmfgXndhgF/vrmQUHUWipRNyG
         3HJn46D0qw0BMBoF1WqaeWPyeP4jr5UXxru5VpAjXjq2U1cWfFTmozAFvl9uHLKOU1yV
         KVFPhk2gd6oeHTWc9jruW0Ix8ifLi68XHRrPbVBs/EeO1KQULVbu+bKAWlG2o1o0GeLk
         evKI+6IxIRrO1E04iUoCATffVvnHqY8ZX8/fXN9nxHclI3vqKOm/fiKiLlivIYAdMDVw
         hxg1+K8XSVZ+aDIQC70kcQOmfwfDMr9l2xIkwRANd+cVOIf7HlH1oL8Hl5LQOANtbD+s
         oAPA==
X-Gm-Message-State: AJIora8IMbj/Rtj47uZcRHFWpx9McFEvG7rKgP6R9DObA943zphmcZIh
	fDSTFPkEwjBjrMpOge5o+k3GlEPxyQgLWXIIHhM=
X-Google-Smtp-Source: 
 AGRyM1sh76Hl0bbtPySY3ip3MKJ+f/pbvV29ihvwbiGnEk5WtCQOXL1Uv2CW6CncLr2eILxV8loQeQ==
X-Received: by 2002:a63:7c5a:0:b0:40c:a376:6176 with SMTP id
 l26-20020a637c5a000000b0040ca3766176mr12571330pgn.156.1656089052337;
        Fri, 24 Jun 2022 09:44:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 205-20020a6219d6000000b0052525ab06d5sm1964209pfz.78.2022.06.24.09.44.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:44:12 -0700 (PDT)
Message-ID: <62b5e9dc.1c69fb81.f9b3d.2ddf@mx.google.com>
Date: Fri, 24 Jun 2022 09:44:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-272-g3fb28d4c623b
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 38 runs,
 3 regressions (v5.10.121-cip9-272-g3fb28d4c623b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jun 2022 16:44:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8591

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 38 runs, 3 regress=
ions (v5.10.121-cip9-272-g3fb28d4c623b)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

bcm2711-rpi-4-b        | arm64  | lab-collabora | gcc-10   | defconfig     =
               | 1          =

rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-272-g3fb28d4c623b/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-272-g3fb28d4c623b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3fb28d4c623b354373a844dd48f16cb4f005388e =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62b5dd190cbb9f056aa39bd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220610.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62b5dd190cbb9f056=
aa39bd8
        new failure (last pass: v5.10.118-cip8-218-g9c4d612b27204) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
bcm2711-rpi-4-b        | arm64  | lab-collabora | gcc-10   | defconfig     =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/62b5deee369a2b198fa39c18

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-nfs-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-nfs-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220610.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62b5deee369a2b198=
fa39c19
        new failure (last pass: v5.10.118-465-g0af29783a3c9) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62b5def8f3bfe7f836a39bd8

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220610.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62b5def9f3bfe7f836a39bfa
        failing since 107 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-06-24T15:57:23.135002  <8>[   36.477898] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-06-24T15:57:24.134550  <4>[   37.476414] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-06-24T15:57:24.144129  <4>[   37.487065] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-06-24T15:57:24.170819  /lava-6677592/1/../bin/lava-test-case
    2022-06-24T15:57:24.205468  <8>[   37.548803] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

