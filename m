Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D908EC46CA2
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:15:49 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.26610.1702570542948956815
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:15:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=j7ws3t5A;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28abb3c5b9cso2012660a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702570542; x=1703175342; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uyd872qskSy0U+4nbu2ZqA/zXi4dapI/Y0ijXsj38cM=;
        b=j7ws3t5A5QpQJSgKPm7YAHxtp4U6dNvqB2e9KAM/aLTd2uYPoRJWVLKuy5Ea/4KDgZ
         AgLvWNHer6OOfNELzHRmO8wi+sWYdTKWUX7jn9znNP2CgFXgelJ9DVu+CkLkheBCZ/S5
         +TprgUdin9j1oPlrs1w9u6M8FLmbGHkAiZ/JMgJmRrNd0U6oFTTMXxX6fH75vrbfMjt9
         9MYGhB/uH7zD9f+lwXccfTOIOtzeB1uyK6+fjzdy62JPHSMz/pnfYGFHMA3+RmgoGP6b
         cOsvbEptNQ7x6TViPaVAMbO459BGPl8lXlChe0o9scUqYrS8vGz3Ez3lznVz1PcbFHzM
         +vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570542; x=1703175342;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyd872qskSy0U+4nbu2ZqA/zXi4dapI/Y0ijXsj38cM=;
        b=FzmU9+k83NOS5YbjZ8cN5V73eIs4yrQ71ouN3s0qtJwI/NUh20TgMd3TGkGguHCR2N
         6cxgxa93Imy0usmkuFfyRCADWyic8nF3kS2J6EX4NPpJpmNZ16FE7fqWQVa9qzGbqaU/
         xuNhjnR6c5iihhtpZybGZyGg67KpJ7fVr3VzYEwSOXsdoJuk1ZSf4egfZrayyGb2VTHi
         7J5FDyqc7lP2UfT3lsdAfeHTpfGBFf64JOdr/K5Bx5x/kPV16TYH/T74pjcwc9O25gmf
         rMxbCoVfKNHe556LsFC/UfXCUkUAb0nikp7+s2VNxrS2CcvnPee5qr2wIvuq2TLi7uw1
         klDA==
X-Gm-Message-State: AOJu0YwDh9vf0O+ATs3uZEg/XKmHGNL375Jq1V0Me7RPRIvHIyKnUBoj
	gwn0j4Ts/Zkp7hHyy2+xABaQdAsT7YBx4QNq0Z4=
X-Google-Smtp-Source: AGHT+IHyvlFu9tII/kNvSbThgISKIWeb6zvg42TWvuKw13wmM8inELXngLL7f5hGrQic+DoZx4ACRA==
X-Received: by 2002:a17:90a:17cb:b0:28a:fb21:ac61 with SMTP id q69-20020a17090a17cb00b0028afb21ac61mr1001972pja.90.1702570541862;
        Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qj3-20020a17090b28c300b0028ae8a31664sm3537270pjb.35.2023.12.14.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Message-ID: <657b2a2d.170a0220.44a17.a92e@mx.google.com>
Date: Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip ltp-ipc: 13 runs,
 2 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:15:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14115

cip/linux-5.10.y-cip ltp-ipc: 13 runs, 2 regressions (v5.10.201-cip41-69-g8=
f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig | 1  =
        =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/657b205a910157342ae134ac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_sm=
p8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_sm=
p8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/657b205a910157342ae134=
ad
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6) =

 =



platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/657b1caef0425c6653e1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/657b1caef0425c6653e134=
7b
        failing since 71 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

