Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66068C4167B
	for <webhook@archiver.kernel.org>; Sat, 26 Nov 2022 12:03:05 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.68745.1669464176911766214
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Nov 2022 04:02:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ZSpIwe0T;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d6so6112951pll.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Nov 2022 04:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mztEmLVZfgHpohHqtamBj6s8v5+vsk2q7wh3EJb5MCg=;
        b=ZSpIwe0ThyB2+2o31f2PKH53JhkVGEBqpJGRsz0y45lMctelYXiwIvR+lNDyF2cV2Q
         sVk5IY/kG7DQSyxN4DLDnRwiU7GWKw/L/Wpi7YR2GYdAJPZR9/EuxQEPvGGODneOSOVc
         dYzpcx9yBbHY7MIzGLcHeV1l8KLy+O/ZJfcd8gwewlTmZY+11Lpsx79BNZZs1cxRSj3e
         lRQz7gf+45/xmhspxXzPEx745dnNkP5sTWyNK0D74YotL1m+vD7/T55TAbPbtu5hZZkS
         my6iULvuHCEohr3bH1RaIKuu7sZFSbrLJJK/vrhl73LKtZtle5BIWlVUyDq+jvVv6+ht
         cQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mztEmLVZfgHpohHqtamBj6s8v5+vsk2q7wh3EJb5MCg=;
        b=uQYGtpZPVyyWkwCig5uBIHOeDn/X4BkWe8pkmEsywEdlGlEYHJqkInPGKIr5K4u2bk
         EEOFJSU6htzQxzyKHwJ22TtQNqmPNhO0O0l1MnwzsXHFmxDNlsYMIxipmUNq2h4oYkE9
         bw4i1IiT31cr2V4lTgQZzU4Ln5QV+sU4oNstVT+lGYu7YORnHmzICaDnUW1wxgX1BR00
         vkhtRtMxAbEznLjbMHWr1BRoYnR+ylskVKog3McwSB5Zecz2x+OBw/jtDMmDE+7sG2sR
         hNFWPQvgO4Wg5GVbFTHAuprb+JzhYY0rJSdRSWyZUPbHZUozdv2TyfrzsdRRUv72/o+R
         fZnQ==
X-Gm-Message-State: ANoB5pkDtOlJofQF87rNgysgiA0AvQsCo5uWwPPf623lPSgvb5aeIB1o
	ra3xUfC9nc7+8c0rk/kTTGUmiY2/eE+u0Ah2aJM=
X-Google-Smtp-Source: AA0mqf6LFd5KHYvg5psvIXqG+Cj2pPYS2krz3KV+WYm601PwrQm0ItvSnnrBkSvV+SZic9EN2O8eKw==
X-Received: by 2002:a17:90a:4207:b0:209:46fe:871b with SMTP id o7-20020a17090a420700b0020946fe871bmr51678942pjg.163.1669464175978;
        Sat, 26 Nov 2022 04:02:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090ad25000b00218bedf8739sm4544111pjw.17.2022.11.26.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 04:02:55 -0800 (PST)
Message-ID: <6382006f.170a0220.8b6bf.5ef0@mx.google.com>
Date: Sat, 26 Nov 2022 04:02:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.155-cip21
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs,
 3 regressions (v5.10.155-cip21)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Nov 2022 12:03:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10119

cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs, 3 regressions (v5.10.155-cip2=
1)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.155-cip21/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.155-cip21
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      02e30f9cbbfce3d687cb1ab288e46ad20079e8e0 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6381f1166dfde9ea182abd7d

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6381f1166dfde9ea182abd83
        failing since 151 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6381f85ebdc12c7dc22abd15

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6381f85ebdc12c7dc22abd1b
        failing since 151 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6381f12929ccf6afa22abd02

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6381f12929ccf6afa22abd08
        failing since 151 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =20

