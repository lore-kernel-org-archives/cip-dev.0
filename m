Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63875C47077
	for <webhook@archiver.kernel.org>; Tue, 16 Jan 2024 04:45:12 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web10.4746.1705380303614833711
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 15 Jan 2024 20:45:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PGCncizK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.169, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bd7804c014so795010b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 15 Jan 2024 20:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705380302; x=1705985102; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QS1kvRTBjI1hwYa6xOg6PrR8lYjm2KgHMA6AD7IhWhk=;
        b=PGCncizKjAP7aMkh0KFbl8kRwRA/NL8ttIyiQN3sWi3uTNUI8oEZJS+K/i6XcwAMjI
         XftteizMKz8SqCwcwtoaWB9WQXJVh3OT408Bh3r/z29y4nEWz+zlFC9SPQVb5WcvYjh8
         tzbKeFBtra5bKKKAsBNx0BSZB0HOawDfPG5iKJCyc9BiBn4J2/KG2L+WCZqh4oTqZAC+
         tEV2MrbdxD0MlxYh6EnjCBDWJsn/gFCWYJ7R81FzhubccCYJr72zOrhFzZLNogY3qyaU
         jywf4ouw1OmDnpJj4vN5g7b9aHn4eaLaoYH6y6sdLNLkv2d5fyB4yjW7ck3tkt/Q7jT5
         Jwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705380302; x=1705985102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QS1kvRTBjI1hwYa6xOg6PrR8lYjm2KgHMA6AD7IhWhk=;
        b=kbtx6SLs7HLLtvrxBHovrdt7HID1AVpryBDBg24SwW1IrY8h8R/giE/Og4s10hbm6d
         g4RYh8n8E9KjOpLCwX0a5eiwWBHOXZ2wqmxZGPK7MUobS1/Up0qTgb50pwp6GYpQEkzu
         Mvx1p/lgcBvTZHrDv9gyAGD35ejsTsE4K+xyIPO4sqMkqM2W99F5fzU2TX8S2yY/zOp/
         /yWabx89euf1FOkxR0kPA6z5hevVhjerP4HiaQqmi7TEgohidOy4ksU0LgFfpDz3Uxp+
         uXWl/K1so/CnmE/dzbwHXjsz7g3PSC9kyI5HTYLY35/tCzc01eysb1Cc7qTGxhuekdKS
         6e0A==
X-Gm-Message-State: AOJu0YwTcIEpQcCqJQuv1IPJoTFGa1fTnTJc6y7GGIFtOewzReUxKihP
	84MZm5WcG0Y6SqBBEgTvItC5nWG6XaAJXq88c8iZWpd/DrcGNA==
X-Google-Smtp-Source: AGHT+IF3gfAg4U3VZj1w7Eva7JFxxGET/mmDkeFP2Pg+SdGAp5zgQLy2dDoXxpqGxuJ7pua/xpf99g==
X-Received: by 2002:a05:6808:17a1:b0:3bb:cfcc:39f2 with SMTP id bg33-20020a05680817a100b003bbcfcc39f2mr7860465oib.89.1705380302373;
        Mon, 15 Jan 2024 20:45:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k2-20020aa78202000000b006da8f6650a2sm8359955pfi.155.2024.01.15.20.45.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 20:45:01 -0800 (PST)
Message-ID: <65a609cd.a70a0220.982c1.af7e@mx.google.com>
Date: Mon, 15 Jan 2024 20:45:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.304-cip106-27-gf3e967c370d44
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs,
 2 regressions (v4.19.304-cip106-27-gf3e967c370d44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jan 2024 04:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14393

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs, 2 regression=
s (v4.19.304-cip106-27-gf3e967c370d44)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.304-cip106-27-gf3e967c370d44/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.304-cip106-27-gf3e967c370d44
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f3e967c370d44f37d5b1b2cc02e9898573c4a4ee

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a602cc743e687cda52a406

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-27-gf3e967c370d44/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-27-gf3e967c370d44/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65a602cc743e687cda5=
2a407
        failing since 7 days (last pass: v4.19.299-cip105-158-g856c181dce34=
2, first fail: v4.19.299-cip105-289-gad0914f265af) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a60537f5cfd3dee552a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-27-gf3e967c370d44/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-27-gf3e967c370d44/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65a60537f5cfd3dee55=
2a3f2
        failing since 7 days (last pass: v4.19.299-cip105-158-g856c181dce34=
2, first fail: v4.19.299-cip105-289-gad0914f265af) =

 =20

