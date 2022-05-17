X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.6993.1652793365912939895
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 06:16:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7n+Oyw0T;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id bo5so16849576pfb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=CAaDapmSQWYqz/6gmI96AipGQeqIdSkcIJunbfvoON0=;
        b=7n+Oyw0TJeeBt9QgNbS+FHKmeaQjwYT8r/LfK5A5cemE0+JLooOqDuDbAl45dkbnyo
         HaQUytvfAWpbYctVmubcRILXmAxHT2NKXAEsDqYVXwe5jfn/rbw909h4W5Exh2HJyH6L
         l95AUKMMLqESwF9PFsRflETcPdhVOOa446OIbWMlyFNlWD+nxg0MwVBZNJImMeCZz2co
         Bu9tOCEpRvHsZpWo7cWWyK3zzTLgXEGLcJvXsY/P29BA9kMMDD8PjqfuIifUCVRIpBI9
         BjAecZ2+nx95ytmLLzy19ZdfI1qIsfDMGesMFNK2DYDZGM+kfjB/EVqqb7cMcb7lrN39
         XxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=CAaDapmSQWYqz/6gmI96AipGQeqIdSkcIJunbfvoON0=;
        b=qQyFKBym7bfGEGZNBB2vNNb28nsb9kwMEElvicvLOeumixP4ownv3OnB9phqoRTyVz
         DXLy0EBvG71sABLArKdms35h2t/UAQh/P8+F1CBASJLMNEHZBSluMu9NfZgtkyfDMn1S
         yrKphd8uLhZ9qrkW3aLuROI5509jJugfQYOSjeCmlAWPEkvSRtt27QWtGfWwd69C5vpo
         oMfJNOfKYWQ5jl7zlzfgvH3zkKKjFSL4l/L3mEOxBJm7l77/ibDV3VyJC3lvbLHVyZv2
         WSvFTQNLCRdTycUDlupe7o4UGPs1fzXQnP6QCLfFxuWIu414WDtXKqK3jXaJqXOVP6ir
         vZ/Q==
X-Gm-Message-State: AOAM53393tr+9oyWL5+qplnvmBFSbH+n7/t5dUL+XVo1PyVC65Ayijje
	SXS8NzF7PwxoGQWqGZkQEkDpYB8o8jf/3OaX1Lk=
X-Google-Smtp-Source: ABdhPJwjGkex4JrT/Tvs4cvH5HTMZt8RmHdYnYjUVMU8j3GTFwtLrH9514yyI5mskS0WmdR/X7ELew==
X-Received: by 2002:a63:6602:0:b0:3c6:60e1:865d with SMTP id a2-20020a636602000000b003c660e1865dmr20160609pgc.236.1652793365155;
        Tue, 17 May 2022 06:16:05 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x8-20020a17090a788800b001d97fc5a544sm1656458pjk.2.2022.05.17.06.16.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:16:04 -0700 (PDT)
Message-ID: <6283a014.1c69fb81.247b2.3ffa@mx.google.com>
Date: Tue, 17 May 2022 06:16:04 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-293-gbfc4bd11718e1
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 8 runs, 4 regressions (v4.4-st5-293-gbfc4bd11718e1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 8 runs, 4 regressions (v4.4-st5-293-gbf=
c4bd11718e1)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

qemu_arm-virt-gicv3       | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-293-gbfc4bd11718e1/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-293-gbfc4bd11718e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bfc4bd11718e111c2344c45b9237855beb947e3c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62839e1914ed71e7f6a39bd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62839e1914ed71e7f6a39bda
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm-virt-gicv3       | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62839f96b5aaac4399a39bf3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-=
qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-=
qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62839f96b5aaac4399a39bf4
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62839e6a7f0bbe74d4a39be3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62839e6a7f0bbe74d4a39be4
        failing since 6 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62839eba7a3df93a39a39bf2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62839eba7a3df93a39a39bf3
        failing since 6 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

