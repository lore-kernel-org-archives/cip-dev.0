Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF5C77B7F
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 10:01:19 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.15119.1683108075321789025
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 03:01:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=hl3RQSJC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5191796a483so3374125a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683108074; x=1685700074;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WbPuljT+8ut57Ai6k+RnXng5Lpx1baVSAqTyas5OL7g=;
        b=hl3RQSJCkhtHmHjVszSJbuTGx2MExfiRQjyCMp6snXjyc6TRchklIgcJN+QUCLm3iM
         XXI7sF77+DUyXTJxAgGdeWmo84mK5joxkTsob+8i+rDlFDrwJEcqRzD5MFNkmPD+gIZQ
         6HhDxoLFpP/rMBacgCqzqZLZSUpbSYiJATvpYuibJ0iZa2it9f2I5hpUMVWDPehG20av
         1GDiiYY8FhBHaqhMYn0HMyWpzYNB6XfCqzAr4yEVH2P/yiHePWZaYE2BQspxRdgih+qK
         KyXSGDUtvL4y3cOMzf/TtVr7F9GrTd8iE5AEEIL8tKfCldWJz3C7kfssji9UfnUoCopq
         xh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108074; x=1685700074;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbPuljT+8ut57Ai6k+RnXng5Lpx1baVSAqTyas5OL7g=;
        b=ig0ygyaiBf1M6LDOJXUrTTx3L2bzdv6xoS68YL1QyeMUdBu/Qs8Im+winb3LGhV6xC
         SC6dKCsieS3ncLMKJJW7xvx/y8EuAn8q3dBlLziFlBmW+Ax8Qm/BPAaQixW3RIBvNtRx
         fX/Qm4PC2vqbFlmPB+TXZfDp9yKN4HQNjZwu6parbGndly3wbD2+E2nUAP0AV7ReVlw3
         xDZJLzF2TU3ZFNDzRHOiZdYjvahLq3a3xZegf+5s+5duHLOjBYu9UVn4qNfTSzRVDiNc
         uBORfHgQM758jO6u5ZeBgYxf89CHQbKzdijh6fC4bpNjTpkz3EhcY6EXc9IR3bcN+t4p
         H1Pg==
X-Gm-Message-State: AC+VfDyGjxi1e4vY6pAYa74/65AR9pISxw8hepfaVKvyMncTqZ7M46KH
	8O8p+oXiFn6pArLXqHXaGzq2NrmkBMnE4oKw9U0=
X-Google-Smtp-Source: ACHHUZ48uKGFmNxJQt6aSMC6TzMAonIosjv3dwSCI3DnIhCd5XqtHLDiWYjhwlDXTCKmwaS3teDA/w==
X-Received: by 2002:a17:90b:1bc4:b0:24b:290a:fb2e with SMTP id oa4-20020a17090b1bc400b0024b290afb2emr20493902pjb.36.1683108074090;
        Wed, 03 May 2023 03:01:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902690c00b001a6a6169d45sm21351165plk.168.2023.05.03.03.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 03:01:13 -0700 (PDT)
Message-ID: <645230e9.170a0220.eb12a.aef5@mx.google.com>
Date: Wed, 03 May 2023 03:01:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-gb629b961cbe6
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-ipc: 5 runs,
 1 regressions (v4.4-st20-1186-gb629b961cbe6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 10:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11394

cip/linux-4.4.y-st-rc ltp-ipc: 5 runs, 1 regressions (v4.4-st20-1186-gb629b=
961cbe6)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-gb629b961cbe6/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1186-gb629b961cbe6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b629b961cbe64f7960f450588400468813a5f85c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ec58cf9bfb5588e6f831ee55aa6b10ebd790a826 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6452238fd19a8414872e85f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230421.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6452238fd19a8414872e85=
f9
        failing since 5 days (last pass: v4.4-st20-1097-g52d843097a439, fir=
st fail: v4.4-st20-1186-g2516b357b2e3a) =

 =20

