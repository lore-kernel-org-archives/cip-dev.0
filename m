Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C4EC38147
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 16:35:34 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.20565.1674059730686451283
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 08:35:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=yaEcJTsS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id c26so22196467pfp.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CCbN6AhWRhzhbPbyUH54eHkjkhvy7RBcdaJJB17zR0k=;
        b=yaEcJTsSBnPu0ddQr1/mO0hVwuLjm+vRugMWnZKXyKK0o+vCG7HQsWVyOY7tIkiTQz
         pU1G9VTD1jER8T+YqqyLiy9g/ZfovYajG4InGwcvQw6UYQH2JbNjkz9RtyxiLIhivmEY
         pWjd6gXfaVnKJT7kRe4J6lka5wjZr2yupR3ssiGzVGZpe7ipwAe11mkzAjtz9qNyrY0c
         R1BLelSQnpXJXHXDqA8O79mjiQTxaEAXq2Ns1wmBX/9GuXJcDXY4OLEA2OvwOh+EB2v/
         QbbRfJIYo1cmqmoQfe152He5WiR+NeSIeUiRwopuZjUkcxLbm+1GuiQ2tu7MYNm9ECNw
         TAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCbN6AhWRhzhbPbyUH54eHkjkhvy7RBcdaJJB17zR0k=;
        b=oTkvDynBR8066Nku7XyZ6qtyLWOfw4ZOCrWElgGuu/BAvAmlHbACkqDMolQ2RcEcDC
         t27lh5PBxI2p12jfGPjLoy7sffjMdBEZCFmuZRIEI3sBUgMw4yPo/I15F+3ZztIzeCFk
         QOeq0lM17UP44eker4J+j6Wj4wDJhCO24R1Vsodk8ZLhu0Up69+e4KLeypRfNkl5BXGO
         dy4cM1TWcVSEMxpu/b9aenGfUFmkwsVUP5xKBTVdza7rlW+mO/cRh2SAQk9PmLPdZT1w
         xv0+gd3W50ciuIEzhNQh7qfscblHxDgMh4Jh5i7xppP+Af2twyNtPiaCpxYNuaQi6eYi
         lvtg==
X-Gm-Message-State: AFqh2krMU8Wu8VhRYvJGqR9rE8BAFPVVR8A7bfrLAuiDp/zOGFdX3utO
	+WDGE4UACp8BkBB200bCPGJL5bzsod5LPP6AXTCafg==
X-Google-Smtp-Source: AMrXdXu7rUUIxpgqTRddYHc1JGZbLxw2VPdAxXHbDn2tNk9x7L/jMkw8PXh1MUsl1/BfkJ4g202wnA==
X-Received: by 2002:a62:fb12:0:b0:576:65f5:c60a with SMTP id x18-20020a62fb12000000b0057665f5c60amr7536317pfm.27.1674059729917;
        Wed, 18 Jan 2023 08:35:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x186-20020a6231c3000000b0058bcb42dd1asm7917136pfx.111.2023.01.18.08.35.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:35:29 -0800 (PST)
Message-ID: <63c81fd1.620a0220.6f495.ca8d@mx.google.com>
Date: Wed, 18 Jan 2023 08:35:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-853-g709bb3738fde
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs,
 1 regressions (v5.10.162-cip24-853-g709bb3738fde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 16:35:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10396

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs, 1 regre=
ssions (v5.10.162-cip24-853-g709bb3738fde)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-853-g709bb3738fde/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-853-g709bb3738fde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      709bb3738fde9ab95ab1303d161730f508a6659e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63c80c0ff697061a0e915ecf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/63c80c0ff69706=
1a0e915ed0
        new failure (last pass: v5.10.162-cip24-788-g63c30712099cf) =

 =20

