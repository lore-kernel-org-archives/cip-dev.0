Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE530CD80B0
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 11:37:17 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.88775.1696937829057103212
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 04:37:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YP67nDXs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c5ff5f858dso36964545ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696937827; x=1697542627; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DEg1DJYBK+phevJ+YfNoSLtgSHztaVCPAlkmZoSwZXk=;
        b=YP67nDXsyOjCZSFCMMFsZKDxULtLBxnw8tvy+DiPfZDdM3sSChwY1UCZAKW7nQTYhD
         7OSLaQvbR1QTTkPHh8627qlln6/kHubAb61FEfI2A0chfGvBLHVOfQwGYMX1HaBFDTnK
         fLY2mo4epSosiDindYadnYN3hegHVK9x9Z0SwVZtqBSPnQYWpjy4cGB2YOIaWK3DCuov
         +QiF/t7z+XrSIRs5XsWdLGz7j5rJgFvu1xvnjixJl3dQeG6FOtHe0ZfvKSeTpH55DXn2
         VOSwPL/rEOvGrZ0omQxLsZR42icuZEazdheHunGQ4BbqynL1UGowSMeZ7aHYdMq7bmrk
         EkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696937828; x=1697542628;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEg1DJYBK+phevJ+YfNoSLtgSHztaVCPAlkmZoSwZXk=;
        b=MTXl9LO8OwE7GE62hbQKGoDuKfwiQHZXpt3ZDn9hhM9r0qgoV634Qq65S32qc4lWAk
         i+sSUOXMpbsTjd9LoY7oDygikZAjOgHVlv1JQsrMmtDVwVzCC714lEUg2UwkOYjuNRAz
         idTwas7pl6ym1P36DltklSQOo9LCw7ulvUCBHYsTBFSgkRik4XqscXDJJgcegKelYEAc
         gD+vXcOJ/K214fDmAoqmT54HMNzIqMrFPyUJ2ojYDHbDhwtN4JR8vaA4Gh1FMPxKZkQF
         UP7aBYGUBn6C/0QGCUfvpZjN0RN+RoapxYBQK4uHMUe/PhCo0iP9Q4KOb7biXe1wHBr5
         OyTA==
X-Gm-Message-State: AOJu0YwcFWf4G+VIQ9VDYqnrIH8WRwjgB6eQRDWZr4KL1DOjKn33raZc
	B0c+1vcErcuOp8VC+LIb3FYPWpUkwAnwvrSV5k74NQ==
X-Google-Smtp-Source: AGHT+IGguf4+EIZJAxyvsH9p9PT+myYZYjFCYANVe0WEqLn9zxb7jBeQX0r29mt8laFaiGgYPH22Gg==
X-Received: by 2002:a17:902:ce8b:b0:1c5:be5c:bb5b with SMTP id f11-20020a170902ce8b00b001c5be5cbb5bmr17323097plg.59.1696937827620;
        Tue, 10 Oct 2023 04:37:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c18-20020a170903235200b001c62b9a51c0sm11539993plh.103.2023.10.10.04.37.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:37:04 -0700 (PDT)
Message-ID: <65253760.170a0220.4a25.dfd8@mx.google.com>
Date: Tue, 10 Oct 2023 04:37:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-552-gc89b2c57483f0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 17 runs,
 3 regressions (v5.10.194-cip39-552-gc89b2c57483f0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 11:37:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13357

cip-gitlab/ci/pavel/linux-test ltp-ipc: 17 runs, 3 regressions (v5.10.194-c=
ip39-552-gc89b2c57483f0)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-552-gc89b2c57483f0/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-552-gc89b2c57483f0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c89b2c57483f0aae7f9cb377230347592eb3520f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65252324262198778aefcefb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-ipc-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-ipc-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65252324262198778aefce=
fc
        failing since 117 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65252437e9ff3b8ce3efd061

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65252437e9ff3b8ce3efd0=
62
        failing since 5 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65252973d459591283efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65252973d459591283efce=
f4
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

