Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809DCC4706C
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 01:30:05 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.42023.1703122198337810318
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Dec 2023 17:29:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=CaTOzGdE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c6839373f8so208214a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Dec 2023 17:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703122197; x=1703726997; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R2Kdh20CMjNtBur098H1d7fDEhlCzAe4ZtEGfMQsSbI=;
        b=CaTOzGdEounnwBncl/1meZ2t/fLX2eHmvzSSn26pVZ4rcfY//Uub31bJso1weAQjS+
         TCoXnblTK4pUEsVRKM8P7WAkAE1O54thNOc0nKhiZzZv2BHIFyvQZh/hQzgNiiswLii4
         khOoCkekKeuTpOMm3QIfdG1MZakMaU6U90SZhcxBpjsCx4583ZOD8qSFcFof4M0Ak9/8
         XRfRN7RvCFnDr8M55ybDZlv3KMBRHUtuZQEMPP9y/D68/+S3VMrY4yipCXX7egZngrFw
         Li/ReMqtgMMMoSXrJk72AE83LYqzmmCPLlvjlz0RysgUUYavgBEppI2w8cJYQ8+Rwtqa
         R+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122197; x=1703726997;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2Kdh20CMjNtBur098H1d7fDEhlCzAe4ZtEGfMQsSbI=;
        b=KFz73vfYu4kvenLbUSnZTtnrscGC8OiZwWE862Og40iXG+OMlzLQO6m1Wl2sc/NG0c
         FfWmdcFbInBRe5yNskY/mh+djTu8xLbWRgCE0hpqXdSO0D0GgrScdixAdmp9ZDIHVlB/
         ohFn1ywqhTQByVpAmEBOPjvBgFNu+/gXvpi42o1KxSTIj2zb2IYS2hWaXOpqg5VILek6
         XicOrcuc3mwSr8fvUJ8fK4wpovCjHVKKRLDCNQw0BpgOXM0N8WUAcfEjPNjWiyOIq8hn
         OxwMRyoTQOG0rI+2+Y0Cu9rUGAprbu7gX4oiEZ5yepgi3oN8Mvl6wrJ84MZnxvqCNaLF
         vgZw==
X-Gm-Message-State: AOJu0YxKK8Ri5t4UqnQuAV8vhcBHWhIqsN2OsSBJxtSJuIMsLdxaBzce
	5+lPg77zKj8hMvlAQbEFOJ8xcIC4LOnKPeF8C00=
X-Google-Smtp-Source: AGHT+IGSQHt2oaMRB8jNL9KE5nc2u4cEHExwkYjedoyIz3Q6wWPg6ZuLmnPCmSI9OVs2dktnxPlFCw==
X-Received: by 2002:a05:6a20:258a:b0:18a:d791:6629 with SMTP id k10-20020a056a20258a00b0018ad7916629mr723396pzd.11.1703122197265;
        Wed, 20 Dec 2023 17:29:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7870c000000b006d7d454e58asm387260pfo.117.2023.12.20.17.29.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:29:55 -0800 (PST)
Message-ID: <65839513.a70a0220.99281.1f85@mx.google.com>
Date: Wed, 20 Dec 2023 17:29:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-540-g3640150b3b169
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 15 runs,
 4 regressions (v5.10.201-cip41-540-g3640150b3b169)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 01:30:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14177

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 15 runs, 4 regressio=
ns (v5.10.201-cip41-540-g3640150b3b169)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-540-g3640150b3b169/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-540-g3640150b3b169
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3640150b3b169fcd03031a9e8aab166a9730a1f9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65838a21d928d7c4fce1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65838a21d928d7c4fce=
1347c
        failing since 6 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83a=
, first fail: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                | 2          =


  Details:     https://kernelci.org/test/plan/id/658385f42031d3e4b2e134ac

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/658385f4203=
1d3e4b2e134b1
        failing since 116 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/658385f4203=
1d3e4b2e134b1
        failing since 116 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6583920683dfb443dde13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6583920683dfb443dde=
13476
        new failure (last pass: v5.10.201-cip41-473-gc43d7b7bbe83a) =

 =20

