Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1423ECD5BCD
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 14:31:07 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.10364.1695133864885851136
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 07:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nImeoZCb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c44c7dbaf9so31694185ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695133864; x=1695738664; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D/0WrBzh63C7xwn8f0bvNlIZVyHGQOan8CcxVdRn864=;
        b=nImeoZCbu4qp4dWr8w2xeq/P8q3oCwx2MHqDkHO/AkK5qDsERuiVa40FA00kquSD6A
         K3sXtWlktOuMKWSLssf5R6E+eeOBZb9hpwEFPQ4k/nskWjdTNcBmTghXpIUK+MJCXo8Z
         x1B6M31E7FXixPEZmH1tObDI4uOZ0Ou9MbDVEEXyCzc5jdx18PuRMQDRF6/Lt/u3BVzl
         kLmCVG0iykqVz0loOlHuzYAHKLPH0LcDU+FR6UWyYICLnX4L4RP8YdiNG3Py0d/qQOM4
         FoPhOoVjhGjxft7t4cvzozUaSrb/a0NYYQN9fk+8FlSd6Mk8VVd0un2twQ6r2LGROXW/
         aCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695133864; x=1695738664;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/0WrBzh63C7xwn8f0bvNlIZVyHGQOan8CcxVdRn864=;
        b=L57CE59NpgXKnzVAv9h126zWNIi5I+IbUqsfiJnZvUa18TTMs6gWxKC3K7K0q1I3+W
         J6qDPyqEfpS2YpD4nB3O93smVeRfRokwCsl3iLXMwidXFXYp1+FbjD+3Ay8ycD77mkT6
         zeIG03wH9ocXIzMrgXjlBvPTp4d9yDr8Jdi0wbc68bdL9SGV3ugqHCmND3PirBjGHsTh
         M3iC9elwuqoxr/yUxoMzP8o6Eu0oFhsJWuI2a++Vq/ltmR9v0Vh/JJHGA0GwyLxoYoO8
         jmyw/oJWqi8/kAOY+4jCnkJhta3H7qmGcSeUckiGKpaBFQ6hVaaUgvkkN2HMU7w8DyZW
         IehQ==
X-Gm-Message-State: AOJu0YxC8jIFQ1sH5Sv2ZiKIFOqbibYY2hW6DRcpkr3RHukOlTXEJF5o
	RLw+nwMt4y4gtmNhp4lKIB7AIS8rUWeL5THcz4eQ8Q==
X-Google-Smtp-Source: AGHT+IHllfB2JPfVKqCiikGSONF5nW0RNOKrb5B+BzkQaULq7uamcdEL87EU3M80pw9zTy06bz20HQ==
X-Received: by 2002:a17:903:41c3:b0:1c4:4a58:ff65 with SMTP id u3-20020a17090341c300b001c44a58ff65mr13007174ple.64.1695133863765;
        Tue, 19 Sep 2023 07:31:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b001c0e92d862bsm5608446plg.99.2023.09.19.07.31.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:31:02 -0700 (PDT)
Message-ID: <6509b0a6.170a0220.88b0b.0747@mx.google.com>
Date: Tue, 19 Sep 2023 07:31:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.191-cip38-661-g112a3073ff26
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 2 runs,
 1 regressions (v5.10.191-cip38-661-g112a3073ff26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 14:31:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13153

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 2 runs, 1 regress=
ions (v5.10.191-cip38-661-g112a3073ff26)

Regressions Summary
-------------------

platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
asus-cx9400-volteer | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...o=
k+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.191-cip38-661-g112a3073ff26/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.191-cip38-661-g112a3073ff26
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      112a3073ff2650cf1c0684ba93fb4a7284304812 =



Test Regressions
---------------- =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
asus-cx9400-volteer | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...o=
k+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65099c86751b9a86278a0a69

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lib-asus-cx9400-volteer=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lib-asus-cx9400-volteer=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65099c86751b9a86=
278a0a6a
        new failure (last pass: v5.10.191-cip38-218-g9947ff6f0dba7) =

 =20

