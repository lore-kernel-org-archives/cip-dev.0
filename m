Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C8FC05021
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 07:16:53 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web11.23091.1699600609182804209
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 23:16:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=h9ecJrWp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.42, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so935934a34.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 23:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699600608; x=1700205408; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0qwwLry7Flo3SF2I0B9VNHcdCuloD+Vo+u4u0VuN6dU=;
        b=h9ecJrWpjDgg0+DcEkb1s0pA9xgWl0rT/wKbI3dN+L4BBHT+OptoVMemtJogYQzDBD
         CKmx+KKceSQNVMMf7vMYiUp1PO+tAny5bHHIGS7ppak2RMgAz49R79E3fFLcNtcDKREp
         oTKmbpDQBwPomwNSndgTj3/0mNjiIUZCNhAAMBfTDtkydnTAAWuX1AtNpvG4I2OwHbqg
         S7gLGIBnCV6Neq/OB0XGp+Xt+tl2T8JgH4CT/ZgNj6nn1UMKeOrBGoBnXpKewPkP2Nop
         ZX8V2NRh+GKViyqHx9hSu/1ViMHvgge5sHFBlRpJbs1O1+6SOgOfzApiM5oMI96GpX61
         6LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600608; x=1700205408;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qwwLry7Flo3SF2I0B9VNHcdCuloD+Vo+u4u0VuN6dU=;
        b=LtNdVZWEendx7tpLgvyjQj44LTVLrDlIBi/KMWgpC7FNJZ4d/3vCtn4uiN7bKZfWId
         o1lTSMDU4YyQe89YOR0VCEXKHqNH1K28Z6+7qNgdMjbdAcUBlJ3QNJsCTt8v0vfAgPK4
         BPGntDlrojQRS8gwgZTtMi2tcL828dZ5b4FUABSHHwBVQuVHskJZ4xue9L//6BSuz5Et
         2gAvhYhKPyYiY87NSAtthodn6vuF4nHJhLrsizucAHEXNYxHu2+le40dvK8lA3/pmTwH
         itMSHiC4k8fj6uHCwgqmVdsveFoHsrVWHMOHWOMarOEVC1ikn/Ulq069ADA9DXWncgn2
         G58g==
X-Gm-Message-State: AOJu0Ywgwq0kNt0sMonRalh3SpTo+i0ZADX95XFNzVko4pFa3YnRy74j
	o4LsRo4UHXB6//VP1dVNa7ON1XO7xyuhE4utHBF2jw==
X-Google-Smtp-Source: AGHT+IGsv++ubYJ8vBysgS8IDBLTYsLkwjh22/5Y8fjrPHUAteDNa/HOHcE5/3ogNu0soUP4crJyaA==
X-Received: by 2002:a9d:63c8:0:b0:6d4:80ee:f5b with SMTP id e8-20020a9d63c8000000b006d480ee0f5bmr7331244otl.35.1699600607885;
        Thu, 09 Nov 2023 23:16:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t12-20020a65554c000000b00578b8fab907sm5184220pgr.73.2023.11.09.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 23:16:47 -0800 (PST)
Message-ID: <654dd8df.650a0220.56ea8.df0d@mx.google.com>
Date: Thu, 09 Nov 2023 23:16:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-ipc: 10 runs, 3 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 07:16:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13564

cip/linux-5.10.y-cip ltp-ipc: 10 runs, 3 regressions (v5.10.200-cip40)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig | 1          =

qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig      =
    | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc733634accfde5efcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-cip/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-cip/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/654dc733634accfde5efce=
f9
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig      =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc8f10a36748048efcefb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/654dc8f10a36748048efce=
fc
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcbf7457d6b7890efcf8f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/654dcbf7457d6b7890efcf=
90
        failing since 36 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

