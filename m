Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096E5C4167B
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 07:16:43 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.23082.1699600601759546584
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 23:16:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zFSLgXhk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1cc30bf9e22so14333915ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 23:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699600601; x=1700205401; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uCL5suc0UmuhAGvht9erX/UXvNZGTXAoncgbtLqgzXY=;
        b=zFSLgXhkKSXyx1fNaFmfPhvtrl4GhqNs1vDp1aQIjHBQ/b3jOWhXbOK0+M+h/31mHC
         lWfsAUKmx/CKfpBspLkl8WZNYBTj6HoCNYFu3jI4ngh2NLxF1fKknYFdzlKjFWZjZSc0
         D/vVFR0l7D8VA/LRD0RWuT1iLGOJhAUzBt3BMlksa+yme1tIFJ1wEjl72TMciFG0zsOF
         RzKOz0KU2NjYGpZoZ0WSB7wEpIv/mspgKgq+z/CIWNiCwgaA+AQYUQfR2fzsXZUop/og
         YCExpP1PqU8TSTIwDs4rZ10MNnHY8dkYOVv1gNh3S6TIHgQcV1i+qd+nS6z1lNzB1OHF
         NvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600601; x=1700205401;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCL5suc0UmuhAGvht9erX/UXvNZGTXAoncgbtLqgzXY=;
        b=NliGcE6rbUnkmOLHH9jGmZk696IP7zqIRx+AIvmFttydcaMW8v0Vg04HcmpF0jM9WA
         Zfo1BP8b1SiSBpITTYsECL1URP2C/zNsKwD0Ax/QWdsueeOWubuD8/N9MSl3YZnNb+av
         xXvc7ifJxFfV24WakGyzO05PEXuuwjfv/eht6ofUhhCpCylvEOhNRfXLp5SePhqU65c3
         04o1sK71H38D9t3KTQ8PAJa4CnvpRZu4Zi/e7MzUf8LjB1XGR8vufAGIL+K4C5WWJt8Q
         YiCqQEhNuVd2anDIl+l9ubRfAWGdmb2ZoT/e6pSCirE5syPRKmI3FEmpyuitCGwy4t3I
         Bn3w==
X-Gm-Message-State: AOJu0Yw45olLz45dr2HY1gAv1jZERnsBte035zWhOHPw75xUso7Yhj4H
	ePcNewR7E0jZdbEu9TEXb4Wk8zbMyooyENABU2uK3g==
X-Google-Smtp-Source: AGHT+IHKSE6Oe+X6IfI1CfltIf510TRer+DYS8+m/7x3ANaEKSsoKGZFGV/qrRwp8d4OTNp62tIm9A==
X-Received: by 2002:a17:902:da8a:b0:1cc:4402:9e7c with SMTP id j10-20020a170902da8a00b001cc44029e7cmr2775367plx.15.1699600600651;
        Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902cec200b001c3be750900sm4685251plg.163.2023.11.09.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Message-ID: <654dd8d8.170a0220.95c4f.e6a9@mx.google.com>
Date: Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 1 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 07:16:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13556

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 1 regressions (v5.10.200-cip40)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/kselftest-lib/

  Test:     kselftest-lib
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


  Details:     https://kernelci.org/test/plan/id/654dce005620c47811efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/654dce005620c478=
11efcef7
        failing since 36 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

