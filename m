X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web09.6444.1647928101684004400
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:48:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1XgAiCLG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id p5so11210807pfo.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2Z7eRiCw61SMLbdzW1PCmKAweOJgyI7JbUlI3ZVlMYI=;
        b=1XgAiCLGB/+fZiTxpwUSYIuCHt3fAnASFFTbmcOg9v9G3KMHrjP0gxYsFA4cXXxAm2
         dR/aDynaa2Bz1tIovrH6R3gPTFliK2MHMoSjnYI4lCCLJ34Ih97+19WRIoCS5d02C4Uc
         s0rgPISuhUGoxq0Y51jGCDqBslSpCu9m2v7E6bPJR3bQ/MzT07PnJU8tXDDy7Br+NCyg
         q5HzvhVDE2dA9F7BycaYFA9CmSwD7ayBc67g7MdRBA1VtNGumMxZSPemHltL8gGGVMhv
         Wh68UIaaJKJoWR9tT44iTCpQOqLfdVn75guDYm0oZpBLWJVe0NMkPZn3PRhb/gELRaP1
         ambQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2Z7eRiCw61SMLbdzW1PCmKAweOJgyI7JbUlI3ZVlMYI=;
        b=oksPBW92es0amKc8BVh+CVp4BdWoDwsC8Hbpd8nnio+Vx0WNWy6osLKj+Q0uM86ppq
         2CRs1ERN/pDpbHbRjAOGfQQrofuoYDuGueAMWtbbJyX6DtYd5wU8KayYY0G6vFKyVDqs
         4R5TY02+sti9mNCoy+T/TXz72K1j2D68svktl3O139ZnfdsaEM4zcIUx5w4IqfCtXl66
         zmbDIQ+WkwKYJaGXkfnBaklWa3gKxoRcto3VAVr1P7sGzUvMrKlrKbu90fIykXSfCQsi
         9zNhCVoWMIRfkDCIAMQ811owhb/CpJ8VUu6Htv7MBLrsRQrzY4lMWBdjXWsWFi+8mEpV
         FlkQ==
X-Gm-Message-State: AOAM530OHrkeoCEw2deQFosOgNEqT+6Dh7FlPH1GdjuZtLoi6DKfkokB
	RkthInOeLps/udtMDkRZs1jl6QSWY5vBPA+D4vA=
X-Google-Smtp-Source: ABdhPJzvT4WFB0LLLNjARfnZAMhmM/82hGkQHY5pf6UVOYEuvHXwYw3OuIYwqPbr49W7e76CTLZLqg==
X-Received: by 2002:a63:5c03:0:b0:382:70fa:4294 with SMTP id q3-20020a635c03000000b0038270fa4294mr8539968pgb.580.1647928100911;
        Mon, 21 Mar 2022 22:48:20 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm21719393pfe.139.2022.03.21.22.48.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:48:20 -0700 (PDT)
Message-ID: <62396324.1c69fb81.393ff.b0a3@mx.google.com>
Date: Mon, 21 Mar 2022 22:48:20 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.104-cip3-155-g4f07dbd2df49e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 4 runs, 3 regressions (v5.10.104-cip3-155-g4f07dbd2df49e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 4 runs, 3 regressions (=
v5.10.104-cip3-155-g4f07dbd2df49e)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-155-g4f07dbd2df49e/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-155-g4f07dbd2df49e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4f07dbd2df49ee61f77347287ba5837888067f02

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/62395434af048c72552172e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62395434af048c72552172=
e1
        new failure (last pass: v5.10.104-cip3-132-g46c091c34fabb) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62395cdc21f769454e2172b9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62395cdc21f769454e2172=
ba
        new failure (last pass: v5.10.100-cip2-484-gede5006fb276) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6239540132f7bcea912172c5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6239540132f7bcea912172=
c6
        new failure (last pass: v5.10.100-cip2-484-gede5006fb276) =

 =20

