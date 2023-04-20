Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27776C77B73
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 20:26:26 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.2079.1682022382199914914
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 13:26:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=LqeSO/Qf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-63b62d2f729so1297933b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682022381; x=1684614381;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CcJf1eYr8if+BvTjmW5D8dFWssoBxdcbphf3II9cUzw=;
        b=LqeSO/QfLBLRKALtWW7GScnzHxNaWAhPjzc8CKIgyrudkkWtX+uI/9hsTRYsbPbTfE
         K1slaa6tnYf2Ez0hDYLTXBeFUE0/9RGG/SZ5gF9CI6nQSHlSDQBaCD3fHjJtzfY91rG9
         NvY3BWN1iBa62lw5fktg7I4iGZiL82oyazy2l3DVRMXORQzbaQxkA3pJmzmUmpm0+U1B
         mFsgny3wLdAm5dr8VwLhTAtL9ygxAYpJFzIIpWST6Rlw/VJyF+3K19IDAdp3/bhTtTML
         YAgqnf9/17bOwW0QKqY2JROeHJFJc0hpCm//UVefgQIlXMg4SPcE4Y3M+STs6w41PNL/
         cFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022381; x=1684614381;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcJf1eYr8if+BvTjmW5D8dFWssoBxdcbphf3II9cUzw=;
        b=FcujOCkJ7KP5AONs7nIZXEMaGyfMz2mKJ8K2caQB/+aj16cH4A8JkgY3ucpVX05suK
         i816cBx2yGXp8OLhwHlbAd0SRUstnrB0UtGuO8MCc1Mn8qCIdzYNkXSXSpbKn+tqCi5t
         J2OXLm7rWilnoyEh7UVhm34dflmAHorwZ4lyZMgbzq9Q7TRzuNrx8+c7Li3kafwrUO9E
         YklAyXRRm62sAwmKBbYyMV60Zt4dofloLGZeC1oDHoG17sSPp6PDIDVhZMHvWVU6Fr82
         tnM732eWc259nSSqneeVwDyuZtxWA820P+oJImqooPO6MoHCH7nfi2/GvZKdJzGMFfKu
         X3Qw==
X-Gm-Message-State: AAQBX9eFMS7A0tGQA6jMNymFLFBAWNkogFE7wvOieeaL9WAXsU+e4rXD
	qsxwyWurVm1yTIUBfHDFvvFadwzEnq+7AZWnheXV79XT
X-Google-Smtp-Source: AKy350ZAiLfXVwJ+7/8sP1vmnIX1P60JoVI0aZ3HX+7AfCRcDK4QWBT8He+UsugTJ+xQLU0nZZupsA==
X-Received: by 2002:a05:6a00:1a0b:b0:62d:8376:3712 with SMTP id g11-20020a056a001a0b00b0062d83763712mr2128792pfv.28.1682022381250;
        Thu, 20 Apr 2023 13:26:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y19-20020a056a00181300b005ac419804d5sm1692676pfa.98.2023.04.20.13.26.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:26:20 -0700 (PDT)
Message-ID: <64419fec.050a0220.b8c9.3d5f@mx.google.com>
Date: Thu, 20 Apr 2023 13:26:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1100-ga8cadce4b9649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs,
 3 regressions (v4.4-st20-1100-ga8cadce4b9649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 20:26:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11265

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs, 3 regressions=
 (v4.4-st20-1100-ga8cadce4b9649)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-1100-ga8cadce4b9649/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1100-ga8cadce4b9649
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a8cadce4b9649177791a9adf0eef53ef0c90de78 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644194977b08c3c21d2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64419497=
7b08c3c21d2e85e7
        failing since 29 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441976aa783c1ca582e8645

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6441976a=
a783c1ca582e8646
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644194d27b08c3c21d2e85fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/644194d2=
7b08c3c21d2e85fc
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =20

