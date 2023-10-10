Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7950EE14D8
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 14:13:19 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.92269.1696947195908148419
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 07:13:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vuIkUCJh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-69101022969so5023212b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696947194; x=1697551994; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qXlQJK6uLKu1gsTwMzPjjhYktsiD6xir+GTsLsdtyZw=;
        b=vuIkUCJhMPXcA+LdfIxiPfaFP5NZzwbZxE8uBypsYu6UrABY5Yz3dQKXDhTMXJ/M9L
         7x8z5wFCZI2eAVL6N7dfeKQgw7N79+Db2SgMcnCDEUGVEj/gR4L0e5IVqKgCCksTTwUx
         FrRVm+JOOTka8fVhmje9PJLeS/temZwrukfE9yWJ0KmjIvaeTbE6Xkx9fZJoWZgmFXHg
         dHyXCkpSAt55g7Wor/4JPO3r9bAsCgw6KwY3WdcxMH5Yal4uYJEI6yMZbL1OubX70fBh
         q1WbYDTmSRx3gFzhZwpb/DvbzlCxzkSgHOBv+trmvqlj0OBzxHlxnn6WdAWiuqavKBn1
         qR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696947194; x=1697551994;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXlQJK6uLKu1gsTwMzPjjhYktsiD6xir+GTsLsdtyZw=;
        b=pw6tuetEftOaTOLB7CEv0bXVksiesC0tHxZRrRqg/OhCuQgU40R5eQUC6DROHdRo+C
         eb9qgqcrN35PMptHUHpryuBmDKKltmv2Zjfh3UN1QH/5RowcKx5icHmWZhEOB8zvInHO
         iHMM33xD+5SsH3rT/xh+IZHBHbuZIeTm8NExEMhwAEI6qNQawsZ2oCGs6KBEqDQNplVN
         4NyDpkzt8+QyqgYmU9wScXO7ibYCgFpVhLPL7VQISlGyitS8UkNOOLcQMvoUxw8Wgira
         aOaYnJbACR8wQg0IePSk5VMtKL/6DvxKelYOjNt3VBGcpman3rqdTqoy8WUBbkHiX3rR
         AQNA==
X-Gm-Message-State: AOJu0YyaE4RoLfInkxzOo+uitd0ULMbyHVpXZXYSWbfCW6NkdC1ESOrB
	dANwZsoj4MDVhzBo2ZdCOQsLi3SjQUN5rl8PXF/OBw==
X-Google-Smtp-Source: AGHT+IE2UeXs5IqviIrtO65yOQwgJEJ+cNqeXEHSDJgCCFq8FAYVCqAXT8WFULIlu1rs/qN9gyQ+tQ==
X-Received: by 2002:aa7:8894:0:b0:68f:edfd:2ac6 with SMTP id z20-20020aa78894000000b0068fedfd2ac6mr21645297pfe.0.1696947194244;
        Tue, 10 Oct 2023 07:13:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e18-20020aa78c52000000b00686b649cdd0sm8287941pfd.86.2023.10.10.07.13.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:13:13 -0700 (PDT)
Message-ID: <65255bf9.a70a0220.f0272.42fd@mx.google.com>
Date: Tue, 10 Oct 2023 07:13:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-557-g2932db67f070a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs,
 3 regressions (v5.10.194-557-g2932db67f070a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 14:13:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13377

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs, 3 regressions =
(v5.10.194-557-g2932db67f070a)

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
nux-test/kernel/v5.10.194-557-g2932db67f070a/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
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


  Details:     https://kernelci.org/test/plan/id/65254cda4a56bcda7eefcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-fcntl-locktests-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-fcntl-locktests-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65254cda4a=
56bcda7eefcf05
        failing since 118 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652550aa7e73d462d5efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/652550aa7e=
73d462d5efcef7
        failing since 0 day (last pass: v5.10.194-cip39-1-g53e59f50ca3ff, f=
irst fail: v5.10.194-cip39-552-gc89b2c57483f0) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65255160da8dd8443eefcf1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-lock=
tests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-lock=
tests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65255160da=
8dd8443eefcf1e
        failing since 6 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

