X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.21598.1650549030575545215
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Apr 2022 06:50:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=4opj1bsj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id s14so4914570plk.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Apr 2022 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LKF+Ox+SBXdoOVLvi+bWOPSf5UnSQRV+USaNpju1xE4=;
        b=4opj1bsjVVB8OGLRbA8QMePhNI4dLmumzXHVN5p/qpe+dDWpfBBaRK/NGHt9hQf/N1
         Z8Bvp1yJ4mXUkrDSX1DnnEa16EWOb4Loci8pYOMO61vVL/Q7cxuFF3LzQD1OeY91HLrL
         QEdN9S21k+Zw1w04exFydNl63BVXq0fd4NoDTOVqARKV8BdktBJykFbdrRT8V+b/or0j
         Vmr/foVvuemqs2MQjkeBQwMt9Kf+iWDTIFi6n0ejqeCHVE7diOkdXTxGFQJ4WOPSLmFM
         LwTdTIkq7OdS0EPAM2/2yhfW/++Iwpkt3Rioby2oeQmMfNLHjmgnlcqQ4c5JKunbKUT+
         vxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LKF+Ox+SBXdoOVLvi+bWOPSf5UnSQRV+USaNpju1xE4=;
        b=DSd4I8yC7A4VxeDBjfvutmq7/T6gMtTNTWYdzd9nRXjlNKA1gEFwOxbrMymfM6jf89
         XD1fN5mxCqIO55yVO4tP4qgDOFJN9QefZVUDWtxNcWDLrq0Nl1m3CEsef+FWDFWOyl5p
         VfqQwZCITz8+DF/pCKu+LblcNH6Z3WKhHOIqWs1r2leg8bxs1CRRZ0GcJyZjnA/2BAJm
         kjrs+g7ajF4nwg4owx85tVxJRLWMr38eR5yHXqBltdUpUKcJa1TGEImFkjxTzx74NXnV
         F5wQEZbCwk+G+Gun3+jOhoCI7IEv944QdhrPztIZsQ3k5LkD/rqfsqgi3wiVo3SQkY/N
         qhpw==
X-Gm-Message-State: AOAM530GXtm8KobIV83IPzYYcnOX+IfV0HM8Cz8zSqYUy99Twe7xi9LC
	pymhoC9if3y7EMHxBd8QMH/zAFIo2Y858vV0UiM=
X-Google-Smtp-Source: ABdhPJy1aIfVP6wvLzebVmKAvWng5Fk77mm2cB0dcTxwHGucGGk8dEjyDMV74omdWrf646mREUgEvA==
X-Received: by 2002:a17:90b:1a8a:b0:1d2:e93e:6604 with SMTP id ng10-20020a17090b1a8a00b001d2e93e6604mr10503807pjb.233.1650549029769;
        Thu, 21 Apr 2022 06:50:29 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f16-20020aa78b10000000b0050a81508653sm13691844pfd.198.2022.04.21.06.50.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:50:29 -0700 (PDT)
Message-ID: <62616125.1c69fb81.ac1f.f91a@mx.google.com>
Date: Thu, 21 Apr 2022 06:50:29 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.109-cip5-24-g4e205e4287c50
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 3 regressions (v5.10.109-cip5-24-g4e205e4287c50) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 3 reg=
ressions (v5.10.109-cip5-24-g4e205e4287c50)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-24-g4e205e4287c50/plan/kselftest=
-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-24-g4e205e4287c50
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4e205e4287c50edfe5c1d4c9775b0670bf9bafb4 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6260f9ab42337b6400ae06e4

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ00=
05-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ00=
05-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6260f9ab42337b6400ae06eb
        failing since 48 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6260f9dd5b09a81f3eae06d4

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A200=
57-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A200=
57-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6260f9dd5b09a81f3eae06db
        failing since 48 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6260f99c7b7ca1b047ae06ae

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gru=
nt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gru=
nt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6260f99c7b7ca1b047ae06b5
        failing since 48 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =20

