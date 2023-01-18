Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA08C32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 06:08:41 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.9509.1674022116074852577
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 Jan 2023 22:08:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bSwocyap;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id z4-20020a17090a170400b00226d331390cso1143385pjd.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 Jan 2023 22:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N8sJtOEjm4WXNr8pMUV7UEoO7SBVbfMYt1N+rOF/A2U=;
        b=bSwocyap6BAsb384Yo/nnrcRdfLgNWhAcW5G7iKiPnFsdgOaEAt6ewyShDXCipZSd3
         S4TT44Gk24Bw24V0FSFTOJsmZjPLGLo/3WKywox8lgh1a4V+TqEj/0/Cnp1VQ6WG0uoX
         ASxB1//KHrc7bS7RxlhTYlUAvq/oD6NSx1fzLDxTnweczpkloIyL5SWJELLd2fYYbZ+G
         5nPw5AzyAME2veIynxrBzfs7F1YOF9XHqA2ZrPBMfwbbvNF2obZ6exB7ekONT1l2otJS
         T1/EkFAPggwkYVUTdouROxzx2rm8CAffQakS01TluGP+2i42M9rM5MOBVpTeq7r8Fhv+
         lj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8sJtOEjm4WXNr8pMUV7UEoO7SBVbfMYt1N+rOF/A2U=;
        b=aHUKeQQMC03mZUtRviWXnwOqaRHYC5cannKoDOi9paE3uHmoOrCNOGIGMZqSj0qiaE
         9ebZJX+khJIsZYEMeLJxJ+NTPdDt7pcxelSFEvXx5/a7v9gleEzXZAq4Ifer16l4ekN7
         V9ddCUXvznnlkS59LDSH4xrYydRGxcaZ5UB5pmkg5Cq3QsPSzMFqwuXn7FPM1+E9lgrX
         Zzxs/cl0lReo4/ZggvufaSHPoiSyNw0mWnHDRDWmzqbHKinVG6VMj9/xGCpkwDZqMNPz
         KdcqCgsFSF76qchbFNwf5Eh7PQjvZ/pNioeaKccxoLamopFwrFaxA78M40VlhwuXxcsa
         FGnQ==
X-Gm-Message-State: AFqh2ko5RmvvCx2la7ZVLZv4DSE93F+eQVqh92JIkfNDh6Kbe8VlEtYN
	S4ULiSaBecMl8S3L42cvDyLmMTdy6hW9o8E06RcZnw==
X-Google-Smtp-Source: AMrXdXtQfO8qHOnAelHtPOHNe4498pDXzGYyQFGjFyvBKt8vEYS2wkFExi/A8vPfevSZIRjPtCsMqw==
X-Received: by 2002:a17:902:e88e:b0:192:b2d3:4fc8 with SMTP id w14-20020a170902e88e00b00192b2d34fc8mr7279720plg.1.1674022115383;
        Tue, 17 Jan 2023 22:08:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b0018963b8e131sm103791plx.290.2023.01.17.22.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:08:35 -0800 (PST)
Message-ID: <63c78ce3.170a0220.a4fbe.01c2@mx.google.com>
Date: Tue, 17 Jan 2023 22:08:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Kernel: v4.4-st20-821-g39bdf0444b23
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 22 runs,
 2 regressions (v4.4-st20-821-g39bdf0444b23)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 06:08:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10380

cip/linux-4.4.y-st-rc baseline-nfs: 22 runs, 2 regressions (v4.4-st20-821-g=
39bdf0444b23)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-821-g39bdf0444b23/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-821-g39bdf0444b23
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      39bdf0444b238ce8b92fda121bd1462a27f07a66 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c77f28dfb61d63fd915ec3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-821-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-821-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c77f28dfb61d63f=
d915ec4
        failing since 7 days (last pass: v4.4-st20-234-g4e6ec7162c8e, first=
 fail: v4.4-st20-799-g1229c813bcd9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c77e20166f370246915ed6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-821-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-821-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c77e20166f37024=
6915ed7
        failing since 7 days (last pass: v4.4-st20-234-g4e6ec7162c8e, first=
 fail: v4.4-st20-799-g1229c813bcd9) =

 =20

