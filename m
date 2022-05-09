X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.2043.1652134978917513129
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 May 2022 15:22:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=W+NPDQWg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d25so13405709pfo.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 May 2022 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nKIrkSnML3ElWFP6xKBwIL7R9WoL7VPjJnwyOyh32Fw=;
        b=W+NPDQWgCA0UlpE0Net4gaAmfoXhzUbb0mfz0XsnSt641DM4tLHL2R+EW/IzY7MTNX
         boKRTtPcOEl3HY+2QBeKTvCLJ7GI/ThcWcxluSim1ULrAKb+jFuwEW8S/E0uJFqtMzsb
         oAwtNWzk8lhJNycx8FUIAiCARY3OQwCqzdHNW6fzU5rdlYVn8Ci+6K7d3+//cr+Cc7KX
         EGb4q30OtnI4rsrhm7LHtHao/SW14RgNYoXP7YPf5AfBbSJKVcvxQ5bvB3QdUZCDUJv9
         w7igagyRGnMeCk3K7aa76AszYZ/8RR5ut1jUJRv471ptsR6joVOaInf4gZB5nX1pMK/2
         dZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nKIrkSnML3ElWFP6xKBwIL7R9WoL7VPjJnwyOyh32Fw=;
        b=EFDaQ5jhlz75KLoZuwFReEBiVfF+EuT/3v1zUt2cPY+UYdRbn6B9u2yzU/s2EAMqur
         t1hx4apQdY5or0hlqf0n5s73M6hTECuwhzG7mV79GQugaT7r+UWxT7UwLtA0ibA6urBP
         hdB08LPGoYYAtt/LGlbmX2k4F/4f4Pv12r0FmZ0EpW2bwNWgpCGmzDJ0DNDAH19+nKd2
         vaDrJ2zEf91Cbkxc6yCwEFtpcUgtiuPA4A1w9r1L0kUNOKA8f4EGxSyk2/Wcp+5yyr3A
         pzmio37+8T25E93bPyn1lT0Dc7vm/aO2y8lQV3MzaQSq+FPzBaQVImyu6xpAs6q7vSQf
         j5Sg==
X-Gm-Message-State: AOAM530642BXt1Srw5Z8czlOMa97Bt0mXAceFupuKwvLdEzJZS6VWWjw
	7IkZQ4wWwMDWQvBo+NN8FvMs6YvI0SiSJ1n/88k=
X-Google-Smtp-Source: ABdhPJzCABQavII2qeYEtVXAu+yo0A9aQpF9RVUF7SswKehv9aR6LSlQrJzW+SwVE4oYCPFPf4ZN1g==
X-Received: by 2002:a63:d842:0:b0:3c6:ab6b:5f3c with SMTP id k2-20020a63d842000000b003c6ab6b5f3cmr7106010pgj.148.1652134977997;
        Mon, 09 May 2022 15:22:57 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090a6c9000b001cd4989febcsm224335pjj.8.2022.05.09.15.22.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:22:57 -0700 (PDT)
Message-ID: <62799441.1c69fb81.56f7a.0be3@mx.google.com>
Date: Mon, 09 May 2022 15:22:57 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.112-cip6-218-g8253434cd56a
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 3 runs, 1 regressions (v5.10.112-cip6-218-g8253434cd56a) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 3 runs, 1 regressions (v5.1=
0.112-cip6-218-g8253434cd56a)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.112-cip6-218-g8253434cd56a/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.112-cip6-218-g8253434cd56a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8253434cd56a1ed24ebcf6bd7bb980b182888279 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6279923b193ba462158f5753

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-218-g8253434cd56a/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-218-g8253434cd56a/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6279923b193ba462158f5754
        new failure (last pass: v5.10.112-cip6-88-gf3397cadb2dd6) =

 =20

