Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC132C4706C
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 11:13:00 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
 by mx.groups.io with SMTP id smtpd.web11.16899.1705144375688861528
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 13 Jan 2024 03:12:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nhcjyrfp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.49, mailfrom: bot@kernelci.org)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7beddc139c4so163011439f.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 13 Jan 2024 03:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705144374; x=1705749174; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=doxOPZadm3oJCFl+4qtj5R8EB91UJvpu2gaHpKYZvsA=;
        b=nhcjyrfpyObspbMNkF3zZEqEUyjkxLu87hxINmse+PyrzpG/2DSm90dDy3D+y5cEHM
         IfrS8jLApbhKejZBistyEoDwaojxmyGolsJiy8zzkt/8iDw1Wsxf7hyiAlYJUjAu6cYh
         3rEKH2cdOfKpi4+nIEKLf2O2EDEh3gK+U5/tN5GJ4vhp3WfLmKlVAiBBCalQZyUn/vxT
         oHb7btnANgqEpfgJItEwgo0KaEFBlfFUMiTTg/nwiwUnCKjiJvgCZrTmokW5UsGeUeyj
         qZi9A1nMK2bMD1nWHXEjjpQwQ20xw5CT/SR7VdhN2BY5Tjybq4Youl7PHNK+QBCCPnpF
         1L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705144374; x=1705749174;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doxOPZadm3oJCFl+4qtj5R8EB91UJvpu2gaHpKYZvsA=;
        b=j/nW/7ae79AR/hE8Uy72gr4tzrjkUym8B+BlVeblXtDmYjE5FYTWlSAoghRFPRjZhm
         F89y0X8skPHhtYXMgdy9X41HNVY6RGBOuPnrhYrCPPCQddHS61Sh3pjBICOlLagdTGzz
         A4diWkTq1onLAMVdNPGAIVWvrqZeZwkI2Ae9F80Mwftc+7UqZv0bNn7tevCe33q8v/Ke
         W3wKym6JqYwGEEA4coL3qleayIrci/R3xFpKSgZI6odSuaorqbWmlOGBmr+IEWod/D7l
         8Ab58cNuDk502oE5lpCYOLg7D1zr8o1m3V+EIY5G1bBz7qVhDO6KslMqoXvPKbXJ9g3N
         kLmA==
X-Gm-Message-State: AOJu0Yx861CZ2HszE5wMQL9xkAEKbR6F84p9+tjWb7Rn7tarMH9nSYVq
	bs6rERAr9spbqTsCWN3T7NdVItyMFGfUKloIgKsK6wHmnaA=
X-Google-Smtp-Source: AGHT+IH4WPx5hoFgXnGEQya7teHNEG1+RuROrybkb/H9uILc7lcqyLrQltjOwdUuoGcwcw7RfPDWIw==
X-Received: by 2002:a5e:db02:0:b0:7bc:267f:a03f with SMTP id q2-20020a5edb02000000b007bc267fa03fmr3169683iop.8.1705144374463;
        Sat, 13 Jan 2024 03:12:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e80e00b001d4abc234a7sm4592107plg.100.2024.01.13.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 03:12:53 -0800 (PST)
Message-ID: <65a27035.170a0220.d9f5a.f906@mx.google.com>
Date: Sat, 13 Jan 2024 03:12:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.304-cip106
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 10 runs,
 1 regressions (v4.19.304-cip106)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 11:13:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14374

cip/linux-4.19.y-cip ltp-timers: 10 runs, 1 regressions (v4.19.304-cip106)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6617f4528449a329abd3b2dab36052b341610d99

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a267108b67407d6f52a415

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-timers-a=
sus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-timers-a=
sus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65a267108b67407d6f5=
2a416
        new failure (last pass: v4.19.299-cip105) =

 =20

