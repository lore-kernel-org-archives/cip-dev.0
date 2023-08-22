Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C721EE49AC
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 13:19:48 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.7910.1692710381168840300
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Aug 2023 06:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=l9FP/nLm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-68a3082c771so1862372b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Aug 2023 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692710380; x=1693315180;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mDTZHXiatfXHC4A1wUJNBmah5nS4OTJrqMSnK0/asOk=;
        b=l9FP/nLmp5gXEBN/sTJTxnM/H66hHi4AZ0E9XwdRNbI+gZZ1+lfiGkjt3LnBO3sUM3
         R1jWOATEbzcRbj1m462OSJKCzFPbjg3dfke/ZJV6bWApkmL0mdMY1RwQjXBS4iwjT1Wr
         ZxAbtM6oUxXvN5imCTOLL7v8U3ZNe5GnsITH0QUUDEe9XjfK7wUG7MYBvLDTJyyyihmr
         E8FaPyDeVz8XKkplc/E32DnMaE4ynm9kfNyOqNXwdjuHVxdtXbMYnZFMbmhAKTtr+cm4
         3MH6lWKqVAl2k9Za1f2JQOqOeEC5C720jeTyCzR1tIrCVodP+WEW+tLlHWwDoDfktLXC
         GJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710380; x=1693315180;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDTZHXiatfXHC4A1wUJNBmah5nS4OTJrqMSnK0/asOk=;
        b=ZNJs3kQ+UhTVXcE1s1THVivFkTkkZEnT3ny60L8kQabEiAy/Uv+YGI9dPK6OIDrEiR
         h3R5D4xONEaQ5OlghB0KXki6ZrX+8BdUGX0iBWOil0U6OJTqg4dgnYurXPzQLUWNO6Wo
         hKMsOYIDW8Q84FCAKJQvyTV31ZF6d08cXid3ubucfYMWbLbmu8HlExJmFscigVwZ2utQ
         bNwF2NlwwdMnc5UABedV+N72dhWELVUfPrN4MrIl3En0fO+OpP8pGBtrWNtvGOz7FDSC
         RWqeRW3r80aCyk6hR5BSRH4fxDHl/1P7bRxKbEFrbf5zgAfYSxD0ELTFEVDSV0nzHmuD
         IS1Q==
X-Gm-Message-State: AOJu0Yw0bGnDaictC1lYd6x9s0/UyZk+uEyrxsjNRZkyL5owSHe/+LAo
	eXtmPIYyDPaX1cXfKY4bp9RF9kX4SGsJlL4+lBN4rA==
X-Google-Smtp-Source: AGHT+IHAdrkFUJC1PUiUXJ7iI8im5neQjD11URBSm0IL/MVnkzOljTraP/YxwMq2k2ld14Vz86iFWA==
X-Received: by 2002:a05:6a20:7489:b0:140:45aa:c601 with SMTP id p9-20020a056a20748900b0014045aac601mr11942071pzd.30.1692710379775;
        Tue, 22 Aug 2023 06:19:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b26-20020a6567da000000b005572d796b9esm7186218pgs.88.2023.08.22.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:19:38 -0700 (PDT)
Message-ID: <64e4b5ea.650a0220.2bb83.c158@mx.google.com>
Date: Tue, 22 Aug 2023 06:19:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-27-gd6d928db0a620
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-ipc: 5 runs,
 1 regressions (v5.10.186-cip37-27-gd6d928db0a620)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 13:19:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12823

cip/linux-5.10.y-cip ltp-ipc: 5 runs, 1 regressions (v5.10.186-cip37-27-gd6=
d928db0a620)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-27-gd6d928db0a620/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-27-gd6d928db0a620
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d6d928db0a620394e433833b5dda4ec7ac822999

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64e4a458eb07025fe4b1e3b3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_=
smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_=
smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64e4a458eb07025fe4b1e3=
b4
        new failure (last pass: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =20

