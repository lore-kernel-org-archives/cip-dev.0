Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A6C43217
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 15:02:41 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web08.8385.1665500556838780507
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=1mgqxqbx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id fw14so12724754pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fu+FCSRTXTDwtaEgUVWmLjsyl/RvYspyTCNPrItq6dQ=;
        b=1mgqxqbxSC9OHxgFANZQaqGu4liUQNd0Wi5uK/cR6dmRJUm8LWdpNYMS50t3YFz6tF
         yXU87Qwq1IEcWLcNVHXHWlBIj62uRrkheOeWz51e6L+zsme+9Xn29XxApcWhMERINQOb
         4P5ntRd1BMyf8XE6I+4Oq2oKqsefyfxnt70XPDh2AjQi/A0KpfqlEKLWmQUvFJ12auf7
         RBSaC0QyOhepH/e7OKZrCqQDYGSxcmSuHF46FBnP3e9WIGzmLo/k8s2+oVuZN47hVFGm
         ENJQUmhQNkxV6JnrvQNCeDtHQ9qTo4x3RVLwCGPp7EN+LUc9ndot09e7IfYV6RH3p5cS
         EJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fu+FCSRTXTDwtaEgUVWmLjsyl/RvYspyTCNPrItq6dQ=;
        b=yVa6HJGYZaber374AEn5OtvcaDZCQ7ZOkmxXwOqJJCKvtpDP9PqBKV+5ZaXVQdKTah
         H7HVTZXaV//AFwJmCIWtoMXTvz/X1oGWNdnCMqpvJWceIebbk3/dZBb7EWXdx60qlF6s
         pVTG1WbukxwUCIVeeF19HB/v9zL0n6aN5pij/gkvDeJQoI/uKwhckzwxTB43rGQjRxqi
         JYSw5/c9L5ttWm3qzzrCIdN105JCen3LRAMCPLSghj8QqsK4cctzImajgKv2qCqhz8UK
         zt8URV5PzWUJHE2LH44YYenDVDAy3+gV3pe3R1FSmp4FZFdOfANjUMOVcSazSJ+Hbii1
         io9w==
X-Gm-Message-State: ACrzQf1/MZWZBURmp4dLBq4qhccojpJYiexrg8MOClOITY/CfxmJuf3U
	0MOhhqqZ056yALKjMsFBQQZDCB6FDQE/k1RdH5U=
X-Google-Smtp-Source: 
 AMsMyM6jhtTLfRKiwPhxkhsefzz4AxF9oHnTQWQvl+0a+F8LwKs5VgDXWi5lIQmFpaD8Q0P2BLNiXA==
X-Received: by 2002:a17:90a:f3ca:b0:20a:d4ee:3859 with SMTP id
 ha10-20020a17090af3ca00b0020ad4ee3859mr28098727pjb.70.1665500556186;
        Tue, 11 Oct 2022 08:02:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b203-20020a621bd4000000b0056186e8b29esm9369905pfb.96.2022.10.11.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:02:35 -0700 (PDT)
Message-ID: <6345858b.620a0220.37235.ff82@mx.google.com>
Date: Tue, 11 Oct 2022 08:02:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.145-cip17-1-ge85493c8cea0
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lib: 11 runs,
 1 regressions (v5.10.145-cip17-1-ge85493c8cea0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 15:02:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9724

cip/linux-5.10.y-cip kselftest-lib: 11 runs, 1 regressions (v5.10.145-cip17=
-1-ge85493c8cea0)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17-1-ge85493c8cea0/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17-1-ge85493c8cea0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e85493c8cea0c5b53ef511efe088b0749b4d5aa0 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/634577d2ce2983971ccab661

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselft=
est-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselft=
est-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/634577d2ce298397=
1ccab662
        failing since 49 days (last pass: v5.10.131-cip13-84-g3b53e4dbd9f41=
, first fail: v5.10.136-cip14) =

 =20

