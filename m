Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D10C4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 04:28:29 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
 by mx.groups.io with SMTP id smtpd.web10.13771.1707280102471747420
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 20:28:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=QIU63vTT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.43, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dc36e501e1so123808a34.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 20:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707280101; x=1707884901; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xG9EJzfaRfAc5bX8Umvz4khesHxMN9MnCKAGMvbS6bU=;
        b=QIU63vTTlKYSjeC2nJJeIS2dUtK8C095VH5aRjcMCpkpG79ig5qfuYjVi/faPom1iS
         +5BIzLJ3W9/hVncjgLYWGJDERy58Xo9qXo/mupKl7sXeGZobH1Y4G4lc6ZpGkvWofEbK
         tBHlsMJS4GG63h84pGvc4hLFWOW6pXjHKqD66d9UscpzMNMnYJhtZFyaW6Eg9NrnSR5r
         l6nFb5H/8736yLi0vuQfYF7qXcUwND+XzrHIp8Vz4ZdpDu0iXnui3EG7DsFogk6WvXOJ
         aEfdTXEkRMKXMTiLMweqGTHLs5sSrRtYTQLwZSwJoNw5k0Q+NUTb7L3XiKETp3mVa4s0
         GWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707280101; x=1707884901;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG9EJzfaRfAc5bX8Umvz4khesHxMN9MnCKAGMvbS6bU=;
        b=d7pNE/J0X4TcFWmrKnuEq+S0P9H5zJu9upWDiPLVsyubq60IoPF3oACsdQnRYK2wPT
         iDafuL95AIeEYyfj+6r9BBBcep67dZdoNGDwtTZQbTN1FDtPAhA6Mw0BtoDnFNHIrXO5
         QKGpFYZyh0wU0jAj6Vb5dAGcuI7ydmWVGy253herXw1YaM2vsjVzFXzFlPnrjkedAVup
         OagKQCuxtGBWnyiBVY/SopkShFLrAU0LjObiTHVOTzBhgB2AWCdRRZcRyVn3roEtWuyr
         mr9kJAR2NtqIbyIaqbw8Kp2xUJDWvyGpmG7FDNVNDcMF8Mq1CByglfLANU2oPxlo1Ej1
         lHGw==
X-Gm-Message-State: AOJu0YyPbngo7hoCCHUIie++T+Wn4MO3FFcQCXJKtgwRU6CoQLr3IFf+
	IWkSADU5F2xj4R3gptdv4USyf7lo5an4L+GftkqAwR4PMAAWetTJUYRZoLg+VH+1sy3cB0XrbxV
	D
X-Google-Smtp-Source: AGHT+IGqpxhqKSmPzKwJw6clP3rV4kFwPd3mz/vC7nPB18WRhKYQCQInVfZh9x4g3Dt11cugrGEKiw==
X-Received: by 2002:a05:6359:4113:b0:178:7d98:f7ab with SMTP id kh19-20020a056359411300b001787d98f7abmr1567458rwc.15.1707280100098;
        Tue, 06 Feb 2024 20:28:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qb3-20020a17090b280300b00296dcee8212sm433292pjb.49.2024.02.06.20.28.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:28:19 -0800 (PST)
Message-ID: <65c306e3.170a0220.ec050.1680@mx.google.com>
Date: Tue, 06 Feb 2024 20:28:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-g39ff255b75f5
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs,
 77 regressions (v4.4.302-cip72-1250-g39ff255b75f5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 04:28:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14860

cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs, 77 regressions (v4.4.=
302-cip72-1250-g39ff255b75f5)

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

acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig          | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 13         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 13         =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 15         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1250-g39ff255b75f5/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1250-g39ff255b75f5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      39ff255b75f5caee714b345c0c47b1c44b88dbe0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb13998b3052258e1e83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb13998b30522=
58e1e84
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb2176d9bda0ec8e1ea1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb2176d9bda0e=
c8e1ea2
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb129194736ef28e1e84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb129194736ef=
28e1e85
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb70659ec511888e1ea2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb70659ec5118=
88e1ea3
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb219194736ef28e1e9c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cp514-3wh-r0qs-guybrush.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cp514-3wh-r0qs-guybrush.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb219194736ef=
28e1e9d
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa48980bbd9ade8e1e85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fa48980bbd9ad=
e8e1e86
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb10998b3052258e1e7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb10998b30522=
58e1e7f
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa6c725221e59b8e1ee2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fa6c725221e59=
b8e1ee3
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb24998b3052258e1e98

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb24998b30522=
58e1e99
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb1c9194736ef28e1e8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb1c9194736ef=
28e1e8e
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fbd2ada23b902e8e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fbd2ada23b902=
e8e1e7b
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb00e1883173a38e1e7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/bcm2835_defconfig/gcc-10/lab-broonie=
/baseline-nfs-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/bcm2835_defconfig/gcc-10/lab-broonie=
/baseline-nfs-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb00e1883173a=
38e1e7c
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 13         =


  Details:     https://kernelci.org/test/plan/id/65c2faf4562b54d8768e1e7b

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c2f=
af4562b54d8768e1e7e
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:37:16.178597  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:37:16.232396  [   82.972796] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T03:37:17.270811  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:37:17.316947  [   84.058338] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/65c2faf4562b54d8768e1e7f
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:37:14.051340  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2024-02-07T03:37:15.082646  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:37:15.138888  [   81.878720] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c2faf4562b54d8768e1e80
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:37:12.901121  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:37:12.949115  [   79.690005] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T03:37:13.990312  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:37:14.038638  [   80.778862] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c2faf4562b54d8768e1e81
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:37:10.722684  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:37:10.775790  [   77.516482] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T03:37:11.815028  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:37:11.861793  [   78.602164] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c2faf4562b54d8768e1e82
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:37:08.561874  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:37:08.600838  [   75.341855] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T03:37:09.640379  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:37:09.682885  [   76.423211] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65c2faf4562b54d8768e1e8c
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:36:55.301318  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:55.340641  [   62.080327] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T03:36:56.380033  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:56.421199  [   63.160678] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c2faf4562b54d8768e1e8d
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:36:54.221267  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:54.259331  [   60.998857] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/65c2faf4562b54d8768e1e90
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:36:49.723485  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:49.772245  [   56.511872] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T03:36:50.815713  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:50.861348  [   57.600968] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T03:36:51.903400  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:51.944867  [   58.684198] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/65c2faf4562b54d8768e1e91
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:36:46.450014  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:46.496291  [   53.236739] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2024-02-07T03:36:47.536818  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:47.588274  [   54.328387] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2024-02-07T03:36:48.630890  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:48.681876  [   55.421483] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/65c2faf4562b54d8768e1e92
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:36:45.370403  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:45.409229  [   52.148575] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/65c2faf4562b54d8768e1e98
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:36:40.762483  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:40.812728  [   47.551813] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/65c2faf4562b54d8768e1e9c
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:36:38.386902  /lava-552011/1/../bin/lava-test-case
    2024-02-07T03:36:38.424936  [   45.164292] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65c2faf4562b=
54d8768e1ea3
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)
        1 lines

    2024-02-07T03:36:28.137928  / # =

    2024-02-07T03:36:28.144582  =

    2024-02-07T03:36:33.149833  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/552011/extract-nfsrootfs-n0dulowg'
    2024-02-07T03:36:33.160359  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/552011/extract-nfsrootfs-n0dulowg'
    2024-02-07T03:36:35.451642  / # export NFS_SERVER_IP=3D'192.168.56.193'
    2024-02-07T03:36:35.462686  export NFS_SERVER_IP=3D'192.168.56.193'
    2024-02-07T03:36:35.566171  / # #
    2024-02-07T03:36:35.573275  #
    2024-02-07T03:36:35.675613  / # export SHELL=3D/bin/sh
    2024-02-07T03:36:35.682556  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 13         =


  Details:     https://kernelci.org/test/plan/id/65c3018bdb9d723db58e1e84

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c30=
18bdb9d723db58e1e87
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T04:05:12.233640  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:05:12.338721  [   86.821189] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T04:05:13.383499  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:05:13.490096  [   87.971907] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/65c3018bdb9d723db58e1e88
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T04:05:10.005593  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2024-02-07T04:05:11.039239  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:05:11.190558  [   85.669793] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c3018bdb9d723db58e1e89
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T04:05:08.567707  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:05:08.732625  [   83.214179] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T04:05:09.773824  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:05:09.991425  [   84.472599] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c3018bdb9d723db58e1e8a
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T04:05:06.147574  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:05:06.292474  [   80.773488] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T04:05:07.330971  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:05:07.530937  [   82.011406] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c3018bdb9d723db58e1e8b
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T04:05:03.820052  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:05:03.949728  [   78.431440] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T04:05:04.990596  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:05:05.110029  [   79.590597] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65c3018bdb9d723db58e1e95
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T04:04:48.554080  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:48.725231  [   63.204510] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T04:04:49.765759  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:49.949564  [   64.429743] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/65c3018bdb9d723db58e1e97
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T04:04:41.931103  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:42.127818  [   56.607312] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T04:04:43.167370  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:43.335525  [   57.815484] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T04:04:44.375636  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:44.539504  [   59.018364] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/65c3018bdb9d723db58e1e98
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T04:04:38.406894  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:38.533678  [   53.013574] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2024-02-07T04:04:39.572472  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:39.694445  [   54.173711] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2024-02-07T04:04:40.733099  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:40.889466  [   55.368358] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/65c3018bdb9d723db58e1e99
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T04:04:37.208504  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:37.366890  [   51.846445] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/65c3018bdb9d723db58e1e9f
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T04:04:31.619948  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:31.785704  [   46.264931] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/65c3018bdb9d723db58e1ea3
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T04:04:28.638006  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:28.839341  [   43.318019] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c3018bdb9d723db58e1ea7
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T04:04:47.327757  /lava-1089710/1/../bin/lava-test-case
    2024-02-07T04:04:47.511365  [   61.990607] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65c3018bdb9d=
723db58e1eac
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)
        1 lines

    2024-02-07T04:04:17.208549  / # =

    2024-02-07T04:04:17.216678  =

    2024-02-07T04:04:22.268899  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/1089710/extract-nfsrootfs-pcv3c9eg'
    2024-02-07T04:04:22.279711  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/1089710/extract-nfsrootfs-pcv3c9eg'
    2024-02-07T04:04:24.318994  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2024-02-07T04:04:24.329853  export NFS_SERVER_IP=3D'172.16.3.3'
    2024-02-07T04:04:24.434115  / # #
    2024-02-07T04:04:24.441939  #
    2024-02-07T04:04:24.543728  / # export SHELL=3D/bin/sh
    2024-02-07T04:04:24.551663  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 15         =


  Details:     https://kernelci.org/test/plan/id/65c2f9c295eb94e7118e1eef

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c2f=
9c295eb94e7118e1ef2
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:32:10.669291  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:32:10.781461  [  100.675850] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T03:32:11.900330  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:32:12.003314  [  101.898853] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/65c2f9c295eb94e7118e1ef3
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:32:08.318429  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2024-02-07T03:32:09.436200  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:32:09.548083  [   99.441822] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c2f9c295eb94e7118e1ef4
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:32:06.922555  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:32:07.038265  [   96.932521] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T03:32:08.160306  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:32:08.292648  [   98.186593] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c2f9c295eb94e7118e1ef5
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:32:02.289262  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:32:04.433167  [   94.327152] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T03:32:05.570067  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:32:05.837126  [   95.731309] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c2f9c295eb94e7118e1ef6
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:31:59.780452  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:59.897468  [   89.791356] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T03:32:01.026656  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:32:01.145781  [   91.039112] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/65c2f9c295eb94e7118e1ef7
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:31:58.526376  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:58.645091  [   88.538491] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/65c2f9c295eb94e7118e1efc
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:31:55.465432  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:55.604925  [   85.498033] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/65c2f9c295eb94e7118e1eff
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:31:52.608797  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:52.723795  [   82.616990] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65c2f9c295eb94e7118e1f02
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:31:48.021062  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:48.336344  [   78.229374] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T03:31:49.468525  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:49.768251  [   79.661017] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c2f9c295eb94e7118e1f03
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:31:46.608292  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:46.891461  [   76.784204] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/65c2f9c295eb94e7118e1f05
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:31:40.639315  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:40.753525  [   70.646248] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2024-02-07T03:31:41.874573  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:41.978140  [   71.871054] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/65c2f9c295eb94e7118e1f07
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:31:39.404514  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:39.517649  [   69.411018] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/65c2f9c295eb94e7118e1f0a
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:31:36.708977  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:36.814582  [   66.707497] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/65c2f9c295eb94e7118e1f10
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:31:33.550875  /lava-551973/1/../bin/lava-test-case
    2024-02-07T03:31:33.666330  [   63.559150] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65c2f9c295eb=
94e7118e1f1c
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)
        1 lines

    2024-02-07T03:31:18.715603  / # =

    2024-02-07T03:31:18.720126  =

    2024-02-07T03:31:23.747442  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/551973/extract-nfsrootfs-vc_puk6u'
    2024-02-07T03:31:23.758108  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/551973/extract-nfsrootfs-vc_puk6u'
    2024-02-07T03:31:25.994885  / # export NFS_SERVER_IP=3D'192.168.56.39'
    2024-02-07T03:31:26.005965  export NFS_SERVER_IP=3D'192.168.56.39'
    2024-02-07T03:31:26.111244  / # #
    2024-02-07T03:31:26.116698  #
    2024-02-07T03:31:26.225901  / # export SHELL=3D/bin/sh
    2024-02-07T03:31:26.231721  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 15         =


  Details:     https://kernelci.org/test/plan/id/65c2fc8dada23b902e8e1f94

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c2f=
c8dada23b902e8e1f97
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:49.260953  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:49.473316  [   91.891057] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T03:43:50.589639  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:50.797517  [   93.216071] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/65c2fc8dada23b902e8e1f98
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:46.846940  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2024-02-07T03:43:47.945293  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:48.148174  [   90.565964] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c2fc8dada23b902e8e1f99
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:45.273596  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:45.473298  [   87.890937] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T03:43:46.605709  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:46.822250  [   89.238412] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c2fc8dada23b902e8e1f9a
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:42.590618  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:42.839819  [   85.256660] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T03:43:43.944393  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:44.151394  [   86.568917] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c2fc8dada23b902e8e1f9b
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:39.930368  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:40.142496  [   82.560195] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T03:43:41.258674  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:41.477373  [   83.893536] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/65c2fc8dada23b902e8e1f9c
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:38.678660  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:38.853161  [   81.270151] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/65c2fc8dada23b902e8e1fa1
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:35.113751  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:35.328643  [   77.745557] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c2fc8dada23b902e8e1fa4
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:26.242447  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:26.434718  [   68.850738] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/65c2fc8dada23b902e8e1fac
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:18.774224  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:18.985763  [   61.400914] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2024-02-07T03:43:20.063889  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:20.246523  [   62.662103] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/65c2fc8dada23b902e8e1fad
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:17.451769  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:17.655914  [   60.070717] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/65c2fc8dada23b902e8e1fb0
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:14.427495  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:14.613283  [   57.027814] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/65c2fc8dada23b902e8e1fb6
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:10.733955  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:10.936986  [   53.351748] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65c2fc8dada23b902e8e1fbc
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:27.526432  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:27.746217  [   70.161572] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T03:43:28.858159  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:29.071070  [   71.486482] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/65c2fc8dada23b902e8e1fbd
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:43:31.960673  /lava-1089694/1/../bin/lava-test-case
    2024-02-07T03:43:32.160405  [   74.576779] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65c2fc8dada2=
3b902e8e1fc1
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)
        1 lines

    2024-02-07T03:42:56.552072  / # =

    2024-02-07T03:42:56.561392  =

    2024-02-07T03:43:01.605617  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/1089694/extract-nfsrootfs-e3n8_n8j'
    2024-02-07T03:43:01.615973  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/1089694/extract-nfsrootfs-e3n8_n8j'
    2024-02-07T03:43:03.660460  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2024-02-07T03:43:03.671308  export NFS_SERVER_IP=3D'172.16.3.3'
    2024-02-07T03:43:03.778967  / # #
    2024-02-07T03:43:03.786298  #
    2024-02-07T03:43:03.894491  / # export SHELL=3D/bin/sh
    2024-02-07T03:43:03.901432  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb273e9268596d8e1e93

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb273e9268596=
d8e1e94
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb344ef0f6438e8e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb344ef0f6438=
e8e1e7a
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa58725221e59b8e1ea1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fa58725221e59=
b8e1ea2
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa68725221e59b8e1eaa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-hp-14-db0003na-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-hp-14-db0003na-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fa68725221e59=
b8e1eab
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb1276d9bda0ec8e1e7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb1276d9bda0e=
c8e1e80
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb5f37abb73bc18e1e9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb5f37abb73bc=
18e1ea0
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb1f9194736ef28e1e99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fb1f9194736ef=
28e1e9a
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fd956a20a14cf88e1ec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fd956a20a14cf=
88e1ec8
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa57725221e59b8e1e9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2fa57725221e59=
b8e1e9f
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =20

