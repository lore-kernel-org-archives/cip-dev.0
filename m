Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAA0C25B6B
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 00:29:22 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.189551.1698280157314647527
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 25 Oct 2023 17:29:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PnjgDIn5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c9a1762b43so2306825ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 25 Oct 2023 17:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698280156; x=1698884956; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d9YePP5RPBBH2WJn9QiZOnEnzlkFKb6N8kDjBIJi7Jo=;
        b=PnjgDIn5w4m6iM1t6V6LPgUbkm/sJDFQmoUjC27f5O/Y6wPte9aV5aVCLI/iX/0qLD
         brHbjua3OiJgkdlNyYx9nMlYQ+VBeOS7j64+8qoGH3HDLmQ3Z2tbPygyajYc5pWD2y5b
         lsgZDb1Cl8z/AZVPlVHgenL13igNSAVAMu6X9EcJQ5X4eIVbuUYrR/dgE+AGhwl5yu13
         XYYHawaz1Yvtc7EB0DJ3panvkmAiPzJKpZoNYbN3xKAlT8jKAhtCDD+sJiyf4mKuCo+w
         5rFG5v3l8IPanoL3s3A/b4sYCwEBnjOTjM8a5oKLoWApYLDY5fnmKkC9IvC578t6Esl4
         Dj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280156; x=1698884956;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9YePP5RPBBH2WJn9QiZOnEnzlkFKb6N8kDjBIJi7Jo=;
        b=PRUVmvkiu0eEIQoPfBq47Rj4tzjl1AusVuDPK6gRl+bsUnW5Aob/As1Ty39xE3K/pZ
         TyvxUZYVbiNeCV/LhwVhE/+FONzZgXc7SqlKuS2THbaa9ToNLRYDzCuV7az2vmVpeBAX
         CkbceOpKHrc7AmTwrA4973jYB8pMrxfivZVXymx2FzmESZ/xd2CVB416Ri/cIXT2BkjT
         U0Qr91BG/tGxRk8EF7/8zZnUmOeXg1OksxQKf+JJv0fhsK2eCxMxgChw1qe1YjdYGX36
         C1lkta3ZUjDyol74Ar1WZVnfme0Y33T12iEABgqMHg3heJGrx73QLC/hqaHlTIZlBKFk
         2qnQ==
X-Gm-Message-State: AOJu0YzVFuEYNhR+slOa4FSn9Bvb3NHxvl7uQezzK/a917YJrPzMJfsr
	Ob4XUCG4DHUOCaZzgfJdt5cuLJQTadY3D7b/waY=
X-Google-Smtp-Source: AGHT+IHRW2ls5opjnr0t6sgFfzobVZ2QuMhoa35IAMedDPCtRDMKy98Tz1OOfCjkQpbDL/6gxnl3GA==
X-Received: by 2002:a17:903:11c7:b0:1bb:77a2:edda with SMTP id q7-20020a17090311c700b001bb77a2eddamr18159035plh.36.1698280155890;
        Wed, 25 Oct 2023 17:29:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001c9d968563csm9754200plh.79.2023.10.25.17.29.15
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 17:29:15 -0700 (PDT)
Message-ID: <6539b2db.170a0220.a347c.1b3c@mx.google.com>
Date: Wed, 25 Oct 2023 17:29:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-915-g33f52aa14b957
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 45 runs,
 4 regressions (v5.10.194-915-g33f52aa14b957)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 00:29:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13451

cip-gitlab/ci/pavel/linux-test baseline-nfs: 45 runs, 4 regressions (v5.10.=
194-915-g33f52aa14b957)

Regressions Summary
-------------------

platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6dl-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =

imx6dl-udoo | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1      =
    =

imx6q-udoo  | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =

imx6q-udoo  | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-915-g33f52aa14b957/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-915-g33f52aa14b957
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33f52aa14b9570bcc02c5ccb3277101f421e6f93 =



Test Regressions
---------------- =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6dl-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6539b1e8d3e35c5cd9efcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6539b1e8d3e35c5cd=
9efcef5
        new failure (last pass: v4.4.302-cip78-rt45-338-gf468de833aa13) =

 =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6dl-udoo | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6539b07fd30a07a141efcf07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6539b07fd30a07a14=
1efcf08
        new failure (last pass: v4.4.302-cip78-rt45-338-gf468de833aa13) =

 =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6q-udoo  | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6539b1707285c0ac20efcf20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6539b1707285c0ac2=
0efcf21
        new failure (last pass: v4.4.302-cip78-rt45-338-gf468de833aa13) =

 =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6q-udoo  | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6539aff32fe5c461faefcf28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6539aff32fe5c461f=
aefcf29
        new failure (last pass: v4.4.302-cip78-rt45-338-gf468de833aa13) =

 =20

