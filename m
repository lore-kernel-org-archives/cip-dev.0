Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC83C48297
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 13:43:57 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.63107.1707140636364364778
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 05:43:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sUygybM9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d9bd8fa49eso5147865ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 05:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707140635; x=1707745435; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C8nxUKbNL5iGqs9gw9MM1NrntSRIK1+1p8xlf66rlZA=;
        b=sUygybM9RvK7jjcYeGiFqHvTXXLRDitF0KzuM60oREIZBta4QrwyVuLhm6yX0W/47y
         VUEChzqo0tyHa+Ev5kJtKSxrV5li5BAX82qAXat+alr6dbMiui1kSV5U7/POwVx4DD31
         jBe7pkPm6noDSVh+X2dYGzN7BQPFYodYo+Tp82FbdlT1odLE6b1QZZzux4gBpvq/OBCv
         crx0x+B0G+qDE01zzxYfk7a8rj6dzTdwriUHC2VrnFqR3FuTq2Ny+eQBqDkD9ZW7iEMt
         MCFoP6JJTF3ZO5t1kZiLqb2J9pR9R65YcBBQK7efx/NQrX/lGrsk0IbkSX9JKJOK0R87
         t4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140635; x=1707745435;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8nxUKbNL5iGqs9gw9MM1NrntSRIK1+1p8xlf66rlZA=;
        b=NLvpYoCWrN26QRSXmsdcVwgyFOmig8AujnfLXApgC7+MlWgn0xEKx1bLAXwg9YEvgA
         UuJqvl1Rkgr9XPq1v0teI0k3d2mFZoZTmPu3JYszx8kg3riidkO7Wj3Nza+oPV2e8WZo
         akEYI53AKsL82eun3EivxS6VMSjEdSd9Qqg9hZ+xNzbT0GeH4dlJbrZVu+9T8jQD1ShH
         /Od1oa+JGZ6WYI2PQk3p46qLXsABspS1o4K/Vki/Z+TSxzUeMOICwsSsc3N6JHeFBtHB
         pcluAi53/rvMLOzHTnmRMGrL+SkipzEhPsLBWZYW4wfzsjXISjjENYacl68jgNtCB3Wh
         v1bg==
X-Gm-Message-State: AOJu0Yxz5wjebaFGbMhxVYyCVRfHRdMZi3m7av8jg67/cQvGkxGtJwcd
	/LzOukmhAJwIK9Z8L0hDsdke9imxAAge4zpRIm8ECktq8CZpXSeVn/sG9UqHxPvmc0jsCV3ge+J
	Z
X-Google-Smtp-Source: AGHT+IEcj/6N+PsuSJDdLrmHE9lOnFXUIQtDqglyyEMuag0cOTrAlBK4bc3MpQcFnaNShs1S+9pqRw==
X-Received: by 2002:a17:903:2347:b0:1d9:8cb4:5228 with SMTP id c7-20020a170903234700b001d98cb45228mr7049072plh.31.1707140634986;
        Mon, 05 Feb 2024 05:43:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e80400b001d9a40e204bsm2803433plg.21.2024.02.05.05.43.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:43:54 -0800 (PST)
Message-ID: <65c0e61a.170a0220.d28c6.7289@mx.google.com>
Date: Mon, 05 Feb 2024 05:43:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-6-ga817aa655908
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 12 runs,
 1 regressions (v6.1.75-cip14-6-ga817aa655908)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 13:43:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14722

cip-gitlab/ci/pavel/linux-test kselftest-futex: 12 runs, 1 regressions (v6.=
1.75-cip14-6-ga817aa655908)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-6-ga817aa655908/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-6-ga817aa655908
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a817aa655908e54b6999ed3d0663c3f370d059ec =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65c0d9ae1990fbcd3e00a18e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig/gcc-10/lab-cip/kselftest-fut=
ex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig/gcc-10/lab-cip/kselftest-fut=
ex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65c0d9ae1990fb=
cd3e00a18f
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

