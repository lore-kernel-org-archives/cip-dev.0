Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76172C10DAA
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 00:17:09 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web10.15091.1701217022461722449
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 28 Nov 2023 16:17:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=enlUxck8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.175, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b844e3e817so3753587b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 28 Nov 2023 16:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701217021; x=1701821821; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTo9Ah50BtTmDtaXRcQSAlFI596P4Zpk+pDiU8pp9zA=;
        b=enlUxck8/69MGiuvMNc9G2njYWNva5MdHxQKimxyUUhn68uugI2fPnvsWhqqn8z/uz
         CnMGYHvtzkCFN2yEZxbovlUVgVa7HxG3exo0LFo9HrEhJlgRuB3/G5HvInviynuwJZay
         2sPBH7EzEb0VJbYIASuWBt2UbVQFFLy7LOKVoN2UngEUg70E8UaxL6AmKtBtA1bGi4gx
         p4bRkzh/Pcntq1H0mqLXjFV2ljCtJKgcfoUaaHpWdFBoXqEQK6Ac5WGRzChz2znynTHA
         gh99+g6SNKs7JNGzLJuDtQi+/KeADnWTp0ot6ZjW5AgePLLxkZScD30PPHkeijm1HlEH
         CXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217021; x=1701821821;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTo9Ah50BtTmDtaXRcQSAlFI596P4Zpk+pDiU8pp9zA=;
        b=CQjPkAt+IAD3jsBakqsA2QbfFeBkKGBQ6tXmltmnezzAqsv0A1UKa/FJ7M0B7zF4CV
         lXHfVJ+uAaxTy+3WCP4x0d81oLDnriA714NsSABaa2QsA78J/udXI7WU5KYFrTiBj6Mj
         HUb3CwMBrkn9P9RokQQckCinjmgCIR9y15pFE3BkslBHrspc3lRiAYG0vSvduBSGjrQC
         vGpZtLGuY2BPz5kBxBIC3TcwnrNQpQbw7jAFEEm4HpwMlSW4fUzEjnmaXsdZ6joIbYdc
         aeq0u4DEmWm7vhrkDM5Wu6Ts2/rAFtBN1dZWI1EQOwQ+JOzUsfiznLmQTk2nb6CKwq/F
         tuYQ==
X-Gm-Message-State: AOJu0YyNiXlw6lnPSjBE0nMZVSwLMA5fssp93hv5LH/Jnr0rQTmTyjlc
	NKMGEjPkt4kk/+oznkePl1vYXOygeZTqUtcMWds=
X-Google-Smtp-Source: AGHT+IHpglepDnVzvD/S11ajaSVBPVWY8wt2B9k6+MTxCL1DxcJkPz27difYy5IbeuDG/zJIs7WZBA==
X-Received: by 2002:a05:6808:e8c:b0:3b8:33dd:f964 with SMTP id k12-20020a0568080e8c00b003b833ddf964mr20573208oil.39.1701217020710;
        Tue, 28 Nov 2023 16:17:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w66-20020a636245000000b005ab46970aaasm10105748pgb.17.2023.11.28.16.16.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:16:59 -0800 (PST)
Message-ID: <656682fb.630a0220.2ded9.92d0@mx.google.com>
Date: Tue, 28 Nov 2023 16:16:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-cip41-197-g2d08925b44e52
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 2 regressions (v5.10.201-cip41-197-g2d08925b44e52)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Nov 2023 00:17:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13760

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 2 regre=
ssions (v5.10.201-cip41-197-g2d08925b44e52)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-197-g2d08925b44e52/plan/kselfte=
st-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-197-g2d08925b44e52
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d08925b44e52ce450bf165f843637412f9c979b =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/65666f0257420f73367e4aeb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65666f0257420f=
73367e4aec
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6566703481dfbdc0ff7e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6566703481dfbd=
c0ff7e4a6e
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

