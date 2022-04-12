X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web09.5151.1649724052451488604
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Apr 2022 17:40:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cj2wkYof;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id z16so16046162pfh.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Apr 2022 17:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9PRvSBJhQiCRqlz5TjOVG2Yu+2Wo3dG9EQOFNeip+Y8=;
        b=cj2wkYofnsHqOBQqQN+Kdz/s5rGfRvEUmUo/o/Uj+c6g6GLsKhphp1LdpJEef5IVK3
         K22CwrsdcTRb3MppJw8wx3j3kL2Oxa25xTN9iN4caoJQOxrFT++yC6sW5n+4hnSfeb2a
         RFMhWjuPlH3/KcHxcBsz3nE7N5mUYhsIRDRAez5tGasebBJpOwerMNIt3FGoryWldDSD
         L+KwiqNb2Dp9eZ1SgmLRL0sK1jeSqzGVotbINaKiz3gyr9Gqht41Pz/10ZeXhoY31QMC
         IYJ5MGkc/CrK9vemh50ZaDLOrJaX7TBlnyetu91YMse9AKTHq1lS3NihogdDCrVYjlte
         rS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9PRvSBJhQiCRqlz5TjOVG2Yu+2Wo3dG9EQOFNeip+Y8=;
        b=MpHJTG7pDj+Rqp1JuJoeo+lfOQ0BiLiNI5vbSvkQTut8FE6cSOCbehkHj7uNChCpD3
         R9RkQsjVsKFqdNpZWWobIojBDA9tSf1RtZlFCROBmfJF5aXMUVqqbGKN1e3e3iICXvN4
         r7b8LwND1vgJTTaV5DUb/LqXkbE59zxneDYi8qa7YStOt07Jvd5NEWJOLqRyVF2RN61Q
         SxWqhGjl5G3kd4XEb/EPBf6zuBMdema14COPExlP04M3DLSNsTn7OKtaxpfFDsFvgyES
         iS5Os/FbJsvH0NInvd/9dJPig11y1SA0YvL77OyjgCNnxd+ptyPgYYe+WV4w+xnGfrJj
         VUUg==
X-Gm-Message-State: AOAM533KFMSVvGZZr9YJQaQnvtY6sOO2M84wa4V3om7cEgAt+P9LoPAM
	SZstlmsdetIT0LQpmRwKpZ1QpzGBXq4yROuX
X-Google-Smtp-Source: ABdhPJxOFWNZwXI73k8v9a6p/Rq/QKdr8zwXMo8EFxlDOQMGfjQ2OuJKf5fO5HPfWKKfp0bRLjnJ7g==
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr35627826pfm.3.1649724051813;
        Mon, 11 Apr 2022 17:40:51 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n23-20020a17090a091700b001cb57fd5abdsm631718pjn.40.2022.04.11.17.40.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 17:40:51 -0700 (PDT)
Message-ID: <6254ca93.1c69fb81.aeeb5.2a35@mx.google.com>
Date: Mon, 11 Apr 2022 17:40:51 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.106-cip4-757-gd8c01ae8a4bc9
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 5 runs, 4 regressions (v5.10.106-cip4-757-gd8c01ae8a4bc9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 5 runs, 4 regressions (=
v5.10.106-cip4-757-gd8c01ae8a4bc9)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.106-cip4-757-gd8c01ae8a4bc9/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.106-cip4-757-gd8c01ae8a4bc9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d8c01ae8a4bc9d22111adb18d50f655db7432e10

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


  Details:     https://kernelci.org/test/plan/id/6254b99d1630cc792fae06be

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6254b99d1630cc792fae06=
bf
        failing since 19 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c1011835be9440ae068f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6254c1011835be9440ae06=
90
        failing since 19 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254b9aadb0f846497ae06a4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6254b9aadb0f846497ae06=
a5
        failing since 19 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6254bf9c41eb8f6eadae06cb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6254bf9c41eb8f6eadae06=
cc
        failing since 20 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20

