Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB1C46CCD
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:49:15 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.42745.1702057748083689897
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:49:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=yuCreLmI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d0bb7ff86cso26358585ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057747; x=1702662547; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u9WPPHKre73Pu41gBz7EzA8WuppZc0ZH7RFAXWFOwiA=;
        b=yuCreLmI4Ew+RrAikNl3AnWbWO+9UvgCJWFREEkFBSEkdu8nub2+GYT6m1PTsOLRQX
         iVSZbpbRGmpxhLsFClc02sN9RhGXjichgbME7qib02EkUvoM7z03agX+znAPqp3O1dqz
         P1H1I8ZbyxBZvefgePwZfnSbkQ+sc9+KnRVSVFjHbYftI56Nh2uo11Yg7BqTx8Iq4zgu
         VUp+qjTkEQWgYlXiaTDfahmN+bTDvsR2NhyuBZQ9enpqIsGUc4qZYaQs0UOYQ49BrgYk
         o2EAHmSWdoW7oDyDtHGPayjjqHUeG/DOsalH2fh18RDBQe//yVITla/WiTCT2ZFtheS2
         GHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057747; x=1702662547;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9WPPHKre73Pu41gBz7EzA8WuppZc0ZH7RFAXWFOwiA=;
        b=Ipcgqbl1wg8NMlcPFrvpIAPXhuTG/6vMHr/6vetxuZp/7Y71VCw5CbXn+fi14YJAeP
         IdinhGIPjMyC67I/5sfe18+HKmMANNQNzYu3kIJpxPPqP5UV0tqGoVIiNPXPw/6e+Jyh
         S6Omow8YLsMtMNhnkPKZnCgIv80moqKSdLOT4wIlFqlIPBcpqg47mQV71OsNUGnkyN/8
         6l6rndMMpUp+eHSLS0XxGopxyFGr41JG1HdnnFYfy/oRR8SATskz+hHf6skB+DF+3xnc
         ixUCeR9C2xwAV6RdVPmOOAep7DXeHYMy6WFSNKHyKLB99QpFtNUTo+A6e733p7H/TUa7
         oogA==
X-Gm-Message-State: AOJu0YwgJ+5gSlQdDIBcLW7Xgk164mqk9/nFg7DYoocsPcF8hUmPOYME
	mfaIqDcvR161Bb9TYAh2eiMu9UVA5TI2vxOPo0O6QA==
X-Google-Smtp-Source: AGHT+IGUen9TwAefmoPeITpM5zB7G87Ftkq8kfc6+7F2VDJTd84snV+9uK22XHy9Red+r65KOAUfiQ==
X-Received: by 2002:a17:903:22c7:b0:1cf:e9b5:90ee with SMTP id y7-20020a17090322c700b001cfe9b590eemr585386plg.24.1702057747017;
        Fri, 08 Dec 2023 09:49:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jg6-20020a17090326c600b001cc50146b43sm1964056plb.202.2023.12.08.09.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:49:04 -0800 (PST)
Message-ID: <65735710.170a0220.ad8bf.6e4d@mx.google.com>
Date: Fri, 08 Dec 2023 09:49:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 8 runs,
 1 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:49:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13984

cip/linux-5.10.y-cip ltp-fcntl-locktests: 8 runs, 1 regressions (v5.10.201-=
cip41-46-g596f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e

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


  Details:     https://kernelci.org/test/plan/id/65734845530729218de134c4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6573484553=
0729218de134c5
        failing since 176 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

