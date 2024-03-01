Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4D6C5475B
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 18:16:35 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.31132.1709316991815300248
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 10:16:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=plTmMnzR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e4560664b5so1997969b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709316991; x=1709921791; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=whMkOtE/4jI06xQUs3hcV24wwQ3NSpR+X+yMsz7zTVY=;
        b=plTmMnzR10+4AbuaLxwamdGFnXF35YhzkyHQAymUZYvSNrGN04tt6/ONEMvL/A/0Fw
         VdyvqAD1UAQUOQ+GChstIXIx6gLiJngEWUYc6XrxxDL1zVrPTR6/o+myruTFpBDA8vMq
         iX/jQLWtWv2Amfqz9MJ78SVMp6GT3b8RbSLFW3ZGGg/HjwsidYUEn5OPWqzOTiMfcOAf
         bG95RwRhT6drvwCLwPxN0ad5J5bgFGM6zh6EGOUUn2sYF1f7Vr6u7VAdzXmIkBOrHv6o
         gefigAzQ7daTpYd/uOzXwv3vvUUIeM7TfWwYeYlidcksui3cA0S5os6piv98RjWouNLf
         QfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316991; x=1709921791;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whMkOtE/4jI06xQUs3hcV24wwQ3NSpR+X+yMsz7zTVY=;
        b=Jv1jHVykw2FFyI8aVd2O19m2M4YahTRxEwO8Eei79adDfyugv8VsECXFcqg1cVjHit
         xDM38fA+nycjMqYQo8WFjtcYdbE7TO1OYAS+LAgwZgfX8Bbbvlvk/t6FVn/B3M9qmgdw
         B9XH7o92Igw7Luv8P75pNGpRaLM9QhkIboM06Gin0+L7f9I/foTKp8RePB+h6AAE9TBU
         fOXG6UBeava/8Vt9sGK5ML2hZ0jIXwvre4bfjncEK3B3HrnvJ84JyA5CR9bXELfdiXfM
         xTdrh0yJCi6Mk9QMT0P9v6qbM9fJEWBR+AITKvnig1ByPlK0hXd/ea380Zq+9KzntFMQ
         7ZWQ==
X-Gm-Message-State: AOJu0Yw5lIiod2CEhp2tJb0mj2pg8YfgeERRTIjY9P/RmGiEgTZ3AROT
	wfUi+1IRjoOizljbsQ62A7bOntH+hRdDgEpYYIDO4z/Jw0MmiVQTxZqeeAf8l7LsGj2+o0BD2v2
	5D8c=
X-Google-Smtp-Source: AGHT+IEPPnJeiAqWju+VfFBD2hVM/87q8UbzBFgWykOHjohMcR21W7EpQUJQQ4PsIj2GPgkSUXYXKw==
X-Received: by 2002:a05:6a20:5482:b0:1a1:2a5e:5909 with SMTP id i2-20020a056a20548200b001a12a5e5909mr2773805pzk.21.1709316990771;
        Fri, 01 Mar 2024 10:16:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u32-20020a056a0009a000b006e144ec8eafsm3229045pfg.119.2024.03.01.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:16:30 -0800 (PST)
Message-ID: <65e21b7e.050a0220.547ae.f8af@mx.google.com>
Date: Fri, 01 Mar 2024 10:16:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Kernel: v4.4-st20-2245-gb01c108f53cc0
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-2245-gb01c108f53cc0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 18:16:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15131

cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20=
-2245-gb01c108f53cc0)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-2245-gb01c108f53cc0/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-2245-gb01c108f53cc0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b01c108f53cc00abfe18491837bb94881ee164b8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e20cf5e9c13a6c9e63701e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2245-gb01c108f53cc0/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabor=
a/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2245-gb01c108f53cc0/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabor=
a/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65e20cf5e9=
c13a6c9e63701f
        new failure (last pass: v4.4-st20-1987-g9e48fc479c400) =

 =20

