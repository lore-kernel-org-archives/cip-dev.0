Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D67C43334
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 01:32:50 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web12.1701.1658799161735065927
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:32:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=PrbZdhAE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id c3so11933479pfb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=My7fO0aO4Nte7JdRuaqDO61cfFBzZO4G4/X2n1ogUcw=;
        b=PrbZdhAEkO1aSKF7fyYZUlYGX3FeiH++8dyIOAY1iwmf7K3g7gmANdyIRvJHP40xGT
         5gdHmtMpQlQ/vD2CRo0A7A08vnSQinRHl+Pt9nbU/Uzmo2pYgwliXKUK9ZC8Bm/7hvKX
         /SMKPtgPSKIi0k7cELWRjm6Pl9jhWmuaPHZ2KPl18CrtGA8QoZF2NWq5sNoo7tNvvLCk
         cvgcSbW5ajBVO7jmFc8O8waIzeAviqKjRtQtB4BsEKkx14nWWEB49Iuw1+/xa2s0da4a
         EehOCD6BErs8uLN2s7bC99chDcAS4ekB8POtvuc+7LkHLDxsLVHxSC3ierCOVNENaic1
         9G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=My7fO0aO4Nte7JdRuaqDO61cfFBzZO4G4/X2n1ogUcw=;
        b=zgJknGwnbcIRFyRA9z78XJUb1JBmeWq1w/mwvQ/AjW3wriPHz+SOOwRKx0y1nb8h6b
         Vv/vbTyrV1E8/w1f3kIMkJ5ya6WTQM3aE3svkRMjPIMzMHmf4xBlAE8s4CFAJtla3bAh
         koIsTUMZ9DbIxPjZhn36GrFGU3kzkXBuHNqoZjekWnDQw8r/m1JH63/OxpsDDdWzjxTN
         nsaC8beVWfNfiEN7LCNXGlKbWKT6kB+Bz6gOHVkoF9GDuqSaou621Tz/3UBCJbj0R0Ab
         juToPFN14DakNeocOWC+66MtLXb+B4UTijN3frfvMw7gSAdNyKwZDmgb1o81TIT8L9LK
         LCwQ==
X-Gm-Message-State: AJIora/7lWza7JFQSJJJMuFJ1ctdE4aFz024Mkmyn6beqQgYJYYwZGf0
	meTYRUhreqKFbp+nbmtns2neu2hhsl3aru0x
X-Google-Smtp-Source: 
 AGRyM1tElFZjP1AlRsv8VRf7cm7erFSNX82gIJXbIswnQY6e5tVMBypKaXLRjVUBcEGulP3XoPGidg==
X-Received: by 2002:a63:455a:0:b0:412:9855:64eb with SMTP id
 u26-20020a63455a000000b00412985564ebmr13502994pgk.131.1658799160957;
        Mon, 25 Jul 2022 18:32:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 f4-20020a170902684400b0016bdf0032b9sm9803483pln.110.2022.07.25.18.32.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:32:40 -0700 (PDT)
Message-ID: <62df4438.1c69fb81.5f9a2.f87d@mx.google.com>
Date: Mon, 25 Jul 2022 18:32:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 11 runs,
 1 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 01:32:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8914

cip-gitlab/ci/pavel/linux-test ltp-ipc: 11 runs, 1 regressions (v5.10.129-c=
ip12-36-g21d9d56f4de5a)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.129-cip12-36-g21d9d56f4de5a/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62df382cfa611efdcbdaf07d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62df382cfa611efdcbdaf0=
7e
        new failure (last pass: v5.10.112-cip6) =

 =20

