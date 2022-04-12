X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.5190.1649724051164312411
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Apr 2022 17:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=gbkCL3zx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id z16so16046137pfh.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Apr 2022 17:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fnVs3RB2aCBVZxj9uKgBs++7cp+ajwrf0stq02p5dX8=;
        b=gbkCL3zxlY25mfwZX9W1CD/LYZIhtZtJxX/GmMHKUcIDxlX2fJIVAwIaJdOKCOeo+9
         QIbKE0naPI1T1l0FkJ8K6Q/DnwvBmBQYXDm6/9AD87CWoiBrq/ZETgYbjn5gEON3Huxw
         SVVs5bsYIS0BnW2TFcJkqeZNyvOsY2ILzXff9sPiNWwlHDR3dK3RfLOEbkwCUMiryR0z
         Mkf5Wl1EPZTVzEbSQAanEuSf+WcSmf2QuVXKBxLegC4UBGWHj8x+zK585/NRDxiR4dzr
         cClbswW366vZwVSWwN5vSxYxXKwO/aHy+3RFNZflEU3KQeVcOlPoM3t6HVlWQ0nvGA6d
         oZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fnVs3RB2aCBVZxj9uKgBs++7cp+ajwrf0stq02p5dX8=;
        b=UFafHR5X98Ej/xw7XqLoMxD4E/RfGQzn4OCDHUlpUPRQTWzMNR6ycNK6MW7Rzj7Wfl
         yRfTFYcJ7PNEMtJL+xxywTfNZc403V2rAnLV8YAKo7nx13+G152YrPANhkIJkEwR6aVo
         I3fu9uS2FAZrYsIvErsWgFtJJbFAlbVmccx5QhCFfG5qV5v2ADWlZfWRv6y9D0lCz7/g
         pEaqKk84Bs1fQBm3JhfnHJTE0Q7umYgKQt5YxfOSawmJ/Ibc8BZNwJnCXIj3Ir2yc7aU
         T7hSvC5/sHid6ps2dTuaDfX5qPyJbDwUEfO8Re54cxEOq8zpmiDUlBYincU4q70zqeN7
         UACA==
X-Gm-Message-State: AOAM532hPALdoVR2VQsO+sd0seJZg0kFiA8HPL7Jl5yqw3s4FK+3UBL2
	eNwhGzRofjIf9qQFJo5HMsj4KkTnZ22r4Ux0
X-Google-Smtp-Source: ABdhPJx2IA2PT55FgnID41nau5xh99+urCjGFIoUJTbYEJBxFFOdXq3fr9ssUiQh3gSfCmEZX1cTLg==
X-Received: by 2002:a05:6a00:1411:b0:4fd:e594:fac0 with SMTP id l17-20020a056a00141100b004fde594fac0mr35606186pfu.79.1649724050403;
        Mon, 11 Apr 2022 17:40:50 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a630a00b001c685cfd9d1sm632145pjj.20.2022.04.11.17.40.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 17:40:49 -0700 (PDT)
Message-ID: <6254ca91.1c69fb81.a6229.26be@mx.google.com>
Date: Mon, 11 Apr 2022 17:40:49 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.106-cip4-757-gd8c01ae8a4bc9
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 3 regressions (v5.10.106-cip4-757-gd8c01ae8a4bc9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 3 reg=
ressions (v5.10.106-cip4-757-gd8c01ae8a4bc9)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.106-cip4-757-gd8c01ae8a4bc9/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.106-cip4-757-gd8c01ae8a4bc9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d8c01ae8a4bc9d22111adb18d50f655db7432e10 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6254b7590fe40d4199ae06ee

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0=
005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0=
005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6254b7590fe40d4199ae06f5
        failing since 38 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c3d57aa186e022ae06aa

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A20=
057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A20=
057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6254c3d57aa186e022ae06b1
        failing since 39 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6254b7719978254e0aae0699

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gr=
unt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gr=
unt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6254b7719978254e0aae06a0
        failing since 38 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =20

