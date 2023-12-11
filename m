Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1C6C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 07:11:01 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.3158.1702278657585062840
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 10 Dec 2023 23:10:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=R1iOHgwD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c21e185df5so3498259a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 10 Dec 2023 23:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702278656; x=1702883456; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QdIIi9IWcvd7e3DQHx3Ufdr+MX0ct+TupdH98qwcmw8=;
        b=R1iOHgwDEQQlfI3xWTwmTLq+sfn4LM8+W8BdOkqjH/dI2GE6LshFkmm0nYFtPn0BBQ
         eXnGayu1D/fYOcrPBxkQnhyn0xHD8X7zCFa+pxuHxaSv26cy+RzPUJy1xg6eJo2bOv8H
         LC66JJMrQg1WSBheGZPVccl4iNrZlxN3oSX9nX7XhjfNOKOIh1PQuyIRk2smwNk1fq6t
         CTqNUHM8lRUr4egDpvdK4ofTVTNHxlArAf6uBJHANqeaqyMLjUkGJZr/aZPi+uQupIyb
         +JTAmhszFS+GYp8w6WY6zxN5OalkKsX0cSoE3yWMpXYdlR2Zj4ySwxv/Cl8g+BuV7+YW
         adQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702278656; x=1702883456;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdIIi9IWcvd7e3DQHx3Ufdr+MX0ct+TupdH98qwcmw8=;
        b=ZrM4jt/rIdOtbYmQVBKnJe3G3uT+AKszJ6XAvz7xye0facK8wPRTq53TbVk4or6h5o
         O3w76gca9tx3iuFQVyWlyvwEqbWvUZECQqIAElG/dfcGDSIFyF4jeOSQwse8oHiz7l/b
         uP+lUWQC9vNGcSNr8f9dhVYVZhm8o5chLzIhIkx7OYRG60udJPxTux8VJPbRDq3f6xhF
         eLR2MBjcIRux/f3D29DfdHrqCmxgEu1p2viH/zOXNUT5AYy7RLmUuNU5sDur1TfuAV5+
         40JJkHSobPnENOouDe6URvKeRIyqz/u+98cwLDB+3jXqHIBJggKBK18w6Asv9G+FSxUS
         Kh4Q==
X-Gm-Message-State: AOJu0YwWdRekdjGaYbONbRhPZZi6GyiDk/B/CtCNgC2g/lkJIKsPAwzx
	RSZqbtYFDhGldJrK1sKJWifO5haJLxWvXqNvRQuCeA==
X-Google-Smtp-Source: AGHT+IFAv91vQxRd9/6/aKJC4sgqOebj/AlIhnWA99NEZZyTrJEme38i21tPXB+CIsa00dKnREiFYw==
X-Received: by 2002:a05:6a21:6da1:b0:190:5d48:ddd9 with SMTP id wl33-20020a056a216da100b001905d48ddd9mr5394865pzb.59.1702278656340;
        Sun, 10 Dec 2023 23:10:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d12-20020a056a0010cc00b006ce61c9495fsm5561415pfu.206.2023.12.10.23.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 23:10:55 -0800 (PST)
Message-ID: <6576b5ff.050a0220.37939.f77c@mx.google.com>
Date: Sun, 10 Dec 2023 23:10:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1988-gdf21aeeacf3cd
Subject: cip/linux-4.4.y-st baseline-nfs: 28 runs,
 1 regressions (v4.4-st20-1988-gdf21aeeacf3cd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 07:11:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13994

cip/linux-4.4.y-st baseline-nfs: 28 runs, 1 regressions (v4.4-st20-1988-gdf=
21aeeacf3cd)

Regressions Summary
-------------------

platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1988-gdf21aeeacf3cd/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1988-gdf21aeeacf3cd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      df21aeeacf3cd115619050fa97b2f131485aeaa8 =



Test Regressions
---------------- =



platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6576b14a4e728f705ce1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
988-gdf21aeeacf3cd/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-=
imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
988-gdf21aeeacf3cd/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-=
imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6576b14a4e728f705=
ce1347b
        new failure (last pass: v4.4-st20-1873-g923c12c3034a) =

 =20

