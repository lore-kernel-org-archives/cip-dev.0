Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E6EC19F2A
	for <webhook@archiver.kernel.org>; Thu, 11 Aug 2022 15:40:50 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.8045.1660232440633689068
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:40:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=NvW2ybg2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id
 15-20020a17090a098f00b001f305b453feso5766906pjo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Qk6PGikn9xOBxgiuRyCXOIn1kuyBcYVpFLcpnh35viM=;
        b=NvW2ybg2Fbph6dgWaqVqqZLQ8B9JcxCwg151uqDDJrEiFWOQHHW2ON3779f2G8dMU/
         Z+xlU+kZo3V1RJwLTE5yQdc+xINmXB/yfg7YWsDjN1mpdOn7ktC6IUsxTqdFpjfnTfRL
         3KCUeqTOtU8eU22LVvVCPF/kBFWNUdoCz6AHnbddAO+RGNLY3EcL0SJIvC4jg25lLls/
         0qRrM+y31Dd4A40PxKt8OK2QCL3ggNg97xXA++5PDkrbNjURnx1+dWNj+8OVFfxh7TPM
         0INfct3SzkvlREFaGhPVcK3hXh/JZBX2cjILoSxg4j29sDA40xdHB/oMese9+iyPf3bQ
         xdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Qk6PGikn9xOBxgiuRyCXOIn1kuyBcYVpFLcpnh35viM=;
        b=6oZTm52q0l2kR5Reunmtt6ZITzZbU2VyyCD1a8WUWM7afDitMSvUQ8BPHVqrg+zf1S
         bWULPQfDFpbnu6h2S2RELd4EbW62HBDofU5J2nNgtHpa1SfTfbWqK4B91/YDJJNuBV4A
         mQ8EIoop4stAbTGFwLIfGA9K1v5z1kISVoez0i1TLikFeKvtl34HkHOaUfFE6os2Z7Zg
         KbOWt0koV/wH2vy5OOSm98cBxFgTX5OnfJWgZne3HvrEkLbq++/CCMtZp6SYe6tNqBPe
         fVX9rTYjWM8jjTUKYPcHJ/Dw2N8HyrG4vBhckebi1dTjgTj89bqvuj4HV8iq3QK+uTaV
         4yBw==
X-Gm-Message-State: ACgBeo3/jJTErLpjkFUAOX+ldzkaR98ELVhl2rAngf3FkC22BIfWgrQ1
	9W5LEoRpx7/DbFhgpy7vB3T7b4X+iWj5ge+v5z0=
X-Google-Smtp-Source: 
 AA6agR7tIaMj+BUqMA2XQcJ8L589uA8OWZUzdrvNDqUm8t9AsAQ7WJk/5E//4cj8av1zBsPBFW39QA==
X-Received: by 2002:a17:90b:4c4b:b0:1f7:11f:8e8e with SMTP id
 np11-20020a17090b4c4b00b001f7011f8e8emr9280416pjb.98.1660232439959;
        Thu, 11 Aug 2022 08:40:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y13-20020a655b4d000000b0041c8e489cc2sm11540903pgr.19.2022.08.11.08.40.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:40:39 -0700 (PDT)
Message-ID: <62f522f7.650a0220.b5e0b.3854@mx.google.com>
Date: Thu, 11 Aug 2022 08:40:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-493-ge129308279043
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 9 runs,
 4 regressions (v5.10.131-cip13-493-ge129308279043)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Aug 2022 15:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9166

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 9 runs, 4 regressions (v5.1=
0.131-cip13-493-ge129308279043)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-493-ge129308279043/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-493-ge129308279043
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e12930827904334316a5d7407de3f9a7126f9892 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62f5136c6b9c1f10f5daf0ba

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62f5136c6b9c1f10f5=
daf0c6
        failing since 37 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-08-11T14:34:11.699044  <8>[   12.452980] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62f5136c6b9c1f10f5=
daf0c7
        failing since 37 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-08-11T14:34:11.680679  <8>[   12.434932] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62f5143fd9c0e1e39adaf097

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62f5143fd9c0e1e39adaf098
        failing since 90 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62f514cbfeef110ae8daf085

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig/gcc-10/lab-=
broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig/gcc-10/lab-=
broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62f514cbfeef110ae8daf086
        failing since 93 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =20

