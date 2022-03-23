X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.10004.1648046206040883439
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Mar 2022 07:36:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=o/5pJyxf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id o23so1256182pgk.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Mar 2022 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9fXMHIqvyPwwsS+kg6XQzuEdWlH5dd0myKXUqoJ/X9c=;
        b=o/5pJyxfRLtjrqfiYwW3rbF5AOpBkVMYa8BnHl5kcjWelwaeGrfMd0KTVyup2hNB12
         su0oUDPb5xd8WYjWHZzpl7Ucu7ppzoaO/07503CjOjtIDP0Qt/gLXC/+ZKNXMKcQENpz
         C29yPLrBx+bAzinh1mtOsAF8aCRIN6qBX80DtOw+buMdB5O0nbuRyLhV6NmojkI7hUPW
         qaYHEHAc1FXa/upA0BRaboUZkkcd995EMEMR1oRyYl2Sf8SMhnyIMywxZyUdCqEXr/Tl
         7/RHdjmymgzTk0GZoCUIWArM/dn+H6XoQCRK5VJ+019V4W58WbbwihbQBTuDXs07/8H6
         ucpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9fXMHIqvyPwwsS+kg6XQzuEdWlH5dd0myKXUqoJ/X9c=;
        b=N/MfVuKJSvj1Latt99A3m+PpNVi9MJoathiNeHWiW+2YiqNVCf0VXwqo6XHsrgPlAA
         JvYEoDkPUk8siRf8JRk/LKNAa8Bs854DUgr6bS+g+YJneVqMgjTf+9mq9jDYgmTzjoDS
         OZGBUagO93tw4+3QNWSBcigl63qxgCiMHOoj1IcIVIEN90f2mj+SgNfEy57RPL+e9vTv
         r/wBibzTyYnuyutYEc+p49dXC7s1gz3OyZaHYwV7NJnzHlpmgbEyP+0JiECg428Rlf/i
         kJSOtZ5mtSxlWZ1uvkuKrYOFHGK8dFEGBTEC/3FBDwFsfwFEBuZFBj0MKRltOq5nbi2b
         +o8A==
X-Gm-Message-State: AOAM533ySKWcROgl74gKtqhz0vAD31NTl4+RRg4kL3Lgj0soJoRHeanD
	y3Ny/IgzJWw3mwgBzSX3OGodlzUNh7X8toeobEg=
X-Google-Smtp-Source: ABdhPJw6glWnXpMZCZ6NHjwPEkwT21EmuzWC8tZQR0N+cLfWh8B+pFnXAUcA71Yoo3yro3zQxvAWDQ==
X-Received: by 2002:a63:8c2:0:b0:380:bfd8:9e10 with SMTP id 185-20020a6308c2000000b00380bfd89e10mr181384pgi.422.1648046205389;
        Wed, 23 Mar 2022 07:36:45 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t2-20020a056a0021c200b004faa4646fc1sm175982pfj.36.2022.03.23.07.36.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:36:45 -0700 (PDT)
Message-ID: <623b307d.1c69fb81.e7911.07ca@mx.google.com>
Date: Wed, 23 Mar 2022 07:36:45 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.104-cip3-186-g758e0f22e236
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 3 runs, 3 regressions (v5.10.104-cip3-186-g758e0f22e236) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 3 runs, 3 regressions (=
v5.10.104-cip3-186-g758e0f22e236)

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

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-186-g758e0f22e236/plan/ltp-pty/

  Test:     ltp-pty
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



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623b2155b579aec065bd9191

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/623b2155b579aec065bd91=
92
        new failure (last pass: v5.10.104-cip3-132-g46c091c34fabb) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623b2e14c4c6c4fe4dbd919f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/623b2e14c4c6c4fe4dbd91=
a0
        new failure (last pass: v5.10.104-cip3-132-g46c091c34fabb) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/623b28bbf85ca07c09bd919d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig/gcc-10/lab-ci=
p/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig/gcc-10/lab-ci=
p/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/623b28bbf85ca07c09bd91=
9e
        failing since 1 day (last pass: v5.10.104-cip3-132-g46c091c34fabb, =
first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20

