Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0165C48297
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 16:07:57 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web10.66784.1707149274057575699
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 08:07:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ce6ZsAi2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dc13cbce45so1200828a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 08:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707149273; x=1707754073; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ximp3ALAbawHxJvAng/yqB4QFajm9RMqbWH7aIJuDA0=;
        b=Ce6ZsAi2IRfCpg0pCs1NxUj/Ud+O/Qoh9DAb44Ssa+QfT2IWEP9/RBehloM1pz9P3s
         fUdC7wtq5LlbtKsYsum8pLvcYYIIyVkm62ZffTZXtcgZnb2WPm/JOaJ1dG80uTaFOjri
         PvwPyDjOrWFzzsQNIHXfxo6MC6p7CAqWtpZd4UDrD8atG3X5g24vEgN7ejW/qJXkYiCQ
         nzriMKdYN3PNNPtT41CP6uKIl7p7knXbWSgXpwDa5vIu5dE+ura7rQBVu9EhjEiCzeL6
         k0kAWidOLfTDkwbQa54G+OLTbrpT9mV6aFRKy72bb/gxB3m8fOIwwkebbjWG4E8mT4mt
         pN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149273; x=1707754073;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ximp3ALAbawHxJvAng/yqB4QFajm9RMqbWH7aIJuDA0=;
        b=tvLdBGzaoTyvkPhWwnmNyh+6a5ee8f9JRzaoF41QuOPIo9HEpy+g4Wzi6qNJ459ODQ
         XF0uTUjzqGuzWzGOgCKfjewMGEEJzOVTz/fvn6FdpI1Qq8Qm/zsx7ZxU272mc9sqgiTE
         Btvkf/sxzlWkUkOP6QIX2Teu4TD2nD8opOLhBB5/DsowlroWrf546kV4egb0USBzifks
         JjzsLL7Vy4H9hvkWcOpywRM7U4jEOZ2zfRybSDSuAjNfJzzdxsnRB4+Q0wOy45ah7CER
         mtkRTnedmMmoCXP7YqPkrCZgflhfI+jfYxL9wiKLWl1Z3o6pzCCzAFwgnqkvxCDf2hBr
         yAfQ==
X-Gm-Message-State: AOJu0YxrtIby5/YYXjD9XXPFsbsOMKbZgQXGoFJZ8DRLS2tjkBvY8R65
	Svn4JF8Vr6RXVtlBq/8pWIVsy3Vb4U1tUZybOEYDtd/hFQONdB3znLq160zTp5QbJU0WfbPCycs
	P
X-Google-Smtp-Source: AGHT+IFBP5vigQsGNGjvgf0QNcIZVDu1lpKqa13o8ZTc5pTrHdkYiPhysXuCqI8DoFKs0WkFKmA53A==
X-Received: by 2002:a62:ce43:0:b0:6e0:4a04:2282 with SMTP id y64-20020a62ce43000000b006e04a042282mr1917319pfg.22.1707149272570;
        Mon, 05 Feb 2024 08:07:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h11-20020aa786cb000000b006e040c3374fsm7211pfo.64.2024.02.05.08.07.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:07:51 -0800 (PST)
Message-ID: <65c107d7.a70a0220.48a62.00ad@mx.google.com>
Date: Mon, 05 Feb 2024 08:07:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 12 runs,
 3 regressions (v5.10.209-cip44-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 16:07:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14735

cip-gitlab/ci/pavel/linux-test ltp-pty: 12 runs, 3 regressions (v5.10.209-c=
ip44-rebase)

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

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-rebase/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      17e47f846f71ff31baabe74a720660536794686d

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


  Details:     https://kernelci.org/test/plan/id/65c0f13687d976d7df00a053

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-pty-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-pty-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c0f13687d976d7df00a0=
54
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f6f9f339f5239800a071

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c0f6f9f339f5239800a0=
72
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f78e5540caa7a300a044

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c0f78e5540caa7a300a0=
45
        failing since 0 day (last pass: v6.1.75-cip14-132-g6e54756fbd6c2, f=
irst fail: v6.1.75-cip14-6-ga817aa655908) =

 =20

