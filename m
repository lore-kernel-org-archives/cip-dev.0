X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web12.5462.1647307800577059293
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 18:30:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=3k/+fnlV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id f8so17069080pfj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 18:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yQvfPsJHhBBA0rHwSaUNMaButmQS9WItz3A87EU9iWY=;
        b=3k/+fnlVDwE54Nfp+9HmNj8QrV1T4r3kxaLjaNHrwLCn3OQZ0G+i/g66UWZJuFQnad
         gRG6TrslKBUcHmUoSG4190qBlf1SOu6oO8qO6pb82/9D+MEWRPEPOy14130S8nmLQW4i
         23BnMwIhokDSvh2AuHVnG42DyhA40/EUvrcgX/v5L35ijpNMGa225ZgVX+EeSR6EdYPa
         qTrbmOUNvlf0+X5XpJjqmL2By515glJPENm8kjjoUSZmtuwRKzl0HwjPH9ik1EkGltyt
         SPvmepcHPtLrqUs/kvaHQCnrrIKkvO0fYmOTkU5PM2VvpAxQoQJLyLR+ZAebLkNlYTVW
         CWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yQvfPsJHhBBA0rHwSaUNMaButmQS9WItz3A87EU9iWY=;
        b=A41sm7KFKFuqxFtPwk1JDuOwTHFs6CAYzX0qbVB7NtqLHKvi33oqw85tsYXs0fB0/N
         GyUUFqJAZVhLMtTge6+AzmzOTtUfl/ala6Al73KqmdfF6/gFyvlPANRtroULU/PdhBY/
         ut9EHj+CfzMrNsy8au6aKJg8pOD7/6cbqQ54zaVzD/+T3VOLR4YSE73EWrI1tt3tJZoh
         odkHhmTS8Xf+gWhMuYatPzrLxmrLeTdM4qXrwzwEuJMEo6MWLW374Og6ZjZAO0kPa67w
         XLddNuHsdd9VbTE/rSVO6QPLUKFiu/9B6zH9d+gHDJMRm0ukXC4oP5nV3M5a24h/nGk1
         GI8w==
X-Gm-Message-State: AOAM532Z5UCxKzc60X51wQASE5anHdGRbPaaXVWg/SKDHjjZnyX0u1i6
	5/Liv+Y6jxlcrt18Cgkd91VZXSLdufM08jWoLIM=
X-Google-Smtp-Source: ABdhPJwdhDEgX2fz/+Z/e7iembq1hJaVPJOsdYs2HRgmklZa0An6FEkfumJjhqzTbwdein7b327rwg==
X-Received: by 2002:a63:8ac8:0:b0:37f:fcfb:6886 with SMTP id y191-20020a638ac8000000b0037ffcfb6886mr22066946pgd.466.1647307799495;
        Mon, 14 Mar 2022 18:29:59 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w21-20020a634755000000b00368f3ba336dsm18043127pgk.88.2022.03.14.18.29.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:29:59 -0700 (PDT)
Message-ID: <622fec17.1c69fb81.b8a93.e375@mx.google.com>
Date: Mon, 14 Mar 2022 18:29:59 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.233-cip69-1019-g2e5815777e975
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 7 runs, 3 regressions (v4.19.233-cip69-1019-g2e5815777e975) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-timers: 7 runs, 3 regressions (v4.19.233=
-cip69-1019-g2e5815777e975)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.233-cip69-1019-g2e5815777e975/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.233-cip69-1019-g2e5815777e975
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2e5815777e975e9b2702739a96b2af41357c95fe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fd74cb247af2c3bc6297c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/622fd74cb247af2c3bc=
6297d
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/622fe6d87b87f07d98c629dc

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/arm64/defconfig/gcc-10/lab-cip/ltp-tim=
ers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/arm64/defconfig/gcc-10/lab-cip/ltp-tim=
ers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622fe6d87b8=
7f07d98c629e7
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622fe6d87b8=
7f07d98c629e7
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =20

