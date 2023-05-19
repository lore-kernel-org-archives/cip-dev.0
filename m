Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EA1C7EE2D
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 15:12:09 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.28880.1684509127936368800
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 08:12:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=HqJBdt3A;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso1102264b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684509127; x=1687101127;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MBg0vrV51hUsg1+cGU5jQ8eVUJ7JYg/tBESKiARX3Fs=;
        b=HqJBdt3AaBJM+/OQlgXl+VDWTzNgw7eWqNW1Ze7zw09/Esf9vcCjRD6NHhW5g+jLbf
         VssxLMx3eNGI5QiV2rztss0xJQ4CPdTM3b5L6X1ysCRTRD5u9+A5trOObW5Z/MA/nUKP
         1l/wTUe/OpOCaCV2CIvjaJaX6FEiLkNWmdfrOCAgItytu4DJGyNOpnEmLS6gaOMY9M8E
         n2ghfU2YF5uJjr3gdJml25hhy0ZJ8Y42fMV2EeyfVZGlaXnYnYJK+sBzbzWloaImqrJ7
         qv6o7Kltz4u3bkoCWJfBfF5dFqrdtOzD8oeU9548itUzcdsKR7ujt7He+e2VeS9vAMFA
         BV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509127; x=1687101127;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBg0vrV51hUsg1+cGU5jQ8eVUJ7JYg/tBESKiARX3Fs=;
        b=U9d7IK7E/6A6ybmCk9gZCVcYRFh+A1M08n78aWX9/Ar/F86pDDe7BY6Hkrx45XydAU
         NqV/I5TF6vwoGE3pvXW1x2VEQbkUHg7M6n3uTb2cvZGIj/2tGvnzORq4aooCJHCyS/vj
         iyQ5VueuahKLtepXMwVOCETHiSQR51cAZ/lQwg4inrWdeQZqoAX4L/xwjflX2dqPRPMh
         7J0HFOC7F9dB3Xu0rpdAJfk91RorkrkFsE9OexFIsQ/wEypNalRc3k62/kwG5lY1TZAt
         1BEQSyXdKB6X3Zu27YYH2SJg5n43g6v31eps/CPK8go0qEV3WG3O18zFP86IsxCBWusi
         EpVA==
X-Gm-Message-State: AC+VfDyz3JF8BsVce/vp1r/3z+/5n6UYSeLTn/xTQbbP5lX3b6vfzOdn
	zpz02L4Yvn9fxWWKCmhWPAX8xCTf2Hb61ZmO/BfjcQ==
X-Google-Smtp-Source: ACHHUZ7QfwRX7PonJjYMD9TlI9kMDuiZi0YTiJ3QUQZLjvpWGl5pIRdd1vN1LKDpE5fzXxXh4UPksg==
X-Received: by 2002:a05:6a00:24cc:b0:624:7c9a:c832 with SMTP id d12-20020a056a0024cc00b006247c9ac832mr3800654pfv.8.1684509126906;
        Fri, 19 May 2023 08:12:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x11-20020aa793ab000000b0064d32771fafsm1353032pff.97.2023.05.19.08.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:12:05 -0700 (PDT)
Message-ID: <646791c5.a70a0220.540fb.2783@mx.google.com>
Date: Fri, 19 May 2023 08:12:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 5 runs, 2 regressions (v5.10.180-cip33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 15:12:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11567

cip/linux-5.10.y-cip smc: 5 runs, 2 regressions (v5.10.180-cip33)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f6b02104eb287caf662ade9a67f11896ab01fde =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64678953941b895afd2e85ff

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64678953941b895afd=
2e860a
        failing since 319 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-05-19T14:35:42.337694  <8>[   14.494974] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64678953941b895afd=
2e860b
        failing since 319 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-05-19T14:35:42.324387  <8>[   14.481267] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

