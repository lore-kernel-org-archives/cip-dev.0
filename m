X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web08.31103.1653329246676760902
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 23 May 2022 11:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=i3iBfOnO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id q4so13788237plr.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 23 May 2022 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=J637cdOnqp8NxBL/CslOrsAs/rW8+BHVAHQ2wJoiBSA=;
        b=i3iBfOnOT3SZ3jzM0TvmAPC08uCYMR75HuqeqifGXV4LHMb9yR1TCYYRXS3y/hLBzz
         pohB4ics13y2AAoFWBmhhvP3bMqsUFZVSlZND71RWTW4YSbmfD8SkCu0fyF3fuBcWtfI
         9KLNpD66b4MFFNENueYawCtnZ7Z4CYvNSvrJ9lk/eex85bCYxVtaatbiO9XfhgnAIXRX
         zpaPP+v01jcjhXa9N/08y7w7xx4nsGkBYULKZpglqZbdEtp4o2VXrMqYgtlQXsz2Z/gW
         5mvtdCKGfV5NmjVqHDqR/xLyDH0pGEM0R/wDhI2R+iwNurjDPDLof6tVHyksB/yJFzxP
         TTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=J637cdOnqp8NxBL/CslOrsAs/rW8+BHVAHQ2wJoiBSA=;
        b=NT+7TB4QkEX0gA9aBFeMjy7uaAGFSX5/6q9zNCmktlS/gdT2G9GIVurGdYniEJVk1e
         UKRjowvehcz0Rfaer6eMo9tvdB/z+FuxFj+6bQRhqzpCepVk7jKTNyiLEePd0mvKFSb1
         xEAMhVZw4cjK4ZRQ0PfYoKMtU9ZwgDntv4K8HmONHGEuxtRjIaTw3+31Sql3Bxu8o9/x
         UQtzqirck+BjKAT37USrUWKtfOUCP4AClDeeaRXWCuyAnURulCYUbLiAbQrUdgtuHeaM
         ClnkXIUVkR0TACRx8H/3OU2GXA4z36AoYX316AGSRYOmFun/+611DQAvtQm0qkGPq6yC
         ycrg==
X-Gm-Message-State: AOAM532CiZpAWatDLgyfIxdCbm49Yu/u8w8fRkn9lK6S/QUM6j27S+BB
	YtVNnPya/2ve7lqVerZYpqxNYG0bk4nQFvvy6xs=
X-Google-Smtp-Source: ABdhPJxS+NnafwLxM7xS9GJSEYYAMD6Go5INQQIjra5elGwJHcbIzMXPnGwIm2yjNFtBPobSmpP0EQ==
X-Received: by 2002:a17:90b:4f4c:b0:1df:e74f:ebcc with SMTP id pj12-20020a17090b4f4c00b001dfe74febccmr268206pjb.38.1653329246106;
        Mon, 23 May 2022 11:07:26 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b00162037fbacdsm5432345pll.187.2022.05.23.11.07.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:07:25 -0700 (PDT)
Message-ID: <628bcd5d.1c69fb81.2b767.c6fe@mx.google.com>
Date: Mon, 23 May 2022 11:07:25 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-1797-gb2b8419761095
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 5 runs, 2 regressions (v4.4-st5-1797-gb2b8419761095) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 5 runs, 2 regressions (v4.4-st5-1797-gb=
2b8419761095)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-1797-gb2b8419761095/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-1797-gb2b8419761095
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2b8419761095643d782c4cb4a982131b3efb6b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bcc9ce0b583d075a39bf9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/628bcc9ce0b583d075a39bfa
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/628bc99a46019bd226a39c04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm64/defconfig+arm64-chromebook/gcc-10/lab-b=
roonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm64/defconfig+arm64-chromebook/gcc-10/lab-b=
roonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/628bc99a46019bd226a39c05
        failing since 12 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

