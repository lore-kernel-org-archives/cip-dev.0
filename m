Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A9AC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 07:16:54 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.78627.1701933408783650516
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Dec 2023 23:16:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=yebkfcnB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d048c171d6so5139295ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Dec 2023 23:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701933408; x=1702538208; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MXfgStwo4RMIV0ecZePybDM4LevlfqTCuTEyJUXF9kE=;
        b=yebkfcnBfWe1sIGAnxGf1BTxnyHjXrNZIdzeQyUuLciT+q/8szzFpj7l4Kj6Qi08Pm
         RXfsAFcSFzOMi5IiGSEHN1PF6jD4GIWzl6wzleSq/FgInjkWdb7flhozyM4rklRGQuF2
         e5txepjCWTTyjdHBYxpRjMnwsIt0NxJl37/7SBcRZLg5WZoujzNjy8/2KlCMI8aivmi8
         y0qw9SfRipi2mLgMhUFogmQSOwsQLo4dLk77dsLabqkRTRsDvrkRrvr6U4oMC5zgvAef
         YSqLNbSjbCYFLSyU43VxTzyOg8xkMWvSaQVR9m+/e/Ps61gGmso6UC2FlMY6WRXq1bGw
         oVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701933408; x=1702538208;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXfgStwo4RMIV0ecZePybDM4LevlfqTCuTEyJUXF9kE=;
        b=VDefdJlUn2cqd18ABfATi8A3YRdQhFreRCj5P6ytcG9p2dBj9ibPdvgGCUMj7fTlwo
         Jr9obk58ugtqZJExF/wkfueCaSqt8avvUT9+8q/dX4oEXo7tmmIaznSQIBhkZ4t8rMGM
         wQp9/bRvNMhntI4FrMYeJGDYdQO9S1Ef9Ftx/DoB6RZKzJI1uRzNApIHJfbo8/w9QETd
         TRh267b4hBjGZK1EGEY3RERTcM4yY34s3RdcWFz+v1l7WD7Vk4qmccGV/tqc6yCv4dx9
         jqVV6lFvzlz9fzU6emhbqfubk1PNgaRJZVvPAhWDn/ajB0VSdHLq0TVS4cXPgvUF4dnx
         tGAQ==
X-Gm-Message-State: AOJu0YwHLMS6H64Xr5fVAwRn7Z5girqVO/gioQWYK9K6Mqw8r0X28kEL
	WszVb3xvXRLJWKgtAlAUPrub7MmMbYzacPu3v2IbaQ==
X-Google-Smtp-Source: AGHT+IGzQtRq6GgSr9rBhplWROu5vVDQnGIlQXQhwyJuH1EHtj4YQ4gF9ojdVQfGRUVhVcw80Nlm/g==
X-Received: by 2002:a17:903:483:b0:1d0:60cc:7ebb with SMTP id jj3-20020a170903048300b001d060cc7ebbmr2032601plb.25.1701933407808;
        Wed, 06 Dec 2023 23:16:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z2-20020a170902ee0200b001ce67fab3a2sm618414plb.261.2023.12.06.23.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 23:16:47 -0800 (PST)
Message-ID: <6571715f.170a0220.c4586.15f1@mx.google.com>
Date: Wed, 06 Dec 2023 23:16:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1987-g9e48fc479c400
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 30 runs,
 1 regressions (v4.4-st20-1987-g9e48fc479c400)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 07:16:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13808

cip/linux-4.4.y-st-rc baseline-nfs: 30 runs, 1 regressions (v4.4-st20-1987-=
g9e48fc479c400)

Regressions Summary
-------------------

platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1987-g9e48fc479c400/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1987-g9e48fc479c400
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9e48fc479c40013a21ec5c14b702b67ac153fb38 =



Test Regressions
---------------- =



platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/65716e8a429c677de7e134c9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1987-g9e48fc479c400/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-n=
fs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1987-g9e48fc479c400/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-n=
fs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65716e8a429c677de=
7e134ca
        new failure (last pass: v4.4-st20-1872-g0dd3085de20bc) =

 =20

