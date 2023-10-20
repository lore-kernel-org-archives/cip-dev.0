Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B99C0032E
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 18:09:20 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.61830.1697825352946086643
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 11:09:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qd7VB2h5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c9d922c039so9079335ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697825352; x=1698430152; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fu2Uc4aWV7Ins1knBxJTY85j8pxWTP1VQS9uD3+ASQ4=;
        b=qd7VB2h5Mynj73EJvx3O3iHs/o8PrdPMYH0y6b4OejhubcvzxVb0MdomAAZeVxO5e4
         ulKJGgG46wYvBCEpjn2hHFcnFAumAvQCkA3+gXF6ax63jQFYLpl7HNuSI6NLYj4Lr69V
         5R5p8hfmvzN2vDPmS+o8AF9o4Qrtvs/qaeM/v4eA9qug5eB/POqp8wu5fZ3NVckHYJHG
         abQmbfRy2FUy3+Nu/wJ13pU4FsBEvnX4ug1Dt/R63k4Z9AXAcz7srApUZi4cQhacPmb0
         JAWa8hjsu73zDuLwHal6TJGHSXUZwPvWdlWgpbVaKLOkOIo48boBebx3XwFOQMBV0Cmp
         PfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697825352; x=1698430152;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fu2Uc4aWV7Ins1knBxJTY85j8pxWTP1VQS9uD3+ASQ4=;
        b=G1/WXMVzFNWTXTOZcGZWb/7/dTS7qCISoN1BH+juPmRcv4reYlaYLWeikBuF2wp6fK
         9kyKMpOIpT4Sz3h4Yv/pFbbNywipOsJ/93elrne4l19/itY72b5pfwc5SG5i6IyKN10j
         4BEWPd4nmdgynTBr/FFad810CoveP+k/WB2fyxJJ2RDSB+SVMU/KRoip//LXWPFOJGXY
         GF6m+s7h6ldCe8p6DlnpnbLMTA0fPve5ux/R+pbaPbDdBCc2ggZ1TLcaJmRfuUaAevHf
         Sru8oNCLF3wHdMmNW/Ki3JsBV3aE11kTtf+jUqXuY+mFdUoknpYDuyG2G1RR+nPKMgDs
         nXcw==
X-Gm-Message-State: AOJu0YwdfXwxM3m5NPdMbSF/eVUVO7oLjmSDu8dHXVJxCW0bVIghdpIp
	+N8BzA3xjNni58jRQl8jAC4CXBob7BdCxdhsIlEprQ==
X-Google-Smtp-Source: AGHT+IFj3/yUwVgHrEMMXmNRus9kLI1bOPCNXJKwtZw8pRYgmmKW0v+30XGG3a1VaY4QS/lbfdFL/Q==
X-Received: by 2002:a17:902:d34b:b0:1ca:7ec3:f4f9 with SMTP id l11-20020a170902d34b00b001ca7ec3f4f9mr3364943plk.32.1697825350829;
        Fri, 20 Oct 2023 11:09:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k20-20020a170902ba9400b001b89536974bsm1803475pls.202.2023.10.20.11.09.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:09:10 -0700 (PDT)
Message-ID: <6532c246.170a0220.43f3.6b39@mx.google.com>
Date: Fri, 20 Oct 2023 11:09:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip78-rt45-338-gf468de833aa13
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs,
 74 regressions (v4.4.302-cip78-rt45-338-gf468de833aa13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 18:09:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13424

cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs, 74 regressions (v4.4.=
302-cip78-rt45-338-gf468de833aa13)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 13         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 13         =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 15         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip78-rt45-338-gf468de833aa13/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip78-rt45-338-gf468de833aa13
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f468de833aa13aa639d147055db4edf9931b6811 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc645ada5e855eefcf10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bc645ada5e855=
eefcf11
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc663a1a159708efcf24

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bc663a1a15970=
8efcf25
        failing since 16 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc787ef55e8ddeefceff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bc787ef55e8dd=
eefcf00
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc67c09f717ae8efcf06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-acer-cp514-3wh-r0qs-guybrush.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-acer-cp514-3wh-r0qs-guybrush.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bc67c09f717ae=
8efcf07
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bbd7b351456b0aefcf74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bbd7b351456b0=
aefcf75
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bdc0da734dcd49efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bdc0da734dcd4=
9efcef4
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc4b5ada5e855eefcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bc4b5ada5e855=
eefcf05
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc737ef55e8ddeefcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bc737ef55e8dd=
eefcefd
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc3bb27ca85cb4efceff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bc3bb27ca85cb=
4efcf00
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bd30dc8c29222cefcfe8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/at91_dt_defconfig/gcc-10/lab-br=
oonie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/at91_dt_defconfig/gcc-10/lab-br=
oonie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bd30dc8c29222=
cefcfe9
        failing since 16 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 13         =


  Details:     https://kernelci.org/test/plan/id/6532bbc1b351456b0aefcf2e

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/6532bbc1b351=
456b0aefcf33
        new failure (last pass: v5.10.194-557-g2932db67f070a)
        1 lines

    2023-10-20T17:40:20.999425  / # =

    2023-10-20T17:40:21.006225  =

    2023-10-20T17:40:26.030271  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/181856/extract-nfsrootfs-7k8svn98'
    2023-10-20T17:40:26.041291  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/181856/extract-nfsrootfs-7k8svn98'
    2023-10-20T17:40:28.337973  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2023-10-20T17:40:28.349102  export NFS_SERVER_IP=3D'192.168.56.123'
    2023-10-20T17:40:28.454369  / # #
    2023-10-20T17:40:28.461693  #
    2023-10-20T17:40:28.564333  / # export SHELL=3D/bin/sh
    2023-10-20T17:40:28.571648  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6532b=
bc1b351456b0aefcf35
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:41:10.392259  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:41:10.442372  [   86.182267] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-20T17:41:11.483346  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:41:11.530204  [   87.270856] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/6532bbc1b351456b0aefcf36
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:41:08.258173  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-10-20T17:41:09.290733  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:41:09.346872  [   85.086054] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/6532bbc1b351456b0aefcf37
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:41:07.096962  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:41:07.147651  [   82.887626] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-20T17:41:08.189522  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:41:08.244822  [   83.983363] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/6532bbc1b351456b0aefcf38
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:41:04.911878  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:41:04.962426  [   80.701976] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-20T17:41:06.008828  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:41:06.056299  [   81.796051] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/6532bbc1b351456b0aefcf39
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:41:02.711698  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:41:02.766837  [   78.506623] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-20T17:41:03.809229  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:41:03.866797  [   79.605670] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/6532bbc1b351456b0aefcf43
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:40:49.073660  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:49.134112  [   64.872017] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-20T17:40:50.179439  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:50.315027  [   66.052887] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/6532bbc1b351456b0aefcf44
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:40:47.967266  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:48.027021  [   63.764587] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/6532bbc1b351456b0aefcf47
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:40:43.366955  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:43.425490  [   59.163688] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-10-20T17:40:44.471995  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:44.532912  [   60.271274] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-10-20T17:40:45.580983  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:45.636609  [   61.373936] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/6532bbc1b351456b0aefcf48
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:40:40.076481  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:40.118167  [   55.856233] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-10-20T17:40:41.159952  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:41.212988  [   56.951452] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-10-20T17:40:42.260578  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:42.321429  [   58.059226] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/6532bbc1b351456b0aefcf49
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:40:38.968427  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:39.029055  [   54.765741] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/6532bbc1b351456b0aefcf4f
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:40:34.201394  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:34.260667  [   49.997947] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/6532bbc1b351456b0aefcf53
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:40:31.685249  /lava-181856/1/../bin/lava-test-case
    2023-10-20T17:40:31.736150  [   47.472398] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 13         =


  Details:     https://kernelci.org/test/plan/id/6532bd27dc8c29222cefcfbe

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/6532bd27dc8c=
29222cefcfc3
        new failure (last pass: v5.10.194-557-g2932db67f070a)
        1 lines

    2023-10-20T17:46:19.577237  / # =

    2023-10-20T17:46:19.588972  =

    2023-10-20T17:46:24.637205  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/1023197/extract-nfsrootfs-1vhc9kht'
    2023-10-20T17:46:24.647608  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/1023197/extract-nfsrootfs-1vhc9kht'
    2023-10-20T17:46:26.755118  / # export NFS_SERVER_IP=3D'192.168.1.1'
    2023-10-20T17:46:26.768384  export NFS_SERVER_IP=3D'192.168.1.1'
    2023-10-20T17:46:26.870775  / # #
    2023-10-20T17:46:26.880302  #
    2023-10-20T17:46:26.981141  / # export SHELL=3D/bin/sh
    2023-10-20T17:46:26.992287  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/6532bd27dc8c29222cefcfc5
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:47:05.250340  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-10-20T17:47:06.273679  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:47:06.321782  [   75.643465] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/6532bd27dc8c29222cefcfc6
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:47:04.123090  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:47:04.163104  [   73.483239] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-20T17:47:05.202369  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:47:05.247204  [   74.560077] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/6532bd27dc8c29222cefcfc7
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:47:01.968426  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:47:02.005481  [   71.325769] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-20T17:47:03.044832  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:47:03.083845  [   72.404314] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/6532bd27dc8c29222cefcfc8
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:46:59.808840  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:59.849831  [   69.169782] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-20T17:47:00.889195  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:47:00.929200  [   70.248672] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/6532bd27dc8c29222cefcfd2
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:46:46.557647  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:46.599654  [   55.918645] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-20T17:46:47.638894  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:47.678948  [   56.998343] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/6532bd27dc8c29222cefcfd3
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:46:45.481340  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:45.518327  [   54.837498] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/6532bd27dc8c29222cefcfd6
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:46:41.015290  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:41.056314  [   50.374876] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-10-20T17:46:42.095573  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:42.134505  [   51.453745] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-10-20T17:46:43.173855  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:43.213813  [   52.532464] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/6532bd27dc8c29222cefcfd7
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:46:37.776428  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:37.817476  [   47.135900] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-10-20T17:46:38.856707  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:38.894654  [   48.213712] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-10-20T17:46:39.934038  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:39.975971  [   49.294438] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/6532bd27dc8c29222cefcfd8
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:46:36.697153  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:36.737010  [   46.055329] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/6532bd27dc8c29222cefcfde
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:46:32.138910  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:32.179848  [   41.498071] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/6532bd27dc8c29222cefcfe2
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:46:29.755445  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:46:29.799369  [   39.117376] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6532b=
d27dc8c29222cefcfe6
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:47:07.361050  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:47:07.404043  [   76.724396] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-20T17:47:08.443370  /lava-1023197/1/../bin/lava-test-case
    2023-10-20T17:47:08.493290  [   77.802859] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>
    2023-10-20T17:47:08.493588  + set +x   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/6532bc9dd95131e779efcf01

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/omap2plus_defconfig/gcc-10/lab-=
broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/omap2plus_defconfig/gcc-10/lab-=
broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/6532bc9dd951=
31e779efcf06
        new failure (last pass: v5.10.194-557-g2932db67f070a)
        1 lines

    2023-10-20T17:43:43.309580  / # =

    2023-10-20T17:43:43.313347  =

    2023-10-20T17:43:48.341187  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/181888/extract-nfsrootfs-bs1u3km_'
    2023-10-20T17:43:48.351791  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/181888/extract-nfsrootfs-bs1u3km_'
    2023-10-20T17:43:50.638331  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2023-10-20T17:43:50.648921  export NFS_SERVER_IP=3D'192.168.56.123'
    2023-10-20T17:43:50.753895  / # #
    2023-10-20T17:43:50.758736  #
    2023-10-20T17:43:50.867124  / # export SHELL=3D/bin/sh
    2023-10-20T17:43:50.871914  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6532b=
c9dd95131e779efcf08
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:45.725537  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:45.842859  [  119.516632] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-20T17:44:46.973434  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:47.095873  [  120.770658] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/6532bc9dd95131e779efcf09
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:43.360216  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-10-20T17:44:44.475191  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:44.616532  [  118.289634] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/6532bc9dd95131e779efcf0a
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:41.945985  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:42.080036  [  115.753993] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-20T17:44:43.213018  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:43.333685  [  117.007127] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/6532bc9dd95131e779efcf0b
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:37.887478  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:39.556589  [  113.230531] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-20T17:44:40.680495  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:40.812611  [  114.486473] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/6532bc9dd95131e779efcf0c
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:34.690326  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:34.799287  [  108.473311] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-20T17:44:35.920908  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:36.760162  [  110.433475] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/6532bc9dd95131e779efcf0d
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:33.457699  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:33.569486  [  107.243000] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/6532bc9dd95131e779efcf11
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:30.309194  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:30.425957  [  104.098816] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/6532bc9dd95131e779efcf14
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:27.123023  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:27.368078  [  101.040953] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/6532bc9dd95131e779efcf17
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:23.100418  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:23.226809  [   96.899883] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-20T17:44:24.317607  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:24.426924  [   98.099522] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/6532bc9dd95131e779efcf18
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:21.844585  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:21.972378  [   95.644706] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/6532bc9dd95131e779efcf20
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:05.699679  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:07.044521  [   80.715983] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-10-20T17:44:08.167668  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:09.503287  [   83.175213] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/6532bc9dd95131e779efcf21
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:44:03.568521  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:44:04.570788  [   78.242542] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/6532bc9dd95131e779efcf24
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:58.767867  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:43:58.873223  [   72.544414] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/6532bc9dd95131e779efcf2a
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:55.561802  /lava-181888/1/../bin/lava-test-case
    2023-10-20T17:43:55.677854  [   69.348988] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/6532c0aad5e2d8dbabefcf07

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/omap2plus_defconfig/gcc-10/lab-=
cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/omap2plus_defconfig/gcc-10/lab-=
cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/6532c0aad5e2=
d8dbabefcf0c
        new failure (last pass: v5.10.194-557-g2932db67f070a)
        1 lines

    2023-10-20T18:01:27.141477  / # =

    2023-10-20T18:01:27.153304  =

    2023-10-20T18:01:32.201654  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/1023213/extract-nfsrootfs-ag_to8eg'
    2023-10-20T18:01:32.212054  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/1023213/extract-nfsrootfs-ag_to8eg'
    2023-10-20T18:01:34.319586  / # export NFS_SERVER_IP=3D'192.168.1.1'
    2023-10-20T18:01:34.332539  export NFS_SERVER_IP=3D'192.168.1.1'
    2023-10-20T18:01:34.434933  / # #
    2023-10-20T18:01:34.444384  #
    2023-10-20T18:01:34.561376  / # export SHELL=3D/bin/sh
    2023-10-20T18:01:34.572314  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/6532c0aad5e2d8dbabefcf0e
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:02:08.829238  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-10-20T18:02:09.884477  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:02:09.953392  [   77.264115] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/6532c0aad5e2d8dbabefcf0f
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:02:07.517021  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:02:07.634968  [   74.945595] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-20T18:02:08.754231  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:02:08.826116  [   76.124256] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/6532c0aad5e2d8dbabefcf10
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:02:05.069535  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:02:05.170603  [   72.480554] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-20T18:02:06.289868  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:02:06.397814  [   73.707705] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/6532c0aad5e2d8dbabefcf11
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:02:02.624118  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:02:02.730112  [   70.039914] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-20T18:02:03.849395  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:02:03.966273  [   71.274441] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/6532c0aad5e2d8dbabefcf12
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:02:01.397942  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:02:01.504845  [   68.814423] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/6532c0aad5e2d8dbabefcf17
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:01:58.485751  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:01:58.588733  [   65.897923] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/6532c0aad5e2d8dbabefcf1a
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:01:55.752593  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:01:55.858511  [   63.168460] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/6532c0aad5e2d8dbabefcf1d
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:01:51.815025  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:01:51.941976  [   59.251287] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-20T18:01:53.045281  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:01:53.157232  [   60.467441] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/6532c0aad5e2d8dbabefcf1e
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:01:50.594757  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:01:50.695762  [   58.005053] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/6532c0aad5e2d8dbabefcf26
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:01:44.962415  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:01:45.065365  [   52.374185] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-10-20T18:01:46.136585  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:01:46.243578  [   53.552360] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/6532c0aad5e2d8dbabefcf27
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:01:43.815166  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:01:43.891114  [   51.200195] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/6532c0aad5e2d8dbabefcf2a
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:01:41.145948  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:01:41.257849  [   48.567223] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/6532c0aad5e2d8dbabefcf30
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:01:38.130088  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:01:38.235028  [   45.543301] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6532c=
0aad5e2d8dbabefcf34
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T18:02:11.024705  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:02:11.134650  [   78.445046] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-20T18:02:12.253864  /lava-1023213/1/../bin/lava-test-case
    2023-10-20T18:02:12.357822  [   79.667905] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc6dc09f717ae8efcf09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bc6dc09f717ae=
8efcf0a
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bef371f2fc7059efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bef371f2fc705=
9efcefa
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc0fcc495188e1efcf03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bc0fcc495188e=
1efcf04
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bbbcd7194f3dafefcf1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-hp-14-db0003na-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-hp-14-db0003na-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bbbcd7194f3da=
fefcf1d
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bdf0da734dcd49efcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bdf0da734dcd4=
9efcf06
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bd14e20268a247efcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bd14e20268a24=
7efcef5
        new failure (last pass: v5.10.194-553-gd498c00818b88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc73c09f717ae8efcf12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bc73c09f717ae=
8efcf13
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bba1b351456b0aefcf02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532bba1b351456b0=
aefcf03
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =20

