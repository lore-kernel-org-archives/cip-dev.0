Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99906C4707C
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 21:08:58 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.35085.1704488933978248290
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 05 Jan 2024 13:08:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=dVdS1apA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28bd623c631so24254a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 05 Jan 2024 13:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704488933; x=1705093733; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h18uS0UjtUQHp71n3rC8Se6NevvLSHfHI2kH8iRhZeM=;
        b=dVdS1apAdoPbYx3sws20S6GqHGwDZj1KVvTIegQzpBVcfPBQFZiRNjXb+cy7jFUy8/
         MSMdRlM9efGNkWoGIBdSHkkj/FY/oun621s92Wc4vWSvsNKx5njHYDE5ld28YBMmES1D
         aJncfps4k09PIZoIx7xOYjpbAvyMC9cnq6WEyXOhHdXvHExKfR+P7oyykdBemDRC3Ax0
         eN83t77+7HYOl/qyZ35/ZiCnUAeuPjRki7b5UMizOpBucY9VK4jFip3a41BYH2LTy3/F
         rKokWbZy76QdYk9ZPK1boDiA+AENUiWpCFSZ94R2tMLAkZSD4rzdgAIdLWDDk7KYfTlt
         cwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704488933; x=1705093733;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h18uS0UjtUQHp71n3rC8Se6NevvLSHfHI2kH8iRhZeM=;
        b=gAOYlrKMbTuWdaNbO5aKY66rKy4mbvFYhi/s64Sz6sN5prcWuwSl8lOvGaqFEcjcs9
         uQNjt8wPTRbK0y2pWjJFz8Zca0vLhz18G3ZV6wJiWfNDxjpmHX8HHkP9TVmDG9RxU1Cn
         UeqxAdZl4vAJ/W3BXbTBmrw3LiBC+dbJDgmhE79bLapnfJdhYLU6zhR7B0gxD8hqku1x
         OjG8MwLinz6G9caXOI00CLB9vvQsUzXieeED8hc8vL08/DmNA2n8eGGVa8xmizq0BonB
         7COM5lVpohPMx3wzs2EaAKCzG5ffBrtMXQE9J9xrbueLFK5pyYpvuOqaOVEH8ujQk0xA
         5mtQ==
X-Gm-Message-State: AOJu0Yx8bHoKTMV5g3OrQzqJWrbiECQEMC/gb5QZ/X1wopP3R9IHYkio
	kUaJG4vnUN+VihoNTFq9HakK2+YIaS+5AWt1d5o7PbNToUU=
X-Google-Smtp-Source: AGHT+IF9P73m/JHeV7zqyjWCJhLlBBKBqCT+w7F1VYU5qldtc0RgcJ3vlHscVaxXpiLcqm3aXcB+bg==
X-Received: by 2002:a17:90a:9511:b0:28d:d25:bfba with SMTP id t17-20020a17090a951100b0028d0d25bfbamr62705pjo.84.1704488932872;
        Fri, 05 Jan 2024 13:08:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ee8200b001d0b6caddbasm1805744pld.291.2024.01.05.13.08.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Message-ID: <65986fe3.170a0220.fcbf0.42b1@mx.google.com>
Date: Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-897-gcc9858ae2881
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11
 runs, 2 regressions (v5.10.205-897-gcc9858ae2881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jan 2024 21:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14263

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11 runs, 2 =
regressions (v5.10.205-897-gcc9858ae2881)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-897-gcc9858ae2881/plan/ltp-fcntl-lock=
tests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-897-gcc9858ae2881
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cc9858ae2881ce2dd7cb1eab9e7038ce843f1bfe

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


  Details:     https://kernelci.org/test/plan/id/65985f6daa70257b4352a432

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65985f6daa=
70257b4352a433
        failing since 64 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6598623a345e933ad152a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/ltp=
-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/ltp=
-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6598623a34=
5e933ad152a3f2
        failing since 44 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02=
, first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20

