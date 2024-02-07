Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F414BC4829D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 01:39:37 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.11060.1707269973317388946
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 17:39:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=u+r0lVkW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d731314e67so1187755ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 17:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707269972; x=1707874772; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bGcJgdb+HnlfCtG319BmddWRdgu3wv7xOT3udDD+gF8=;
        b=u+r0lVkW+BO1MbsjSyRnaqwKfhVU4p1gjzLx4Hx2wQA0gXmNneKoCQhTmodo+jGc5Q
         uLoNuNB3tMC17YZxkps8Vr58L18AKrexHEnv4OMKWaQVpnQNFkfBLiQQAnlHetXGXtjq
         PpRbsU0W3buLXAsPmxASTuvjHh6yiEmXNx+jRNOCV2ND6MlbyLcrITLSlRN7czIweajt
         cOmHF2DTguvmpM0cPRvqHm7FmoVT/YOUVfxTZvQSBw1MuxrqUZbuTiEqbku+rHY+wveo
         qEa6ABqVURzPc2kXqNCi4D0BSP8NCkpgm10US6Z3t8BsFQO5tBkjtTfYK+i+t4x5oi3L
         TVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269972; x=1707874772;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGcJgdb+HnlfCtG319BmddWRdgu3wv7xOT3udDD+gF8=;
        b=Bp649KdGfMKYcfPw+pBKU05E/fTPh991ynqQYC8Vyln6Gh6vqR4T9pCuijOyPOcfPb
         DQtApS85Mh1/lP0KYQpGlvaoaILpta0PvWrJw5FKV6NjkGq9WKR78LaWgezMpqKdE8VN
         BklRQC4AjX0wgFvWKZ/D5mDMQyGOzfIXN31Wqa1bHPx2gEZlCvFpH8p3uBYuMymsGj5l
         QEtD5FgL5CtfZbllBz2YgOwvY0t8QrdZwazlBzXUzuRisXYD6aXavlBqQoz1xMtgUHqN
         ycYbpD4fw3iDXd+uncqrOva3mBmo1QHY8ZGCAEK5o+C0v89b3q1dl8VuuvtTZKjo5Hkj
         +2AA==
X-Gm-Message-State: AOJu0YwMWLxY6O9tC0X9kqPWb+n9q1PnaAo3OfBCDd8+56cz101sgNLN
	2GyrD4d0m+s46v5iyMhnggsevKONKJU8z0s2YFwn1Js6xBRuWRFtnqX29+TXQRWGQKMjGt/+wAI
	3
X-Google-Smtp-Source: AGHT+IG0sGXykHlQt0jPj2l9KdiwOoeMfRw+ebx0NjKMUN2tZ6j6BXOhWQcO5xWrR7abYQc5deTvPg==
X-Received: by 2002:a17:902:e5cf:b0:1d9:d17c:5818 with SMTP id u15-20020a170902e5cf00b001d9d17c5818mr3920892plf.4.1707269972341;
        Tue, 06 Feb 2024 17:39:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwjxrIoIeTfPhSYQeIyVfgNWy03S6RqW99onW30PkQQCzU7i0tG6RhF6sMU5XogmolzyftoYF+kQjk5X4XOa5/VWLUVPxjUDdcVqh9dytY3qDmLL2qUa1g3gPUKEIq8qHQgSu4lv0mgjHwmcyPIX03uQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b001d7610fdb7csm177060plb.226.2024.02.06.17.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:39:30 -0800 (PST)
Message-ID: <65c2df52.170a0220.4a1a0.0be1@mx.google.com>
Date: Tue, 06 Feb 2024 17:39:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.209-cip44-50-ga624abaa85d7
Subject: cip/linux-5.10.y-cip ltp-mm: 3 runs,
 2 regressions (v5.10.209-cip44-50-ga624abaa85d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 01:39:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14853

cip/linux-5.10.y-cip ltp-mm: 3 runs, 2 regressions (v5.10.209-cip44-50-ga62=
4abaa85d7)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-50-ga624abaa85d7/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-50-ga624abaa85d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a624abaa85d7f3ff289eb2e257db5c4485d11d18

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
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d17e110f57be298e1e7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c2d17e110f57be298e1e7f
        failing since 756 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d393976ffc8d6d8e1e87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c2d393976ffc8d6d8e1e88
        failing since 756 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

