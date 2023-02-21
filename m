Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB0CC6379F
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 14:22:47 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.43775.1676989362535467914
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 21 Feb 2023 06:22:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=gNP7fDzf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id q11so5508397plx.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 21 Feb 2023 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mBClWn7xyKg96kXmwnSAlo7K3vbOv90e8lNt44ZjSSI=;
        b=gNP7fDzfvMKy1DIpLGcg/thz5sfX5t+UUqLgh5NLVj6UxBwOienKcF6mQXvB86vhbB
         pc1S3BmBNRRmRIDzVSrbDSOVDMROYV3g4GxFQV89aEpEsp+iCSc4kBUXWrWhAzNPLWAF
         sxksNqnGswrPHIlSCXsvt107qcuyqLOSJgPoBCa0J6+tNhuBuQFz66fX40YeKuyQ6BrX
         m4T3+x/XGnmbTo26eFxZkomnBDAcmTg2YWxMf1CPhKihM2RmSi1DHNwEzF6vr72wzDRS
         pY4HxRv27yF0mn/SBvHJU+oXKD3swXzSYtZwLBWLjlWWSvW/yWqh1ArHIrEg0PhP/n95
         5WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBClWn7xyKg96kXmwnSAlo7K3vbOv90e8lNt44ZjSSI=;
        b=fDctNSImVJ/SQPLrRHOknrMV9esjVUQLmNCvF06sF0yErNhAiXKcUwYnrI8/1njUbE
         +6s0IJRegJ5boa1wC/VSZE7ZzaAdAgoRMSxGjFolXlzaI3P6fwKygBduPJ4CY5/eWnNS
         QQbNNWr6TmZAK5idNG2GG6Va8r9suJ0uB5E/rhHdZg1lDV4hWYVVew27Wkf1F4WFDU0w
         tys2Vi09EQDlm7gITZ/G0KOoD8GFVokCgUG0jZwnp8QeLBIddRx829AsnaD2slRNeOXc
         28rVPIJm/DxH2RzANR7oGgRV7hOI3+PLqbMhkxVlj8kqj4va/AZ268keOlEbGoTyVU1N
         XWpw==
X-Gm-Message-State: AO0yUKUxdv9wfRLzMDLEn4eM8yUm/PY2BljyUmE+Uydac7V5sDCk8l2K
	5O6z2Fcx/QXXFp+Cm9zy/QrjCHeH4hGwkLeERwE=
X-Google-Smtp-Source: AK7set+MKq2s3erNRa+vIDWH/Egq3YI9E4KspFMZmVyzQGKbpTMWwUa98987ON+p07cqkC+i/01l5g==
X-Received: by 2002:a17:902:e5ce:b0:198:a338:b9c5 with SMTP id u14-20020a170902e5ce00b00198a338b9c5mr7502249plf.2.1676989361770;
        Tue, 21 Feb 2023 06:22:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c28300b0019251e959b1sm9911104pld.262.2023.02.21.06.22.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 06:22:41 -0800 (PST)
Message-ID: <63f4d3b1.170a0220.c76fc.0b95@mx.google.com>
Date: Tue, 21 Feb 2023 06:22:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-2-g28bb49f7179b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 10 runs,
 1 regressions (v5.10.167-cip26-2-g28bb49f7179b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 14:22:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10756

cip-gitlab/ci/pavel/linux-test ltp-ipc: 10 runs, 1 regressions (v5.10.167-c=
ip26-2-g28bb49f7179b)

Regressions Summary
-------------------

platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.167-cip26-2-g28bb49f7179b/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.167-cip26-2-g28bb49f7179b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      28bb49f7179b9cb7b4cd5c5a139820ec49c19d6d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3b0d7f6f204e94e92ba2255b90edb36b1852d368 =



Test Regressions
---------------- =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c30113c3b424a88c86c3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/riscv/defconfig/gcc-10/lab-collabora/ltp-i=
pc-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/riscv/defconfig/gcc-10/lab-collabora/ltp-i=
pc-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30211.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63f4c30113c3b424a88c86=
c4
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =20

