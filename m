Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97767C25B0E
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 00:42:51 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.23264.1660696966966877930
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 17:42:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=irDkQWal;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 73so10704512pgb.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 17:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=w5itfi2JoTyNYJkVVX8s6+JAIKc/vQLSedS5TIeg/io=;
        b=irDkQWal6d1qmBDo8PlekEsUmpaLOAAsbZEonF1kj/qSU+hHqclETYij+8gmMv2UGO
         08jVKAFLgp6bfDQRJwuXDaTq0/+VdqK7ikfTMoWA48ZYhMeYiZ+m2yXLWZcBYHvIEimJ
         QgH3RQtPsSu6aX0rOurBYb6ckCI7DuAvS258t1raEbK9mIgUuYTfe7CvsDqCPL2MoH4T
         /WtgaA0PNzyRQtNfer9+y2giMeqHuQLm0HncxXnTmBQz1jgGz2pkwfgQ2m9wJHnu+KWo
         gOOd48GAcqsOQ538HYvuT2/s+oGkrhdowMDMfJvyH9WEaun3WgkkMIllIlIOd5QZfTuB
         9fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=w5itfi2JoTyNYJkVVX8s6+JAIKc/vQLSedS5TIeg/io=;
        b=lEXsNjwZbnVn3zo3M9NTQG6+LDBtO3fJT8kPWEKks2g1YmIZrZ2AgcAkg4U+bzuzyk
         4T64ltqRut5Z6D1hRRoOEndhRlVNhRZ6tnyfBToig7uHTwBK0hDA2shxT93D2uDJrvx1
         kf6DMmTwMoqw48OzZFwnzb7tjQ1XCWpt/VsqBTKqv1u+7gp7s/zXofNc2+mglbpkW7wr
         NN26/zT0FIAJB1QWb8EvQEZbPH23JekKtz/8IUu8L09K69DW6x5ivYlVhugRL1ehP7PG
         /xF0zzDuH6wRZvjiumLBjE/h7KcvbJHiLdKLQsRvslGx/krjfs8EZccMXwnmaXmCGwWT
         a0yg==
X-Gm-Message-State: ACgBeo21YG1IpY9Cvxn8eHGxVmjUxXo9r9k9nPKUumbWT50fHOLxp5T4
	FXrhTvU+mI2vE6gxHtLPo8u/HWrEhtiM8BzR
X-Google-Smtp-Source: 
 AA6agR4Q00sku9KkAb+rgtCi5BkmscPV+6aqTJ1MRz9UyeNdDgIQr6Prb/X0CQ/dp2+dUJG0OEFd2A==
X-Received: by 2002:aa7:8c5a:0:b0:532:8f18:cf7e with SMTP id
 e26-20020aa78c5a000000b005328f18cf7emr19790707pfd.7.1660696966305;
        Tue, 16 Aug 2022 17:42:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t16-20020a17090a1c9000b001f30f823145sm139653pjt.55.2022.08.16.17.42.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 17:42:45 -0700 (PDT)
Message-ID: <62fc3985.170a0220.eb6e5.053c@mx.google.com>
Date: Tue, 16 Aug 2022 17:42:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g5fcbe4a63ab4d
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 9 runs,
 1 regressions (v5.10.131-cip13-84-g5fcbe4a63ab4d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 00:42:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9262

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 9 runs, 1 regressions (v5.=
10.131-cip13-84-g5fcbe4a63ab4d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-84-g5fcbe4a63ab4d/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-84-g5fcbe4a63ab4d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5fcbe4a63ab4d3a1c958bd377c1c3c31e82f8909 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2fcfbc3aab5aef35565c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62fc2fcfbc3aa=
b5aef35565d
        new failure (last pass: v5.10.131-cip13-35-gab58aa0904675) =

 =20

