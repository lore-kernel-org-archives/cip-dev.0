X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.10040.1648046206445759886
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Mar 2022 07:36:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Xwwiltf9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id o8so1266607pgf.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Mar 2022 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8EhuovCYMnSrrB6MEDnKvc+3bKHp/vW9CAK5MCl6JfA=;
        b=Xwwiltf9guTwzsszb65A06pec/bSjlydJf3PKkFDQI5vxKeMQ3DXoLRHay8volw4Hf
         FV3RGEOdnKILa2dL+TnubruHmKA8dp00QWU3ws3oXxHfZIFXcXsBIBUv7ml+GVrFI8A9
         HuVbPMcjUbEzx0LKV7ruiwjZNOGrr4G6jgHLM2xGvfGIBbRZUoybTcaHli9yUiXp0dBr
         DBHitMZj6TZgSNWBQ1fro//8GwBoVrW6XMbi5ywxSdT2vTqIwPWO/onMaNgk9Jl25SI4
         TyPy0Fbbp2KUjZSj25guNM8ko5feWS07Vg0HGhLCm1Kknk3k3IzAxDSbf2SnIC+WtUvT
         NSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8EhuovCYMnSrrB6MEDnKvc+3bKHp/vW9CAK5MCl6JfA=;
        b=A+p4k9j+k0HHYA0GiN9t57dymjs5fI3Phf1/1b6jixbsykPY3eDc0nQssYfQrbXC4R
         t5ok6LsR6a6Puxwi+jJH4xed2KqxHR2IkjEcQ2qp0xo+W8i+JfB5fU5vlkw3JSuzbHSq
         nL8Ov2ow9Iv5do3Tda2XG8YyLpBntOOlE3UqgrAhyBqLaZO3LWTJHZcDEzroVetNw1S+
         jzmDbIj/kUUDdkGNjHvQNykxKYjwVeTufxlfgsam7tthj0kIgfNyEygbj0Kn9yxv6l6r
         opuo046H/vjuZWkNmx3FzIUgcmDaKAzZg/x3gE2LLsBpVT5YCh4cLbtNHbrJyZr0hdxD
         yjPw==
X-Gm-Message-State: AOAM531EXfp17ajKYW2ODceErQXZQVu4db7AghaabE54545tgyiN8k6E
	2XEujovpboBS+CdFT/KNhT+yL67r5hG/jHZWve0=
X-Google-Smtp-Source: ABdhPJy7RuIaqGsn1pZgOAo4csmHgfDmuSbS7xgFv6JZSARMTOR+Yn7TxhwzT/uQv60lXUZM04mCtA==
X-Received: by 2002:a63:ae48:0:b0:386:2e2a:c16a with SMTP id e8-20020a63ae48000000b003862e2ac16amr167365pgp.59.1648046205764;
        Wed, 23 Mar 2022 07:36:45 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a630a00b001c685cfd9d1sm7324pjj.20.2022.03.23.07.36.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:36:45 -0700 (PDT)
Message-ID: <623b307d.1c69fb81.3342.0048@mx.google.com>
Date: Wed, 23 Mar 2022 07:36:45 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.104-cip3-186-g758e0f22e236
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 4 runs, 4 regressions (v5.10.104-cip3-186-g758e0f22e236) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 4 runs, 4 regression=
s (v5.10.104-cip3-186-g758e0f22e236)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-186-g758e0f22e236/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-186-g758e0f22e236
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      758e0f22e2369c3d29d49c89c4ab585390c74a82

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/623b2cd40856de6f02bd9193

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623b2cd4085=
6de6f02bd9198
        failing since 14 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623b2cd4085=
6de6f02bd9198
        failing since 14 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/623b270bf7b1ca05b1bd9197

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623b270cf7b=
1ca05b1bd91a2
        failing since 9 days (last pass: v5.10.100-cip2-425-g0a0d92194f39, =
first fail: v5.10.100-cip2-484-gede5006fb276) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623b270cf7b=
1ca05b1bd91a2
        failing since 9 days (last pass: v5.10.100-cip2-425-g0a0d92194f39, =
first fail: v5.10.100-cip2-484-gede5006fb276) =

 =20

