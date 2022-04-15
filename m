X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web12.12351.1650056792561800464
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Apr 2022 14:06:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bxxmapEI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id p10so7951893plf.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 15 Apr 2022 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ClBQRfxVBCmLJHAe3Vcb0R6LbVdvBo5yVk/5jUK6vIo=;
        b=bxxmapEIqbPtQnNZ81JCO9yZnXdrrqpKmd7nbRBwkSti0X/x/jkkPBvNI7Bh6kzCIf
         TBqPTeV88GZHS9EIwGDZZwLHTX51FuX02vHEwPikOleGjyugszeQZ6hRQg+sECWjfObw
         oCXtshlOalXbxQL3cAUJ9EtVo7nV02wYF3ZQpaaI3JYOYBrZZm5FPbfinHqNzxNQ/iHp
         kTTHp1wSQ5oDctW0jxQjuPwqRtTRezWrn8AgebifZmeF48zC9TnPFAsATFqJCjcpqDg0
         Xf0ydRRU8umusYL0URAEeKf57Vk9BZbo/Z5rizdldfAGDEDT4igcIRiBT5qQ5VAiq+jZ
         E5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ClBQRfxVBCmLJHAe3Vcb0R6LbVdvBo5yVk/5jUK6vIo=;
        b=44VvlupafOxL8AWG6eIEcSIrN90oOKhmxA3j+3c4XF16/qxhNufynu4dY4Dj4wVIAX
         qV/AYmK11bJPE63nP4N8OQqbUOMuZeNDk4iIN+gazUQC3o1qRc3mw3ur39IppjPqO2Sk
         zDCmYw0Cyoi0QTr29QGE5eIGQPzl1KKtvuQ5s74fLpkfIQrDBSuvEYw3D767dVRmbR8g
         V+nF2IcAlsMXg46u1+L6LBI9BjRwbyBcTATnBKa3g0O9nn0AVgOVZ9xEG8zPn5KZTwUR
         TZuFJumvjViu4lo+qUxyArDDXj69yWMQyoin5hf530uLRfTqrxUTU6maQ2bxYpAjbnkE
         U++w==
X-Gm-Message-State: AOAM530Q+RsJRsrroZUqJPEQmBS1AfWp95Z8rdP+GrGwyd7QWMfj0VaH
	miKtY5+3ledA1MmTgTL/9781N8rtBtMAlxII
X-Google-Smtp-Source: ABdhPJxcBS3RIUzpyHIrXREQRzgx5QpmRl0jU1LtRZQjOhc05cO/AYVLHKU+NK2mEqSNe27NLKFesQ==
X-Received: by 2002:a17:902:bc8c:b0:156:bc64:fa47 with SMTP id bb12-20020a170902bc8c00b00156bc64fa47mr788904plb.135.1650056791691;
        Fri, 15 Apr 2022 14:06:31 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a4d8200b001cb41f25148sm5742298pjh.17.2022.04.15.14.06.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 14:06:31 -0700 (PDT)
Message-ID: <6259de57.1c69fb81.60072.f3eb@mx.google.com>
Date: Fri, 15 Apr 2022 14:06:31 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.237-cip71-337-g1c3cfbe23f3d7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 5 runs, 5 regressions (v4.19.237-cip71-337-g1c3cfbe23f3d7) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 5 runs, 5 regressions (=
v4.19.237-cip71-337-g1c3cfbe23f3d7)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.237-cip71-337-g1c3cfbe23f3d7/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.237-cip71-337-g1c3cfbe23f3d7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1c3cfbe23f3d794216220a2a9fad32c5894a0f7c

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


  Details:     https://kernelci.org/test/plan/id/6259d2228d4c028686ae0688

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6259d2228d4c028686ae06=
89
        failing since 23 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8,=
 first fail: v4.19.233-cip69-120-ga36ab9aceb93) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6259d1e67005cb8a63ae0685

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6259d1e67005cb8a63ae06=
86
        failing since 23 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8,=
 first fail: v4.19.233-cip69-120-ga36ab9aceb93) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6259d4dec23f5ae310ae06a4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6259d4dec23f5ae310ae06=
a5
        failing since 17 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8,=
 first fail: v4.19.233-cip69-142-g40322771bdc1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6259da1fd45f9e4e1dae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig/gcc-10/lab-=
cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig/gcc-10/lab-=
cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6259da1fd45f9e4e1dae06=
7d
        failing since 23 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8,=
 first fail: v4.19.233-cip69-120-ga36ab9aceb93) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6259d57f48ef84ad46ae068b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6259d57f48ef84ad46ae06=
8c
        failing since 17 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8,=
 first fail: v4.19.233-cip69-142-g40322771bdc1) =

 =20

