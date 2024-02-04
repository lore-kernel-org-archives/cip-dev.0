Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E150C48286
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 05:40:36 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.33694.1707025227027417434
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Feb 2024 21:40:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lxWIm+b8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2711263a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Feb 2024 21:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707025226; x=1707630026; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rRssGchWbqrrRvFPNF9bAc6b+d8ge88qzohKsSKt3JI=;
        b=lxWIm+b89hXnUGoOMu1YymFWqESmmtu6XhtX4KAsNgOVeqA62azPzRI/kjGQJKXBLP
         jXDe/aiHk5oVV9cHgjNQL9eEHryhKuTjMovh5e8C3e2sXRbCZf/tZr8+1VcvZLMykq9M
         G6cOiVw8531Is0xcJSZhPHCr1iPJOt+vhiN742jQwkJaSkXzJMP1NyBHS2Wjxgo2g3pc
         wboinFELKpDgs4BdSBGk8JNYTPC7mJqZl5Q35Ul3xK9ebOaBw+eJ5HvXim8wt+Hh4C/g
         F5Pw/6LhHeWYIH9IEiipm2ptTuXijF6hSGKMfw9EFJJqXO5Ya2mhAUnW2Rwd4iVoXgk7
         TA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707025226; x=1707630026;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRssGchWbqrrRvFPNF9bAc6b+d8ge88qzohKsSKt3JI=;
        b=UWzqI2ADOYsxdFRGOfpvZN1EkCLjXoNq7/u7WKmXUD8r2qwry5ZZZldX6wsObRPBXC
         lQbEhTJStp6h1IrUFoS7J5sa+s1XQ39eKjFH+WLGN2cqO3VLT2KOPgkoPbhcwsOLzlak
         7bh0MHbKayjSBNPJku3OhU+OPlcng5wfx4HpxAMHbZnF+MFZaIzqGAbvEq9IWgq+novQ
         4NToBzSkZBzmpmILCYMdP9Gd4ztZQCT/4fNhv4uDAPOHMKJQGdpY5WyiJsopZY8L65GM
         RZb8pOQLZALZGDv5EMXSdU6X2bdaW88LAygbGRinckSbCe4u53Sr5XhiNktcUFuCU/61
         68GQ==
X-Gm-Message-State: AOJu0YwPQH2yq2L9ozDuJ1Rvb0qOPo2m9EtYpdoOkJfjwE1dHg1PGx6s
	9erBU9VjFpqizk58vFhlTiNEncnO5Bst8/O+kHfGUbFyWQIhkD0ovSkoEDAGhWrr6PPXoGPcr3C
	NLGM=
X-Google-Smtp-Source: AGHT+IFjIMeyoOujDmEVEuHUAmCfU2k6p3pEAfjEw62exqNo3vekTEYjseqiwVx5VBIZHy7dU63jJA==
X-Received: by 2002:a17:902:e882:b0:1d9:7095:7e1f with SMTP id w2-20020a170902e88200b001d970957e1fmr8289104plg.67.1707025225665;
        Sat, 03 Feb 2024 21:40:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id lh4-20020a170903290400b001d8ecf5ff6csm4040541plb.147.2024.02.03.21.40.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:40:25 -0800 (PST)
Message-ID: <65bf2349.170a0220.cf058.e364@mx.google.com>
Date: Sat, 03 Feb 2024 21:40:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-132-g6e54756fbd6c2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs,
 1 regressions (v6.1.75-cip14-132-g6e54756fbd6c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 05:40:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14648

cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs, 1 regressions (v6.1.75-cip=
14-132-g6e54756fbd6c2)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-132-g6e54756fbd6c2/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-132-g6e54756fbd6c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6e54756fbd6c2a85eb65a7be04700955d2e49b68

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65bf124853d2f4bac200a05b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8=
a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8=
a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65bf124853d2f4bac200a0=
5c
        failing since 3 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

