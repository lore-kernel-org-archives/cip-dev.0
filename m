Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30385C48BE4
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 03:59:59 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web12.27496.1661227197764771863
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 20:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=6zWxu+j+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id
 t11-20020a17090a510b00b001fac77e9d1fso13261042pjh.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=GUHlk88liboG1Z087AwcL0KEoPecpZisigf/vbsDDQY=;
        b=6zWxu+j+MwSaww9qOJW+6fl4ShexNUQwLkddLfxtvCTwg7QJ45yoz3sY9OH/y7r3b9
         rdc91A8V4nMh5yFQG4OXrbjtGlj/J2zxnuKAiOPvB0Btfo2aJ253GekR/Cx6IDe9fJbv
         azwBaTaOS/GexON2pxX9dar/u6dRzD14F6vUuDtND8XEFjM1rS7+2xEc2bJuqoKK4tyZ
         0RK0gQYZM3xPFPZKQmRmyp4aZfok3lsHEiG17oaYsekTz3yw8rP/U6mpuMm5GrEh3WZY
         hYpwDwMZGRcAJZjyEywA6XBh1YonTtQs/64MwMwj7sKutANYf6rKbUmkouMFzcJqVpTh
         UbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=GUHlk88liboG1Z087AwcL0KEoPecpZisigf/vbsDDQY=;
        b=U7WZB+EylBYHwSjytgv9Jv7yv019ofNbzDmay6JBTZVrGjQvAT3IX43Jq4UeLGFMEg
         v9uqxjWRD3Xl44Z5ej9HTz5ONcMvMlylyfxLitZ9u//iVetSE7/pMOq0nTF4rZGCSW8n
         YQF+6MjrbqqRN5/KYpaqas1TtP6b4Vv7bndzjXzbqv7FlXrVpaUtrVDAVYFfZ9IuXlk7
         MpWr5rQzXSAGwtKYmSDgVqHo2A5siZ9c/W1wBWQKZ90gU5cVjyLa0+tyybOey33rsnps
         UB/sCouGXz0s0gNn90nZTKoYvaf4IHcims+CRGNJgQECxGky7SOXuI09HFmBb3Jf9gg8
         h0yA==
X-Gm-Message-State: ACgBeo3MbT4LboFFDfvIeojCBkIsaaXkVzsbaKKT0dJEI4PRUPvC4Nn/
	kACZ+/uR3+1LdaKb/GtYPwdHwRVT5k45OYx2
X-Google-Smtp-Source: 
 AA6agR4m51vOyKkAacPSE/XS+PhnpDlCi00/qy7IsZWgZUfRO/HArqKQxdpVNSQQS3UDEhbS8h2GGQ==
X-Received: by 2002:a17:90b:3b4f:b0:1fb:632c:f97c with SMTP id
 ot15-20020a17090b3b4f00b001fb632cf97cmr1069189pjb.129.1661227196741;
        Mon, 22 Aug 2022 20:59:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b0017297a6b39dsm9270332plg.265.2022.08.22.20.59.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 20:59:56 -0700 (PDT)
Message-ID: <630450bc.170a0220.1bcce.1a1d@mx.google.com>
Date: Mon, 22 Aug 2022 20:59:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.136-cip14-542-g97767707d3d0
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 8 runs,
 1 regressions (v5.10.136-cip14-542-g97767707d3d0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 03:59:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9301

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 8 runs, 1 regre=
ssions (v5.10.136-cip14-542-g97767707d3d0)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.136-cip14-542-g97767707d3d0/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.136-cip14-542-g97767707d3d0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      97767707d3d0aa36cbf6620b216d0d19b9314417 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/630441ba641703caf635565e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/630441ba641703=
caf635565f
        failing since 18 days (last pass: v5.10.126-cip11-116-gef362fbbff52=
8, first fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20

