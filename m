Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAA2C7EE2F
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 00:32:04 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.34798.1677285117687382331
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 16:31:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bvPR7A1Q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id y2so748947pjg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 16:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GK3f4oTof7xxuxW6VHnJNiWRGhWh9Ej5TKiERP4DJDs=;
        b=bvPR7A1Qka6Q/PYjhqiEnJfJtLT0BpSXUVam5cwI+sDgnUI7WcPKcdu4Bpaw+3w9wD
         qLwvIzoqHYeQtVBBMrCLiHzFWo+BVIwxjSWiRU/zsFli850fTX3PTWq7omDNFyslePXY
         i6Pse2JXZgR5+/nCfXUk0AEGpMcU57KgyIMbRcSEBjIsmzLETvcmhm2dbh1MddGLbT9Z
         jzuHMJZYNeOrDyQ0kTnLBynXy5YNakxc1pQPL3+K6YbWtOwxoeWfkNNgU8E2g8K2iitj
         v8+MCqtJlPvgDUg9h7G4fDxP1GVfi2UZxYRW7KcHsH4Mo+KKkIoWbeNlJ7cf4v53BRiR
         vJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GK3f4oTof7xxuxW6VHnJNiWRGhWh9Ej5TKiERP4DJDs=;
        b=5mjIJSnWrmif5BWonixgJJK9m1nMPycbEmU5DHYcXZS36RmE8L6vYnGwMXK2418AFd
         plhhfv14eOL6ghvG5lukFcV4ZLqvtTBLK7GTLQbhGp4FsDSmRja4oScO+IbDtaWeIyfi
         B0dop1uL0muOM7R5PWZKfj0njvtDMP4lIcMPbVmVId2+VcZSCMzA5AYXtVYUkOgarJrd
         aIR1kN9DpuVU/2ROructdkolFBgBEw0Kmdatvubg5gWLCS7YhBf/pdGwwqcFeX7IOc/z
         XLC3K3k3Kz+rbhXMJn9KRRASmehjQXO+fUI26E4gtaTsEUKQZLTXTOALZ8I/XGRGe6jO
         gKqg==
X-Gm-Message-State: AO0yUKXzYZfKwD09OYqMdzmbvGcr+RrXs5/qZaykRznGZcCUS4teqZ87
	PAy0GRoOB2MKNPQge8+q4bfB1ljUTKlWclA35T6f6A==
X-Google-Smtp-Source: AK7set+qzb0ZxvK2wAQADa+D640PN71sunhPrtN/HRvQHgU17Wn41Oo5dYwQ1Fw3cg3uQOIDQQmdng==
X-Received: by 2002:a05:6a20:914e:b0:cc:7967:8a75 with SMTP id x14-20020a056a20914e00b000cc79678a75mr4512800pzc.46.1677285116984;
        Fri, 24 Feb 2023 16:31:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g20-20020aa78754000000b005a8beb26794sm121949pfo.132.2023.02.24.16.31.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:31:56 -0800 (PST)
Message-ID: <63f956fc.a70a0220.3b101.056e@mx.google.com>
Date: Fri, 24 Feb 2023 16:31:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-456-g42a59c4e5329
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 16 runs,
 1 regressions (v5.10.168-cip27-456-g42a59c4e5329)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 00:32:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10834

cip-gitlab/ci/pavel/linux-test ltp-ipc: 16 runs, 1 regressions (v5.10.168-c=
ip27-456-g42a59c4e5329)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.168-cip27-456-g42a59c4e5329/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.168-cip27-456-g42a59c4e5329
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      42a59c4e5329312aec627def5fefeaf40a482f9c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63f948e831154003418c8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-broonie/ltp-i=
pc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-broonie/ltp-i=
pc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63f948e831154003418c86=
49
        new failure (last pass: v5.10.167-cip26-2-g28bb49f7179b) =

 =20

