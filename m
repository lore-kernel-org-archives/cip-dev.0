Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD1AC77B62
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:57:23 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.43619.1679493434452051145
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=JcFqFOeH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id x37so10612450pga.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679493434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8JHItHLgNjq/nqvrpSveF2DqUqm8cgaTxfCaCWFBsas=;
        b=JcFqFOeHW6Nlhn78KU1W+y1WnQUPnUWeF2r9O3xxJw97Jh6+icys/1T2gCn2SXTfO8
         3CZ9k3tbjbijX6ZLmJtqXEkDK4aw3xJrf/9md/KwMm964UIWbpdZttuuZdZjiQZ/O8Bh
         lsMGvFU6F8fpFyxyOUIFqSptlvy6ueZSKDtFtftDuUQmCbN2eyHFzP4DPobhLccCjPMY
         t9e7JD53H+dhN2/qkHmzd+flsl1ugUM8jG941hGAKWt8XMTrIG3LkZZOHYnY+2meql3H
         ig1b2d3LhyIXytUGYm2xZ87l95ZYMTymxlHXW9Cc6+wr7M9+nwBVLiFm+cLx6XhDIPxQ
         20Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JHItHLgNjq/nqvrpSveF2DqUqm8cgaTxfCaCWFBsas=;
        b=4Dqmv2gbDK+JpIKhLXnT9AewF3rotVJ3/Ep+WNe9WFxbeV0R3ulUmP18TA17U6KbxV
         BGveSHr236plbDsJBkkiGmp729QMfgnLG4kEfszr0Yva+M9P6HQ6eIhwRa4thZmEO3nK
         iShc8/eQM4GTA8Qg8VQdVgkF8sI6lzplL7tntogJZuxr8qNw9+kkF9rOMqh7Xa7bnM3j
         jj5GWjDRLoZaNfUx5y1bUXpNm99w+urYXMQs9Mh62hos5uyx/Ozg75YK+/k0nS6Ecqq9
         eiQ91sqcKcTBLhMHRyVR57Lp1WyNTRerGaz0j8vmjuPhyitNM9a+eXPtW0ZkSKbXWTxY
         gqQg==
X-Gm-Message-State: AO0yUKVa0GOeHwGhBfjw829YaJ/CycRiCamstTsyQDYXz6wkB2q8gLES
	/9Fyz4NuVrgt/P17wXNrXPqqUo3LZMzsrVujJSJxIQ==
X-Google-Smtp-Source: AK7set9EMqXpdXLCdDqCc/Et0CI+/AUkDFjNr4U9zaXxYoytxg2L9MVbRIBQPV8jhvf2u5rg9ATiSw==
X-Received: by 2002:a05:6a00:309e:b0:625:5403:cd87 with SMTP id bh30-20020a056a00309e00b006255403cd87mr1804262pfb.11.1679493433633;
        Wed, 22 Mar 2023 06:57:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f14-20020aa78b0e000000b005898fcb7c1bsm10433988pfd.177.2023.03.22.06.57.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:57:13 -0700 (PDT)
Message-ID: <641b0939.a70a0220.f3909.3271@mx.google.com>
Date: Wed, 22 Mar 2023 06:57:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 15 runs,
 4 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:57:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11087

cip-gitlab/ci/pavel/linux-test ltp-ipc: 15 runs, 4 regressions (v5.10.175-c=
ip29-rt12)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

qemu_smp8_riscv64      | riscv  | lab-broonie   | gcc-10   | defconfig     =
               | 1          =

qemu_smp8_riscv64      | riscv  | lab-collabora | gcc-10   | defconfig     =
               | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.175-cip29-rt12/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.175-cip29-rt12
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641afaed5883c3a59b9c9552

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641afaed5883c3a59b9c95=
53
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af9701a40ecdd619c9523

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641af9701a40ecdd619c95=
24
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_smp8_riscv64      | riscv  | lab-broonie   | gcc-10   | defconfig     =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/641b0212b6b60a0f239c9559

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_smp8_=
riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_smp8_=
riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30317.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641b0212b6b60a0f239c95=
5a
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_smp8_riscv64      | riscv  | lab-collabora | gcc-10   | defconfig     =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb16e2bf6f9d029c9514

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_smp=
8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_smp=
8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30317.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641afb16e2bf6f9d029c95=
15
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =20

