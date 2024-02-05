Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C436C48298
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 17:51:28 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.501.1707155479274085446
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 09:51:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=hL7WLUM6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8ef977f1eso35306605ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 09:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707155478; x=1707760278; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K1Yo6jq7kD7I5BXin+oMDKZ+UsP/EoPKXwOVWGUHe4k=;
        b=hL7WLUM62nxa/CO7CbUTi2cIM7DHbbHPGZE3IUsrPMXrkGKUNH0D/ptcB5gAzTAYU4
         bcyBhDP3NuvEr9T6B9H9trtf/VJ+7MUC5ORPsH8g6KTMKMS3hhn5YzdWINRdRUUPaXq7
         bNGsQWRsFfomSGOMe38jJMo8mSF13relycwjC6JwJqimTRu/mKrMCMPTf0UKhSCHPAMF
         01y5DOAgVebf+YYQO+CvpbrTaHIr7+ebeEg32l3fD4zF3JGVh+kKtSWLFEqLgz1s2DpE
         V8iqddErKvUvaOeMb/rt5lEhn5POxoS6juunqwXJDlNWnawBecRgIvyj2smFUE89/I/k
         jKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155478; x=1707760278;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1Yo6jq7kD7I5BXin+oMDKZ+UsP/EoPKXwOVWGUHe4k=;
        b=K9NkszNljixHidY6U2sjTGG7ZQ3mZvJA8fRzi+r/5IhkCDaml4ldDV6w4tvybNM6XA
         7aOnkG21Ma8H9WjjoyzVtdL0yO9+WnvNXup8lOn1DX4CX3Er8fr782l/7ffFLZ5uMjjf
         XpgLOTk9hhbFftAaELyeslTPhDVmWFemm011MXuQTI7wcVGzAuVuzmwtKKpAW8j/qaEE
         0OLHSbEldzDnADeJdoFDOr9dSBTCXCqcsfoFpoNjRNL3rDYKDtl0ZQeZaS4X3gxwhX+9
         bZrhYdFvXImTYzo1vf/tbyJiQMIimu3M/UB5dAf5me4JSjJ7aLvKlW6uXI/TBLcRqxJw
         BfAQ==
X-Gm-Message-State: AOJu0Ywvvz0rAt3YxiBEtef7EgwwiLJ4mF3eFkpWPlDFmZhC9710sRwB
	dVxd5amk19291JGEBBo5+Ub+a8u804mMVEF42IWa39EHawE4H98Kw1HIO4q8h3zBP1cFrzc9VsZ
	c
X-Google-Smtp-Source: AGHT+IHUe8HOqenOnm+NJip1cv2rGT/XOmD6icDTISftmVYwfjLBeyGhyqJnAFjmlxvmxBNC6K7nRw==
X-Received: by 2002:a17:902:fc46:b0:1d9:542c:ec01 with SMTP id me6-20020a170902fc4600b001d9542cec01mr351550plb.12.1707155477728;
        Mon, 05 Feb 2024 09:51:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVGzfLuzp6vSHk08QS2R9r/G11retslCm2k0b6pJ/bfB2wr7GMSx5QfvqwA2ifF0jFPCNoSiEHSfw7ZadmB2y30S4rlFz/UoGAL6VKg/QiE9f2guLC6vMLFZnjjhCjB8Y5lwWh18hHazb6cecQQSPaNWQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id lo6-20020a170903434600b001d8f6ae5199sm145743plb.89.2024.02.05.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:51:17 -0800 (PST)
Message-ID: <65c12015.170a0220.5e240.0e38@mx.google.com>
Date: Mon, 05 Feb 2024 09:51:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-cip-nfs: 13 runs,
 10 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 17:51:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14741

cip/linux-5.10.y-cip baseline-cip-nfs: 13 runs, 10 regressions (v5.10.209-c=
ip44)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fa4c25ee66abaa707e8d165c790bb96e883cca4 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c115dce5882a551000a07f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beaglebon=
e-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c115dce5882=
a551000a080
        failing since 87 days (last pass: v5.10.131-cip13-37-ge3a52725ce96,=
 first fail: v5.10.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1185783a9ef2c5c00a04a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beaglebone-bl=
ack.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c1185783a9e=
f2c5c00a04b
        failing since 87 days (last pass: v5.10.131-cip13-37-ge3a52725ce96,=
 first fail: v5.10.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11a588c24e2cb3400a03a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beaglebo=
ne-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c11a588c24e=
2cb3400a03b
        failing since 87 days (last pass: v5.10.131-cip13-38-ga8671b4cc3c74=
, first fail: v5.10.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11c0aab0e2dae3c00a07e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beaglebone-b=
lack.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c11c0aab0e2=
dae3c00a07f
        failing since 87 days (last pass: v5.10.131-cip13-38-ga8671b4cc3c74=
, first fail: v5.10.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c117cbac2880178300a08e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c117cbac288=
0178300a08f
        failing since 3 days (last pass: v5.10.138-cip15, first fail: v5.10=
.208-cip43-4-g1c63c70fb18b8) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c119c629d33f537a00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2=
m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2=
m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c119c629d33=
f537a00a03a
        failing since 87 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c117cafc69b046d500a091

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c117cafc69b=
046d500a092
        failing since 3 days (last pass: v5.10.138-cip15, first fail: v5.10=
.208-cip43-4-g1c63c70fb18b8) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11bda5b26a32b3100a040

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hihope-rzg2=
n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hihope-rzg2=
n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c11bda5b26a=
32b3100a041
        failing since 87 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1186b83a9ef2c5c00a055

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c1186b83a9e=
f2c5c00a056
        failing since 3 days (last pass: v5.10.138-cip15, first fail: v5.10=
.208-cip43-4-g1c63c70fb18b8) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11b12b046eaec1b00a03e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c11b12b046e=
aec1b00a03f
        failing since 87 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =20

