Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59B3C48BEC
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:06:26 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.22112.1707851179648874620
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:06:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=atGoRqxj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e0a5472e7cso1913897b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707851178; x=1708455978; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hLSYxxDb3fXaAzV0hf1eOzmGy+SJ8Rm8/k8bN7RCMPI=;
        b=atGoRqxj64+2sI7REQuGfGA2BDYWX18krIjHLLwHLpVVIsGBpa1BFS0D7ZJBrT+Dyl
         w/S3yAEMIp2+H8OqTuVJLHsBB+bUAQukVGcCdEKncdFtwryXJgIsz93sMc2DMNbMMuCH
         C5kYJj6WJTcewqHW9/oZUWL4UlQPXUf6fPGbhhfgfR9kezsx8cbsJhPojPOoeJh6pDeb
         9OMAv4hDhDd8IkH1U7+F4i4g+oTQ65Y8UnRiP4qJqldzbm8qYrTQJQws2J3oZqFroRqK
         xuMUKJXBwbVwBz+OP2R9KTti9WlwgfjzpHTxfZzUDZUTPe1VojWlIJFDpDrebLgV4fwy
         SdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851178; x=1708455978;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLSYxxDb3fXaAzV0hf1eOzmGy+SJ8Rm8/k8bN7RCMPI=;
        b=cXj7YMA26jhUTtU7feuqK/FBTg94ZEwyLdzedf0YSMytgtSlD7l8yZV5/K1aKPgADP
         N2cqEUD2885RQ7sN2fpv1zE6c5KNCF6/eqfKDL7eZQPdUnra5Imk4Iq4bGfNr8jkKoUx
         sEpK4YpTHt18WK7QxU84inzUz0h2FDATfec9gynkUJUfMwTCZne3H/UVRc2cC9IHI9uh
         7K+v76tsGfvYcmL3wrv0C1vXccKj8RoTx8n9WhkTZE6nxJ5qMp10bga5h6x7A/GaD0bh
         8bBuSDOeTZ2qOePB1MZTWkmlL6jAULszJu8s2YFENMx0vWaJXtVL8g1sj3/j9HgPfBc0
         mJYQ==
X-Gm-Message-State: AOJu0YzoE1oXS/aGHBo5cdag7deKZ7K39rs/P1J/56B55Iy71y3+VLtv
	gGB0SHQ/OigHyq1NrFlci9zFeIt0urYEQfv2ZGxWaq4dwYYG/He53aI9qvozl//dspm60H7YHXm
	gXjw=
X-Google-Smtp-Source: AGHT+IHP+pm6TRsouG7FzbVr/IjTdxu3hOsA4+BG1bBblhuu74xQNstH/KEvnUP8zcnYHCvEAtkYXA==
X-Received: by 2002:a05:6a00:1394:b0:6df:fa71:f044 with SMTP id t20-20020a056a00139400b006dffa71f044mr219030pfg.0.1707851178596;
        Tue, 13 Feb 2024 11:06:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSQWBjWz02X0BJWvGasMm65/n1wya51dKNVJDHAcSHWqr5+rEuSLEzp50CNLij9H8HDr5oUlnJ46RP+5YTcsyPHr9GxnyHEj6vydhrOPqsdnsJldKyfXq6m9PQZBtxKMwubWTYgO4YKQ/vgLaZpSUQxw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j25-20020aa783d9000000b006e0826bf44csm7988328pfn.172.2024.02.13.11.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:06:14 -0800 (PST)
Message-ID: <65cbbda6.a70a0220.47843.7376@mx.google.com>
Date: Tue, 13 Feb 2024 11:06:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs,
 2 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:06:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14952

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.209-cip44-51-gdb9=
9ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-51-gdb99ac443b0da/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbae40741a385c88637017

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65cbae40741a385c88637018
        failing since 762 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb115b884a70f5c637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65cbb115b884a70f5c637013
        failing since 762 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

