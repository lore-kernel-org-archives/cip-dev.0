Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF3C3F6B0
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 23:12:31 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web08.22616.1660691541179489160
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 16:12:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=3ujtQj6H;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id l64so10587175pge.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 16:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=LKPRQ5pnNdsAt0twBWwpQKn03ZMpWUBvFFnfQueKud4=;
        b=3ujtQj6HQkCqGSNyCJcrhDvrYL00WHQ1yIXfggckr/GCxZFbW+VWyHn6bN3OolnP7A
         TkRGBfHAWbb46SzzP7/YkqBQTLIhC4JHZiOURWmfD04/+29+IpQll5e7j3WvsommkLQL
         0Seq0ZzlRLF4ypc28ynFn2z2b51R07Y2t9bwP1aymMx05lXiBtStW2YY0Eh1nYLELhhS
         /j0S0IeDV38QTc+53KH9N53ABqeZwoDh44p7rFNZLM09baDV5kWed9aBy+btxt8JiLz0
         7byrBrNxEDEuU7EfZiUaAG42+sajiW4DP/e5c0yfYThI+Pb/VzVPHRO4lvr4L3I/8MmL
         KTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=LKPRQ5pnNdsAt0twBWwpQKn03ZMpWUBvFFnfQueKud4=;
        b=Ty2C6LaCNb3tu+MJsjsRg88zR+v5twf4EhYREr6V+ucxCIufCzht+i5Q0oEBG4zZx5
         OT4bRLgbsRovQ5SIj4Sdfe5dHnEnDL4Vm21c4HyCfnTyPBW9cB/YBfsF2SRu8DfsSJ1p
         R256KcmWkkWe5575+zAIlGqBKKrAMGbwCVVinCdcZ3x7hwytoXBHCQhAjv6jGMGHciK1
         Y3NcM6v/wjQ/xFszOpRwb2HevvOPwKsrEmxknJ/xnUYxaFVG/0FRYOPPG7JaYmmQKpNS
         O/yyuIyAUfsKkeo3zmHZs06jRVrrPLz1P8wABDX6cpZl27HzLVy4FGhKuLeZSml1bCWT
         UxZw==
X-Gm-Message-State: ACgBeo3S/Y6vGSzqfV1lGV0OcgtXStPiLbgabmbvmv/Dd3Em0rRtFtVs
	HjZfhRg6AsD9BfQBkBGacBmRIMxslhx+bNui
X-Google-Smtp-Source: 
 AA6agR7CN7XXK0rydMZk8JD162hMMeABVugDVVNWBAql3t/hEWPMptmVRfS3cstuf+QDiuCzl2r9sg==
X-Received: by 2002:a05:6a00:c91:b0:52f:1b60:b526 with SMTP id
 a17-20020a056a000c9100b0052f1b60b526mr23325218pfv.74.1660691540329;
        Tue, 16 Aug 2022 16:12:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 iz11-20020a170902ef8b00b0016fa99912d7sm9534926plb.141.2022.08.16.16.12.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:12:20 -0700 (PDT)
Message-ID: <62fc2454.170a0220.173fe.0808@mx.google.com>
Date: Tue, 16 Aug 2022 16:12:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-49-g1145e9c6352e6
Subject: cip-gitlab/ci/pavel/linux-test smc: 8 runs,
 2 regressions (v5.10.131-cip13-49-g1145e9c6352e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 23:12:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9257

cip-gitlab/ci/pavel/linux-test smc: 8 runs, 2 regressions (v5.10.131-cip13-=
49-g1145e9c6352e6)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig | 1   =
       =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-49-g1145e9c6352e6/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-49-g1145e9c6352e6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1145e9c6352e68c31b58d1035f4f1ff07b2f9c89 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/62fc15249cfa2edf55355649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62fc15249cfa2edf5535564a
        failing since 98 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/62fc1534860f2004c3355643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-collabora/smc=
-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-collabora/smc=
-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62fc1534860f2004c3355644
        failing since 98 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

