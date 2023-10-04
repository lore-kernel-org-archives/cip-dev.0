Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29264E7B5FA
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 11:41:30 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.16122.1696419685766133736
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 04:41:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ac1AVmTc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1c434c33ec0so14450645ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696419684; x=1697024484; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ks4PtX7dFGszBwWn9LCZ2oX496sPiVywZfNUrPPxAg=;
        b=Ac1AVmTcPm2u73395zeCk12/7lJ3ZDj3CUa4XtMWu/Qk9JTs1lfL9a7S3mICX+otmb
         VQBHAuFoegunrlKiKTSbUlzU/Lrdhs/odi+MIZwRWzy6jurXrm1m4kCnxgkpmmGjvJE+
         0d/Ve8Jr1R8z+7LavuX0NidwowCUIMTcvdTx11ZON2zDShbBgNsPhABz5AdY968UEBe1
         0Vji5QmG9SVGaWsDFUDXZrZhzU3P/1aY/GcjqeiY5214zBEa9CE851NEO4w2N34TScqt
         DH2OApvC6K85DvlWyJ7g4Nnt+cXAPr18OXR6ib3twCGa9z7BNCnUymPVHPQgcXxTV7Wa
         oSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696419684; x=1697024484;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ks4PtX7dFGszBwWn9LCZ2oX496sPiVywZfNUrPPxAg=;
        b=JQ1pcyAeJqtq9yq1nhiPP1Rr8Ex6Y99vdRB4UTX7sJLWioIyW1e8qe62oxHQI65erE
         2TjK1/rkZHIP2srxmfyol/4jWIU7OaO909RtJwe5jiuIhCZb/FnlHnrHoLtplUyCHn6P
         beOZD3o016VRbufMcWOpto5LCdKQxujrEZNch603wNke2F+FHs0Nv0DVRCTsolr0bwMD
         JnekPHrcyrCyeMX+Ke3E2PO2dWiXoXJoqcd2G9jDbImkGaN8dycyVDaEW4rV6E17lto1
         f0uvIcas7+okJFLan7K/sUnVRm0e+Oe8ZeuMeAa4DwumGSVlnX1aDUp6VE3kbcDTXMgI
         Kgrw==
X-Gm-Message-State: AOJu0YxF3YJSIl2Mtq3h5hqfQ7mJ4GK8pV/QOknyQjU8WmpgHqUTSuHj
	zBN8S15W6K1nUxe5nLU8GVmIQctg5gQ/8U3oUfg8lg==
X-Google-Smtp-Source: AGHT+IHAe23k5uTL08Ra13SPHJgH+JjxTv2DGfvnAt1zOoGS86WVCKtC18yiiHuIAu5YXfcrBZcgCw==
X-Received: by 2002:a17:903:2587:b0:1c7:54f1:337e with SMTP id jb7-20020a170903258700b001c754f1337emr1794759plb.33.1696419684581;
        Wed, 04 Oct 2023 04:41:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001c75d7f2597sm3441886plx.141.2023.10.04.04.41.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:41:23 -0700 (PDT)
Message-ID: <651d4f63.170a0220.1c0fb.87c3@mx.google.com>
Date: Wed, 04 Oct 2023 04:41:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs,
 3 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 11:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13272

cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs, 3 regressions (v5.=
10.194-cip39-1-g53e59f50ca3ff)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-1-g53e59f50ca3ff/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d425f343374622b8a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/651d425f343374=
622b8a0a44
        failing since 111 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/651d431a134e8d9bf78a0a64

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/kselftest-=
futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/kselftest-=
futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/651d431a134e8d=
9bf78a0a65
        new failure (last pass: v6.1.31-65-geef5a19d48f6) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d45ff79e6fb29088a0a55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/651d45ff79e6fb=
29088a0a56
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70) =

 =20

