Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97DC61D85
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 03:00:13 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.128553.1700794811935124633
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 19:00:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Fqh6y83L;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso1052501a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 19:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700794811; x=1701399611; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wFfDrR3HA9XgSNUjfySkJqpTfdD8RIsmsc0aJUJQCTM=;
        b=Fqh6y83L7g1aAhgG61MA0IbPaxv6VyUzhH6lhUAHDuEy17Y2wYKxUPgiR3GUerJBYU
         K2RYseqJhHQS32yhkXiUdUp92oVUAFKOD9/lkRpi9BugAyf55DXZyb1u6d1cI0K2Snz1
         7OMob2Jdue3Pq7rLKmJPXS29Leig18Fzr33fTT7ikGA2rN19BZ4BCXHcpifMYm+StnMI
         FNotnmjqrJ4NnO6dcJWeCVmQ6aKuI5zgCiirrR1X8t2iVOhV0eUZptyESY5R7SRHHav7
         CzmExVnZj8eic8FL0ENBs1h3tY14PaX82FAyZC3u8v8muf5mspvboDCE2BDRMDH5oQwn
         TlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700794811; x=1701399611;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFfDrR3HA9XgSNUjfySkJqpTfdD8RIsmsc0aJUJQCTM=;
        b=QStwHlAsObsn6axxOZfdapBOya8Q5BoI1ZaPmj+uZIMFBOuFIMjUR5MwhRGyLqNL41
         3LyGZuAd0gv43nIpuoACeziretC5iWGiireDS8ZDOJAkAe15Prku5TTHyF6hJbeR9w7n
         Tp/p9kHEUklvLkAeX/tanGPeWxcN/ao/nq4dIpHvqgY1rqVqdZqrNRTagY5t9r36+GjK
         0QoZIToiRmsPnDTMV067VHH4LA7RWIFQGUeb0CrfvhTTaKc5VAmZfU1eMriutMvS6Wqm
         ZNiU/0sFdnkIRNS1ix8gIX8clOJEcQfMuF0b84fjDQ20zTN/pGYExMQVJ8i+7Yb6PN+X
         Q/Rg==
X-Gm-Message-State: AOJu0Yy5HyfFAGBxsatHWN9e0aeG1SHSgNeZxt7PQ0LTpPxNoPipN37R
	bveecizgo0CtUJHx8QSozEjfJqEU11nYHNn9gSk=
X-Google-Smtp-Source: AGHT+IFgUyCx94J4u4jNeznL61r/NVNgcnFf8VyOwmrs+ky1AGT8/SkWke3esB3O0eTXoKWX/lwxlA==
X-Received: by 2002:a17:90a:1904:b0:27d:1f9f:a57f with SMTP id 4-20020a17090a190400b0027d1f9fa57fmr1441058pjg.32.1700794810290;
        Thu, 23 Nov 2023 19:00:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090aa00900b002858824ed80sm322676pjp.45.2023.11.23.19.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:00:09 -0800 (PST)
Message-ID: <656011b9.170a0220.72fa4.123a@mx.google.com>
Date: Thu, 23 Nov 2023 19:00:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-rt17
Subject: cip/linux-5.10.y-cip-rt kselftest-futex: 5 runs,
 1 regressions (v5.10.201-cip41-rt17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 03:00:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13704

cip/linux-5.10.y-cip-rt kselftest-futex: 5 runs, 1 regressions (v5.10.201-c=
ip41-rt17)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.201-cip41-rt17/plan/kselftest-futex/

  Test:     kselftest-futex
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


  Details:     https://kernelci.org/test/plan/id/656007fb20a001f4877e4a70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/656007fb20a001=
f4877e4a71
        new failure (last pass: v5.10.179-cip32-rt13) =

 =20

