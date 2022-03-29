X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web09.732.1648512123167684694
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Mar 2022 17:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=VyC+c6uZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so1056440pjf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Mar 2022 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KVQ+TSJo6YUqce6BgKBICkfKIWPNe9bT6Fn4985r1uA=;
        b=VyC+c6uZXouXAibCV3pC6aa/wpd/Am6zhj03j0CZUhJtkvB1nEYyLa8N4jPzGFxr87
         ukOx2x0z8s3xFPE9Hsqu+LA0K07RyFJGQ/u/pwY66KkUXdv/l+sqw0N2H5B8dT04+YEH
         gsLadcL2JGxybUmTbEqyVVya4XzutRaIRtwfhYWML9J4+whI6Xda0UZ4DvjnkdLgBUnb
         qWC16SoI9BcG5okdwOHFlVDQBkPtF1jgxXD3PMP1ZoGy/msAOde02Y3exyV3iwu8HFMp
         p2VlGuj84yQyrifhRshanccKmVpWF8jP53Mj8HPVe4GYzJu1hwPHGC0N5Kb4RWEu1r/k
         OSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KVQ+TSJo6YUqce6BgKBICkfKIWPNe9bT6Fn4985r1uA=;
        b=KMfeGEl7XNWHuEBvyRiKLhq2CXRvm4TyFK95dEOIHmIKopfLFi84OZqO0orAJtEcFV
         BNOR99TPWGakPlY+x+a+op12o1qPu5yj8h92dcvwcc2KOlbbNqs1I9BIu+rMaZZreJ1U
         WE0IL6saqJ40rucrdV9dUCmJUxT/1WLlDQyjCha1KI8gRM5UC2TDV7aMy6IEx3AXesr0
         5wqNSTMHl6KHGoG1kVb+LnoNNvpp9iW2s1TylMJmJNE+Qrn9DDTlLH/Rb7SCXdU0rrhv
         GAMeTD3Ci+PPipm5R2zS7h3t4iS3XCgZPv4Fgsme990kxk6xz076ZlHsM0b9LyN/b8JW
         6dmg==
X-Gm-Message-State: AOAM532SsXgaH1AJXLPKeJtnWYAjvu6G31ZitImtDG6kBay9JJ0FlwaM
	xvGj6tkd5GiIleWQBto26TR8fekn5hVcC86NLUw=
X-Google-Smtp-Source: ABdhPJw/YXTCAOv0k6o2CHicHAYMmQlYA3uM7/3vCvD/CC1PYWxudVBOwzV33jogp6qnq59bYg48Ww==
X-Received: by 2002:a17:903:404b:b0:154:297b:7125 with SMTP id n11-20020a170903404b00b00154297b7125mr28049090pla.11.1648512122490;
        Mon, 28 Mar 2022 17:02:02 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm17447727pfk.88.2022.03.28.17.02.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:02:02 -0700 (PDT)
Message-ID: <62424c7a.1c69fb81.6fd6f.ecbf@mx.google.com>
Date: Mon, 28 Mar 2022 17:02:02 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.104-cip3-224-gbc5581d50c4e
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 5 runs, 4 regressions (v5.10.104-cip3-224-gbc5581d50c4e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 5 runs, 4 regressions (=
v5.10.104-cip3-224-gbc5581d50c4e)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-224-gbc5581d50c4e/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-224-gbc5581d50c4e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bc5581d50c4ebee1d73a29e0e3e0ce12e959112f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62423d2b71a41cce20ae0689

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62423d2b71a41cce20ae06=
8a
        failing since 5 days (last pass: v5.10.104-cip3-132-g46c091c34fabb,=
 first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242436f48dd65b8dfae067e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6242436f48dd65b8dfae06=
7f
        failing since 5 days (last pass: v5.10.104-cip3-132-g46c091c34fabb,=
 first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62423d09e1bccea339ae0681

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62423d09e1bccea339ae06=
82
        failing since 5 days (last pass: v5.10.104-cip3-132-g46c091c34fabb,=
 first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6242425d0704707e7fae067d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6242425d0704707e7fae06=
7e
        failing since 6 days (last pass: v5.10.100-cip2-484-gede5006fb276, =
first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20

