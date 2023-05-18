Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E190FC77B7A
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 12:16:36 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.15594.1684412190756869106
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 05:16:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=uhaBwCnG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6439df6c268so1416163b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684412189; x=1687004189;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R5x8BdqxnjdppG0cxxlzjemV2ciRam0dgY7jayYllDM=;
        b=uhaBwCnGzCtyAAbcF5xrt6g2a2MQH6BqIKDzWj60nAsxFifurHrcyPJcJLyYl45OoX
         nkraydKuH7SLL3T5IEbu8bL4mCHrqffuO2fTkABoQvsAUhUcYe8WvH2efFY8NIBXWbKJ
         DtL7Yoqu09YFAtQXjrRgFOhdpUBuL4r/7kv8hVbf53EzlHEyNqS/LfDCw9O4rFX1enxn
         wQF6bU0WpX2gu3N/VXnA9gQv3GINfmRl72LVjfP2eNTUJqFr0vsyHgdsh8SsCEIbmHuv
         LYhIGSu9Vxy3gD0+VWCcjozowBaJ+kzF9duKsMVoBRZDAkXKyVTW10Iynb8F5uFVIJB0
         jgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684412189; x=1687004189;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5x8BdqxnjdppG0cxxlzjemV2ciRam0dgY7jayYllDM=;
        b=NNu6qWJx4uQzeCNKnLRbv1JREgsSf1ui47lbAH3jW4gRW63W/r8T1iXXGe/wySklFu
         rFTm8O3ZhDG4xTn80wlmK4OpGMsSvGdFOoRu/H3qQOMn5qcn0a6IDFAwhrCcvgnEi4t0
         QWBhP1iHYPExa5+Ksj4fvVYc3sqZLTAGxgr3FNm1GBVBwrYMUmuT9AXTd3hn5MIst7vT
         LmoXYaTxCDz7mnkTtj5SOWCeAJLM7BHv+RTqH6A4aFdClQjax7txr91I/Gl0o8/fUEdq
         6VXHdYMTPP/M76btUmO207znsOGnbGClKzPED00I0Ah2vvzG5Ph03bz8yKCGaVlOKXYn
         uDKg==
X-Gm-Message-State: AC+VfDwLdDRokCEnbW7dolXrckov9t+xuj3NNCYK/ykWFB0oBOAXCA/F
	TC7C4jhl7Kr/1I/2Ncf+DbUNSj5HIGQSo7zQH+1Iuw==
X-Google-Smtp-Source: ACHHUZ5HAPGdVvDoPANQxBPYQoitmlgNLEvZ5eZFZfWZo5DwNoxWV/eoEi0DCB9x5OqBbEah5NucJw==
X-Received: by 2002:a05:6a20:548c:b0:102:6b0:a648 with SMTP id i12-20020a056a20548c00b0010206b0a648mr2448866pzk.4.1684412189474;
        Thu, 18 May 2023 05:16:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d3-20020aa78683000000b00640f51801e6sm1220450pfo.159.2023.05.18.05.16.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:16:28 -0700 (PDT)
Message-ID: <6466171c.a70a0220.fb5a0.1d6a@mx.google.com>
Date: Thu, 18 May 2023 05:16:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-471-g18129e1b68691
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs,
 1 regressions (v5.10.179-cip32-471-g18129e1b68691)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 12:16:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11518

cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs, 1 regressions (v5.1=
0.179-cip32-471-g18129e1b68691)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-471-g18129e1b68691/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-471-g18129e1b68691
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      18129e1b6869127ae39e5978bb2fe70ecd53f174 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64660f97a926b9ec9e2e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-cip/kselftes=
t-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-cip/kselftes=
t-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64660f97a926b9=
ec9e2e85ea
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae) =

 =20

