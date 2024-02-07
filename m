Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26CAC4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 17:19:28 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.3374.1707326359746718315
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 09:19:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=xPX682wP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so669818a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 09:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707326359; x=1707931159; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JxRacV8fzum9TvCdmBYuxnnw3duGEQgV2zc0c+PEsUM=;
        b=xPX682wPec6pMYf7iy/gdWuB5w9N2fkYGUlkCNpIsDDaWJ3EdnErQUOpHsPPkL1rBt
         7eiHqOEMrRdeO5bHKNeInEcuYdflgIo1KFTqRM0g9LaLdTLIykNMlfDOhkjx7leJHs6K
         O34LTyejsUslzgmzmvW1QhC/18H+ASX07ktj1I+g+pWyxpMVJdL+jpEahnDjrpKFUrtx
         n955xgXZml+NGwSgFXEcr3QrH8W4KutqKWIcwKVNZdk3t5RV9NQbb3e1iVG3b7CGr1sK
         Ggenmi3h7d//BlUhZWAJVEElauPROamdZjN96bPkTN4WDpZh5hJqHq+NWE+FaXTOBgmj
         h9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326359; x=1707931159;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxRacV8fzum9TvCdmBYuxnnw3duGEQgV2zc0c+PEsUM=;
        b=OKKJV8p1ATrOA8CJ7peXLf9H78eAngtgfkyAaUoe+uSoxcUQV1fsHWbtB+v9qxMAHK
         ie90bc19fv8GJ3T+z62U6JTZapH+bLwUi5roLEg6UOJwvO8iAaKEy1dNLz4q88CDfj90
         EiJAGLlDrkS5uJNaanYqnxy6MHkW0viTaSh9XOdFEG2LF9BHkoEt4GnEvVjtJfgzgzNK
         uruQI0dEEIzBKKf0GNXTCtO6kbCG0TL+QihvXV+cNZlTOY0FFIClT3IzDEuYJVA9Eei4
         5H0J46GAh59UiftC+RhMhPiEqAND2b3mFeKUeXyLg6ED2grwZA6rKg+xLALwOf10j9Kt
         7Ckw==
X-Gm-Message-State: AOJu0YwruUU+5GPxtlC9s6WE9dEZaUTSPILIGIvyOLq6KDSv4adwCwh1
	rvg2hiP7SukrrO0ZIPwldLNO/LTKHcjBb+20wcY4nQ+2tjGEgCFf9K5a8oVpV72U5Tcf+IGgQyl
	HyAg=
X-Google-Smtp-Source: AGHT+IHi/b85rNjCfiTL1TOBZ4+CfG8o6tbuApQLIYC/CcDKZ9W6ZFVsnxTFm/tLZzrMQh7kj8eSDw==
X-Received: by 2002:a17:90a:8a88:b0:296:1127:ceca with SMTP id x8-20020a17090a8a8800b002961127cecamr3418499pjn.6.1707326357626;
        Wed, 07 Feb 2024 09:19:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mi14-20020a170902fcce00b001d8e41b3f95sm1713247plb.51.2024.02.07.09.19.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:19:16 -0800 (PST)
Message-ID: <65c3bb94.170a0220.686ce.550a@mx.google.com>
Date: Wed, 07 Feb 2024 09:19:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g57b839f015944
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs,
 76 regressions (v4.4.302-cip72-1251-g57b839f015944)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 17:19:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14888

cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs, 76 regressions (v4.4.=
302-cip72-1251-g57b839f015944)

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

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1251-g57b839f015944/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1251-g57b839f015944
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      57b839f0159440df3a9c4b22dccee20e801350a7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3accf8c009abf0f8e1e94

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3accf8c009abf0=
f8e1e95
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ace5da6196049c8e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3ace5da6196049=
c8e1e7b
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3acd2f8fcb444368e1e85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3acd2f8fcb4443=
68e1e86
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3acd9cb65c63f9f8e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3acd9cb65c63f9=
f8e1e7a
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3aceada6196049c8e1e86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-cp514-3wh-r0qs-guybrush.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-cp514-3wh-r0qs-guybrush.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3aceada6196049=
c8e1e87
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ac12a305f4a1028e1e7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3ac12a305f4a10=
28e1e7c
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3accd8c009abf0f8e1e8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3accd8c009abf0=
f8e1e8e
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ac5c6b022adeb28e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3ac5c6b022adeb=
28e1e7b
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3acd4f8fcb444368e1e8b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3acd4f8fcb4443=
68e1e8c
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3acf2a1400e4f978e1e7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3acf2a1400e4f9=
78e1e80
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3b21fefe55398158e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3b21fefe553981=
58e1e7a
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3b46615a05cf2ce8e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/bcm2835_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/bcm2835_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3b46615a05cf2c=
e8e1e7a
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 13         =


  Details:     https://kernelci.org/test/plan/id/65c3ac656b022adeb28e1e81

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c3a=
c656b022adeb28e1e84
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-07T16:14:08.779135  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:14:08.814028  [   81.895709] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T16:14:09.851495  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:14:09.885113  [   82.967565] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/65c3ac656b022adeb28e1e85
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:14:06.680074  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2024-02-07T16:14:07.708031  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:14:07.742617  [   80.823568] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c3ac656b022adeb28e1e86
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-07T16:14:05.560797  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:14:05.595862  [   78.677428] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T16:14:06.631875  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:14:06.667033  [   79.747743] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c3ac656b022adeb28e1e87
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-07T16:14:03.417682  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:14:03.450843  [   76.532372] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T16:14:04.488104  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:14:04.522931  [   77.603815] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c3ac656b022adeb28e1e88
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-07T16:14:01.275175  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:14:01.309357  [   74.390962] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T16:14:02.344885  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:14:02.380533  [   75.462308] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65c3ac656b022adeb28e1e92
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:13:47.960064  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:47.998439  [   61.079108] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T16:13:49.036568  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:49.083527  [   62.163649] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c3ac656b022adeb28e1e93
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-07T16:13:46.881460  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:46.918845  [   59.998508] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/65c3ac656b022adeb28e1e96
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:13:42.396474  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:42.454073  [   55.534086] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T16:13:43.491378  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:43.528232  [   56.608252] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T16:13:44.570940  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:44.608282  [   57.688221] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/65c3ac656b022adeb28e1e97
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:13:39.129828  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:39.190754  [   52.271540] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2024-02-07T16:13:40.231397  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:40.276570  [   53.357679] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2024-02-07T16:13:41.316082  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:41.359126  [   54.439286] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/65c3ac656b022adeb28e1e98
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:13:38.036351  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:38.086753  [   51.167432] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/65c3ac656b022adeb28e1e9e
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:13:33.407413  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:33.460883  [   46.540580] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/65c3ac656b022adeb28e1ea2
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:13:30.977245  /lava-554084/1/../bin/lava-test-case
    2024-02-07T16:13:31.032168  [   44.112015] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65c3ac656b02=
2adeb28e1ea9
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)
        1 lines

    2024-02-07T16:13:20.677678  / # =

    2024-02-07T16:13:20.684141  =

    2024-02-07T16:13:25.725372  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/554084/extract-nfsrootfs-3n4qx5ni'
    2024-02-07T16:13:25.736656  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/554084/extract-nfsrootfs-3n4qx5ni'
    2024-02-07T16:13:27.979993  / # export NFS_SERVER_IP=3D'192.168.56.76'
    2024-02-07T16:13:27.991048  export NFS_SERVER_IP=3D'192.168.56.76'
    2024-02-07T16:13:28.094465  / # #
    2024-02-07T16:13:28.100299  #
    2024-02-07T16:13:28.202727  / # export SHELL=3D/bin/sh
    2024-02-07T16:13:28.209104  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 13         =


  Details:     https://kernelci.org/test/plan/id/65c3b266efe55398158e1e7e

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c3b=
266efe55398158e1e81
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-07T16:39:42.562870  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:42.616431  [   76.500907] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T16:39:43.654539  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:43.692097  [   77.577656] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/65c3b266efe55398158e1e82
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:39:40.453408  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2024-02-07T16:39:41.481437  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:41.523423  [   75.407308] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c3b266efe55398158e1e83
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-07T16:39:39.321724  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:39.361672  [   73.246256] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T16:39:40.400651  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:40.440382  [   74.324452] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c3b266efe55398158e1e84
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-07T16:39:37.163174  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:37.203317  [   71.087929] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T16:39:38.243371  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:38.283036  [   72.167504] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c3b266efe55398158e1e85
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-07T16:39:35.003945  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:35.043134  [   68.927962] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T16:39:36.080682  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:36.123344  [   70.007427] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65c3b266efe55398158e1e8f
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:39:21.763072  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:21.802681  [   55.686351] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T16:39:22.840069  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:22.881397  [   56.764474] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c3b266efe55398158e1e90
        failing since 2 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-07T16:39:20.679887  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:20.721896  [   54.605010] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/65c3b266efe55398158e1e93
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:39:16.213717  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:16.255435  [   50.138529] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T16:39:17.295778  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:17.335920  [   51.219066] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T16:39:18.375574  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:18.417274  [   52.300352] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/65c3b266efe55398158e1e94
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:39:12.965913  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:13.007492  [   46.891352] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2024-02-07T16:39:14.047888  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:14.088588  [   47.972457] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2024-02-07T16:39:15.130061  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:15.173518  [   49.056616] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/65c3b266efe55398158e1e95
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:39:11.887894  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:11.927235  [   45.810135] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/65c3b266efe55398158e1e9b
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:39:07.312570  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:07.355843  [   41.238700] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/65c3b266efe55398158e1e9f
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:39:04.923424  /lava-1090276/1/../bin/lava-test-case
    2024-02-07T16:39:04.964555  [   38.847308] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65c3b266efe5=
5398158e1ea6
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)
        1 lines

    2024-02-07T16:38:54.743233  / # =

    2024-02-07T16:38:54.749492  =

    2024-02-07T16:38:59.799206  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/1090276/extract-nfsrootfs-1a_syzaf'
    2024-02-07T16:38:59.809776  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/1090276/extract-nfsrootfs-1a_syzaf'
    2024-02-07T16:39:01.968402  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2024-02-07T16:39:01.978987  export NFS_SERVER_IP=3D'192.168.11.5'
    2024-02-07T16:39:02.081716  / # #
    2024-02-07T16:39:02.087759  #
    2024-02-07T16:39:02.188947  / # export SHELL=3D/bin/sh
    2024-02-07T16:39:02.195173  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 15         =


  Details:     https://kernelci.org/test/plan/id/65c3ad2ca1400e4f978e1e9a

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c3a=
d2ca1400e4f978e1e9d
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:35.830116  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:35.930321  [   92.025183] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T16:17:37.049858  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:37.149488  [   93.245337] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/65c3ad2ca1400e4f978e1e9e
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:33.524414  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2024-02-07T16:17:34.613329  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:34.710366  [   90.804446] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c3ad2ca1400e4f978e1e9f
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:32.176126  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:32.280889  [   88.375937] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T16:17:33.400762  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:33.500092  [   89.594248] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c3ad2ca1400e4f978e1ea0
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:29.731899  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:29.830159  [   85.924856] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T16:17:30.951816  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:31.051735  [   87.146486] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c3ad2ca1400e4f978e1ea1
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:27.311896  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:27.407936  [   83.502866] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T16:17:28.529876  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:28.641124  [   84.735364] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/65c3ad2ca1400e4f978e1ea2
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:26.125154  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:26.223900  [   82.318314] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/65c3ad2ca1400e4f978e1ea7
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:23.222995  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:23.324541  [   79.418366] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/65c3ad2ca1400e4f978e1eaa
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:20.488900  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:20.594143  [   76.688131] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65c3ad2ca1400e4f978e1ead
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:16.504442  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:16.610949  [   72.704951] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T16:17:17.728207  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:17.825624  [   73.918921] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c3ad2ca1400e4f978e1eae
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:15.284162  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:15.384124  [   71.477729] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/65c3ad2ca1400e4f978e1eb6
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:09.553860  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:09.653694  [   65.747057] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2024-02-07T16:17:10.772476  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:10.868903  [   66.962606] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/65c3ad2ca1400e4f978e1eb7
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:08.329451  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:08.432940  [   64.526829] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/65c3ad2ca1400e4f978e1eba
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:05.676006  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:05.780928  [   61.874033] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/65c3ad2ca1400e4f978e1ebf
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T16:17:02.602584  /lava-554106/1/../bin/lava-test-case
    2024-02-07T16:17:02.702121  [   58.795376] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65c3ad2ca140=
0e4f978e1ec7
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)
        1 lines

    2024-02-07T16:16:51.464390  / # =

    2024-02-07T16:16:51.469263  =

    2024-02-07T16:16:56.478743  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/554106/extract-nfsrootfs-qtcaj9b3'
    2024-02-07T16:16:56.489707  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/554106/extract-nfsrootfs-qtcaj9b3'
    2024-02-07T16:16:58.723798  / # export NFS_SERVER_IP=3D'192.168.56.76'
    2024-02-07T16:16:58.734387  export NFS_SERVER_IP=3D'192.168.56.76'
    2024-02-07T16:16:58.838573  / # #
    2024-02-07T16:16:58.843464  #
    2024-02-07T16:16:58.952413  / # export SHELL=3D/bin/sh
    2024-02-07T16:16:58.957290  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 15         =


  Details:     https://kernelci.org/test/plan/id/65c3b84a8ebe4cac518e1ea6

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c3b=
84a8ebe4cac518e1ea9
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:52.960094  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:53.196746  [   89.962807] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T17:04:54.276102  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:54.450343  [   91.216518] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/65c3b84a8ebe4cac518e1eaa
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:50.591082  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2024-02-07T17:04:51.657734  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:51.880558  [   88.646411] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c3b84a8ebe4cac518e1eab
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:49.022540  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:49.230747  [   85.996957] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T17:04:50.348897  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:50.567705  [   87.332945] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c3b84a8ebe4cac518e1eac
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:46.404143  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:46.613184  [   83.378326] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T17:04:47.691643  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:47.908118  [   84.673292] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c3b84a8ebe4cac518e1ead
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:43.739702  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:43.980302  [   80.745380] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T17:04:45.082907  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:45.283585  [   82.048160] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/65c3b84a8ebe4cac518e1eae
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:42.428828  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:42.656154  [   79.421048] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/65c3b84a8ebe4cac518e1eb3
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:39.099840  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:39.264771  [   76.030179] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/65c3b84a8ebe4cac518e1eb6
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:36.035002  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:36.237691  [   73.002965] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/65c3b84a8ebe4cac518e1eb9
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:31.612414  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:31.814286  [   68.578551] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T17:04:32.935780  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:33.149163  [   69.913001] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c3b84a8ebe4cac518e1eba
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:30.302418  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:30.505514  [   67.269003] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/65c3b84a8ebe4cac518e1ec2
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:23.398473  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:23.613162  [   60.376945] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2024-02-07T17:04:24.692629  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:24.898715  [   61.663334] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/65c3b84a8ebe4cac518e1ec3
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:22.065880  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:22.282266  [   59.046702] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/65c3b84a8ebe4cac518e1ec6
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:18.983112  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:19.208139  [   55.971388] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/65c3b84a8ebe4cac518e1ecc
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)

    2024-02-07T17:04:15.234102  /lava-1090287/1/../bin/lava-test-case
    2024-02-07T17:04:15.455923  [   52.219437] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/65c3b84a8ebe=
4cac518e1ed3
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5)
        1 lines

    2024-02-07T17:04:02.814022  / # =

    2024-02-07T17:04:02.824172  =

    2024-02-07T17:04:07.882397  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/1090287/extract-nfsrootfs-z9las0w9'
    2024-02-07T17:04:07.893155  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/1090287/extract-nfsrootfs-z9las0w9'
    2024-02-07T17:04:09.938447  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2024-02-07T17:04:09.949210  export NFS_SERVER_IP=3D'172.16.3.3'
    2024-02-07T17:04:10.057321  / # #
    2024-02-07T17:04:10.064742  #
    2024-02-07T17:04:10.173933  / # export SHELL=3D/bin/sh
    2024-02-07T17:04:10.181039  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3aceca1400e4f978e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3aceca1400e4f9=
78e1e7a
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ace5cb65c63f9f8e1eb6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3ace5cb65c63f9=
f8e1eb7
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ac13a305f4a1028e1e80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3ac13a305f4a10=
28e1e81
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ac050ac7d35ac38e1ec9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-14-db0003na-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-14-db0003na-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3ac050ac7d35ac=
38e1eca
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3acea01474869e58e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3acea01474869e=
58e1e7b
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ad1d48197d63d48e1e92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3ad1d48197d63d=
48e1e93
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3acd8f8fcb444368e1e9a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3acd8f8fcb4443=
68e1e9b
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ac2202c29b09428e1ed7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3ac2202c29b094=
28e1ed8
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =20

