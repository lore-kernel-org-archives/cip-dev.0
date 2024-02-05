Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF09BC4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 16:07:57 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.66783.1707149273956496062
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 08:07:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=X42vMgw0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-295c8b795e2so3328177a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707149272; x=1707754072; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JXFiHRgKpW2tzJ0EcOLR+KUceC9H4kJRRJMvCFxvfko=;
        b=X42vMgw0vOY1vpLkRbL2AwruEHtPd90sbi37wG3/0M19oIY37+wcRgXz9Dlk2KAI8W
         NdBPFjYXWz0O0sMsOc0GVXMFzQsqA7d9N6rkj+JeLBzuPqgW5lP13Wfnv8nf98yfAW6v
         6NZK7h4AsmwAm3c51Ob0J31L5VVZODEgnOxhZsBQ4eFeKQ8rY0h/PuKN7wucFPab5u/x
         Kw6wAOoJ/P/HZmtOr5/h6p1dgAHIfBNKLOewiXEM9gGuUAWdaEyMibLvW8CH1lEEtGRi
         0D/H2paofxhu/2hB46bFyb5EARnccscYlPC9vvUN7kIUs07oKDD97JI2lORHwD8QEyuq
         3fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149272; x=1707754072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXFiHRgKpW2tzJ0EcOLR+KUceC9H4kJRRJMvCFxvfko=;
        b=ISsX7Gw/tzK6jc1HkyyLsEOIQttxtF6ETHQi9dInZmPUl9qd8VK39f8fdyDtNpOBQR
         Bms/UXzMigDpsBygTdiVmSKt2e+q2zQFFMa1dNDFLNbinabkeo69aiTHHjTr8fQAFdvd
         /v05o/a1QZ5iQOfMNgEun5kaMnT8dv4eSX+hMQ5WLXG1zI3LexAoRdoDa/H4AjXtQ+hI
         /GPsLwBgB+gIFoZ/Q5cQ6vJXpQbkSy0i3JVQ6DrFq8bJozpRWgVUmT0CxGwBJ3wsEip+
         7qwQp6E9UNZoLkidYagKrrv3W9PUrYcTt1t2W2/HPvZfiDD38RsHyuWBPBCK0bhVt+89
         rkog==
X-Gm-Message-State: AOJu0YxIGLTuMWkGnpdH3A1oPpYTzySOkqHY3+p5f3eDrPbm0k4KwI7F
	i4OW7kBOp4KbZakLBKe+kGcgtLy7WKUUbITLyO76+1OAKyabuAGLN9fw7JLHHosmBa58JfLMoHD
	V
X-Google-Smtp-Source: AGHT+IGZ+ORcQzTYt4Qzv53fHQd8ROt24WzglNI7Y8n56kjSt80LUYkzE6vyrS4fH2cPfovcnVLKtA==
X-Received: by 2002:a17:90a:a00e:b0:296:a64c:7509 with SMTP id q14-20020a17090aa00e00b00296a64c7509mr1876881pjp.30.1707149271776;
        Mon, 05 Feb 2024 08:07:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r20-20020a170903411400b001d8ec844fe7sm29365pld.283.2024.02.05.08.07.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:07:51 -0800 (PST)
Message-ID: <65c107d7.170a0220.25cff.03c1@mx.google.com>
Date: Mon, 05 Feb 2024 08:07:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs,
 2 regressions (v5.10.209-cip44-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 16:07:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14737

cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs, 2 regressions (v5.10.209-c=
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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-rebase/plan/ltp-ipc/

  Test:     ltp-ipc
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


  Details:     https://kernelci.org/test/plan/id/65c0f0c21f8045c63800a042

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-ipc-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-ipc-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c0f0c21f8045c63800a0=
43
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f70d772aab545500a03e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c0f70d772aab545500a0=
3f
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

