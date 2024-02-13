Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA1C48BC4
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:06:16 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.21896.1707851176114455567
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:06:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=gWkVq3qT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d918008b99so33097955ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707851175; x=1708455975; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LAeNAl+mXEjDCo0rKKIFiVadITqmtCFPIczEg6cNUjo=;
        b=gWkVq3qTV1S+Fl2ZiDOKS05wuD5CYf0/tlT50tSln1ryIp+ZAzZPadzEeyoVVBL7xT
         bApgZwh3IsuguwSANaIBxqo+rdMDTkarESPAeQyufCgCqrMcK7PM1S3a7uekDjeoafzf
         rwYA0RcFR8gC3jZLnJFG+57DLZTrIdRB5Ryla1gcEBtYiE4TbCDuiu/ocrGTSbjUQ1e/
         oqtnBEFeE7uK3FHvlaMziOXGsykjn+GvkIXgUs9PDCWW97e34v/xzeAEy3UvheEDv4nF
         H5akPUztdMkNcfckQ2XDEU7pY9aB0WxDTUvJrmlHPIZNrr+wi8fU4IIDGPkoeCQviABh
         Zv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851175; x=1708455975;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAeNAl+mXEjDCo0rKKIFiVadITqmtCFPIczEg6cNUjo=;
        b=cwwbl4EBBizhqEAg+B/JbhokdccPl2WkBNqfsS1cpgOiI3QHERMXKEdRIQtWC1ej1C
         AlAi6i0EsNPCprTqoWl9T3jYpc+K7Ti/VqUbm9QOBJNOvEbwHRKUCjXSxqDTtVJyFHpE
         DxwaWyJquKq1ovL0EfHAV7zmPg4AsVEhuC77hcmk+oXE0mvjbXRPsqMIW8XzyLsx6Ovb
         VG/4Hg304xEpUn3gPt/CW9KQBCAyxwXWnl4zLAS9xss3BGplzkgfcJqKjqYF5y1OCpDf
         rQyhAJZzy+LXNGS7qvmf81BnY1FKfEA18eBDEn2tl51Mwl2PWqQmeN3WAs/fbvnVeMcK
         RoxQ==
X-Gm-Message-State: AOJu0YwjLzpFqxRoqOJxq5WcY5T/luVkZhenZOj45vEhjJ9ktdk17hD/
	uGEnKeGVvV0XJqKM9YUcN9mTCLun9gH80/nx4VbRi/x9pxt1jVWNlHpMECQD4tMpCzdYIFXVMR+
	hLf8=
X-Google-Smtp-Source: AGHT+IE9PFPAA2uDO45KQy4R4WNfDP2TXmSJ8nY/EPrDdiTPGx7Ub7Foa1nbgbNodxgdC/JP0Ab6Nw==
X-Received: by 2002:a17:902:e885:b0:1d9:b21f:539e with SMTP id w5-20020a170902e88500b001d9b21f539emr573564plg.59.1707851174955;
        Tue, 13 Feb 2024 11:06:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiy1DQeyrcNrXez82dOzXDIlV705yfDbaSpG2TqNUWnAAmrSOAVjVcVkxn86OXka3bjlSJQXdCkoVCI7DwrxB5sKqMFwT2A6rptAU+dLaA6bni7+7/tjUI7rKfuw8uDMjQvvD7SHvPWnadr3XR3C2RJQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f2cc00b001da0a698095sm1438328plc.282.2024.02.13.11.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:06:12 -0800 (PST)
Message-ID: <65cbbda4.170a0220.ddbec.4509@mx.google.com>
Date: Tue, 13 Feb 2024 11:06:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 1 runs,
 1 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:06:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14948

cip/linux-5.10.y-cip kselftest-seccomp: 1 runs, 1 regressions (v5.10.209-ci=
p44-51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-51-gdb99ac443b0da/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb242f1add4aab1637022

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65cbb242f1ad=
d4aab1637023
        failing since 132 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

