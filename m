Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB226CD80B0
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 11:37:07 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web11.88770.1696937824534324910
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 04:37:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=NMRiCjzT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.175, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ae5ce4a4ceso4036285b6e.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 04:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696937823; x=1697542623; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZqUIdhvu9AeQElggbkJaSFBSRYeTFG5aRhsjRrXUnk=;
        b=NMRiCjzT/+U3WZCFooig66/ewfTriqYMwgIf29LMxv9KvSYAYH5TIqzl9WdW0Kr6BI
         fPgA/uWZlUJlu1xxFtaKyL5Pu0q7Okyxt4HtXoZsJJUdgDos0phlTiou2P7C86EsHrFm
         DleBDMsY3FlL8b2JXZrMIPE7YzsLYES2XANGXW7Mkya2p421sc+Y6ySFg4wyj2rMOz14
         jYLqF30f1FfRDpRh4eu3c8FqvoILibtsVdCE8ahrlRMiFYyS8d0FyAqOpo7XwLagYI4G
         xxHZW/QVC1w8q5GWdjuT00nrKqieU43gb3vj8C8HICgD+2zgy4I1qnTpAe1b3aQexm0/
         QKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696937823; x=1697542623;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZqUIdhvu9AeQElggbkJaSFBSRYeTFG5aRhsjRrXUnk=;
        b=dojMuzAYFbiWfhKbVerdgDHa/pTm848e/t/RqkPDSVSiFeyTH8yy0bXB0wX0lKyEvu
         jbw5QgrygKiuJFtWMoxZgNkPR4Ln+sWdRI9FCj4Hw+tAWfglG5/zKY4vWbTHaTqnlufD
         +u1Ib05jFpKiiYbcmVFASYPmEHWCzmfHAs7N661KsM3e4Fu4hdkXZfwrKdkZ2q7yZHls
         kk4vDUY5hGO8Q7DUEdLef9YBGfzNueYMdkqrdlI7si9srWUbzHCrHid5xiVHWdGdtEAK
         7clzafQCwIcWmQhyqEUITJaaruWejrBK1MZTaccoDK+Vr7qGI5wB4fQK2/1yiiHCshBO
         f5OQ==
X-Gm-Message-State: AOJu0YweP+QH21uPV+3Fal58ROg5lUVUJjrJguQKt4uL0SrJb4TiA9wN
	xHhlCWWIWM2STPMSB6tL642OeZUIhFi582aigliVAA==
X-Google-Smtp-Source: AGHT+IEEfxNRMDk58goyPlL1PCTG0jf1VoTqG9Ua2LWwz0v9FUh/qWLpUx87n5TMG2nQhuT5XSLR9w==
X-Received: by 2002:a05:6808:18aa:b0:3a8:4d1f:9dd0 with SMTP id bi42-20020a05680818aa00b003a84d1f9dd0mr22438110oib.30.1696937823276;
        Tue, 10 Oct 2023 04:37:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bt21-20020a632915000000b00583f73b7bcbsm7127952pgb.58.2023.10.10.04.37.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:37:02 -0700 (PDT)
Message-ID: <6525375e.630a0220.a9e96.06f6@mx.google.com>
Date: Tue, 10 Oct 2023 04:37:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-552-gc89b2c57483f0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs,
 3 regressions (v5.10.194-cip39-552-gc89b2c57483f0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 11:37:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13354

cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs, 3 regressions (v5.=
10.194-cip39-552-gc89b2c57483f0)

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
nux-test/kernel/v5.10.194-cip39-552-gc89b2c57483f0/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-552-gc89b2c57483f0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c89b2c57483f0aae7f9cb377230347592eb3520f =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652522ca59be730f8cefcf6b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/kselftest-futex-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/kselftest-futex-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/652522ca59be73=
0f8cefcf6c
        failing since 117 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525259e5e2a35ef37efcf02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6525259e5e2a35=
ef37efcf03
        failing since 5 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6525286fd247fbafeeefcf07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/kselftes=
t-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/kselftes=
t-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6525286fd247fb=
afeeefcf08
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

