Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7107AC761AF
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 11:18:11 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.98636.1680607089327183224
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Apr 2023 04:18:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=LoIdAObg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id z19so30946272plo.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Apr 2023 04:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680607088;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XpcsvoQP15BfiJwPFVYMxG71csSdW2y0svxf7NBvuk0=;
        b=LoIdAObgGy3liLJcqK+jlnDwoJUTmGK1MOHogVNsTE1Ecn6KIPCUnDlgt7UWEgSQ6Y
         HjYtRSmrT2u6hhKzh4mfGwqGzfNgvuFUfTHnuP3vrTU6OI0rdTDBAP8ve3qzRneo7oiH
         fpcywVwGJtaUML1lAbalFDt8rHtTsf0B3CMqfuvhNr8qzRBNwSpjWCMYJQJsoAdcHpLi
         bWgkkACTSm7jfOL0cMYZKqOMC9Qrp8S6V+mwZ17FTu+AJEwc4i6rv/oj9yv7q2jW9fZR
         wZIYeGVSun1473CosyeuAt2tsSTJn9y4/sbbOardHumopIuzcabs15PTICMmjw7a0ieu
         phlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680607088;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpcsvoQP15BfiJwPFVYMxG71csSdW2y0svxf7NBvuk0=;
        b=6ValEfG4SWem4prEX2CX7oYJp8uPb3frBsLDNat53D9ZaeS/06go9ONbRPIVv0Djcn
         3V6x3c+in6viwAi3ywFVds/DXdfJ8g0+VYpRPYMxi4/wPuuqn4SlycTlm/TekXdGRPtC
         p4bfTFe4P5ypyGn40fmuIi+eE1TDQLby8ZQ4HKzgLP1P758WmWMCeIELNPaxdhj6AbqA
         jl7LWuUnx+YxRIWfHdnG06ke9QyPFlV9zs7jvY0h2AlxjkeXA0thNoliRpKB4HWXCEKz
         VeqeCYR4Hh6glrbBdcm4Jcp/1WFIe08riOsOABRuociu2ASdTLBZeJ/KWjgWqSsq5NEk
         dixQ==
X-Gm-Message-State: AAQBX9fCSkxfZQ1bNx9249x7Z461vMckhIMbSXfVmZFb/DI8XSfPqSjL
	TlERTozVF9VVs49IPXlQBT7idmMF1p0XE8SH6R5mwQ==
X-Google-Smtp-Source: AKy350YBeCW7CioCcpoIhHFL98FyFrmU6VqcgcaX6oY4/wdHWxCbuFdrmoj/Fek3enB2QRMKuJCO6A==
X-Received: by 2002:a05:6a20:4659:b0:db:9726:8e46 with SMTP id eb25-20020a056a20465900b000db97268e46mr1626176pzb.54.1680607088681;
        Tue, 04 Apr 2023 04:18:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d3-20020aa78683000000b0062e024b5584sm5603054pfo.34.2023.04.04.04.18.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:18:08 -0700 (PDT)
Message-ID: <642c0770.a70a0220.79cec.9990@mx.google.com>
Date: Tue, 04 Apr 2023 04:18:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 2 runs,
 2 regressions (v4.4.302-cip74-rt43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 11:18:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11167

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 2 runs, 2 regressions (=
v4.4.302-cip74-rt43)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      22456e8b8d35c6bd1313511bfa4dd945ce7a0c1e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  70199ce4f0c498bfc7d0d9e0440f54b97b373b26 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bfbe27ee5315bb579e97d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/642bfbe27e=
e5315bb579e97e
        failing since 12 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bfc0c0be71ffd2a79e929

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/642bfc0c0b=
e71ffd2a79e92a
        new failure (last pass: v5.10.175-cip29-rt12) =

 =20

