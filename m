X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web08.9904.1648046204596383092
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Mar 2022 07:36:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=wrDm74hC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so2032228pjm.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Mar 2022 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XelyPkYcDdYOFsV52HHA8YaHJODnX9StYb7WNeZdg/I=;
        b=wrDm74hCUM2LDl1iMmpBn5B3F8asQcKoweP2ZUxH2maIuzzlOaddquSknpHu4wvpCf
         SRHEaeTibpYsJXGJptgyUz27kVIK82UwkhW3t1fKbOVAOBlGgFcHr3CkXsgz0nC3/HuP
         CzRNdCzHBFGAebcJvmMH1c/ph1SZOcyA+lVuHnZcFgkzFVo8j9zHmEqlk+7qQepuTNb7
         n1BV6U8Ujip5UMJYsIW9gsYc/FxMTHpXS9I5YxThyLp+HO3jR2ScT7kzYbASOZhVzABs
         tBmeB7pQc0JlZfpAMguEwKcghtFnTQWljxb5mbPlhpsqRQs8zAK2C2xisE9fE+fetJxG
         FKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XelyPkYcDdYOFsV52HHA8YaHJODnX9StYb7WNeZdg/I=;
        b=D2AyJajfClDrLcQB3dJzqzwJpN86a1NZcoE/vfzbcLehOJHtGotDRpqMACYzJezBYs
         tffrJKG5UpXilfTBAE4cdgGCup58mOdnB+4PgIAcJ+z5h+wOEBIFo8Cl4lFWojDQkDPz
         C++EMVqXoI6rUkr2iiaBKIfy4WW7u1BVlE4l0hpX8+TBLjhnzQtKdOM6Zt3e+rMivVls
         gXPrTSXGa+Ji2zaqssqveeBf5DgkD49XkAlQsJ77IcB0UaIBW0pjlSbu6xg6DnZTar8R
         thtRRoClisHsDgAyrLxMfK7eccjoLMxhSmUvx0sWkcqdRu29Ic90crJ6YpdibQjyXXYu
         3QNA==
X-Gm-Message-State: AOAM533ugS1MIgfTzlUX9qSw7ufuTpw3dAAyL3fSJjRDFfJd8cx0x/cm
	F9FCVuHhzP7cL1Q3dI1rcvR1liBQqC3Zmu57fNY=
X-Google-Smtp-Source: ABdhPJyXyPRZyVdUJEIU0slH+6EVSRu4vKqiTwtbfiMDOWTZBmAkbkAFz4dNzH+7/eP3VbCeC5mZgw==
X-Received: by 2002:a17:902:e80e:b0:154:1e0a:ca3f with SMTP id u14-20020a170902e80e00b001541e0aca3fmr274066plg.64.1648046203838;
        Wed, 23 Mar 2022 07:36:43 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm187009pfh.143.2022.03.23.07.36.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:36:43 -0700 (PDT)
Message-ID: <623b307b.1c69fb81.7661c.07df@mx.google.com>
Date: Wed, 23 Mar 2022 07:36:43 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.104-cip3-186-g758e0f22e236
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 2 regressions (v5.10.104-cip3-186-g758e0f22e236) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 2 reg=
ressions (v5.10.104-cip3-186-g758e0f22e236)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-186-g758e0f22e236/plan/kselftest=
-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-186-g758e0f22e236
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      758e0f22e2369c3d29d49c89c4ab585390c74a82 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/623b1cafc04a3e7490bd91a6

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ00=
05-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ00=
05-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/623b1cafc04a3e7490bd91ad
        failing since 19 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/623b296f3c59f14be0bd9184

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gru=
nt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gru=
nt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/623b296f3c59f14be0bd919e
        failing since 19 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =20

