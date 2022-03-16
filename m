X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.3725.1647472423134812760
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 16:13:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KFVRWtCT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id q19so1290133pgm.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7HdvhGyl3+OWXS7dU5TC3A/1Hg8bFitujwkr9LV2rvc=;
        b=KFVRWtCTib/9TVxuqXaWNPAJYPEcNNOwFogSNBMCAY09kUu6pZBS6aSMG2FOhuoPVW
         KlaHKDEF4bSnHZGbcSl8vtISmKaELbN6p6VMDu4weRb2Iu1zZBP2DLHF5kL+lrzKDl2a
         QA+cygytQEiKXRPcz51GrM0SN0wfJ7ACAzXLHNq/g2Sv1ZvswA9vrxpkYeConPUR81g4
         dFBRTNPP89zyDZb2J4A6nwq+MibDt+d2mCXwpp1Uc3ebVzZ/YiJ7EGPRlm/5Vs0xnn5Z
         WPKbC3A7uaaDERgHf1Y9LrN3z6UEyGX5Zk2zJUXrO+SqWt8dsPrmlilSLgHW9gVdHnZg
         rkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7HdvhGyl3+OWXS7dU5TC3A/1Hg8bFitujwkr9LV2rvc=;
        b=QtzzJoVhM7nq597792hMe6Xjfz6mcWEKkiY85QPV+sJFv+g3o4NkgVy6CPZW7st5jx
         MVDY2v/ofpFRaz1FnxWjdSKPrjw9S+o0D6NtY2Zn64y1clOh2UAyrCkGDTT93pU/jgxJ
         aOk9YBYT2U/Miijoa4uXwdNHrIRDX4LBftXnXVAaG7sPMLaUv0SegkGaEX3WPWrBC7UM
         mxRg0zhua747egNan5My8jRYnyiMCXq/4uHLwV4HM8v+yJ4XIONnkyYBe73+pJclQImE
         GlnX71FRYUWLAnttyNVc7CPpRefoe71YFm18ZCgyKC+I0QPyrBUwH4xN3tzZDRsWSdMB
         wqXg==
X-Gm-Message-State: AOAM533J+OV8OHS6hhnqyhtjjgOsvSPWAmZGJq846cOHE+E7ILrqFXU2
	8S2ipZGx/3QhfSjKpBd2WXumqEww29vr13Elyiw=
X-Google-Smtp-Source: ABdhPJycwF+iR4C/BDP14GwgUjEGsiYCwUc8ScIAXc9bwQ4jTyZvlc5C+RBb3Bn/1vb2drbW8/qd8g==
X-Received: by 2002:a63:2250:0:b0:372:c564:621b with SMTP id t16-20020a632250000000b00372c564621bmr1393889pgm.601.1647472422332;
        Wed, 16 Mar 2022 16:13:42 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b5-20020a056a0002c500b004f6dbd217c9sm4002508pft.108.2022.03.16.16.13.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:13:41 -0700 (PDT)
Message-ID: <62326f25.1c69fb81.8731e.a77d@mx.google.com>
Date: Wed, 16 Mar 2022 16:13:41 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.104-cip3-132-g46c091c34fabb
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 3 regressions (v5.10.104-cip3-132-g46c091c34fabb) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 3 reg=
ressions (v5.10.104-cip3-132-g46c091c34fabb)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-132-g46c091c34fabb/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-132-g46c091c34fabb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      46c091c34fabba36aab030f3c3c0d43214e7806e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/623257f3cd20900652c629e3

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0=
005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0=
005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220228.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/623257f3cd20900652c629ea
        failing since 12 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/623258315b0254d86cc62980

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A20=
057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A20=
057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220228.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/623258315b0254d86cc62987
        failing since 12 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6232580eda81e1e25fc6299d

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gr=
unt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gr=
unt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220228.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6232580eda81e1e25fc629a4
        failing since 12 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =20

