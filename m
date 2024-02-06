Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A564C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 03:10:12 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web11.13864.1707189007842495319
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 19:10:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YuXslnpj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.45, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-206689895bfso3673308fac.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 19:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707189006; x=1707793806; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ayhz3WxUDiDEV7nfROO+RiXAnQ+N+pmoFUa1Z2WhVPM=;
        b=YuXslnpj5kbD0BYEA/WJWIgv9EHtTujjRysA3JiteaEZ8LxwEWUkSkCjGyTud/aG9Z
         ksoOyfyuxmIXA4SqDlEChNWaYAIBx9doRJlJ0HOWANk6rSPq12m6tqoDfmKqZ64yJsvn
         XI7VW635F/D+U/1rf31CsyfhC7SLKFNO3up73lDoKxu9GEZcvKyI2+0HaVLmjJ5x7UCb
         Wps9WbeaqSKCtVaoS+d0OFAnjI5WwL2o0x5LksFtINFpcJOUFDG6dIjZNUqrHDLnkjEP
         iA+zuKq4Ts8w8DW9Ps+3MKYMvvSgTLshPUd4zt6KPHuq/IbZol/DCYBncqJVrzds7nMI
         LRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707189006; x=1707793806;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ayhz3WxUDiDEV7nfROO+RiXAnQ+N+pmoFUa1Z2WhVPM=;
        b=HTX/9bDRTrwnbwlq9XZ8xzgrih12cnIx8whdOSlW5lBDzqVqocrIOgtbMeZ4gKIhHG
         3Y6OpBW9wIExCFYWEYErr0xzcFNr9Zczo/7oVlS78Se6I7OiBK+JjxJQSTl1Aj8T03Iv
         19I1spGILw+JOWweUcJS7Bvd1O5HxXm/FtcjXveXN0AJa8PdnSltwdJRXwkHEVXSNrcd
         yx7CpBAW1V/BlggpLR7AS/bIv/0jEblZMi1lbaqFp0Cjyniop60QdffcjdiV+FMER2Ri
         ZLg7FwgUHIBqHc9yQijS9xNqBHV6n+Fpf1AEAfxTHXCtDE5h/1tod68XDmQLAGkdxXJp
         4+sw==
X-Gm-Message-State: AOJu0Yy2ESx0ejPYgoONm0/8Q7oL/1CrbnGHz1eJulUBq0PO0yeuAUbw
	offV5uC4ph/SNGqxF5qfPBbCnPC2D6ricWyneHVV/XZbwH/XuCrVyc/GafzHhXWXQXLJKEAlj75
	R
X-Google-Smtp-Source: AGHT+IFxpyZEsWi70LzZW+axINC9utpmLEg3lLo0BSZSKdAniCyKVfO18usjr3QivbMY3RlM1fatYQ==
X-Received: by 2002:a05:6359:2f92:b0:178:7a67:b2e5 with SMTP id rs18-20020a0563592f9200b001787a67b2e5mr1338820rwb.30.1707189006445;
        Mon, 05 Feb 2024 19:10:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV1S8ZxArJpHgA6z6u14j4zCzJKP6iNa0DysXq4ytOFu1YLzcNzpMF9wjAWT/tD5T/oGZTlOXt8Gb4xit6cCohWOixhgk5HNq1HO4d2K2hoVPe8+n4uCTdm4GT9/8jeg+N1JIUvJ/A+k6yrYGbLVIGuyw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id hq23-20020a056a00681700b006dde18ed7dbsm665499pfb.170.2024.02.05.19.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 19:10:05 -0800 (PST)
Message-ID: <65c1a30d.050a0220.54179.33de@mx.google.com>
Date: Mon, 05 Feb 2024 19:10:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.209-cip44-rt18
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 18 runs,
 4 regressions (v5.10.209-cip44-rt18)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 03:10:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14770

cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 18 runs, 4 regressions (v5.10.=
209-cip44-rt18)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+p=
reempt_rt | 1          =

qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig+p=
reempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+p=
reempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.209-cip44-rt18/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.209-cip44-rt18
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d814befd12dcf6c81b483cb36f507d70112c1097

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+p=
reempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c194d2628cfe21ed00a15c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-fcntl-lock=
tests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-fcntl-lock=
tests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c194d262=
8cfe21ed00a15d
        new failure (last pass: v5.10.201-cip41-rt17) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig+p=
reempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c19166bbfc07206000a05b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/riscv/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-fcntl-lock=
tests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/riscv/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-fcntl-lock=
tests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c19166bb=
fc07206000a05c
        new failure (last pass: v5.10.201-cip41-rt17) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+p=
reempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1974c4d09bdf27900a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-fcntl-locktest=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-fcntl-locktest=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c1974c4d=
09bdf27900a03a
        failing since 74 days (last pass: v5.10.184-cip36-rt14, first fail:=
 v5.10.201-cip41-rt17) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c198bc5220d7bf1900a050

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c198bc52=
20d7bf1900a051
        failing since 74 days (last pass: v5.10.179-cip32-rt13, first fail:=
 v5.10.201-cip41-rt17) =

 =20

