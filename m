Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7E1CD8C80
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 14:13:19 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.92721.1696947196776864478
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 07:13:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=hukRLhMZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c871a095ceso41867075ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696947195; x=1697551995; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hGZ4zDyiQLwPIgxq2EKj8j5sVXY7xl3VlCg20623/KA=;
        b=hukRLhMZdcZ9K/L9RQCDHdrtMaAtUTOsR7B8SR7x+LXDnodXeHYNH+Ej+lInIf7mg2
         HEIH6kBq40ZzbtaKdFSNHfvXDYB/SPvxM+yPYpXsEVjQv2ol83ieK1lqVsv3xZfqcnCC
         nqgKiBoqLrUoMcgBbc73bMEJOvPI8SVGAzzYIRFK3kNeqMSkSfqagfvDcEWtWn73etk6
         0Z+fB6i7WgKDNQyfZM0HaHUCvllE/R+cy4gnQDU0rA+UkGkhDp7lOydkpkfbN53yti3g
         gzRImC1mayGA9nrGGPOEiM7bEO0pbjCJonENp0ynXXDGtfSCbe4oa08TcXl4k2ZjTSZW
         qxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696947195; x=1697551995;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGZ4zDyiQLwPIgxq2EKj8j5sVXY7xl3VlCg20623/KA=;
        b=P73P9Q6Wr3CWq+p0ZfQsk4f6w/LBwyeNYAD+/7t5IzuqUXj1War1PEgWbxUfH97kcD
         By77p1XrMM6bOkK8MMR0+8TPRJbrWhYTXLsUWPUq/oozNypscrgUyJt4JINH1OHs+jUs
         GNpkLKBBx1fOhrufjI67G2FBpaVC5vdDVQO8h+9lh7xke7iZhSjzwke0nt5VfOt148B+
         iTJONO7Tw01vcOaojQH7ecWvy5RZYXGbFSAUY8xj3b6blEkzVJyey51uCw+hX6xEMJ9Q
         OVVX2T/cNJ73wTpujClxbSGBzrdxE4CxvdFYcfmma29Z7iCeW9V6JIYa7ZhnFkhSQFq8
         y4aA==
X-Gm-Message-State: AOJu0YwGBdalNb0jPeIYNP8oEpdrfEzufLPz/cbBpanRGptqYXP1e4gv
	6Ucj5eRT3JLsBKV7ex2jz2jxEGR/dkgu87s2Vlw83A==
X-Google-Smtp-Source: AGHT+IHWlX5dY8gsy+A10NIoDaSNgm0WHHktyt6gTfwSDA9ON2wi5rBvfaKGkWU9YuZsHr91V8ynYA==
X-Received: by 2002:a17:903:249:b0:1c5:befa:d81d with SMTP id j9-20020a170903024900b001c5befad81dmr20054719plh.10.1696947195465;
        Tue, 10 Oct 2023 07:13:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b001c72c07c9d9sm1288597plg.308.2023.10.10.07.13.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:13:13 -0700 (PDT)
Message-ID: <65255bf9.170a0220.a9c8.23ea@mx.google.com>
Date: Tue, 10 Oct 2023 07:13:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-557-g2932db67f070a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 17 runs,
 3 regressions (v5.10.194-557-g2932db67f070a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 14:13:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13379

cip-gitlab/ci/pavel/linux-test ltp-ipc: 17 runs, 3 regressions (v5.10.194-5=
57-g2932db67f070a)

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
nux-test/kernel/v5.10.194-557-g2932db67f070a/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-557-g2932db67f070a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2932db67f070a3c9076db35b5abbabb867b599cd

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


  Details:     https://kernelci.org/test/plan/id/65254cc239cf9ae90cefcf27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-ipc-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-ipc-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65254cc239cf9ae90cefcf=
28
        failing since 118 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65254edf676331ef9cefcf8a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65254edf676331ef9cefcf=
8b
        failing since 6 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6525537ba2b775f6a9efcefd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6525537ba2b775f6a9efce=
fe
        failing since 0 day (last pass: v5.10.194-cip39-1-g53e59f50ca3ff, f=
irst fail: v5.10.194-cip39-552-gc89b2c57483f0) =

 =20

