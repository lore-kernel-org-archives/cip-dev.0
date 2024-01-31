Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D642BC4828F
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 13:21:37 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.13628.1706707288816826048
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Jan 2024 05:21:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=IbfgLHDl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d934c8f8f7so3191685ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 Jan 2024 05:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706707287; x=1707312087; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=936msySudMUGDrC1L+Slp4fSZFcgclEr2d1HkIOu9t0=;
        b=IbfgLHDlbb4l7oaMYH26Vcr9w7A4/Uo+XCxWtHfuqqjUQ7+CbH1WLwt1ZJ1lJnVLK6
         IANQ+dBziR50Kmb1U3T6AamYQzvWkFMaJd7b0g35OhPWYEl2kUOTZFpQ7AgyHayS0oTK
         EmtrLaBsLP8f+Rr93fA7t7qugV/L7xSIrfHLxh2m5VQvXJDG24VfoAHIB0iwc/sr5J9N
         EezJk12JjbhCP0QmhbdtJn5AfKv1RUXhwfDNfpDWfxnlxbCgaGb/mgGn7b1UquRVIwIf
         VNM5XkQf+HvC+O+z0wgIssbU4FHB3CRR2gRAiRAjEHFBx0bU1CmgD1sL6k88DrkXAB11
         zOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707287; x=1707312087;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=936msySudMUGDrC1L+Slp4fSZFcgclEr2d1HkIOu9t0=;
        b=dvpq/8gAcfedXnuCYUDqDY8lTxw2IgmR708Y7Y3hWlhdEPU+3ERIJQne9gnIpwXjRP
         xxoRDgR1gxiiOSRVIujacoySJMumHQ2UeYbQoPICj5JpGsGr7uacLx52nc5qM7MWcPqx
         sq1Ddt8eCfuR4MRCJSybfktz2KPkuSOtjH5CCuquo0zmCIVbF5V9JoizZAp8d51SSL8w
         WSJsoYeegMcXxbM9+V2uwkiLI7KhN9Qy4MAiXMp4XGUv3H9TDl85Wu82rITuYkpMr942
         sbku8OlvCSMJ93Xgm4mHjTYpC/x5Z2Lc6WARfg+4xll/MUNcvhh5k5V2YYxcw3cRSykX
         u4AA==
X-Gm-Message-State: AOJu0YzsrUbizcCQeVhdhX532wxAYuo/5V4r40IJhuiXcTmEyTqCn2SW
	HIWgcAPbSz8glKskoum8n2zYpnrAprUmzm4EK8AmPTW4qzcAt/DJttLwGIqLco2HRandLa+Hizk
	+
X-Google-Smtp-Source: AGHT+IGAmLH15gFDKtyucSg7pwllT8RbJ25Au26uoU9etWkebXNy8Lcs8vbJLvO5hEEJ04CQafuj1A==
X-Received: by 2002:a17:902:64cf:b0:1d8:b2e7:9e83 with SMTP id y15-20020a17090264cf00b001d8b2e79e83mr1342544pli.45.1706707287379;
        Wed, 31 Jan 2024 05:21:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902dcc500b001d8cdc5c400sm6422059pll.184.2024.01.31.05.21.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:21:26 -0800 (PST)
Message-ID: <65ba4956.170a0220.e297b.31bf@mx.google.com>
Date: Wed, 31 Jan 2024 05:21:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.72-cip13-32-gf60d2e8cb51c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs,
 1 regressions (v6.1.72-cip13-32-gf60d2e8cb51c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 13:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14565

cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs, 1 regressions (v6.1.72-cip=
13-32-gf60d2e8cb51c)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-32-gf60d2e8cb51c/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-32-gf60d2e8cb51c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f60d2e8cb51c9da65ffcfe73144286c27725ceea

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


  Details:     https://kernelci.org/test/plan/id/65ba33783d6e5c089f00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a7=
74a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a7=
74a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65ba33783d6e5c089f00a0=
3a
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa) =

 =20

