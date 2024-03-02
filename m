Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB73EC5475B
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 01:05:52 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.40727.1709341543605246824
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 17:05:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vIztnKc6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so24267575ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 17:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709341542; x=1709946342; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KwPSqAQVPSPrqAD5qP+xvLawTnYrSVruO2JlgL+1/ls=;
        b=vIztnKc6tSjlnyp2UxhQLMw4ziopO13muZFnipb7UtkPGE1P3aY/VOmyWTYkpepj/A
         X0qVNL8Aq7S2sl0HQtbGKVRxmGVNU7OEUdyrvqHpv2H4jkg572Vln0eaS/kxRbo5V3W7
         sSG6WE4fGqbDqgGmFcUIZ8o183KdZUvd8wG9Xwmtk7abUu6hSZ1YTRO0OB1ViAcgv3qt
         Tdi8xF7abIOMGtvvCG6KsPRymWSrWC7256C1LJDl65TpH0CDZYCoPRq3C2DCOori4/6X
         xHm6cif5J/gQwdDLbLSXop6CM693VcBDk/px2crLAcUS/6TD0QN3y4jjF3zvFtEtKpxd
         keDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341542; x=1709946342;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwPSqAQVPSPrqAD5qP+xvLawTnYrSVruO2JlgL+1/ls=;
        b=ZWnopdMGno9S4wbUAs/KEficOgHtXuv+Z0rueJgzjLThzpxkbj/uWWsBlLN27Aacvi
         CyzvS7iWThfIRbA0nLhAXS5vFsw/mFCTAnXxQqDaq62BeTtFAMQorV9AI2aqYseZqRul
         ftXnH8BAhipRIxgxYd4O3HvncIVUCZsSi7k0YJV3t3Hzfqcrwq1Luw2Qbq7kp+3DgPbB
         1EezRWmk4aCUP6xUD0BaeMPdB+R5nD+Gj2ic8IDd80V+a+dSeQSUHm4nCCt0SZBQ9Ews
         HRvs1/c212oV2U8JNw5nWlDH7gDp52XvEIVWSv393GOiO9YFyGFdUUgdizx89uzGo7dT
         mqGw==
X-Gm-Message-State: AOJu0YxKl1z2vO+1S9LrK685ANCsvD5Dd7bpamGEqMKTqrUE2yllGdzW
	AtWQsBWvAE+qyWcD93pcEibYfxGqdHQu0bVlyCWqVj9fs/q0s9gQ6/YG2s5JF9NI74q4i4eGHAI
	Zv3U=
X-Google-Smtp-Source: AGHT+IGMt8Qh1+gJ/3+laui8SHZjy9Qw6j2B1KpJqQTXnMNEMvLNcK72WLPJg+aoOb1kVbm5nGu3Mw==
X-Received: by 2002:a17:903:1c8:b0:1db:8d0a:cfa9 with SMTP id e8-20020a17090301c800b001db8d0acfa9mr4968315plh.6.1709341542164;
        Fri, 01 Mar 2024 17:05:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001db3361bc1dsm4091114plg.102.2024.03.01.17.05.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:05:41 -0800 (PST)
Message-ID: <65e27b65.170a0220.d256c.4698@mx.google.com>
Date: Fri, 01 Mar 2024 17:05:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.306-cip107-1142-gdcbd51e7744f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 10 runs,
 2 regressions (v4.19.306-cip107-1142-gdcbd51e7744f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 01:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15153

cip-gitlab/ci/pavel/linux-test ltp-ipc: 10 runs, 2 regressions (v4.19.306-c=
ip107-1142-gdcbd51e7744f)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.306-cip107-1142-gdcbd51e7744f/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.306-cip107-1142-gdcbd51e7744f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26996957b7c43d6637037

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e26996957b7c43d66370=
38
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e269ab5146f27c22637016

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e269ab5146f27c226370=
17
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =20

