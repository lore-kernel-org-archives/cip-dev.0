Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB54C4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:45:56 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.23145.1707853555701289669
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:45:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JHFx5c2h;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2909978624eso2428972a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707853554; x=1708458354; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3xx3zBoptAChXyT18XiN0zbQD1m3j3fFfHYfsR82JPM=;
        b=JHFx5c2hxk2kvx5f3cD8kw2Qv+VcNpCoXEIcUnSBNFTggeLc2AH5DMFi/Gin2ORlnM
         ifFuNlrNY17mQAWflIYh9ua3xi69dQFeB04nk1UHmnbH1NCV2Em94ZjLjhNDOEzy4O8H
         fw/tMAwEHWxim6OyF3dRdTRA1uuS0n1FQfLxxKlMuNuGhIYv3+/qR04SZ06b5AhR8MRH
         yEQ8/0Nt4cBM7rAdfkE5zvXyEWmaW3j0g+c3bOQUv69DYOb8S2WtOeQ+PE2Sow5umvYt
         mQwLWuMUzchhG3EB+8vRbLhTaVXK7AgQi0rLT0VFwlWJ0ADax98gfukaJ70eckirttf0
         Qftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853554; x=1708458354;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xx3zBoptAChXyT18XiN0zbQD1m3j3fFfHYfsR82JPM=;
        b=IO1NmC2lg5pg0Cmmh/r2/4rS+u5km2vppgU5IEgR4FDIJGLy+TTpuGNmGrul0uScJa
         owjnTUfSkJjkl+MmASX9VqpzMHL3HidXrfiAEFBxdaJnCqU7H0sU6EdtSGcgiSzYn+qc
         KFQau2IYke7vpFlzKyv2SUhZ6DbXPp2Rf5cUS+yWjBVBeVNlqX1a/bPd8YeUvo3wntiJ
         Dal9Tqn9LQP2xQd/xR14KTz3iCmYh4z01k+Hyd3ZhRnrhj6yyB9PlQhZAXXp2QMKc7Wi
         ohCwQjQdnkCLniuNgfysAEEkXvRsfOCVXqhXMiuS5S+M81nWUZWLMzEPThhCKpLASJsn
         amWQ==
X-Gm-Message-State: AOJu0YxUyrPvy+WxejRy7I5F37wGpDgbmzdUAIfF4P1q6EPUyheeRwmm
	f4fbnDdqxhluviVxlX76JaBv4uATYTiswsYlAQ+kYl1SnY2G0M3UbbNgHIRvUN6NP8LimVH5f0d
	jq6I=
X-Google-Smtp-Source: AGHT+IEEuLcNZ+WnlevPQH1nW8zOeXAZGJnvKpXOagFnVWy7yUHohg7Mt7LPGNMO/lFx9c7TFB2nNA==
X-Received: by 2002:a17:90b:3a85:b0:296:f32e:c3b9 with SMTP id om5-20020a17090b3a8500b00296f32ec3b9mr565310pjb.26.1707853554225;
        Tue, 13 Feb 2024 11:45:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r88-20020a17090a43e100b00296bae431ecsm3168933pjg.48.2024.02.13.11.45.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:45:53 -0800 (PST)
Message-ID: <65cbc6f1.170a0220.3c6ad.b571@mx.google.com>
Date: Tue, 13 Feb 2024 11:45:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 14 runs,
 2 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:45:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14957

cip-gitlab/ci/pavel/linux-test ltp-ipc: 14 runs, 2 regressions (v5.10.209-c=
ip44-51-gdb99ac443b0da)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-51-gdb99ac443b0da/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72

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


  Details:     https://kernelci.org/test/plan/id/65cbb358d9f4ae86c26370ce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-ipc-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-ipc-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65cbb358d9f4ae86c26370=
cf
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb59c7941d73c17637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65cbb59c7941d73c176370=
13
        failing since 13 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

