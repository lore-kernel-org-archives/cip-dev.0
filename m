Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3153C7EE23
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:40:52 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.5340.1685965250679943583
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:40:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=p/k0SG8k;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-543ae674f37so451334a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685965249; x=1688557249;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XC0WKeOvfaUf1fq8G1Ywgd03ApOus9qWecqWdFQpOHk=;
        b=p/k0SG8kHI4qRiWJZXOpHnFukuEvCNWF8/XTvo9Gu1QFSaPNxHBr8diPx21eflm14V
         TQWwStZtFmcGVw+lcTzC+AH6WliLQBE3UvxMx10ZkmVTIlAdHaPLZ5kw9O95h1EX62W1
         b/fsyQ839u+IGEH4inB9PV7cxEeTVy2GlZ+NPpjqrZJh/cwV5c3XP6Sx5tVD93RuCT8g
         GNH2jDb71EqsBEDZtZQjyzAvxtNg0qPQeFvissYYpQhZucabT5/5Xmd7hTBBqUUFQ3ux
         v2vP0ZCEF8MyBk+kAhe52/g+mygcOX/HZfCjfdw5BznOQZYrSD/8QNiHtNhA0U9+Y3LJ
         pB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685965249; x=1688557249;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XC0WKeOvfaUf1fq8G1Ywgd03ApOus9qWecqWdFQpOHk=;
        b=R0j3RjyG+oFLwMt1Vy1qtrFB+B6aFyL4ZU8DkdiG9bjIEGWhGGdIhYVNQdytM/s/aP
         TusjztMk5fuEO3LdC8IPU/Orzej6lSEauwVukpLF815sW8pzbVw3BKdAIrsyLdeFIYAj
         Yr9jBWxAKVnigFfInRo1CU0tzWUyaoCI36zm8F3IS3T6FC8slpeJMzPlmTPT6qNCFgz9
         G80LOlqIvd2uRscEFkgIVQ7sOBWn7wUP61fOc2CIBkDsxfzV0BJcwCB/Aw+v7enoZQsV
         cQFg+ZDMnku32VxVDXSnW3/O05iNax3g2XI6vzvOsU4A3Qw6c6fXgOZbSPBk71ApRXZf
         J4nw==
X-Gm-Message-State: AC+VfDxLS78iwhjszL6YMgRiskXpsFM9B0ryANhbQcaJABITInfDFQF5
	8bONQb7qXfrlhiq6mgbkIkWtaAig7LVkT5nBhPsWvw==
X-Google-Smtp-Source: ACHHUZ7xQ8ooLoRcsJvlbsnb2PDiOvQ+Leie/DXXupUQueOTKq/9BdxZMfuCJRRtPO4qBlsWqYK2vQ==
X-Received: by 2002:a05:6a20:1581:b0:10c:663c:31c3 with SMTP id h1-20020a056a20158100b0010c663c31c3mr1921877pzj.29.1685965249574;
        Mon, 05 Jun 2023 04:40:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0064d4d11b8bfsm5074304pfo.59.2023.06.05.04.40.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:40:48 -0700 (PDT)
Message-ID: <647dc9c0.a70a0220.4ac56.8ae3@mx.google.com>
Date: Mon, 05 Jun 2023 04:40:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-236-g6d219c607dc68
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 11 runs,
 2 regressions (v5.10.180-cip34-236-g6d219c607dc68)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:40:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11806

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 11 runs, 2 regressio=
ns (v5.10.180-cip34-236-g6d219c607dc68)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-236-g6d219c607dc68/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-236-g6d219c607dc68
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6d219c607dc68f956270abf58e720f31e27b38f5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647dc2c5e3ac26301df5de2d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dc2c5e3a=
c26301df5de32
        failing since 221 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dc2c5e3a=
c26301df5de32
        failing since 221 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

