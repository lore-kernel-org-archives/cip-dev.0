X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web08.1808.1646354185470209123
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 03 Mar 2022 16:36:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=hhv0OecX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id m22so6089550pja.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 03 Mar 2022 16:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UGtRIWJpz4sZ3dITPrxAjqxNdv6Tqv/3fWjwR3ZiIPw=;
        b=hhv0OecX7mVcDXQaALYeUb2JkmD7HhbRvnWAeHsgccFTVHMEIWXyB0HRMnGG95ep2p
         F9WIQ1UMXpuh6i4HArsYUEBSj72KpwgqfWdjx6XhHiWZwSGI3gh5/D1vrnERQHiCDmXd
         pBz65emXhABgI8JFkB2YEn+fo06BCFIsvlW2vpgb05X5/2iGMGDixsHXSLbOlOIgDUCc
         T89gWHMmvXvIP4eYFYmVDQ66lD2IwPmYf1SxlNqCqyHD4d0phII+C0KWqRMSRQ7Mrzus
         kHXzERf8pF68Y8TZbdcvrzxyEaHHuHmAwCX6XVh1AdqpfGn2qmXdVB9uMjodAuWgB0R/
         Mnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UGtRIWJpz4sZ3dITPrxAjqxNdv6Tqv/3fWjwR3ZiIPw=;
        b=13cVevowEYbwqXbzEhpHRNo4f5KtaXsonxFENjrT5ohYg4rAlWKuWuPtQsjwfVGlWG
         nNCKRwRwthhAGvcHGQgnU6khSyISECz4zXKZRSzRZCnWc7vbxLhsTCveCS+gn59lVNFg
         noUbxkHfty+jtwZj6Nso3A4BNWUxvxnZvUlWvZaguTD62HjGBOuhJAEI248c0/iKI0dq
         S0nExVc5ZKaSlpSrg8bEdGFzL3nXGbw4jKUmQZo+KfXiN0WTByb1oXFLrZDSDw0m26Wp
         Jf8Cq5Q3XdSUY0qUcEN1KfPj3POxEXLPpvvj6QuS6RGdwBuvpdf+0OcW4Xu6bnhuIMYU
         yEYg==
X-Gm-Message-State: AOAM530PH1UAyhVsiX0NNup7qUPWSeEAyu1b/mJAGR8Wik/61wT9M0He
	jkNCdYjh1ki+KeeAhwfF+Pol6G0Ttzr4jwxHVpE=
X-Google-Smtp-Source: ABdhPJwZWMHwZmlRZF4abtFG1zaiBkigiMbWRiTbo5i11mBzLtlqmq9y205aDv4e3ah/tlCTMoBZHg==
X-Received: by 2002:a17:90b:f8a:b0:1be:dccd:e4f7 with SMTP id ft10-20020a17090b0f8a00b001bedccde4f7mr8042932pjb.92.1646354184624;
        Thu, 03 Mar 2022 16:36:24 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00180500b004e1bea9c587sm3864021pfa.67.2022.03.03.16.36.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:36:24 -0800 (PST)
Message-ID: <62215f08.1c69fb81.84c7d.aa1e@mx.google.com>
Date: Thu, 03 Mar 2022 16:36:24 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-319-gcbff87047566
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs, 3 regressions (v5.10.100-cip2-319-gcbff87047566) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs, 3 reg=
ressions (v5.10.100-cip2-319-gcbff87047566)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-319-gcbff87047566/plan/kselftest=
-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-319-gcbff87047566
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cbff870475669d78815941c2e765cc5a8b6078f0 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62215004cc7490426cc62a55

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-319-gcbff87047566/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ00=
05-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-319-gcbff87047566/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ00=
05-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220218.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/62215004cc7490426cc62a5c
        new failure (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/622151c36bc3faaef1c6297a

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-319-gcbff87047566/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A200=
57-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-319-gcbff87047566/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A200=
57-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220218.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/622151c36bc3faaef1c62981
        new failure (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62215076bfdc8f639bc629bf

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-319-gcbff87047566/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gru=
nt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-319-gcbff87047566/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gru=
nt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220218.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/62215076bfdc8f639bc629c6
        new failure (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9) =

 =20

