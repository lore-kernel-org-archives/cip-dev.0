Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CA3C7EE2F
	for <webhook@archiver.kernel.org>; Wed, 31 May 2023 10:25:22 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.10743.1685528713765048106
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 May 2023 03:25:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=kLVyBaea;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b04706c974so26414365ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 May 2023 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685528713; x=1688120713;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D6mwTg27KW1saXruOYOCyM7StmGOyUvjxIE/gg4f3rA=;
        b=kLVyBaeaeK3Ghslv1LaDFWS9hUoNwICwm1Uwu/7SOe5qR+u/4mqr+KwNk+NDBhmSHc
         QgMSxN2eUGqPzjgLrchGPhPPxyLs4hDb8bKWe7xZGJMPgJsbabLAOXkQC9iIEy30uk0e
         OoHXHidC5g2b9VjrlUh7GxrBJXAVB1/zpHk6jn/UAmQgkuawDXjkClKYKR7LTwbTtwWl
         dQX3pvwx89ZCaEvxw1UGP5Oask/qSm1a4QkUbfcAG4OAN4ALns4pAYhdVZcbsaqnz05z
         jjx75OBE1t5PYT2gP4+FAfT8YtXbZSax+B76+MAwlEvFV9qe/n4cIr+3xwBuuCs9Uzsx
         0qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685528713; x=1688120713;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6mwTg27KW1saXruOYOCyM7StmGOyUvjxIE/gg4f3rA=;
        b=f4SbZ8GOCUxGKtUn9tLzCmTqkluVkg87ERaBXLsTZc4ESvXgTQ3TsrXVfgW9vMpxz0
         G8pFNyd2XrwmQsPnwU2qg7wxkBgonfnzIPhmgpPnUN+pl08r4I+10lBjc3tjj06UlNxI
         apH17TQ+HJRXZWVdeBTJTWRhhpGdYrio+j08noNy78/4bAlslKQq2UywmiACkxz3L6C4
         i1FMrEaV9rgcTBjvzd9ENP8hr65/fplYdXkkPZ5YxO2881vd26r8yNbkqqMlnnYRU/1M
         X9NM+Ud+J04v/Z80tNKOt1xeHW+06dJhXG0CY7N8WueoljSss9dWd52nGavSmQ2Z4Wyn
         YGSA==
X-Gm-Message-State: AC+VfDwq2ep6o842auvw/i3P//R8L23nzgvcYrWAFMa3NlZKd3SqmQB3
	ZyNrBXwa1RUdZrFf6R9tlBVGG/fvOiNHLKaLs78EHA==
X-Google-Smtp-Source: ACHHUZ7K5XEPmaeoQ+QVU3KPEEqqLH8x1DCPg+GRU9QkpNGTGFLGq1sMvLqWPKbghjQpL2ujiZEY9A==
X-Received: by 2002:a17:902:e5cc:b0:1b0:3742:e732 with SMTP id u12-20020a170902e5cc00b001b03742e732mr5866159plf.23.1685528712814;
        Wed, 31 May 2023 03:25:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b001a980a23802sm1007311pln.111.2023.05.31.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 03:25:12 -0700 (PDT)
Message-ID: <64772088.170a0220.4b0f3.18d1@mx.google.com>
Date: Wed, 31 May 2023 03:25:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1307-g20af3740f4fc
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-ipc: 5 runs,
 1 regressions (v4.4-st20-1307-g20af3740f4fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 May 2023 10:25:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11712

cip/linux-4.4.y-st-rc ltp-ipc: 5 runs, 1 regressions (v4.4-st20-1307-g20af3=
740f4fc)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1307-g20af3740f4fc/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1307-g20af3740f4fc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      20af3740f4fcb1ef7c5d829654de94824a2d493f

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


  Details:     https://kernelci.org/test/plan/id/6477117d71a09341aa2e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6477117d71a09341aa2e85=
ea
        failing since 34 days (last pass: v4.4-st20-1097-g52d843097a439, fi=
rst fail: v4.4-st20-1186-g2516b357b2e3a) =

 =20

