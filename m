Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D090AC61DF7
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 03:00:13 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.128344.1700794812420140677
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 19:00:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pDL2TpSc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1cf8b6eb13bso8769705ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 19:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700794811; x=1701399611; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T0RF/TKWPunoHirZElm2ej8zr4cITVTEfkJsEuWfW8Y=;
        b=pDL2TpSco+fWini6hR3UPQ8SjMxwdus4BOxU+CJE3DQTNgzllOJuzsBpGFbhYuL98p
         n00iswsdspV/GEVDL5hRcBjx5ekJnlwnQqrs6uvXcFf+G9YYyemjtiUkSWvIRJQ+K9dQ
         gLgvWiFyol5jcaZP2IJy2JnNM5YyuFPRlx7ZWIjy3PqZkifQLHqPVb9rI4bKse2eshcX
         hNHUGB5Hq6qpROFXLaVkTrqrz+ziVGuW5A9Dqc1yrFN//X9EDblAgRDiXCsA9kL4xoGp
         KwCJ315RLlYL2aUCqtFZIMP0NHxbNf2KSZoIFwCWJoi9RBubyHju+Qo0B1umNqKR59CU
         ZffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700794811; x=1701399611;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0RF/TKWPunoHirZElm2ej8zr4cITVTEfkJsEuWfW8Y=;
        b=a0mQb46oLyIe5YYreR/k9lRx46xiCddlxpRNnbwA+Sr0yvdU5zn2QckzlETmgGPH3/
         6NT04742MFOlplC6Z8dmT0IPo7JGr5AIVyBcS6qBc3sk2/XOFYUjJuxEPWBUglaPko+o
         bTEnwmt3UUdVc+CKFToA8NB0PqZ771KL7k+QBJ4tRdEXc/eW9krMKD0AAYCUTPfFnM2f
         /Eao0I5y6VtZ2GkZR5ghjv7eEyvQSm+29lFERGtX30lNlmsjJAcIRgsiIDzzU8XKKMDX
         Lv6wGbMRltcMtXsXwidV/tLgoDPC/4jxk0142R74mWo0jQtbAs/jzTdA+oPw5QdQTPGp
         4Xew==
X-Gm-Message-State: AOJu0YxYLdlNswucyJGJl9zf7aFWDUKj+hei88u40KomNyc40mkrBvta
	JMRNkLzpcU+oiW4j+nZHPDVx1qlsL0Q5rQnlZ+k=
X-Google-Smtp-Source: AGHT+IFVaojpC+Kcwx4Ih+tGHP4zPoDviiezmQPjgXQP5kWFk+LRwvMGIHrIjw5fZwk6o0Qd4FYymw==
X-Received: by 2002:a17:903:2311:b0:1cf:9a10:cede with SMTP id d17-20020a170903231100b001cf9a10cedemr1627012plh.49.1700794810791;
        Thu, 23 Nov 2023 19:00:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ec8200b001c7453fae33sm2033376plg.280.2023.11.23.19.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:00:09 -0800 (PST)
Message-ID: <656011b9.170a0220.fdc93.5363@mx.google.com>
Date: Thu, 23 Nov 2023 19:00:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-rt17
Subject: cip/linux-5.10.y-cip-rt kselftest-filesystems: 5 runs,
 1 regressions (v5.10.201-cip41-rt17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 03:00:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13705

cip/linux-5.10.y-cip-rt kselftest-filesystems: 5 runs, 1 regressions (v5.10=
.201-cip41-rt17)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.201-cip41-rt17/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.201-cip41-rt17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78ed1354cecc021db9a1d8a8b4755fdfcd826e33 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656005f5ac5984c7647e4a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/kselftest-filesystems-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/kselftest-filesystems-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/656005f5=
ac5984c7647e4a76
        new failure (last pass: v5.10.179-cip32-rt13) =

 =20

