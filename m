X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web08.33454.1650909208713145970
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 10:53:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=obqNIGIy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id bd19-20020a17090b0b9300b001d98af6dcd1so15594pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iZvKQ3C/EDl0D21g4GaN/wohDeTwsREhtqXddf2mVqg=;
        b=obqNIGIyp4CM8k2AAZI+D8VlMoihV2+8mNyH6IDfI5Ch4JEHIV7IC8gMEntF3GYbjE
         PaXhYFgSl/JkiFvIQ/u2KtsyxvV3eiXce8dS0Ve/r7PKGBrhTmm29OcMnluTCYsGJCms
         YFik/LTM40NJmqoyPlNuKnjlC6GRQyfflHe7YRE2fnASnGANOyqW/zBEcn2G8d2BvuIS
         o6mtlby5c/S9p+GPYJKKt0e8EPZNP4puKyB6+czIeooVh4wx33zVnNJ0RWO3tmgI8mAi
         IAY8RWT7qII5TkJLWvrqiTI+gyY1CFsgz0EqTwJ7DLUXA9JawRhRh5/M+B0cGbeuuyu9
         iuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iZvKQ3C/EDl0D21g4GaN/wohDeTwsREhtqXddf2mVqg=;
        b=gClIi+3pa2luhnnHEprVBIDFohUaQtp0+8cWhqVPgtSbvgNVQHQ6xy8STCKYN3cycn
         iv6NsMS6Ftl/dnKTCZlsBnUYkE/vOmS2DX410CB8QtSD1+fA0VLrXKCHSPSRNkKB+MJD
         23rNqAK9o7UTluFVXsPsuaCXjgtMx0Z9wFumWJTk8+n59xg/Cx3AsF7knRb32d6NV3jI
         tbO9GGKjWI5qYQER7VxwqFyaA/uZDMHuUQsHpqg3zhFv/Tzod0JhdqGc4JhcowbxQAPa
         ihK1CbvO6idt1VbpScIvnoel2ofOll7sqI2mtqOi+5EdO9tLsZYN2hxg9j9RCECFOCjL
         DFYQ==
X-Gm-Message-State: AOAM5327h6omtEhbtPIW2C/mtQkdLIyaQYxnGc94bxrpjFkRVqxoQE3S
	RnUMElOZ02xbeE+HNtKCG48WecjMsS1JfPdUk0U=
X-Google-Smtp-Source: ABdhPJxe94VmJRF51WoY0KYOLNr2cCEZMgCl5lyOTFoe4sdoQ61PbLM5vA3e/rSUdXAPlXjT/5vKtQ==
X-Received: by 2002:a17:902:f68b:b0:159:48f:1185 with SMTP id l11-20020a170902f68b00b00159048f1185mr19363605plg.83.1650909208170;
        Mon, 25 Apr 2022 10:53:28 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g15-20020a62f94f000000b0050d3742e1b9sm5578584pfm.200.2022.04.25.10.53.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:53:27 -0700 (PDT)
Message-ID: <6266e017.1c69fb81.55d70.cc13@mx.google.com>
Date: Mon, 25 Apr 2022 10:53:27 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.109-cip5-899-g234e7e7d5bd3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 3 runs, 2 regressions (v5.10.109-cip5-899-g234e7e7d5bd3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 3 runs, 2 regressions (=
v5.10.109-cip5-899-g234e7e7d5bd3)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-899-g234e7e7d5bd3/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-899-g234e7e7d5bd3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      234e7e7d5bd36004288823dfb36ce5e3d2f6e940

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  4e132c1f9e14f9eaeb4f9875eee3f97a4a1ac987 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266d1f30f2d9282baff94bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6266d1f30f2d9282baff94=
bd
        failing since 33 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6266d5930b50b28ca0ff9493

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6266d5930b50b28ca0ff94=
94
        failing since 34 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20

