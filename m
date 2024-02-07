Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B829BC4828F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 20:44:41 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.797.1707338679498851714
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 12:44:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sQcVWVDX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-296dcd75be7so800361a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 12:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707338678; x=1707943478; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RhntgZXV80Cmj/XgjtL7d49oDIwNEBXgGP8qMVs72BU=;
        b=sQcVWVDXTOE/w4i3tEuDpeu4qhrj8S7Ickw1kylp7cicUuT3HfPBl6M2z1sLhxVZfZ
         HpiyuBVZs+iaIVhQ1DupAU6v1JjoOA5SYFKFSbVgJLKVB7AIFhJzHiwenIOKda8Zi8bJ
         7savXWrp+O+CjsEKp9Pu50S4ludig8FZFHzhZFzkYUzZhXFZ32IxsyqOaHGWeoYRi0nM
         lZ5zHIx6jA2j+iS6Ii3ZfeARVjlLKR3tJZXXkHOUQk7Gg1EBiannwa7XtMA5aNTyQQ/F
         6K043hadC+cuSWVucIVl0WT77BaC9az/4s++dhUABZBy9UkmyX5PfsVTEaoVNAvb0sko
         ptpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338678; x=1707943478;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhntgZXV80Cmj/XgjtL7d49oDIwNEBXgGP8qMVs72BU=;
        b=Hyt4ABpm8B/ONYaCjW4Ds8KrtLhw2PXfQ9aikvLmVIA9Nw92z8s6+cpkLVUm1d5Dzo
         WxTOTCWvdWx8R6b1bqnoNYunUFH7ovtZXm6haEXF/eonMuubbD5GFqyPNU9t6vXNuGUJ
         NRMYQ7EUhO9ylcrPgQVDlQS5ImMWEGTeW4Fy4jHWBexaUvVjDU9Mgvqs72rCtsNyc3/h
         aCVuMKgYXauFb16IkjTOs2Kkme7gFrXAieVmDBOaEDkpUy0ipZlyrRHIszHEbXNmdSC6
         vXO9QHUHnFPZ6GWJC1l2z8oFeIKI/W33QgV3rCeNe7z2liCkbEV1c3dxC+AYQmWDNZUx
         5kAw==
X-Gm-Message-State: AOJu0YxB9KuM0Z3OxoDOrGV0mkL8c2rRSn7BFfhUFCJ+0ztyGgxCMb4z
	tOh1K79pcM/xU6N6eCmPSWkQKbks1i3qWDmJOitVFo11+t8c4I6C6MjXsmR1D4RaMsMPhEhBi8z
	vkqA=
X-Google-Smtp-Source: AGHT+IHaV5VSiKPh9WEIe0R6QQYdW9aktIf7Js2mLmRRygZO+nTtETB1ElqXcN0RQUiogliPyo+fOw==
X-Received: by 2002:a17:90a:4b4f:b0:296:f6d3:db5d with SMTP id o15-20020a17090a4b4f00b00296f6d3db5dmr400147pjl.4.1707338678542;
        Wed, 07 Feb 2024 12:44:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUileXh8x29KyQIDBq3J4UaXsXKYJUm8QFBn2D9ZTkNoH63elZx9d26GBJoRGX9lA0o75npg2uoUGyf5uh+r4TzWtLEbjqTRRVPY1/w3WdPcqEMvVXWNw3eMB+yPTwT4iIdV8mzDBaQOEocJ7cHkV6smA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bo6-20020a17090b090600b0029552a03219sm4340013pjb.29.2024.02.07.12.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:44:37 -0800 (PST)
Message-ID: <65c3ebb5.170a0220.4d92.f837@mx.google.com>
Date: Wed, 07 Feb 2024 12:44:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g681701bd9bc1f
Subject: cip/linux-4.4.y-cip baseline-nfs: 31 runs,
 2 regressions (v4.4.302-cip72-1251-g681701bd9bc1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 20:44:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14907

cip/linux-4.4.y-cip baseline-nfs: 31 runs, 2 regressions (v4.4.302-cip72-12=
51-g681701bd9bc1f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig         | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1251-g681701bd9bc1f/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1251-g681701bd9bc1f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      681701bd9bc1f65237982eebce24afcffab64f4f =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3e222903f6be4a88e1e7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3e222903f6be4a=
88e1e7c
        new failure (last pass: v4.4.302-cip72-1250-gd530578b1386) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3dd8a18cf29cce08e1e98

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3dd8a18cf29cce=
08e1e99
        failing since 35 days (last pass: v4.4.302-cip72-1187-g657481329b53=
c, first fail: v4.4.302-cip72-1224-ga0ac575eeff8) =

 =20

