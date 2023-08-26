Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6770EC83F15
	for <webhook@archiver.kernel.org>; Sat, 26 Aug 2023 16:56:27 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web10.12165.1693068977496071788
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Aug 2023 09:56:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=l74raAzU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53fa455cd94so888159a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Aug 2023 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693068976; x=1693673776;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=39GB+vRaRL8R5cN/fyhzKNCFFAnxh9PqA6nCr3eswzI=;
        b=l74raAzUcSMVyg7HJRPKJ5MnJx4zrS0IE+56qRQMthIb4Rv/oj7dEm0WAFhQu6louJ
         KU1qZ2nRUS3D8dnf3+qWSldm8IjtdYZRCmp2X1qU1qmXQG4OUaxWjvWK9HeOLPO0tcor
         PgbLTZFj5sQF4ZhKA9ihacvnsmEVpEeaaLVOjSZ9hRyO0fEHi13T7io0TvzvxESG7vNy
         Rlq3oBJZDQpeaHS8CtospAvZU2YIGYUP3yDz9Qx/JFTttY5ye2Qg0HGHf8dNcDvUiK6Q
         Zu2GcVtKrhLOQqXc/swpUyQpNPQQe/1IsV47g9WI9pdCWfOEXpsl83QE4C+Sdf9OtOEF
         tpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693068976; x=1693673776;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39GB+vRaRL8R5cN/fyhzKNCFFAnxh9PqA6nCr3eswzI=;
        b=P0Ag9h/sDtqdJztvEoB+ybQbBhQXMe88N6proPCo8jfCyLEZ0NlXctu0NaGlqvAdJq
         HDrXOLUARLlwEFFmSnuA2k3OJD6iAaux6qwY4EJLLUR7e+D4GlOarJzdDi+yGbv+VSn1
         7tYzT+/Lr8SM6KOvDvSSvyJicOEmjg8bCmaxA9yeF6LdLfh2NYU7Sbd2oGzeW5lOjORY
         rU7QoF1ftlLEYc+G1GThWBi2GyLV7JM8bcE3fXUxgmMkvv6RsRPJf0UWWovZalUF14GX
         XARsmokjDskzqpfRJ87zDUrs2b8OErCrrB9mUkgMhHVLr5wxhpqvssdKnmmePOzYlugj
         ZfIg==
X-Gm-Message-State: AOJu0Yzrb7zHMNhaCSAQdI4AbTKqs7e0Ibzk8buQapDPjtqW6N+XQ3Yd
	D1UZrAXrDQrE8umfJp/9/nbbO0OjXRnHaRvy/IQ=
X-Google-Smtp-Source: AGHT+IH1oDLxlQwNI12/Kqc6GwRH6im248wp64URJCZLowVif1fBf2XagMHMa4UYjkIbgfUVw3yH4w==
X-Received: by 2002:a05:6a20:3948:b0:13f:8a5f:ad8e with SMTP id r8-20020a056a20394800b0013f8a5fad8emr21601947pzg.58.1693068976119;
        Sat, 26 Aug 2023 09:56:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78488000000b0065a1b05193asm3481875pfn.185.2023.08.26.09.56.15
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 09:56:15 -0700 (PDT)
Message-ID: <64ea2eaf.a70a0220.c8464.5748@mx.google.com>
Date: Sat, 26 Aug 2023 09:56:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-982-g80a0585c0aa62
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 42 runs,
 10 regressions (v5.10.186-cip37-982-g80a0585c0aa62)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Aug 2023 16:56:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12851

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 42 runs, 10 regres=
sions (v5.10.186-cip37-982-g80a0585c0aa62)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-982-g80a0585c0aa62/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-982-g80a0585c0aa62
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      80a0585c0aa62f4c1dd47f7b489c39ee5bba99ab =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea23412a6331ff53286d84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ea23412a6331ff5=
3286d85
        new failure (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea235bfbab734ff4286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ea235bfbab734ff4286d71
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:07:38.095765  + <8>[   18.636460] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11363444_1.5.2.3.1>

    2023-08-26T16:07:38.096167  set +x

    2023-08-26T16:07:38.203716  / # #

    2023-08-26T16:07:38.306531  export SHELL=3D/bin/sh

    2023-08-26T16:07:38.306774  #

    2023-08-26T16:07:38.407716  / # export SHELL=3D/bin/sh. /lava-11363444/=
environment

    2023-08-26T16:07:38.407969  =


    2023-08-26T16:07:38.508810  / # . /lava-11363444/environment/lava-11363=
444/bin/lava-test-runner /lava-11363444/1

    2023-08-26T16:07:38.510087  =


    2023-08-26T16:07:38.514773  / # /lava-11363444/bin/lava-test-runner /la=
va-11363444/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2246d8d9510890286d70

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ea2246d8d9510890286d75
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:03:07.261158  + set +x<8>[   22.026997] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11363375_1.5.2.3.1>

    2023-08-26T16:03:07.261660  =


    2023-08-26T16:03:07.371329  / # #

    2023-08-26T16:03:07.473901  export SHELL=3D/bin/sh

    2023-08-26T16:03:07.474800  #

    2023-08-26T16:03:07.576377  / # export SHELL=3D/bin/sh. /lava-11363375/=
environment

    2023-08-26T16:03:07.577260  =


    2023-08-26T16:03:07.678842  / # . /lava-11363375/environment/lava-11363=
375/bin/lava-test-runner /lava-11363375/1

    2023-08-26T16:03:07.680210  =


    2023-08-26T16:03:07.685398  / # /lava-11363375/bin/lava-test-runner /la=
va-11363375/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea22de94dcbefe43286d8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ea22de94dcbefe43286d92
        failing since 128 days (last pass: v5.10.168-cip27-109-g23841ec76be=
c, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:06:39.926737  + <8>[   20.784307] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11363396_1.5.2.3.1>

    2023-08-26T16:06:39.926816  set +x

    2023-08-26T16:06:40.030859  / # #

    2023-08-26T16:06:40.131434  export SHELL=3D/bin/sh

    2023-08-26T16:06:41.357446  #

    2023-08-26T16:06:41.357594  / # export SHELL=3D/bin/sh

    2023-08-26T16:06:41.458307  . /lava-11363396/environment

    2023-08-26T16:06:41.559001  / # . /lava-11363396/environment/lava-11363=
396/bin/lava-test-runner /lava-11363396/1

    2023-08-26T16:06:41.559312  =


    2023-08-26T16:06:41.564468  / # /lava-11363396/bin/lava-test-runner /la=
va-11363396/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea22d9b7408eb1b7286dfc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ea22d9b7408eb1b=
7286dfd
        failing since 29 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2657d85e6e3272286f36

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ea2657d85e6e327=
2286f37
        failing since 15 days (last pass: v5.10.186-cip37-566-g36076316ef04=
9, first fail: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2804db5ef58899286dfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ea2804db5ef5889=
9286dfb
        failing since 29 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea28ad17ebc751a0286dee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ea28ad17ebc751a=
0286def
        failing since 29 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ea2629e92d4b2aa5286dbf

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64ea2629e92d4b2aa5286dc5
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:19:41.031627  /lava-11363585/1/../bin/lava-test-case

    2023-08-26T16:19:41.069421  <8>[   38.299081] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64ea2629e92d4b2aa5286dc6
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:19:39.926887  /lava-11363585/1/../bin/lava-test-case

    2023-08-26T16:19:39.966088  <8>[   37.195646] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

