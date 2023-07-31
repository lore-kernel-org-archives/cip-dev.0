Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C174EB64DD
	for <webhook@archiver.kernel.org>; Mon, 31 Jul 2023 00:45:14 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.84879.1690764313377717176
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 30 Jul 2023 17:45:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Bb7lk23S;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-686f090310dso4005088b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 30 Jul 2023 17:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690764312; x=1691369112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ+wamJcTUoyIwi0AN5L6RsNJNttmEPRqloDlqKM8Nk=;
        b=Bb7lk23ShQlfuYZtSc+JJDgcjfoUlLaDSpqMgRhZJKwAWtL/ko2z6heGVtRagd+SWn
         Ww4HMxxmG+t8rGkJiu3gwcvo+O9SRzNqB+HGc+IErLb/u3VtjR9eViQ3jfufAYqUO8mf
         qmri4k5XzXyVmFBfyC1+XwfT7UzKUJNCvZqbyKt9Ug57hN0IGFr3CCHbszxFkrJCWEoL
         NpNBNKz5B9Isv8MfqHyT4Y7rm42S1VZuim4FVzhMFfhATaPLxYQ/10fThviyDYLYiQBz
         7Biflr3rk8lqJrvg7XUGw8JwjCpNx/VHxHE7/Lz8kMj+lbqhLSnynyACgzXlIiD2Lm2m
         4fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690764312; x=1691369112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJ+wamJcTUoyIwi0AN5L6RsNJNttmEPRqloDlqKM8Nk=;
        b=JQPVEB986r8Izqfe19+xLf6b72K3FxdoTjB1AHTGT9CnulEolLu1FmewCOrhQMKDbZ
         IfQZBb93HzhziwdAOytDvS9F8AgyphMPQ7555Bp8W5EvRYmWpkatlahS4nJxlWkgffAn
         kMFzH5UYjL0KKow//usMNUOuZZjydR3KkEqB+1iU0B8DYi660gNKToVd7socKF1sXTkW
         rbQoeMuOjmwW4Fg1p5e3jY9XnrMfHM5aRlW7yvBfANbF0/pfk3WchTkK46v+Fbc7Bk0s
         J/C7LJoY0Dir4CRfb+kjWyWctJBReo8u+6fDkF0dpPfjP7gQCnk2nNSu7IMOYopFcVRi
         mAYA==
X-Gm-Message-State: ABy/qLaFefFjREOYkKpW44Xh0Q5gJxEzECAa6jH+tS4Mrqeq06Q2/W5t
	UOEOqYxLzg1/t7WkerAAiogDMWyVGYOwFd023Z37Kw==
X-Google-Smtp-Source: APBJJlEJtlcFXlwzEnk2WSZGE8v0+7jhyUicmw9nWxQdwrQLIkYIjR6Cv/VTFzhwf3MC7iTkVmmPCg==
X-Received: by 2002:a05:6a20:12d1:b0:137:e0dc:b10e with SMTP id v17-20020a056a2012d100b00137e0dcb10emr10510794pzg.0.1690764312495;
        Sun, 30 Jul 2023 17:45:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm2964347pff.34.2023.07.30.17.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 17:45:11 -0700 (PDT)
Message-ID: <64c70417.a70a0220.6b8a9.4f46@mx.google.com>
Date: Sun, 30 Jul 2023 17:45:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.42-cip2
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline-nfs: 16 runs,
 1 regressions (v6.1.42-cip2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jul 2023 00:45:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12525

cip/linux-6.1.y-cip baseline-nfs: 16 runs, 1 regressions (v6.1.42-cip2)

Regressions Summary
-------------------

platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.42-cip2/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.42-cip2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0d2ec524c820bab8eabc0f1b34aa41ff55d4e9b1 =



Test Regressions
---------------- =



platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64c6f479a9086d59e38ace20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64c6f479a9086d59e=
38ace21
        failing since 10 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.38-cip1-10-gf4eb42f19246) =

 =20

