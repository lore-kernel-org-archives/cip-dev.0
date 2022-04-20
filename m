X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web09.9433.1650469518715164960
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Apr 2022 08:45:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=T5xaCuPZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so2432674pjf.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Apr 2022 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7qDUXdku4dv8kKll1bFgR3tR881M6JvhTJ1ZXJZGw68=;
        b=T5xaCuPZRIYGxI1KjCpEg1LIm0tPF2DKZrtWvuqsgkf92SlxgkO0vb2geTjnILVZ1v
         1HKGdx10JNMuxtjS2tK9kmvbwKpr/J19fAbkJKLcoVO/MEWEACEdFx2lEfu4rzk/lkyU
         Tgvana3oC/13Xd30EDt7AP6pf9iPMhz1FFmq5ktTcnme0zysj9WAOq/zKBw8s5JcaoiX
         vQvPeXHoXrlaTDAkw/sAHbG5tW0hJm9upoLNvUAqnkfYhv6o/0e1UFMBRbpllpKY7fvq
         AZNvRpfrXUi1O2uFSAPK8cXu08wbccrRiExdPjWNMTX2R+yYGvXTsIVGCd9YmG1UcLrB
         xCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7qDUXdku4dv8kKll1bFgR3tR881M6JvhTJ1ZXJZGw68=;
        b=xMuIFd/2ZQRbfRq4Pl+YILt/SEkxL7r+KmaAiZHOmad9WorHId2m2R+BLCBbwXVNrX
         VLwCxbS876Cqnn15Z2Q61jX5v+fapTJScJrmI5zkaRuyTOlUpLOSgqD//llbgoKgObLh
         lM+7fTDpoKTlRAgcSmi1V19eePazAyi06lTfl4oF3599f4W2BhJhjDeSkjoSsxctZ9Oa
         RKyvF7DKTIrdsrRUX9S5+QKwaWz6XX1QeMHVrLOfjZPRn3xZYJvbZdsehu1mCfOh9dgv
         36VUknohT2EduB63Bigxu6e7/gWjJkkqzww8PrdmTrtXcHDwPiAO/3d9RHQENKKaW2Ep
         qp9A==
X-Gm-Message-State: AOAM532E4ztjDdahKJDObM324LVfyY1sItNYXho98EmTlPMB0M1oUQqA
	8S840VFZa6Fh+DjVZLr5yB6KeDzHe4oT9i6PXq8=
X-Google-Smtp-Source: ABdhPJxJBql6ZK/b1xiCb8W2FDl9I5c9f60RD/epCl1hVO6LhTq7eMiRkcRKnclB10EkqQhlfo9wxw==
X-Received: by 2002:a17:902:ce8a:b0:158:f043:6df5 with SMTP id f10-20020a170902ce8a00b00158f0436df5mr19592993plg.125.1650469517635;
        Wed, 20 Apr 2022 08:45:17 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm20835570pfu.82.2022.04.20.08.45.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:45:17 -0700 (PDT)
Message-ID: <62602a8d.1c69fb81.4d757.0b32@mx.google.com>
Date: Wed, 20 Apr 2022 08:45:17 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.237-cip71-369-gd31a7c52552af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 4 runs, 4 regressions (v4.19.237-cip71-369-gd31a7c52552af) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 4 runs, 4 regressions (=
v4.19.237-cip71-369-gd31a7c52552af)

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
Flinux-4.19.y-cip-rc/kernel/v4.19.237-cip71-369-gd31a7c52552af/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.237-cip71-369-gd31a7c52552af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d31a7c52552af48848c6ccbbf8a48c4f1cb17bdb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  91fd818dbff1aa3bcefae3747f83e1dd5c1586dd =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62601e0ca1985e6a89ae068f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62601e0ca1985e6a89ae06=
90
        failing since 28 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8,=
 first fail: v4.19.233-cip69-120-ga36ab9aceb93) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/626028eb4c0dbf7995ae0696

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/626028eb4c0dbf7995ae06=
97
        failing since 27 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8,=
 first fail: v4.19.233-cip69-120-ga36ab9aceb93) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/626028a472d783773eae067d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/626028a472d783773eae06=
7e
        failing since 28 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8,=
 first fail: v4.19.233-cip69-120-ga36ab9aceb93) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62601fc047a978783eae068a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62601fc047a978783eae06=
8b
        failing since 22 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8,=
 first fail: v4.19.233-cip69-142-g40322771bdc1) =

 =20

