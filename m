Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743F0C77B7F
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 21:11:55 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.34327.1684271510945547353
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 May 2023 14:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=pOv37B7A;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-24e4f674356so100703a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 16 May 2023 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684271509; x=1686863509;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zvEu6cSZDdM/n0CJVbg7JoHQeC/XUTsv6Pm+QK4wNtI=;
        b=pOv37B7A31zYF8jKDjuY2RSxsaycJoo6dfdtCT7RSzm5rXzo/CscNeeeibhYVrn0us
         mHYeqPRZRhiyeryfZ9KbLFH14I5R+0DX9UO0zmDYSQsAP/KQ8KMrZ7sK31YauireMU9o
         Mc6WNdF+EY7Xjd6ruVJ/1O7vRgDnrG73anMZZssoOtVCw7lSpaJ0tha19CXti7TnD7f4
         Oa4M7j+tEEa//p0xCXrCn8Xwogv8MtdrcKuiaZ773eK6qFMZWTtT3MHQ8BvluXxMwuQ+
         RpeN1XJUFAc5U807r9USUVVFfFUvwWlD26zrbvepaRv7ACmlrj39hu+T4Hm1TSJo5tdR
         +nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271509; x=1686863509;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvEu6cSZDdM/n0CJVbg7JoHQeC/XUTsv6Pm+QK4wNtI=;
        b=JMfTH2z0gaQt2rU7ngPTfDAwrVHloX/RBwmclPjyp2yWbx0DIVMDm/1M4V+8hgcUPX
         htBrhsuDGSHfsvzYe4uiGVHDhsvRUWf/zt4DPGQw0DIfDEhKVJX4h01p7fC9j0SNnRKx
         g4aX0aM9Bi1RNybZGIeGrrgXxEorBjaSZh7nQrNDP893iebRj6cZASjmIgs3Vi4Yy4jc
         Mqr+Yq5Xwxvq4hqm1sWWfLvOJCHilD6IkTOdNfzG3eePCrTN3dTr4FUiTY+53+gHq2oo
         eaTHKv/PsRC7nb2fYn3DPIXnpV5ia/7bPrWDRRj98CzQ8iAmUOgyoPm9BVh9NgxK0yXo
         bfGg==
X-Gm-Message-State: AC+VfDzbzzTXaWEyqs5XQm8InRTxCLNnqswJuT+OVmGy/Zt1OqJDLDM9
	ZE2yri32V8z7pflUGIp1olybjN55GyKhe1kxkWsztA==
X-Google-Smtp-Source: ACHHUZ4lu6T/Hb45vHSZqJOOtogYk3oaaK0qOgX+41zjc0pe7kDRWOeKEzTj9Q0Cqqr2XQ2mtvHxJw==
X-Received: by 2002:a17:90b:fd6:b0:250:132a:5d93 with SMTP id gd22-20020a17090b0fd600b00250132a5d93mr35702761pjb.49.1684271509287;
        Tue, 16 May 2023 14:11:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090a8c9400b0024e1172c1d3sm24403pjo.32.2023.05.16.14.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:11:45 -0700 (PDT)
Message-ID: <6463f191.170a0220.1210b.0195@mx.google.com>
Date: Tue, 16 May 2023 14:11:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-4-gd8c029e4780f
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 10 runs,
 5 regressions (v5.10.179-cip32-4-gd8c029e4780f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 21:11:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11480

cip/linux-5.10.y-cip ltp-timers: 10 runs, 5 regressions (v5.10.179-cip32-4-=
gd8c029e4780f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.179-cip32-4-gd8c029e4780f/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.179-cip32-4-gd8c029e4780f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d8c029e4780f8e18a07a1a17c1a9de1e01f3adae

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6463e806dfcb52a7d32e85f7

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6463e806dfc=
b52a7d32e85fc
        new failure (last pass: v5.10.177-cip31) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6463e806dfc=
b52a7d32e85fc
        new failure (last pass: v5.10.177-cip31) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6463f063fa4b96cda72e864d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6463f063fa4=
b96cda72e8652
        failing since 95 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6463f063fa4=
b96cda72e8652
        failing since 95 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e898ea40fde59e2e86ba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu=
_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu=
_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6463e898ea40fde59e2=
e86bb
        failing since 32 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31) =

 =20

