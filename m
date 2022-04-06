X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web08.4044.1649213191080169704
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Apr 2022 19:46:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=NEUsiBtO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso4490729pjz.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Apr 2022 19:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pXYwMiaSq74aU+FnJAZ3iHOR2a2CEUMSUv7fAGOlA0o=;
        b=NEUsiBtOnMb28RYDim2YVtYFRPLF+TJ3n7D/2eQDO9FWLR6F9/avmdsAjnW1PkGQPD
         ENwHRV9Ac25eRmp9TMD5ynvTuHrdD7LeMXyeNIJOByaxePnM7MMCGaXJ4ftKFIJkf8vI
         LgB7yz8fqxSro0jQ1Aqa3wlFF/ss935bZJj7A7PoZ6b9lDw45gzOR1yrjbdZ3bVntmWN
         l9Or9vjxSAlxAXJooDqgk6hyZuqfkfFEfc98IRlDiPvPzkjj86wODf5++5BDpAZtjd48
         0oISqzo3ILz9GDT5QWNBIEiRQEDnwLv8+3UoFdzUZqeJ+vy1zw7of7hWjyLV6mEIdGkN
         u1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pXYwMiaSq74aU+FnJAZ3iHOR2a2CEUMSUv7fAGOlA0o=;
        b=Ljy6rXNTnN+J21rB+3vvUTqOU7g+g3aKYe7BluBVBv60lg0CTly/ZfPFKwketMOBW0
         +ot0vBbdQfBC3xB052hRN0PdUAUstj9sFL5qFfg+/8sGkTuZJa9bc1cD3E9OSJdGV4Zq
         Z0fCVroMgxkCymixTRl2lkVXpL/lPvWPZAbhhbw1In2jjHGaGorpqwiabbM8hONID8ay
         mazLiIADnK1l3iFPYcx6XHkRVaKvz5WQ6iSoOsRwPh95p1K7JHXCMPygexu9lDB+IS2y
         McswGGc6VDSky50JEvNJKSfggvci/m3iLz3DdCeEC3NcGPN+goKbBBVU5xQf0+7lpMQU
         dc4Q==
X-Gm-Message-State: AOAM5306THB6IKrORqPfX6s1S6VrnBlLiiyTgiQHqw6451WnLyvbkIb4
	QuKhFmdAzlIt6B3dvtdHb5XhVfXGqNo8cgNMbhE=
X-Google-Smtp-Source: ABdhPJzKD1VSYHgRQ2+IkYmH9a0y/VrMKtHjHlZNi4iJZ8ggtdfs4aCkpyH/fyioehBSOw0fyI9gWg==
X-Received: by 2002:a17:902:a98b:b0:156:40cc:ddf6 with SMTP id bh11-20020a170902a98b00b0015640ccddf6mr6574851plb.111.1649213190476;
        Tue, 05 Apr 2022 19:46:30 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a001ad000b004fb358ffe86sm17127668pfv.137.2022.04.05.19.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:46:30 -0700 (PDT)
Message-ID: <624cff06.1c69fb81.81f3.df8c@mx.google.com>
Date: Tue, 05 Apr 2022 19:46:30 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4-66-gc8c4cc5cdb54c
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 5 runs, 4 regressions (v5.10.106-cip4-66-gc8c4cc5cdb54c) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-pty: 5 runs, 4 regressions (v5.10.106-cip4-66-gc8c=
4cc5cdb54c)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4-66-gc8c4cc5cdb54c/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4-66-gc8c4cc5cdb54c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8c4cc5cdb54c5d2534c7533f0cd8a10adff3ba0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  163cca9acb71d06492836a667a53554ceec37639 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624ceedb39ab88c10bae06af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/624ceedb39ab88c10bae06=
b0
        failing since 7 days (last pass: v5.10.83-cip1-151-ga4163710a1dc, f=
irst fail: v5.10.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/624cec641091904bbaae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/624cec641091904bbaae06=
7d
        failing since 7 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, f=
irst fail: v5.10.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/624cf4ea35f0a06f3dae0693

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/624cf4ea35f0a06f3dae06=
94
        failing since 7 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, f=
irst fail: v5.10.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/624cf2565729f8dbb5ae0685

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/624cf2565729f8dbb5ae06=
86
        failing since 7 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, f=
irst fail: v5.10.106-cip4) =

 =20

