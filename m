Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D52C4829D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 00:24:51 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.10658.1707179084960835479
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 16:24:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=llK1oDhn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d958e0d73dso441225ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 16:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707179084; x=1707783884; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IeYNcJjNXvFdyx7RcHpTJ4QAnL5BF+3UP6Le+LDbYBU=;
        b=llK1oDhn869o4nFvHZ8QF7wCsJ342YB9icJShKStdMjKhvZxIXgXZIf6zh9XRDhLde
         ko1L36HhfgFP2LibUMCoHKQttuxuK3emNUrGYcT2YPe7MrwV7G+I8vdVCIKsS0V5KGbL
         tTjgQwRkJ3dhAst80OYUHDSVIrySSXwHxmMPEXd5sMWb1hF79kznygwkYa5JVjGfMIq5
         xkXEFOE2GMcG0qWJRQnil+OWCN38PMTrMzZNVqrHu7WbWu+C+XZaxIYkX3aGeXO4vig+
         rPqccbCsDEzmzr6/X0oqlRqomKZWpAD5pjqgi82EUYckMNN7Lj4yiXw1V8n1Ia60Tnbs
         zeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707179084; x=1707783884;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeYNcJjNXvFdyx7RcHpTJ4QAnL5BF+3UP6Le+LDbYBU=;
        b=xFZVhfUW1Wdxenik05RkwTOhmSaGVBiLIZH1Hx5Kv+zKEL3SEElD25zbBmYQDYzImd
         TUSRLdEkokJZwv+wf422GhFDDdHZwB1RWchQMeEIDmNZlPa/VRMRIFQ04Raj0wFpiFQ1
         U1LC1eSsTPeGCROrDsgWEbuL8pE9jEXVbJp2FzhBhsUd12g/sfBc724veohNWDdjI3S6
         Yt0H7NuDqRWlPTmFZMl0+kRirwTmL7BA9OA6Qk/4xuHzlnRXcQM84tZfUmIpyVtRZwlG
         Yw9sJEbmbjNuy2KzooNKHJfN/SCWA9L1m2xuL7V7gJNkpv4gcBJ+AATRZ6DFriutENl/
         VPBA==
X-Gm-Message-State: AOJu0Yw9VZHQxjiP9AL26PA+BaEY9pt1AM+Ep6RBofQUTc3P9Uygo9I1
	A04mRRlB7tCsGwxUjfocaIv2W80ondEYOa5lmH1YUiAPaM83STvuaS63QS1iJ7Kvpe2M/d8Xqnf
	r
X-Google-Smtp-Source: AGHT+IHzGGPlflokFaRxyru/kKSIMONZ96swfxNTQ6NiuT6i6016WboCdMBR/wM3rvAP/O3ASUppKg==
X-Received: by 2002:a17:903:44e:b0:1d9:907f:636c with SMTP id iw14-20020a170903044e00b001d9907f636cmr112243plb.8.1707179083778;
        Mon, 05 Feb 2024 16:24:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902d3c700b001d9b0990cc5sm480049plb.126.2024.02.05.16.24.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:24:42 -0800 (PST)
Message-ID: <65c17c4a.170a0220.b2fed.2b1f@mx.google.com>
Date: Mon, 05 Feb 2024 16:24:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-526-gbbb905888ca85
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs,
 2 regressions (v5.10.209-cip44-526-gbbb905888ca85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 00:24:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14762

cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs, 2 regressions (v5.10.209-c=
ip44-526-gbbb905888ca85)

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
nux-test/kernel/v5.10.209-cip44-526-gbbb905888ca85/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-526-gbbb905888ca85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bbb905888ca85ace83da9e4113b4957345c47d70

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


  Details:     https://kernelci.org/test/plan/id/65c16ca6105e27692b00a03d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-ipc-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-ipc-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c16ca6105e27692b00a0=
3e
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16e515b2c026e0600a03a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c16e515b2c026e0600a0=
3b
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

