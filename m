Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219DDC48297
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 13:44:07 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.62650.1707140639807913148
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 05:43:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=KMjcR2Vl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d9bd8fa49eso5148575ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 05:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707140639; x=1707745439; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KlrjXT7A8YUkghVrGbLjeEHyn/G5XKkNLpi0Xc178dQ=;
        b=KMjcR2Vl2+2mcp+zjusmlWOFxT3quX2ZoHQbX1AXBkVRmQiOTEZfY2zK1VeNOC9eSS
         VetJGfCIMck/MG+aAfYy4sJoHFIawdc/hE7JdRTfTx9a1pyd1BsBOvniEdq0C9c0ITpv
         H5zC1uJ2tQgyZOtR2Cd+ZWXbre2ii6cTyILlJv6L2M9Z7puMMSEZMGSzamr5+pKFvX1z
         jhCUrR7WsYGNktEESeIEj1fNRM1+2I97B20LdHKLzz8JB6XzBT37pHasLrkTF9Zkrbyf
         e4D1pXrzvqsYIRQCZZpkLEe9wvLb1BHx+sDFhHxuuPozFn7T/mksgpNko5eS1eLy9qzX
         uIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140639; x=1707745439;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlrjXT7A8YUkghVrGbLjeEHyn/G5XKkNLpi0Xc178dQ=;
        b=GQ+6W/EbCvAv0IJBzdUnFHSQPpKnb5vGUQmN/e/StN6CydgRmQ9xY0TnGRt9Davz3K
         OOhv43I02w8KgETar9OIeo1ygBzE22eFaR2AeS8QxGCFY/UvxuDt40iXRPHUc54ybKb5
         msXRMtqoxSDagdj8638jxVUlCtu7ROjoZi/fcwwaZmvcSiLbd9zJ5QTUk+l6wLP/1evc
         UybdWQbSs4JW5N6BmFOjnWKTlK5iVGNJ23y/7DHjAxInFJAJKjtEs6rPU99KZPFrMM27
         jMi7otspPJ1+LbMv97FhZEHZyM2M0T0sGOUSdV7zfMTUcXnl6CVbSYM/H9YizrfoBTtN
         Z14Q==
X-Gm-Message-State: AOJu0YxogGNCqFf2NMWUHe07dESFyn44q+oX+Ptvk5oSIpNg+fyqrHou
	bkJb4ufkat4z+YeTqkG4KN4faTzMtEPKYZiH+ZVbs1ebIdoTK+jDfOYrXSCPncxS2/BFXxRujTK
	j
X-Google-Smtp-Source: AGHT+IEyrxpTwB4at+ui32d5hKDucC+EBXgbon7HT/T9cnchiyo4ezlBlxTsZMwxfYNHdc5ErNQBTg==
X-Received: by 2002:a17:902:db0f:b0:1d9:c367:2032 with SMTP id m15-20020a170902db0f00b001d9c3672032mr1572754plx.10.1707140638973;
        Mon, 05 Feb 2024 05:43:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902b78900b001d987771271sm4490045pls.123.2024.02.05.05.43.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:43:57 -0800 (PST)
Message-ID: <65c0e61d.170a0220.c235c.cd1d@mx.google.com>
Date: Mon, 05 Feb 2024 05:43:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-6-ga817aa655908
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 19 runs,
 2 regressions (v6.1.75-cip14-6-ga817aa655908)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 13:44:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14726

cip-gitlab/ci/pavel/linux-test ltp-timers: 19 runs, 2 regressions (v6.1.75-=
cip14-6-ga817aa655908)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-6-ga817aa655908/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-6-ga817aa655908
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a817aa655908e54b6999ed3d0663c3f370d059ec

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 2          =


  Details:     https://kernelci.org/test/plan/id/65c0d8361d24c2274f00a066

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c0d8361d2=
4c2274f00a06b
        failing since 1 day (last pass: v6.1.72-cip13-32-gf60d2e8cb51c, fir=
st fail: v6.1.75-cip14-132-g6e54756fbd6c2) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c0d8361d2=
4c2274f00a06b
        failing since 1 day (last pass: v6.1.72-cip13-32-gf60d2e8cb51c, fir=
st fail: v6.1.75-cip14-132-g6e54756fbd6c2) =

 =20

