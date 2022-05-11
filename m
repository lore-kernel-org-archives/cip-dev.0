X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web08.8765.1652256527248329391
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 01:08:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=QN0rEhBP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id m12so1156784plb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zcuQ9/AGAmawRKPmk8Gr1cw7esYaEs+xa6Z6ynJHt7c=;
        b=QN0rEhBPtGewIQhlMRaEI8ahYJlV4NYd4oDIvFmaldDTiax4/OvfVMjIuPE2WqrXq1
         rj9RiRdWaxcuiA2EDvnVxMXYEd1FA4mjgZ0VGtDtL8mNxCoyA2/kjbK+F+S+B3QxlssV
         V1sB5R8uS7jt7SfNHQO+V1zXaZpf+v81M+Eftnrfgqg1SKoSK6Au4a0SqbbXSQCFd2qO
         d2tbIobofRl+42NcQynTR+iuI8YgYPPSsvKLFJSwD5u6y2T1H0T0iPhLS7RK1nmi2XW5
         g6bOTwlN7wf6/8W2lGKD8TMKPpDzWeQqnBmAmtZZ7EGhNYvSDCjzRrBVKo/bPnFjV7yU
         6yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zcuQ9/AGAmawRKPmk8Gr1cw7esYaEs+xa6Z6ynJHt7c=;
        b=wFsWu+ZcDb/KKjfUmUIVjCD6OQx7aOAraB060nI2kQwGhfiXuXLm+HL4AILdUAynDI
         mZASfKRZ6dqX1trFepgnpd56FzAQ2NPEyFd/gcFJJog4iZxbXe7YJzuT/k7nc5QxR4LN
         CU9+fxU8Fjc/lqjZwcDZjs7p2hdyocctl+cGoKFVlO85izbLQN8DFg77u30ihplYFYC7
         LYoVODm4Zl4xt4PVVFSuchY4E9J/bLwntInhzCp7Bp0DxexPUvnsr7UBntIhASHZUAEJ
         E4/r6MS5994TY884XKrkGGAEMCQPQTz+TUa+IIzGG1ijebW9CC1mx5TBTpJ3u3ipb2w3
         TtiA==
X-Gm-Message-State: AOAM532SQPlWSf+bLtSXKBoQO4mjhcs21STMBkuV87Es1GzUlQSCkv2I
	lXaXc6/8OeHjwgqBwoYoS0sgXAw3wn+ljUWGOpc=
X-Google-Smtp-Source: ABdhPJzh3In3UczVUOBNHI14+QH+rxNb++Zkevp8qjBYfluezyYe3edkMq36nTQQ1VsADUc3imfOgA==
X-Received: by 2002:a17:902:ef45:b0:156:1858:71fc with SMTP id e5-20020a170902ef4500b00156185871fcmr23575416plx.23.1652256526420;
        Wed, 11 May 2022 01:08:46 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v187-20020a6261c4000000b0050dc76281e5sm951980pfb.191.2022.05.11.01.08.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:08:46 -0700 (PDT)
Message-ID: <627b6f0e.1c69fb81.7cbd5.246d@mx.google.com>
Date: Wed, 11 May 2022 01:08:46 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-260-gb0fe64f485ff
Subject: cip-gitlab/ci/pavel/linux-test smc: 2 runs, 2 regressions (v4.4-st5-260-gb0fe64f485ff) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 2 runs, 2 regressions (v4.4-st5-260-gb0=
fe64f485ff)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm-virt-gicv3   | arm   | lab-broonie | gcc-10   | multi_v7_defconfig=
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-260-gb0fe64f485ff/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-260-gb0fe64f485ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b0fe64f485ff31f848b40c0d6a9ac286d5b2f5df =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm-virt-gicv3   | arm   | lab-broonie | gcc-10   | multi_v7_defconfig=
         | 1          =


  Details:     https://kernelci.org/test/plan/id/627ae02f92c37944b08f5724

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-q=
emu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-q=
emu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627ae02f92c37944b08f5725
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627adeeea794a3d6c68f572c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627adeeea794a3d6c68f572d
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

