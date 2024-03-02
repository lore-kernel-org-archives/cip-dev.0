Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF35C54E55
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 23:37:09 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.63471.1709422620585031276
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Mar 2024 15:37:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=R6koToa2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d93edfa76dso30637565ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 02 Mar 2024 15:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709422619; x=1710027419; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kCmqcI90DfxKrNgFLpEtsSb54t9Q6vWg33YzGymGBKQ=;
        b=R6koToa2PLz/MR9vYS/mWTIaRWYkIEvbbooC5g1Rds9VH97zugI9REn0CUwcogtORR
         d3/SIE/jmsXYdrWJh2EiLMcpohIJyGdepuk2QKZD8dI0nr8/dcbl67ig+XgLl/QGtI/r
         egmXJQGdDNyhq7ZQko6rTN4v3xW3QWdmmUQg7YW/xbby/7zNnCR9ivEuPDQJwRRbJOlj
         N4VR5m2ugHX2u3r3mds3l1aD8CWJLAgmxxIv4j8yYONFB+WpBHxvZ/bIIwgnEyzlxB+Y
         moYfGLSEQKjJR2hr6/iGwl8k8AJyOXeD5jHj4PfuLJBLcI3A/SyYT0uE5nM16MY+L86l
         E+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709422619; x=1710027419;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCmqcI90DfxKrNgFLpEtsSb54t9Q6vWg33YzGymGBKQ=;
        b=dfxTNUQFuCg5Gn54CIAqQClrKm1kBbpD0XMh5du0y4ifJl2eJ7VFxpy9mawhqPR9Vu
         amesEVTddJmUjGKF+ncmMT7H9Vgco9BJKjxiaR9fz76VMfj9dSXD+t0C3hEqz+5IJ+6M
         +Gn8z+cShW8Ns9KhYc5HITaMnIvgt5pTRWhWc37PzlWrKMowO9rxSX5JMPyoVyswHXPv
         MfoYe3K810lgKw4NljD516PoW+kAhVuv0diTNApXZs/LDbV6rX213IjbcPSHHqdHwv9B
         6i5pvOiDPiNwI0NCJSdx+5S5a2zpXDGdlWh6qijneWaI3S7mfq4n4sXiSK1cQdaUk/1k
         NWeg==
X-Gm-Message-State: AOJu0Yyh4wwIqr1/GpjUWQi1qxr11dZWx8aWNn7bTJfm7iGsCTsVca5V
	sC/Y97XieeX2+L00IGWE4+PYKDi/KCiCsQb5QDL+Q/FHQqAmdH7aPwo+3mdulXu65yU/0JP7Fu8
	TE/Y=
X-Google-Smtp-Source: AGHT+IFbHVNqtDPZ9vKMs19tHA7+aj5IcuvTjluDGXMfkJidGAtIMN3I6712AJ9hqE0trqkPqtnBPw==
X-Received: by 2002:a17:903:2446:b0:1dc:2d63:9bf6 with SMTP id l6-20020a170903244600b001dc2d639bf6mr6856365pls.4.1709422619487;
        Sat, 02 Mar 2024 15:36:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b001dc01efaec2sm5728018plh.168.2024.03.02.15.36.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 15:36:57 -0800 (PST)
Message-ID: <65e3b819.170a0220.e54f0.886e@mx.google.com>
Date: Sat, 02 Mar 2024 15:36:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-404-gdddfc5d4f194
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs,
 1 regressions (v6.1.78-cip15-404-gdddfc5d4f194)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 23:37:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15171

cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs, 1 regressions (v6.1=
.78-cip15-404-gdddfc5d4f194)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-404-gdddfc5d4f194/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-404-gdddfc5d4f194
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dddfc5d4f194925df6ee3d06e86b1d1e12412f06 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65e3ad9ec4e9074ba263703d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-cip/kselftest-f=
utex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-cip/kselftest-f=
utex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65e3ad9ec4e907=
4ba263703e
        failing since 31 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

