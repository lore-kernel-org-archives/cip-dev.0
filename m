Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3295C54E4A
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 00:35:52 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.39875.1709339744051516238
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 16:35:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qFApa02d;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc49b00bdbso27713275ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 16:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709339743; x=1709944543; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pja/QUkFKxnsvERHsTwAPMVXV71q+Ql1CP8I5Wx/cE4=;
        b=qFApa02dMhoK50MIC0K/alM3pbKhsud0sbd6cG7I8K35ulhnETaQo4d8GiJ/hAK9Mx
         BT0n9xazFgCrO525yWY3kLVFlQoLSL2MRSNJt/6kXe3HnwbcCAxi46SfjjCjCHaxilGJ
         FxFiUtOjxDOT76n52VnthmrbeSzDCloDTdixzBg7cpqgx+k7znPnuV9Xd0FwJSvy3mPB
         HxiSKYtlabNLwpVk+xv7eMXUS0I/GX00L77gjIo1jVyFemTYKnBAS8DB+jmnIAHaG/f2
         BmWlTd2nbFXCX3nngNDvrHgL6K8+Nii2orVlFrh517EZU5aHRqCTd59Jkh/XzKnZdwd+
         HNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709339743; x=1709944543;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pja/QUkFKxnsvERHsTwAPMVXV71q+Ql1CP8I5Wx/cE4=;
        b=JLCgwKqA9Ja2v53ZiJQMMYT3sf7KRBO9wOOA15+NWp6USwvboMcfzxY167tydlWY8Q
         wtUFiMPwcOQqFrUJeGNF8bedTABi8mQAzDhVIZJQZWlcVZY7D1Tol5otNpUNv2lS/Xoj
         M9HeI6SxMq/4f0Yv2Jb+3YDoasiA3mRvnD9OSk26AG7C6pS1bsIjo3LmZ/zJVS3lVllY
         Q6x9HwcEXJkSiXlYkrNeYnTx6BUrtKbvFi4s9ecI+6NzWG9j4oLWVnH3JMFm8iUA8dLh
         I/TjE6mcjGZcO2kYN5SSHnTDKp+fZy7/zcJfiLqhVqKpCTdH+r9WaQ3Tmn9Vvrw/JuWL
         hU7Q==
X-Gm-Message-State: AOJu0YwWmVqaTvdio10lZuxg7GacWpibNpZDGTtwlSYfwDQHGixmkd2I
	ZCFV5icRRhCTRMGaYi7rh6QyoqRRNwYTxLca7LgvsVEvR2C+/Gs0G29sROtPIQN7A5/ozL44KGm
	1db8=
X-Google-Smtp-Source: AGHT+IFT/dBVdeBpmU0goB91Vrw7StvLKexbnwEVzXwA9OKAp+ShAaNJnzflLewcH8Sz9P42FeIjOQ==
X-Received: by 2002:a17:902:e981:b0:1db:b09c:6d0 with SMTP id f1-20020a170902e98100b001dbb09c06d0mr2454079plb.64.1709339742395;
        Fri, 01 Mar 2024 16:35:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c20400b001d6f29c12f7sm4053646pll.135.2024.03.01.16.35.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:35:41 -0800 (PST)
Message-ID: <65e2745d.170a0220.aaad.433b@mx.google.com>
Date: Fri, 01 Mar 2024 16:35:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.306-cip107-1142-gdcbd51e7744f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 40 runs,
 46 regressions (v4.19.306-cip107-1142-gdcbd51e7744f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 00:35:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15151

cip-gitlab/ci/pavel/linux-test baseline-nfs: 40 runs, 46 regressions (v4.19=
.306-cip107-1142-gdcbd51e7744f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 2          =

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig          | 2          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 10         =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 7          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 7          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 9          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.306-cip107-1142-gdcbd51e7744f/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.306-cip107-1142-gdcbd51e7744f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26972768d92b802637013

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e26972768d92b80=
2637014
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26995957b7c43d6637034

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e26995957b7c43d=
6637035
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26976957b7c43d6637013

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e26976957b7c43d=
6637014
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2698bfee3aecac9637027

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e2698bfee3aecac=
9637028
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26998957b7c43d663703d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e26998957b7c43d=
663703e
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26986957b7c43d6637028

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e26986957b7c43d=
6637029
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2682831e8320ce9637023

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/at91_dt_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/at91_dt_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e2682831e8320ce=
9637024
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 2          =


  Details:     https://kernelci.org/test/plan/id/65e26a58adbc5e1c3e637018

  Results:     43 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v5_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v5_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.atmel-usart-serial-driver-present: https://kernelci=
.org/test/case/id/65e26a58adbc5e1c3e637046
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:52:15.799448  /lava-652087/1/../bin/lava-test-case
    2024-03-01T23:52:15.877425  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Datm=
el-usart-serial-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at91-usart-mode-driver-present: https://kernelci.or=
g/test/case/id/65e26a58adbc5e1c3e637047
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:52:14.638721  /lava-652087/1/../bin/lava-test-case
    2024-03-01T23:52:14.714688  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat9=
1-usart-mode-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/65e2642ac2427777fa637026

  Results:     48 PASS, 3 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/bcm2835_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/bcm2835_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.raspberrypi-cpufreq-driver-present: https://kernelc=
i.org/test/case/id/65e2642ac2427777fa63702c
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:26:24.458770  /lava-652027/1/../bin/lava-test-case
    2024-03-01T23:26:24.594705  <8>[  116.586435] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Draspberrypi-cpufreq-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.watchdog-probed: https://kernelci.org/test/case/id/=
65e2642ac2427777fa63704f
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:25:50.804113  /lava-652027/1/../bin/lava-test-case
    2024-03-01T23:25:52.030402  <8>[   84.022169] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dwatchdog-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 10         =


  Details:     https://kernelci.org/test/plan/id/65e268684872635202637012

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65e26=
8684872635202637015
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:44:36.302997  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:36.353558  <8>[   80.093907] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65e268684872635202637018
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:44:32.927145  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:32.978214  <8>[   76.718063] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-03-01T23:44:34.018644  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:34.072532  <8>[   77.811670] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65e268684872635202637019
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:44:30.735926  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:30.795151  <8>[   74.534934] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-03-01T23:44:31.835426  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:31.886712  <8>[   75.626501] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65e26868487263520263701a
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:44:28.553066  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:28.604285  <8>[   72.344372] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-03-01T23:44:29.643965  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:29.696215  <8>[   73.435521] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65e268684872635202637024
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:44:15.087707  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:15.140560  <8>[   58.879575] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-03-01T23:44:16.180173  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:16.232991  <8>[   59.971513] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65e268684872635202637025
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:44:14.048015  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:14.050481  <8>[   57.785169] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc1-probed: https://kernelci.org/test/case/id/65e2=
6868487263520263702b
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:44:12.310310  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:12.367264  <8>[   56.107258] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc0-probed: https://kernelci.org/test/case/id/65e2=
6868487263520263702c
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:44:11.201524  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:11.255407  <8>[   54.995435] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/65e268684872635202637038
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:44:06.039941  /lava-652074/1/../bin/lava-test-case
    2024-03-01T23:44:06.102890  <8>[   49.841475] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65e268684872=
635202637041
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)
        1 lines

    2024-03-01T23:43:54.552263  / # =

    2024-03-01T23:43:54.556523  =

    2024-03-01T23:43:59.569591  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/652074/extract-nfsrootfs-fvmy_tx9'
    2024-03-01T23:43:59.580085  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/652074/extract-nfsrootfs-fvmy_tx9'
    2024-03-01T23:44:01.865123  / # export NFS_SERVER_IP=3D'192.168.56.193'
    2024-03-01T23:44:01.875576  export NFS_SERVER_IP=3D'192.168.56.193'
    2024-03-01T23:44:01.977762  / # #
    2024-03-01T23:44:01.983828  #
    2024-03-01T23:44:02.085102  / # export SHELL=3D/bin/sh
    2024-03-01T23:44:02.091139  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 7          =


  Details:     https://kernelci.org/test/plan/id/65e267c38961c4d64a637016

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-bro=
onie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-bro=
onie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/65e267c38961c4d64a637027
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:41:43.178780  /lava-652062/1/../bin/lava-test-case
    2024-03-01T23:41:43.282145  <8>[   74.415024] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/65e267c38961c4d64a63702a
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:41:40.415862  /lava-652062/1/../bin/lava-test-case
    2024-03-01T23:41:40.518074  <8>[   71.650981] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65e267c38961c4d64a63702d
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:41:36.400135  /lava-652062/1/../bin/lava-test-case
    2024-03-01T23:41:36.501376  <8>[   67.634199] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-03-01T23:41:37.602370  /lava-652062/1/../bin/lava-test-case
    2024-03-01T23:41:37.712001  <8>[   68.844463] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65e267c38961c4d64a63702e
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:41:35.196215  /lava-652062/1/../bin/lava-test-case
    2024-03-01T23:41:35.305290  <8>[   66.437676] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc1-probed: https://kernelci.org/test/case/id/65e2=
67c38961c4d64a637036
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:41:32.791857  /lava-652062/1/../bin/lava-test-case
    2024-03-01T23:41:32.897697  <8>[   64.031285] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc0-probed: https://kernelci.org/test/case/id/65e2=
67c38961c4d64a637037
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:41:31.557238  /lava-652062/1/../bin/lava-test-case
    2024-03-01T23:41:31.660759  <8>[   62.794378] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65e267c38961=
c4d64a63704c
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)
        1 lines

    2024-03-01T23:41:17.043918  / # =

    2024-03-01T23:41:17.053066  =

    2024-03-01T23:41:22.081136  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/652062/extract-nfsrootfs-m_iiumn_'
    2024-03-01T23:41:22.091721  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/652062/extract-nfsrootfs-m_iiumn_'
    2024-03-01T23:41:24.325370  / # export NFS_SERVER_IP=3D'192.168.56.39'
    2024-03-01T23:41:24.335788  export NFS_SERVER_IP=3D'192.168.56.39'
    2024-03-01T23:41:24.456051  / # #
    2024-03-01T23:41:24.461320  #
    2024-03-01T23:41:24.569965  / # export SHELL=3D/bin/sh
    2024-03-01T23:41:24.575369  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 7          =


  Details:     https://kernelci.org/test/plan/id/65e26d46006624297b63701a

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-cip=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-cip=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/65e26d46006624297b63702b
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-02T00:05:15.992602  /lava-1101481/1/../bin/lava-test-case
    2024-03-02T00:05:16.096627  <8>[   61.947606] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/65e26d46006624297b63702e
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-02T00:05:13.267883  /lava-1101481/1/../bin/lava-test-case
    2024-03-02T00:05:13.370104  <8>[   59.220964] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65e26d46006624297b637031
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-02T00:05:09.345886  /lava-1101481/1/../bin/lava-test-case
    2024-03-02T00:05:09.446788  <8>[   55.297499] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-03-02T00:05:10.543738  /lava-1101481/1/../bin/lava-test-case
    2024-03-02T00:05:10.646675  <8>[   56.497080] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65e26d46006624297b637032
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-02T00:05:08.147690  /lava-1101481/1/../bin/lava-test-case
    2024-03-02T00:05:08.247371  <8>[   54.097732] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc1-probed: https://kernelci.org/test/case/id/65e2=
6d46006624297b637039
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-02T00:05:05.793558  /lava-1101481/1/../bin/lava-test-case
    2024-03-02T00:05:05.893745  <8>[   51.745270] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc0-probed: https://kernelci.org/test/case/id/65e2=
6d46006624297b63703a
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-02T00:05:04.571306  /lava-1101481/1/../bin/lava-test-case
    2024-03-02T00:05:04.663855  <8>[   50.515389] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65e26d460066=
24297b637050
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)
        1 lines

    2024-03-02T00:04:50.564478  / # =

    2024-03-02T00:04:50.571352  =

    2024-03-02T00:04:55.628866  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/1101481/extract-nfsrootfs-me_s79wn'
    2024-03-02T00:04:55.639414  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/1101481/extract-nfsrootfs-me_s79wn'
    2024-03-02T00:04:57.806567  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2024-03-02T00:04:57.817154  export NFS_SERVER_IP=3D'192.168.11.5'
    2024-03-02T00:04:57.928324  / # #
    2024-03-02T00:04:57.933435  #
    2024-03-02T00:04:58.054429  / # export SHELL=3D/bin/sh
    2024-03-02T00:04:58.059280  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e266d42a70b58063637022

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e266d42a70b5806=
3637023
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e266c32a70b5806363701b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e266c32a70b5806=
363701c
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 9          =


  Details:     https://kernelci.org/test/plan/id/65e265f621d4d2154a637038

  Results:     24 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-nfs-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-nfs-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.lima-driver-present: https://kernelci.org/test/case=
/id/65e265f621d4d2154a63703b
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:56.108738  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:56.141155  <8>[   51.355385] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-phy-probed RESULT=3Dblocked>
    2024-03-01T23:33:57.164027  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:57.203614  <8>[   52.417778] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlima-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-hdmi-phy-driver-present: https://kernelci.org=
/test/case/id/65e265f621d4d2154a63703c
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:53.979734  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:54.011757  <8>[   49.226501] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-probed RESULT=3Dblocked>
    2024-03-01T23:33:55.034548  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:55.085731  <8>[   50.299004] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-hdmi-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-dw-hdmi-driver-present: https://kernelci.org/=
test/case/id/65e265f621d4d2154a63703d
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:51.866762  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:51.899274  <8>[   47.114216] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-probed RESULT=3Dblocked>
    2024-03-01T23:33:52.922005  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:52.955780  <8>[   48.170256] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-dw-hdmi-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-mixer-driver-present: https://kernelci.org/te=
st/case/id/65e265f621d4d2154a63703e
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:49.742515  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:49.784235  <8>[   44.999263] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Danalog-audio-probed RESULT=3Dblocked>
    2024-03-01T23:33:50.807966  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:50.844545  <8>[   46.058263] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8-codec-analog-driver-present: https://kernelci.=
org/test/case/id/65e265f621d4d2154a63703f
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:33:47.627800  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:47.662987  <8>[   42.878038] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcrypto-probed RESULT=3Dblocked>
    2024-03-01T23:33:48.686516  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:48.720356  <8>[   43.933351] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-ce-driver-present: https://kernelci.org/test/=
case/id/65e265f621d4d2154a637040
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:45.510398  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:45.545402  <8>[   40.760329] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dir-probed RESULT=3Dblocked>
    2024-03-01T23:33:46.568109  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:46.604180  <8>[   41.818563] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-ce-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sunxi-ir-driver-present: https://kernelci.org/test/=
case/id/65e265f621d4d2154a637041
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:44.441093  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:44.487395  <8>[   39.701318] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-ir-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sunxi-wdt-driver-present: https://kernelci.org/test=
/case/id/65e265f621d4d2154a637044
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:41.170414  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:41.204126  <8>[   36.418897] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsid-probed RESULT=3Dblocked>
    2024-03-01T23:33:42.226952  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:42.259985  <8>[   37.473862] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-wdt-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.eeprom-sunxi-sid-driver-present: https://kernelci.o=
rg/test/case/id/65e265f621d4d2154a637045
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:40.115070  /lava-652033/1/../bin/lava-test-case
    2024-03-01T23:33:40.148408  <8>[   35.361476] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Deeprom-sunxi-sid-driver-present RESULT=3Dfail>   =

 =20

