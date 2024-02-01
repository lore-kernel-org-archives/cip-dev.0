Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A851C48294
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 22:20:44 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.9122.1706826036114083025
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 14:20:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Livw9myU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d72f71f222so12840075ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 14:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706826035; x=1707430835; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TQ5qFYhiTAwx1PSlpSbnSqmPlkLSJK4wIqFbtzl9Jl0=;
        b=Livw9myULwznl+HREAySxpx5S5LOKs+wbzSjhS9HOGQwiH7CJqlyTmK+qX6ia41JEE
         YM1rLloEK1Ed0C8TJsK73ipuqRracK8/h7UqPVh0HVe450bS/sYAiy1A3Pz3mI9fKaOB
         17p/Ea91a22/CyOk5das1wfa7mxJrK93m34hz9ziblipQHvEQxM8tt2l76ZlOm5MlE2A
         DEgCgi4AYpQzsaxWUHFKBIPAuJ2gH296TFO0ARhiXvgND41PuYgH9QKNSCtB6YNcz18E
         zxWpuF/3zqJ36+JHB6tmuC6gxWVkvxT+gc6mlyFLdnBjGijBXescCuo5eGMhndv43bcn
         6E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826035; x=1707430835;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQ5qFYhiTAwx1PSlpSbnSqmPlkLSJK4wIqFbtzl9Jl0=;
        b=pQtcYjQXX8qZfCtsdUzJOhsvHm1wHTz2fGuoJTdLFvau+3/vqWFv8sSCdy/k9rxSyK
         pd9COgExStpEsL3cL1PbUkhu6Xvg9aafaubEccZT2M1eXQdvV+AJ0/v5te7tHg3NOxQA
         O8zfctQC01fsXdtUBbNE/lWKpFyynDlZyZkeeIHPULhiGGF/uZQ+2/Wyh04l4hROFYZp
         teiOgNMJeS+PKijPCAS5+lOf+hiu0tRPBWLuDttF7FCk8/B72cxddU+YszCVX/3vBJYO
         kpeuSaO7NfRsKr8/Q4JeBX4WfvG2hDFxCc5uZD6lZcRkB2NokpcVVXYCKGY33Geejw8t
         Tv+Q==
X-Gm-Message-State: AOJu0YyGDU4dy+SVqcDaF1yNeZRVXuFUyisdXPaRrg63MtgxpiYzsxmo
	ln5tUCEmucnk1XgTHZ1v6gpJbgqm9QNWMgbxKPmAhfv0+rGQXvF22Q2FVJmDsJtdeTVUtfWVhef
	x
X-Google-Smtp-Source: AGHT+IGIsJe1+zr9ynCHpwkWgwZwhqNB3erTLeXd6hi9HiAoGu6c5V3lFhiP3jiO9bOnV2dX630EhQ==
X-Received: by 2002:a17:903:32ce:b0:1d4:2330:85a3 with SMTP id i14-20020a17090332ce00b001d4233085a3mr428602plr.20.1706826035095;
        Thu, 01 Feb 2024 14:20:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXBjOHVfm155RiTZKIFWRgUk8lDMqlYdFKnD9ar4UBUmLUooRP+ZBztgMjHnpwHuz7ECUfHHXOHleU2EdDkuOb686buJ65qaPkZhsyPvk+Qb+/Ha8HKLbsqsdJ2m3keiO4eTcEFarmDfoZmsc5X4BGz5A==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u3-20020a170903304300b001d706e373a9sm288949pla.292.2024.02.01.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:20:34 -0800 (PST)
Message-ID: <65bc1932.170a0220.6c613.238e@mx.google.com>
Date: Thu, 01 Feb 2024 14:20:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.208-cip43-4-g1c63c70fb18b8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs,
 2 regressions (v5.10.208-cip43-4-g1c63c70fb18b8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 22:20:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14594

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.208-cip43-4-g1c63=
c70fb18b8)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.208-cip43-4-g1c63c70fb18b8/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.208-cip43-4-g1c63c70fb18b8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1c63c70fb18b87b5bcfe5d7ddf0096c92a1557ed

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
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc07b49588786a8400a093

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65bc07b49588786a8400a094
        failing since 751 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0ca061a5115d0500a06e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65bc0ca061a5115d0500a06f
        failing since 751 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

