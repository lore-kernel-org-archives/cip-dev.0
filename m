Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F44C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:15:49 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.26651.1702570542475773163
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:15:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Uc0yjrTw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3448937ddso18802575ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702570541; x=1703175341; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0XUtaXD6TTVJxLD/Ccd43lTr1CfcQ3QkrQmTJF0uByo=;
        b=Uc0yjrTwAIDQUwpbCm0JlCZU2g+OfGHBM1dyd7vUejTLW85WKkvlPfSaMPFTAn2jMo
         CKu4RS29d0D61y0XBrhrCgyDMXDPm5QcA8AiqL5ctmY2jfAAtrROxNBleooexStrfPa0
         SHup5aMsuy6ESVqoMtRu7Yjzv0VTjuQhtVht7TJN1K7O6J/l6iMayzozPeOMe0fYh5fr
         Wi44z8Sm9AFE9ZcldshRwQGFes9eeHAxKQ0X2y9oyenR+opFutOnKh7V3YSPIrx6KtPv
         TJrS/dv84z14UINvYbMEhRygEoCYACrJwqddyim5dg4Wl0SasbvhSA8k3ajWIKtvZeDh
         q2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570541; x=1703175341;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XUtaXD6TTVJxLD/Ccd43lTr1CfcQ3QkrQmTJF0uByo=;
        b=wa9mEPoLI1T8Qphpt7CE74vG9bMDEUbQSe3RtmNkBgwJ+p/+AENTnn0e1Ojc3leGD6
         kiyc3FMwv09VCJgBaf5pr2wQWHmUPbTE1VE944HGnArkcsNtVAWqtS+UrYtdXa6PZxxk
         yZnKNy5vbTRJ5wTyhsgcMG4hv27ejH/CVSZl1jspvD2lHMII0IYX1NMpDyX7xPDmlVtm
         zWaOiysRYXo7q4lVzoByvmBL4PkKyjVVBkG4cgQuLJrormM9MoaokAo4B95o8aIOXLtf
         jLw9E9aaTnB831HHQ5aC+Ql+6Pvto75BURU5uL2wpB+dsy3RWCPL6dlD8MEh4LbKVzkI
         cZLg==
X-Gm-Message-State: AOJu0YwOgnT/4Pl2e1Fes01COs8nNK11wreEA4ChBNFY3Dx19b0MWMPY
	2jHNmzUuCPGZSMF9WbEtQN3t2RODNzP9DS5HgOI=
X-Google-Smtp-Source: AGHT+IGy8U9ua0rHejT96MhzqipKljourofsR1UB7NsT/S3fkRB1w/rsgZvUxE9Jh3Tw7+ZPd5nydw==
X-Received: by 2002:a17:902:d549:b0:1d3:4fa1:9f4 with SMTP id z9-20020a170902d54900b001d34fa109f4mr2273793plf.92.1702570541421;
        Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902690300b001d078445059sm1493415plk.143.2023.12.14.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:40 -0800 (PST)
Message-ID: <657b2a2c.170a0220.b37e7.4261@mx.google.com>
Date: Thu, 14 Dec 2023 08:15:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 1 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:15:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14114

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 1 regressions (v5.10.201-cip41-=
69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657b1a5e6ec8ccdd70e13485

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/657b1a5e6ec8ccdd=
70e13486
        failing since 71 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

