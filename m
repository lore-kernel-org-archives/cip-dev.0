Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68550C7EE2C
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 04:26:30 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.241.1685939182312036017
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 21:26:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=057hY4r3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b0424c5137so38258665ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685939181; x=1688531181;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xBue9EYUY8tCAyVvp3eEEU+BJ0QmMOWPeeIru+CJBAY=;
        b=057hY4r3bJIPXTcRzq6me/WXwlvcJ+haqsaGubtF5meKmZkaughhZWrWuJOp6MI1Gl
         g/pJiIJsorZGkzjhj9wgXa09NG8mFLAKy9pmJByViHiHJkTP0nyeGqaBIRE9Ym0sqzxh
         SrAxsl+ExGsfwgoLUNLmqcTN7sxTbUJ4uUpvnWXrLl7GF5Djz86su4E0rMg684gsKb14
         TJoxGX3/40eN3YVQQ3GnooJbP0T0V7fAMPmCVv6QjC8UK5eGJ18Sn1NI9yqVOigmTGxI
         7ykkZ+gqejCQiLmHRH3uar4afWf6qxvF6/0Uua09PBL3dvmwKcC2D47fifEeKX/e0AFn
         7Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685939181; x=1688531181;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBue9EYUY8tCAyVvp3eEEU+BJ0QmMOWPeeIru+CJBAY=;
        b=iZwWHRueAzO60aJZtmtNXzPPMOL7Rv2t5T8/OXg764/UHljXGokOb0dWBOKx8A5E35
         0o2mlAoCAPO4rvu6h1uL3eGyso6ZRB6IEvLgqPrZlFX+11rgTh7pYtm9LYx2OdgdidIA
         cYTytSK7azasb/ZMhLovQlPzeCDhoeoVFYPoaP7zkqCNLqnQVrfAlEGrqgoa/w8D5gtR
         yz3QzvUr+B7urXmWp87XexRayqOjajDM8o9LCrzfg+oFbLxXxWrAxypur2HBboXeymSt
         2meTzRkKXh1MEtlpaLgxcVOG7WABsAklI4C80ZHN5Fb54oaw6x/3llkwEv6XbK9S/fc8
         ZvTw==
X-Gm-Message-State: AC+VfDzFL0Fr9/NZrrkeNDFkcagQoSkE8zdrgTw5psroYcPc8CylKF/F
	YupTVjEQtriwOCCA5oTOlxNk9YjxmsQZuoHgJ7gmKg==
X-Google-Smtp-Source: ACHHUZ52g67tCoNv2QLbrjCt+yaMuv/JCmHCEsmClwzrk1LaT/k6z5LYqFpbhzL7JkFf3Js90iaodg==
X-Received: by 2002:a17:903:11c5:b0:1ae:8595:153 with SMTP id q5-20020a17090311c500b001ae85950153mr8283882plh.20.1685939181391;
        Sun, 04 Jun 2023 21:26:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902788200b001ac95be5081sm5357481pll.307.2023.06.04.21.26.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:26:20 -0700 (PDT)
Message-ID: <647d63ec.170a0220.ae816.950b@mx.google.com>
Date: Sun, 04 Jun 2023 21:26:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gae79bc689058c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 7 runs,
 1 regressions (v5.10.180-cip34-19-gae79bc689058c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 04:26:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11774

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 7 runs, 1 regressions (v=
5.10.180-cip34-19-gae79bc689058c)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-19-gae79bc689058c/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-19-gae79bc689058c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ae79bc689058cc27e73e1cde11fdc558c96a2889

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d5b6d12a70f741bf5de84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/647d5b6d12a70f741bf5de85
        new failure (last pass: v5.10.180-cip34-213-g6582dd41d2c22) =

 =20

