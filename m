X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.918.1648506489711333643
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Mar 2022 15:28:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0wJQzOua;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id b13so12268281pfv.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Mar 2022 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=llTJN2yxQPTNfXL/Zrsv05EuylFhTahMzj3StCsj8Vk=;
        b=0wJQzOuaSX0pyiONIaTmvz3gaUDTTR4SIfa8WIUxr5kk/orSsSmPlHax+HS1iS2hff
         YdGPEX8VaO/KNGlc5jZXsFe1HCp8hR0Ei25I4D7XqD5poSyRtgLARyMqbblkntXoMvxK
         QoQAfsPGc7No+cHEWsFSL0aRNVJ6WCHcMIDq/EsSV9mbyAbxMGxCI9tyiMy43/GhuVk9
         Qc/ztbYbQqxvl6z5hzyGidthJ3Pz+W/fk82Gvl0r/B7VNK7s4urZLbQbmdY+HTML6oeb
         XVd4ZTiUdrmYwEd3e0yhFmpW31e/jUASBmN2ie/8oI6qp+2gZS5MlQDPaaNEaC9IFah0
         JaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=llTJN2yxQPTNfXL/Zrsv05EuylFhTahMzj3StCsj8Vk=;
        b=Au2dcskhbCaU06FzQVyJ+4IgDhJrDPzM69ZdZrvmun+YXczSOdxsS13pwf9CxW1Fga
         eWgwKIFKR2TdzJAZd9YN4m0u+dhIqza+oKaLfdYrRh4H6NbqCM//t3Pysfdceue+UlgO
         iR1oGWZ81IhfrMhCOeqEA5InFZ43fP/pbd9TBTaYYFCaDGl51MkKm1YI3cUmWWw+nZoG
         JdlKBgdYNVNK6fEjwQz+tj+BXIFMbH9ginSnN2WjE08MVtq5ZH+6WdCsgdqkxtYn/6WV
         jwqdUuANlIX3R1EGPOZ0BSDcjCt1Zh6EkK7O1+beQORtAWXME/NZmlpysS9ovIGjSJ+C
         jT7g==
X-Gm-Message-State: AOAM530QGCVyzyX12P3zEsTUvnztpwvFVVfESR9SpF/rqiCR7yNDd16q
	lk7SbaoYr8UdHaB30Fek9f69EtRO1btTaNDlh5I=
X-Google-Smtp-Source: ABdhPJwxJJ3vv8oSAVziICnNswKyOA038jMrNDk9BG1Wt3oTA5vVxFc/9liUMJmymbMRx290ZW58nA==
X-Received: by 2002:a63:10c:0:b0:36c:6dd0:44af with SMTP id 12-20020a63010c000000b0036c6dd044afmr11334939pgb.41.1648506489086;
        Mon, 28 Mar 2022 15:28:09 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id mw10-20020a17090b4d0a00b001c7cc82daabsm499597pjb.1.2022.03.28.15.28.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:28:08 -0700 (PDT)
Message-ID: <62423678.1c69fb81.f95b9.1df8@mx.google.com>
Date: Mon, 28 Mar 2022 15:28:08 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.233-cip69-142-g40322771bdc1
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 3 runs, 3 regressions (v4.19.233-cip69-142-g40322771bdc1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 3 runs, 3 regressions (=
v4.19.233-cip69-142-g40322771bdc1)

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

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.233-cip69-142-g40322771bdc1/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.233-cip69-142-g40322771bdc1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      40322771bdc1d32499c228464c031d6a0779e3ca

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


  Details:     https://kernelci.org/test/plan/id/62422a8f9df391b167ae0689

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62422a8f9df391b167ae06=
8a
        failing since 5 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8, =
first fail: v4.19.233-cip69-120-ga36ab9aceb93) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62422aa306ea7af7ecae0681

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62422aa306ea7af7ecae06=
82
        failing since 5 days (last pass: v4.19.233-cip69-62-g10346bfb0fd8, =
first fail: v4.19.233-cip69-120-ga36ab9aceb93) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62422be7d667eec76dae0682

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62422be7d667eec76dae06=
83
        new failure (last pass: v4.19.233-cip69-62-g10346bfb0fd8) =

 =20

