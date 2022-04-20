X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.10240.1650473408473932457
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Apr 2022 09:50:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KG/c6Du3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id k29so2103137pgm.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Apr 2022 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Tkr28Y5cRW109qXPQYr+FJe4KLITbO2xVkyETfe+fB4=;
        b=KG/c6Du3K5/kuJqhgMh0+VwDp7xCtKhwVd867V0q3U7ydsFaKukX1MP63ISA562XJV
         JahDxrRsdG+zBfH2Tx58H4yQVCq8AFznKjZV19svMk77pT6px1TiwLFxZ1hmoQNeBcCG
         HHmSCp7tE2mnfkXaXI1ILjjxQm9yT8QI1h0uSR2CKKLl5JQ1r4XGWh7rRlukTMVzn2ff
         /LacuMxcWkv0Yi+TKdaupTQ8T6Pwul/lqFPAROqi0PCmYZXdghutM0cLHEvjyRGKb43J
         wtNCOz5kQ5U2MprH7r7mZ6itLLAm107pGtym0dlb6iKCc/GJFZSJglJPFDjPTGkAGqWP
         UQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Tkr28Y5cRW109qXPQYr+FJe4KLITbO2xVkyETfe+fB4=;
        b=UKiWkrr/wkmzXG4SIvVus9ZKI6+kDiUrEANaLtAaJJ7QAlo+EtF6wquHXqF0cKO4kW
         22anbXTUGJ1+nRFxfHwhe6oty0EL5AJoeHjYiRz1P84AUUxQOJNL0j8FvQ4x+IUs1/QK
         tQWtL2ntQVcONWaT8B3TCpYcLC7bAMYXfTgOCfsvybJKNfvo8FoAz5AbjeJ8FiEYDi9s
         gi8YYO70zQqLCCvu9EG9hzq7iWyZiObDB2BGFpGivzze2HoNgZSyQeh5GMHGAYog+pjK
         NdFkuRIC05bAwzBXlZeGj6D1jcLkLnCTo2Hut/A9jr3DBf74ekUx5dOfQ7j3klRJWgdE
         7Jfg==
X-Gm-Message-State: AOAM531hDYBHbujBHCGJT5Bo4zjpenQOC6ktxAjLEA+rDwOw6OigdnL4
	7kAz3FhG7rjfqOS9ugl6wWyKjOE1VmhbDy2Gac8=
X-Google-Smtp-Source: ABdhPJyvcped6bBa30f1otIha4duOJK4SP1gqVL/kLEB1O62W3Hd03AWyz7FKkvsFRvWc3gLoRlLpQ==
X-Received: by 2002:a05:6a00:1687:b0:4e1:45d:3ded with SMTP id k7-20020a056a00168700b004e1045d3dedmr24483515pfc.0.1650473407599;
        Wed, 20 Apr 2022 09:50:07 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c138-20020a624e90000000b005081f92826dsm21088004pfb.99.2022.04.20.09.50.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:50:07 -0700 (PDT)
Message-ID: <626039bf.1c69fb81.d335d.1bd9@mx.google.com>
Date: Wed, 20 Apr 2022 09:50:07 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-875-g6ed0fe2c3e8b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 3 regressions (v5.10.109-cip5-875-g6ed0fe2c3e8b) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 3 reg=
ressions (v5.10.109-cip5-875-g6ed0fe2c3e8b)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-875-g6ed0fe2c3e8b/plan/kselftest=
-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-875-g6ed0fe2c3e8b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6ed0fe2c3e8b47b471924ff54d5cdb9d0afb1200 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/626027600eb960693cae06a1

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ00=
05-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ00=
05-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/626027600eb960693cae06a8
        failing since 47 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/626034f744a8d50558ae0683

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A200=
57-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A200=
57-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/626034f744a8d50558ae068a
        failing since 47 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62602ae72f8184ec94ae0691

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gru=
nt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gru=
nt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/62602ae72f8184ec94ae0698
        failing since 47 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =20

