Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D6FC27C40
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:34:52 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.35324.1700685282192974748
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:34:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=McGmYzQd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso117541a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700685281; x=1701290081; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lwhhZr4pIVdlRmkNtpAwbnxS6cXZHKWirYX21vTAaCY=;
        b=McGmYzQdikwePenFMzBx5T07SY9UFtYJAmADZ0OfgB2cVXv9vAuCFYG4cWiTN32Rwy
         ftY2IpUcgJOz+WdagNP0xq407GjCIbwLeb30PhikJ7Qls8Aq79csK/kJZHztuTY+pL7X
         e9agTuFY/2b+bBCF5jTK7ii+4RjnFNipWAlFn7au/FLXNryERn3TxQv6JlAv3z718xQ5
         rDNPXbp3CXIybqSekBSauKH9AdFbhX2P46OxuTYaUW0Qgy+lXZoNzH4znFNg3x1ouk8G
         EW0nRAcdMF9D/xUSSurCcFSSz9pC0FXQyHsPap4kgT4LTQjlnerAIMPBwcM5qfDh5/5v
         y3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685281; x=1701290081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwhhZr4pIVdlRmkNtpAwbnxS6cXZHKWirYX21vTAaCY=;
        b=SlAQjSWh4whT9cDVqqVp4plRrVo74KRfSryS8jrPCSkLWfdx7/XOSeDc8BrcZrjHAy
         eFzxVfgYFdsDJXsR6tOeRZJdZHNezAnCgeEBH8iv3PziiuHIg50Yi8bauE9mWt9FPnM5
         OGiqf4e/mdw5gocXkANsALOo/yz7cXrS2NNFgY0Na30hl7wFFSrcwJ94rfRKU9Ij9S+6
         WmUpe2hrx7H5UAtiR+4Kc7dLxUD6ZjjYiMSYkdPFmOJ/WRqQQn65F0SlwsrUzZKDmiT9
         nxECTF/gRFtlu9/bECTKTeR46Op2SmyqUgOAKn16vZaWHQjID3KJytZOuZlSX2K95XB2
         VrDg==
X-Gm-Message-State: AOJu0Yx8k77mpK5Y33R4wuKwefLcZux2Xbezszs34ECQo6VTZNY+OKSh
	+3jgZNCeAZIAa0Va1VbKhTiCIw5NofU4GZlMTJw=
X-Google-Smtp-Source: AGHT+IFrQCKuaq/BNsZamrUT0sdUeYHjRnujucx9kmjy5n9JuNL0xrWkZlCAzlmnJee53j15j0FIWQ==
X-Received: by 2002:a17:90b:3e83:b0:27d:b488:92ee with SMTP id rj3-20020a17090b3e8300b0027db48892eemr3582779pjb.2.1700685280850;
        Wed, 22 Nov 2023 12:34:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s9-20020a17090a074900b002800b26dbc1sm222607pje.32.2023.11.22.12.34.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:34:39 -0800 (PST)
Message-ID: <655e65df.170a0220.c8ad1.1666@mx.google.com>
Date: Wed, 22 Nov 2023 12:34:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9
 runs, 1 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:34:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13644

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9 runs, 1=
 regressions (v5.10.200-cip40-188-g33d0b44cd71d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655e5373f3e225b3e57e4b18

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/655e5373=
f3e225b3e57e4b19
        new failure (last pass: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

