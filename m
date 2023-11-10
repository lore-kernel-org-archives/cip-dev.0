Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CBDC4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 07:16:43 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.22835.1699600602084460859
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 23:16:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=FMEBZSM/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1cc1e1e74beso15856855ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 23:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699600601; x=1700205401; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5fHC/Yh0wj3h7wfhT9LUvgbqrJ6wqhY+oAFUgrD3q8E=;
        b=FMEBZSM/Zly/dZH/hrdg567qLUOK0M2Qg/wAXgRMBYjY0Yh/jtIn3KRSVR8dpXRsH2
         twtZRdwjQ7RiY0ANbbI6OpsJs36lJwvWOHwJ1iY2M2PpidyTipoSL0Omwn0JFxiRKmOS
         9pKfKCizyzlY6/PYQaBs4QOr4Oshx4CXmLyPQ+CPkW9Uc+nz5cjFHD8GLkInCCGimrLb
         3M39CPCJ8hvs7qepk0rsBMXrl0qU/dTQuA2Ii++TEslRqzN8Wh2iZn4x6XB1V9Mpxky4
         RAgLPn899PWJbvZxNlT9ag6se7LS7Hd441qWsqub08AZ3fg3e+aBniLFEY6mLykgAZxS
         JxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600601; x=1700205401;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fHC/Yh0wj3h7wfhT9LUvgbqrJ6wqhY+oAFUgrD3q8E=;
        b=fM4VAwDJOjmGV7COr5mkmRphurJltkecn5Hj0Kfv0Qq0yCddActRFKhZt7Sks82wpV
         uIv7bAe8bLZvLaXTzRGhYUJaqTCX4pOd0B/bkDqKaatSSl1rOvhiw1A8lsUdffJWCJQr
         171Csg522w0sjT7Srdgt74Ma8izZbHt2yCFI7Rrttm21zkx0F0u/+p7fY44v2Z4mVWWR
         NQDuhYjojAOBHg4kNx9d9ydDlac174w8RFutYoTP8X0kCoP5zh8laLmTNammuwmu2+Jx
         qcr29x4XDN9NzSCYmhenAsIY0rAq0HDAvaQ8Y3JXlRPpuskxxgWymTUBkV6Kqq9MadRq
         xZuQ==
X-Gm-Message-State: AOJu0YxeK+QMTCi6PP+L94BCL+q27xLP0ZQ/L4LBSExcEitHVhbsfcyP
	z1Fa35RazUktLATlb24IZW5AfW9G53AussPbVbT1cQ==
X-Google-Smtp-Source: AGHT+IFdpZWQyFjs6SqOf8hE3XhkEtVd32MTxA7IRFKrZKXEMEJli45o4Fdak9CEgsZAMdOAJQX7vw==
X-Received: by 2002:a17:902:c94a:b0:1c9:c0fa:dfb7 with SMTP id i10-20020a170902c94a00b001c9c0fadfb7mr9040279pla.57.1699600601108;
        Thu, 09 Nov 2023 23:16:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001c726147a45sm4685346pli.190.2023.11.09.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Message-ID: <654dd8d8.170a0220.6f573.e7d9@mx.google.com>
Date: Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 07:16:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13557

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.200-cip4=
0)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/654dce3ce7b4dfac2befcf02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/654dce3ce7b4df=
ac2befcf03
        failing since 36 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

