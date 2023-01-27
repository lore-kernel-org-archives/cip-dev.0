Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D41CC61DA4
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 01:22:47 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.92556.1674782561388611802
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Jan 2023 17:22:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=sPL5jraD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id k13so3592602plg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Jan 2023 17:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AqvEfIuDeFMDruBgBAoiQMqx6iSZ0VG5mUO8CJ89KcY=;
        b=sPL5jraDRW4LGrbObABoU7tTUAsEZvFJ4DaVNJ0G/LvQznOxEnqd8WwpttJUmwv6VJ
         ffjqhaG8l3MrQCvf0TipwLP9QvhdeP5t+jZht7unEVnpaHLQaDcjJWkDpKwKmRdZ0Daj
         5R+m2MUiEsKRmDzSNLn8lRsFU4j4f3W5wbrtt1EQFzcGRdPjFFc8NaDkSpG5wmXek8Gv
         sAbIfB+qzdLuQBbvZV2pct+6eS2oqllCx3xMVbPN/GEaUDgXY2Bl4eWHAxTRn4WyaBQ5
         7mTcpBdTwqoDtdQ/4HNorT4hzPtbYTX9q6YTSwrCalmBAUHXzrHvvo9LEqOSgsk9+ZHP
         yZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqvEfIuDeFMDruBgBAoiQMqx6iSZ0VG5mUO8CJ89KcY=;
        b=Zj17rNQmJuVN5jShrNPuy53C27VyF49GyW96nMo0OCUjUvNIsYKRil/WE0MqxKKYZu
         wwFNeRxQ8dNHFTpU+FIQmQoyGYX2/KzXuBnPccar8LC7feZjLGSawq0gHVfssr6sbdud
         CgGixa/TANaA6VJsT+Jptj5BoYQH6lXupZGbpC/V3Wk1xQId6DKLVdHXI+1afycIRdWK
         gefF2Rlh6zXLG2ePtp2+NW9aObvzJ9pShkKWBnfgO3jvKSzDycvaHyJY7/BG4nE44hxO
         kL/iAUDwTzJ/C1jXuXHXXSrn1fBCOcy4QAiAV4r+7CBo3+bFcR7u6ocmqSJAvPUxwOKR
         VjuQ==
X-Gm-Message-State: AFqh2koj3FqmczFHKN4z1+FNkcbXgBz1MTOWOsSir+t80oDbCf1TK2Zn
	Pl4dYUePdZ0XF3b5p994N5Hl/HWkN4GMayyswNWq8Q==
X-Google-Smtp-Source: AMrXdXtO/Bo89LlNBPK3GFg4HiDMJHB/9QbVPr74zTEk5mcvQKIi4qC81Rz+149HVM+z5mLhCXJk6Q==
X-Received: by 2002:a05:6a20:3d83:b0:ac:98db:d4cb with SMTP id s3-20020a056a203d8300b000ac98dbd4cbmr55962074pzi.41.1674782560489;
        Thu, 26 Jan 2023 17:22:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y15-20020aa78f2f000000b0058d9710cb18sm1477164pfr.2.2023.01.26.17.22.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 17:22:39 -0800 (PST)
Message-ID: <63d3275f.a70a0220.3ce38.2a0e@mx.google.com>
Date: Thu, 26 Jan 2023 17:22:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.162-cip24-443-g1f8fb81fe752
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 10 runs,
 1 regressions (v5.10.162-cip24-443-g1f8fb81fe752)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 01:22:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10489

cip-gitlab/ci/pavel/linux-test ltp-pty: 10 runs, 1 regressions (v5.10.162-c=
ip24-443-g1f8fb81fe752)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.162-cip24-443-g1f8fb81fe752/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.162-cip24-443-g1f8fb81fe752
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1f8fb81fe7523922b7ff40bbacc9ac4aa9e11796

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  d042c168dd037bb0128b86ee4ac4f5c526eddc7b =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63d31ab712d3556457915ec3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63d31ab712d3556457915e=
c4
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =20

