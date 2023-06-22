Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C185EB64DA
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 13:41:17 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.11601.1687441272138706053
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 22 Jun 2023 06:41:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=N8BbQYWt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso2937247a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 22 Jun 2023 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687441271; x=1690033271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CrU2ivQyOmogfLMX64rWykgFShlN1jL1PkouaUUCk+g=;
        b=N8BbQYWtQOdZolzT1k4nRIrmFakTBEAVF+rocYbPZ38R00FEbDbfR/wDeYqVFr829K
         e1CYfBLfE2x06PzT7f9h1QE8xyZJRzRdqxOybBlTjPIc2M0Q77+yyRS+ePsSdZ/xB4fO
         Knx7Hic865CsGLhG/qulMYUUy2Jw1U+A6F2fOUpzenUCvnIwjoDn15WDm3A9gGhrkRbQ
         YwKGBf3e6oczvlmtbx48adyhgxTBAiaLrCWP+2FDP2I5qy2b1iWNS/ceIHLr1Yb9RwYo
         M32MsB20+z/VK9CSzEBYXPNC/5pv1ykGl5KlcdJZ4F4nGVixMGOLDP5FYXC/OeKPk8hN
         5mUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441271; x=1690033271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrU2ivQyOmogfLMX64rWykgFShlN1jL1PkouaUUCk+g=;
        b=k03iHuxW6NLZz2wvTjMd9Nly4TWQM/PPPcwpbucrGaHfc1xhHPlwp8Ll9FrWsLNMmA
         1iFBN8HkekeCwZbT9Fz/j5BlDj/9azQDXCIRElh3V7eZ4v2+3ccDwm4MvdfR7OjUfu8B
         N3oIdvIYfhnbXLT+oHQ2AaSGqb6LX1jQ45IyxUzMODeURQ8IVDXQ7k9M8Vlz7POEZWQC
         nIp5zMSzVWXaAsBN07DJiNDOkud2g/bfaHt0nApoDTEKDVKDlg3MKGw7Fw81H/OhAyoB
         zsueTmKACZcwlB84BUStLSrG62dqDn3QtN04avQq+BMUu20+QtW8MN4G84jBSsDm/2gC
         gRnA==
X-Gm-Message-State: AC+VfDxsapAr4uzZYAucOHVFIoOW6lBXOtc4XBPzq+0ZTscB1Szs3ID3
	BI1+SBNanuylhq6VJbsYkUEz78nHq4oy27tG1KUVug==
X-Google-Smtp-Source: ACHHUZ7LDt6jq1SCQW/Mdxq9/Yzm53+ruM5bwNuINr5JtbQa+6k+XWK6Qkoy+ktKGEMr4kLI8eclDQ==
X-Received: by 2002:a17:902:d38d:b0:1b1:9218:6bf3 with SMTP id e13-20020a170902d38d00b001b192186bf3mr14019825pld.37.1687441270904;
        Thu, 22 Jun 2023 06:41:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i1-20020a170902c94100b001ae7fad1598sm5414390pla.29.2023.06.22.06.41.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:41:10 -0700 (PDT)
Message-ID: <64944f76.170a0220.79ab.bd7c@mx.google.com>
Date: Thu, 22 Jun 2023 06:41:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-61-g32a95f5a4e3b
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 2 regressions (v6.1.31-61-g32a95f5a4e3b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 13:41:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12131

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 2 regressions (v6.1.31-6=
1-g32a95f5a4e3b)

Regressions Summary
-------------------

platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.31-61-g32a95f5a4e3b/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.31-61-g32a95f5a4e3b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      32a95f5a4e3b66089d84743bbec9da44020328ba

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64943c98fb1d8ec32830612f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-q=
emu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-q=
emu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64943c98fb1=
d8ec328306134
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64943c98fb1=
d8ec328306134
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70) =

 =20

