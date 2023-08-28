Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA2CC83F10
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 02:10:46 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.5464.1693188635908804485
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 19:10:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=4xPJ49Qe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-68bed8de5b9so1700311b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 19:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693188632; x=1693793432;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LnP0vtsM6MDbFUbDJWABglw6LznOzV+kZg4w2DDalRg=;
        b=4xPJ49QeDcihwj7enYuc7tHrZMB54jB5HGP1qU1j14Cdz9ArD0ppWTxOOI1WShh1aD
         6PH4le5wYJwL5n71CbTwXv68cH9cDa6GajzozIFzsGJ6UmL42qQDjEVCK+rG8yu3V/Rf
         qWOIvcG6bXrLmlGbnG+W+dHHwJUixYPmfgshoht8ESGrIvbJB3CCSRPn/MPPC/Opw9Mp
         uqD2/gfLqV7kCrakpKk4Y5nxLX3FM/NmqXvIpwOb0M5SFgLKrmzPTyyIh63uHxMReQl/
         O5u64+PuoEE53LwDbaXTOewsaXqoaRG/1zbDLN16y5cqDPUm6QM97vZylb5xXA5MqEAm
         tHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693188632; x=1693793432;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnP0vtsM6MDbFUbDJWABglw6LznOzV+kZg4w2DDalRg=;
        b=dNbgsHCRZBE32xglyXUmqpTBwAv1jCoyE7myrD1aa3JPwAAXrK9U5YEOaol8UVfzx7
         JayKh5csb+nUx7GVhho/ZXgTQvSchWAFOA+s9yytF3cSPN32Ehi41gjZiOSbjZiszL4l
         cJpnGwLP3nhJ+O2krGw+LGrsNtMP0GsE7hfZ/9v6HxIZgu8H9lGgUmrTpMrKI8v5ztXV
         psu2QUOVMmExpHXLFJW77jjVQprcMCrWEeDPuAS/aNbdTUhhrFxyoWaB3qVqMSRRzjHD
         6KoZLf2c/mvCh9U19lafYuUmRC1wPJJ8PsKhHaqBBQm0dt5+c7jOluz1MBMt6QjiWr+/
         T4dg==
X-Gm-Message-State: AOJu0YwR/sEXCYjvKZvnoDAun9kbhLkB+b6jZEON2V7e4wj1q/BxSJ15
	K7tGmLWONfwbxgc47ZQ4FGutc84+0dE7mr4Tv0k=
X-Google-Smtp-Source: AGHT+IHMOLFj3rMsLKJdnE7A/YrNeVBsvp2Az2LtQF3t8vYUBUoEKLnloeRUJdO7unHuECgUF1lFGw==
X-Received: by 2002:a05:6a21:9995:b0:14c:c393:402d with SMTP id ve21-20020a056a21999500b0014cc393402dmr4285469pzb.34.1693188632683;
        Sun, 27 Aug 2023 19:10:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p3-20020aa78603000000b00684b64da08bsm5451064pfn.132.2023.08.27.19.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 19:10:32 -0700 (PDT)
Message-ID: <64ec0218.a70a0220.d453c.807c@mx.google.com>
Date: Sun, 27 Aug 2023 19:10:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38
Subject: cip/linux-5.10.y-cip ltp-mm: 1 runs, 1 regressions (v5.10.191-cip38)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 02:10:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12869

cip/linux-5.10.y-cip ltp-mm: 1 runs, 1 regressions (v5.10.191-cip38)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78bddf33c2b7d94fc34e09bc56638615095ddc28

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf69542cf22cd8b286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-h=
p-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-h=
p-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64ebf69542cf22cd8b286d6d
        failing since 5 days (last pass: v5.10.186-cip37-14-gc9b5a049d8ea, =
first fail: v5.10.186-cip37-27-gd6d928db0a620) =

 =20

