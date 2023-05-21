Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55702C7EE29
	for <webhook@archiver.kernel.org>; Sun, 21 May 2023 10:25:24 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.5365.1684664723709193930
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 21 May 2023 03:25:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=WGrEt2iN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so4492106a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 21 May 2023 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684664722; x=1687256722;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=suijkgc8aPkx+cE5KJEyC0LqR1CAedE32qPbePsRQWE=;
        b=WGrEt2iNl8/vXfy0d/mbF7oznXpbhtpCAj7gBhct1ZVyfpyaC4LJls1wvrwXl3SafO
         Np5pVzB0G8h4F5mgyQwfEBiZeo4IqQGq93+6oQX7xoPLGfhcy9qHG7xLz9gayCxFVyN9
         ARIO/2xdrRHcIkYiWNqT93M2JNUMKt8rhsO2D65AVRwaK/kQ9KtaeQTSg7kFLnqwCLzX
         q1IcsvFh2C1cjdzG/iLfNo+5+7aQIF6R70sGQziLt7bkPeyhYMkDTLhe2gm4p5nOoeVX
         6ozxu3PT6/1Lwk/16qzAegLE3dEsTfh+zencTvLzTMr5aFkeIrXEtIVkCalLWEuS6/RV
         YTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684664722; x=1687256722;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suijkgc8aPkx+cE5KJEyC0LqR1CAedE32qPbePsRQWE=;
        b=RdRRQt0tjVDGquAjnvqd75gW3Bxxe3aAia4NywDfmpy8KSeroXkN4T2MVR6mgGCBaz
         7asa+Bd3xrr4bA+MwxpdhEnzvsQi1uoFeAaLAqphVhdHPS+ppGCtIBMjvYrwHcg0f8Md
         ea2TLAlcXqBFlaiN3Kgv6sXjiTAI3EXlIvHM1ukCth4wo/XeX5sROhrthOyUAanacdav
         wMvr+6noAXBLdood59dWfKxFK4hIHWygU1tsKXfbA+PcR9zf7x2lnty4JZ2EcqtUyj7v
         Y2/uC0E0pPZmYqTB6sNYdz3uXPcPts5VH38QNDLZwQJnKiy57TT43VsLaiYPNY+feMda
         EhnA==
X-Gm-Message-State: AC+VfDwddWJ3KC3zxjmxQdwrxW2tyJD/xRHKjXYMWaRDp8des+NLbcVX
	LtM7HnVagNpWSUhOkR3YyLb5Ll4jJBqPX4zpnkzGmQ==
X-Google-Smtp-Source: ACHHUZ40Qp2bq2TxYbdvGJc89DfVgHwztNDzBNGZ4h/Bcf9kuAcXLn6VG/z84pOBPHlx51JRvMBKIA==
X-Received: by 2002:a17:903:124b:b0:1ae:a44:841c with SMTP id u11-20020a170903124b00b001ae0a44841cmr8730206plh.42.1684664722184;
        Sun, 21 May 2023 03:25:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jf5-20020a170903268500b001a800e03cf9sm2726272plb.256.2023.05.21.03.25.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 03:25:21 -0700 (PDT)
Message-ID: <6469f191.170a0220.36cba.436c@mx.google.com>
Date: Sun, 21 May 2023 03:25:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs,
 1 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 May 2023 10:25:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11578

cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs, 1 regressions (v5.=
10.180-cip33-11-gfea7994097935)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip33-11-gfea7994097935/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/6469df37d01553a4752e8623

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/kselftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/kselftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6469df37d01553=
a4752e8624
        new failure (last pass: v5.10.179-cip32-471-g18129e1b68691) =

 =20

