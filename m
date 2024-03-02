Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984CCC54798
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 03:19:43 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.42478.1709349575936947579
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 19:19:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=X+SoOrbr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso1706683b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 19:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709349575; x=1709954375; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n7YzMkO4EHBeA5X2onp1xRqjLCz790g3Es9fUG06SD8=;
        b=X+SoOrbrEz0AS//gXqcPSVKZl8ND8RHSFOm4Z+YT5aKJoWu6jXhT2m7+YV8cn/5l9g
         Z7SyWqzeXTYCbxoAqxobn9w9nzJiFoEeabK8/kxMZY8AXfXmbyZ7xizM6Gylj2rUvoFf
         UpOfxjhyszhKOuaUoN7LlqWlup0xeEFijsD5r4uHQb7JUvcU1bQbOZcXsZLe/PVzpSSb
         BV4K1ZfATj2cRGxW84vb+vLnDtgk5eIQxsxcE3KVj3tSv2gzx8OEUNy8++MZe+ud2w8q
         01L0IoSmdoX+dTwNK6uTbsO6Ew7R3BBup7U2/krjELobPn7aTBkudqlv30Uu9uc8VzB8
         mJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709349575; x=1709954375;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7YzMkO4EHBeA5X2onp1xRqjLCz790g3Es9fUG06SD8=;
        b=QyNHE79WDV9yK7YD321Mfi+9syXqkoNrd+RfPGU2KvK3RIEUNEKFxfYobQ4f4/stC7
         JzoaC8ZaF5ctzMoWNIXVB9oHEmXRBz55RuPaiucP84ctPLHOXmABzUg5FrQrswd4omqw
         pzCArlR6WhuD5/+5mMfCqW0XfPkkGFopJUcEZrxOmTql5In1PYo6KtFMZkzXS5ECvZ7r
         nZgqsPTp5Y5rivoLeFYA7V/egWxJzXagcJV5/jEJMr1ib1d1huV+yjrDJp02eWgDinc9
         VC6NZ0LfV+waqtz529z3/mj9h3+TSavkw4F3vdPA3dH+1jlZdrbvpvgq7clZhCWtxQN0
         dNeQ==
X-Gm-Message-State: AOJu0YxQCV+/oWKIkbzK4fM9jv0XKrYdOwxKV2DC/aO9mQ25gyTwvT8Y
	wX2UDxvTWlNalNz+YGx3HL9bAh3nCZeci+/XDisdj/+iy4wL2LlN8lBjjcw9ntp4IWyFN1h6f6b
	BvAo=
X-Google-Smtp-Source: AGHT+IG4uJAdS0AjVZ8mCF2uLAM6y7OAnxL6SPB0bAOq5wqUnb7TEmblURxKyFgG0GW8lMW291JOtA==
X-Received: by 2002:a17:903:8c6:b0:1dc:a8aa:3c80 with SMTP id lk6-20020a17090308c600b001dca8aa3c80mr3950974plb.43.1709349574914;
        Fri, 01 Mar 2024 19:19:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001dc3c3be4a4sm4173860plg.304.2024.03.01.19.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 19:19:34 -0800 (PST)
Message-ID: <65e29ac6.170a0220.e8849.52af@mx.google.com>
Date: Fri, 01 Mar 2024 19:19:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.306-cip107-rt35
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt baseline-cip-nfs: 12 runs,
 3 regressions (v4.19.306-cip107-rt35)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 03:19:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15158

cip/linux-4.19.y-cip-rt baseline-cip-nfs: 12 runs, 3 regressions (v4.19.306=
-cip107-rt35)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =

r8a774c0-ek874           | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.306-cip107-rt35/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.306-cip107-rt35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65e291ab7b5bfbfd26637013

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e291ab7b5bf=
bfd26637014
        failing since 62 days (last pass: v4.19.245-cip74-rt25, first fail:=
 v4.19.299-cip105-rt34) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65e290e399451c8b7c637016

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hi=
hope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hi=
hope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e290e399451=
c8b7c637017
        failing since 62 days (last pass: v4.19.245-cip74-rt25, first fail:=
 v4.19.299-cip105-rt34) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774c0-ek874           | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65e290a7d6517d0c41637023

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek=
874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek=
874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e290a7d6517=
d0c41637024
        failing since 62 days (last pass: v4.19.245-cip74-rt25, first fail:=
 v4.19.299-cip105-rt34) =

 =20

