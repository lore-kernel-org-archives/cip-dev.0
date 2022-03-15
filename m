X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.5190.1647305996638942174
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 17:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=njPNv5zj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id z16so16977311pfh.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 17:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7V0rkdnyryuRLaB3SLRC1pO6AbiEXnYxeY5VC1vN+6U=;
        b=njPNv5zjkYq7oxfl9yP8OL10+2N8PfeepooapIaHPoSszwi/ERaOcTjeh8RAFptTja
         9eu/yx+UHt3ewYme/JS4JHxR+xoeGEyzoN4BZt3JJnQug7j8JGufqXjlhcppd6aKJ6g9
         Q6ZD5c0ehUap7eik8Tq7Uji1quO906bbPpEOR8Y4RQ/oZQ++SHFL3yFot4Wbjd7CPF2u
         dC6vjoGWthWHOG+e6KCEI14bFrUCMVYY/58bYP32K0Bt4uZCs2OdWp7ZiYItxGccSaTn
         uNWJbkGpFYTtZXvNf186KUG/C3SeJxIqRwPjqIKHTYDSTLzQuCtP+vtZeTIz3FbyKltn
         9Ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7V0rkdnyryuRLaB3SLRC1pO6AbiEXnYxeY5VC1vN+6U=;
        b=Vxs7DksE1r3Z2xN60iZSJ2oTqMqdDyivOv912WUQ53Y5J+qagSg0dz+fHm9t8kuiER
         TNK8JubcyHef6BJ63285bOSM+adIWwMBJfHb1AyWI4BrQYonvOFv38XSZO4lggmJwfHX
         6QFYRZFfL6MAOIVfWDdaEX3JxBK9atPuyKcyNsh8RfVY72kJLZ17U4BOZre8nMrL5YdQ
         7SZzVoBxxXEVUeKUyyfCZpNVwnVasdZu7MdRFVP9Yl7izlRCrdmMQd9DBayBhSxjRXDW
         cvQO/WiSSlU3DSKhclBuQ/QjQrX9ERFvmai9Xobs+z+8ESDfia+ATtaZjJDSGXBIHgmQ
         v1cw==
X-Gm-Message-State: AOAM5309dvrxJwjF1uecz5sWOUJEdJ2+0P+lhYweMrqtZEQ8U3i5nsQ3
	4kQ819Bv48j7Q7t941pQK60CS/PKIb6vAODqbpc=
X-Google-Smtp-Source: ABdhPJwhpeuctYwIEbrpMfC7UHyVoCAk8LTaGO9bzJx+cmJCj8AQdW/6TcF9yMexAKyoUQF+nSgsYQ==
X-Received: by 2002:a63:dd56:0:b0:381:5720:4803 with SMTP id g22-20020a63dd56000000b0038157204803mr2186517pgj.104.1647305995861;
        Mon, 14 Mar 2022 17:59:55 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w21-20020a056a0014d500b004f7261ad03esm22088149pfu.35.2022.03.14.17.59.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:59:55 -0700 (PDT)
Message-ID: <622fe50b.1c69fb81.607f5.74ed@mx.google.com>
Date: Mon, 14 Mar 2022 17:59:55 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.233-cip69-1019-g2e5815777e975
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs, 1 regressions (v4.19.233-cip69-1019-g2e5815777e975) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs, 1 regressions (v4.19.=
233-cip69-1019-g2e5815777e975)

Regressions Summary
-------------------

platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
asus-cx9400-volteer | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.233-cip69-1019-g2e5815777e975/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.233-cip69-1019-g2e5815777e975
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2e5815777e975e9b2702739a96b2af41357c95fe =



Test Regressions
---------------- =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
asus-cx9400-volteer | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fd7517f3e137290c62996

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/622fd7517f3e13729=
0c62997
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =20

