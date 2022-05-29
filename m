X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web08.26016.1653837577295555768
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 29 May 2022 08:19:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1cT9FfD9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so8451695pjq.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 29 May 2022 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=kF2JU1o84BEyrjYjgyZ0wHSxmECQyXizuasuiIGWTo0=;
        b=1cT9FfD95f6V499JUcZmwosHbshmu/5EqAzZmhsFusW3ES/7+Nmkdl6WdWnZGe+Jje
         +CnExFXW/X/9cRdMdTAf0R991bw57Aoc4TOPA6Cj5f/MLdIYonw4icg8fydloYpa7qUK
         gNy8EVn+Ju7dWnTlFIHyzW4S2Vugb92IC0x6lda1s7ir0mX3o2xisZkEWfAAV5lm1/NR
         0WzVHnLwX+Y5u4Ma4sXoIuT9XzG+N59EaDqk9LqLke37qsFR+GTa7myhnUXM/vMr+YGv
         q/3Z6CpwQsFuuDVCjQe0tUV+a2S8tjNt9XHnJsmQP8XvKfl/vOVxSd/4qX0nU8gS8X52
         Jrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=kF2JU1o84BEyrjYjgyZ0wHSxmECQyXizuasuiIGWTo0=;
        b=i/3agA6J7xOiUZs4yHgDKlzPhPbnwoqoag65HDK60TIUTNpLwEu7kV28R9erjJ6+Mf
         ivucMRY8gxhx5tkAukqNRytR1DsGN930Aq+B+BfY8xzOha5WATVmuqDtun03ki8u5GKr
         mfsAAsHD4s9u/EEwMCExo67pL/a14X+wNgocywCBAzAOf89E6alCJxAJWv8zmMgKJ/IF
         TY0gJV5CZSt8DIz8Ptk+JgOOaeKSndoqvfvWd6FMcngnAYyrrsGMTNUU6SWv4a7eJ9gp
         1hsgVQkM3TOW1+Dui9ACvBUeekl2y8eiHvhnnk3OG1JldtMRyIZwQseTPNP483gcPyfa
         KUqQ==
X-Gm-Message-State: AOAM531sRQIxbg9Ic5WdaevuLmPVJhoIW9p65Y9LCHYDWku/8U0+K2ux
	qAsnnw/3v1B94Yiq2TlXMc9+TL5UvYdj1lBJH28=
X-Google-Smtp-Source: ABdhPJysJXDBzy3ldMjFagJjo6VxCFrynGec0eeyCzV1bLF1uu8L7kYi5hF6GG0EnTSu+Z094/I9uw==
X-Received: by 2002:a17:902:ef48:b0:159:51d:f725 with SMTP id e8-20020a170902ef4800b00159051df725mr53645431plx.47.1653837576660;
        Sun, 29 May 2022 08:19:36 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902b20600b0015e8d4eb1d1sm7322922plr.27.2022.05.29.08.19.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 08:19:35 -0700 (PDT)
Message-ID: <62938f07.1c69fb81.5e153.0bbe@mx.google.com>
Date: Sun, 29 May 2022 08:19:35 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-297-gc0d53c2a5c03d
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 8 runs, 4 regressions (v4.4-st5-297-gc0d53c2a5c03d) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-ipc: 8 runs, 4 regressions (v4.4-st5-297=
-gc0d53c2a5c03d)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-297-gc0d53c2a5c03d/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-297-gc0d53c2a5c03d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0d53c2a5c03d0b2672a56140f211b51b3e047c1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  17e9ae697a340242c49188ace12a60cd3bc95a53 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937a308eee34ae0ca39beb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62937a308eee34ae0ca39b=
ec
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937aa11d3b5a920ba39be5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62937aa11d3b5a920ba39b=
e6
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62938084fc3aa7b9f0a39bd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62938084fc3aa7b9f0a39b=
d8
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937c1507d296f427a39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62937c1507d296f427a39b=
d6
        new failure (last pass: v5.10.112-cip6) =

 =20

