Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0522EC7EE2C
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 23:25:55 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.7145.1684452352611556168
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 16:25:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=OMSLNm9+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64d2467d63fso797464b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684452351; x=1687044351;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4EcLpsLVdffjWLBlJMpwgT6TdJEnXiM7eeN6e53ta4I=;
        b=OMSLNm9+pw2a/8g56PzcK1WptpxbBszXgE3r88WW4tKy094+G1c23kVpAMtqnJQmau
         8VLWIOg5P29K+8JRtoxCuIIqOQgNVS06U/CVDvoLsR9xGhpo1XnCr8vKrGJKlk1Rymuz
         S2L47OIRdZDM4H9kIJzsnFHliMzoaV0+jnpjN/ougFCYhTB4pbm17QKPmcnXI+6gt9RC
         sNMZWxRaUYyGAu+CewNVis3ve2K+fiHBWMAgCEd47bLnsSAU+4A5VveoxRAsOnHfR8eN
         vDW3T3mmnCh/HLAk5/pki2F//ctogJGE77jlUzcgebcnXNW/faVS/uUYr2HmeM9eZKiJ
         kIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684452351; x=1687044351;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EcLpsLVdffjWLBlJMpwgT6TdJEnXiM7eeN6e53ta4I=;
        b=PFncv5lgV6tTb4WnTJyizfhxBd+Q99NKMpTxde8EBVUMQoxuRC98bBnyeY19t1V6zZ
         bIGtrRAARtBax7v3PHr5FsU3NVueFLhTiqEUnln5V2MTNcOHNj1x1b6PgSnVaRwd5+oy
         y4Y/ZAoN5Kktm/8TE0WMB7tfzP0xMajqoLkbih5h26YQWQPWKaccITsctmE/8qBb3vBH
         OjMV5TtBIUxzI1aZp+NCDuXtynkHi8crk8Cj579Mpvzea09VsU7TUuFrS7MCERCFMAEA
         4zjyEHMZ29p7cW70el3IBqpepxJdRX5hvYyOOQAXIb4OuaLl9u4JNthKwhy+fzXpq0Qj
         l+6A==
X-Gm-Message-State: AC+VfDx5B3axdhZ2LngVAo6eT4QNC53P2Fwu1iuw1M4WDKQXR3FQyPgO
	hlT3EhMjrc2j3Fh81ekmbEW6xzhZlD9IokUpvo3J8g==
X-Google-Smtp-Source: ACHHUZ5qBqndcj5tdDdQG1TRRWKjey9WQou3tO/Q21teKOnlZbfbigSUmiRny/kmOQoWrS8R1BRwdA==
X-Received: by 2002:a05:6a00:893:b0:634:7ba3:d142 with SMTP id q19-20020a056a00089300b006347ba3d142mr744587pfj.10.1684452351594;
        Thu, 18 May 2023 16:25:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d3-20020aa78683000000b00640f51801e6sm1823390pfo.159.2023.05.18.16.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:25:50 -0700 (PDT)
Message-ID: <6466b3fe.a70a0220.fb5a0.3988@mx.google.com>
Date: Thu, 18 May 2023 16:25:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-rt13
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 14 runs,
 11 regressions (v5.10.179-cip32-rt13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 23:25:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11530

cip/linux-5.10.y-cip-rt ltp-timers: 14 runs, 11 regressions (v5.10.179-cip3=
2-rt13)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-chromebook     | 2          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 2          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-chromebook     | 2          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig+pr=
eempt_rt         | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+pr=
eempt_rt         | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.179-cip32-rt13/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.179-cip32-rt13
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1f0aef82759c2eef50bcbfaab1bad1aaa64a721c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/6466adf301c49e09662e85ef

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466adf301c=
49e09662e85f4
        failing since 190 days (last pass: v5.10.145-cip17-rt7, first fail:=
 v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466adf301c=
49e09662e85f4
        failing since 190 days (last pass: v5.10.145-cip17-rt7, first fail:=
 v5.10.153-cip19-rt8) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/6466acadefa3807b082e8649

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466acadefa=
3807b082e864e
        failing since 190 days (last pass: v5.10.145-cip17-rt7, first fail:=
 v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466acadefa=
3807b082e864e
        failing since 190 days (last pass: v5.10.145-cip17-rt7, first fail:=
 v5.10.153-cip19-rt8) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/6466a6111044b15ed52e85ed

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466a611104=
4b15ed52e85f2
        failing since 190 days (last pass: v5.10.145-cip17-rt7, first fail:=
 v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466a611104=
4b15ed52e85f2
        failing since 190 days (last pass: v5.10.145-cip17-rt7, first fail:=
 v5.10.153-cip19-rt8) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig+pr=
eempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a8d52d1bca52f32e85ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-timers-q=
emu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-timers-q=
emu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6466a8d52d1bca52f32=
e8600
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+pr=
eempt_rt         | 2          =


  Details:     https://kernelci.org/test/plan/id/6466a3af17e9c3d29b2e85fa

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-timers-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-timers-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466a3af17e=
9c3d29b2e8605
        new failure (last pass: v5.10.175-cip29-rt12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466a3af17e=
9c3d29b2e8605
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/6466aaf30e959141922e8604

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466aaf30e9=
59141922e860f
        new failure (last pass: v5.10.175-cip29-rt12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466aaf30e9=
59141922e860f
        new failure (last pass: v5.10.175-cip29-rt12) =

 =20

