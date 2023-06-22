Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A71FEB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 13:41:17 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.11600.1687441271705999724
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 22 Jun 2023 06:41:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=rj6dff8N;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b4fef08cfdso38698465ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 22 Jun 2023 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687441271; x=1690033271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wIhtCF+2bIU5OZrhhcx3B4LqCHYMW0Oi9grLA314xeQ=;
        b=rj6dff8N4ZKUrJJUGrAGMN6/JR3I5GWmuiWvLHevblMC3cJRmq9HyFduahsfI9NcK6
         WJAWlD7SOOWyCBrLqIcFR2NURjf84o1N1uFA+gCpvaDVTxz4axZnh/vkOSRajrAQwfoL
         Ht0bUcwz8+ytZYuUM91kKO6lpODH9BuVQw32JRJNy2yERJUy2Tg/gcLM6MvXkHllYHW8
         21fkF0o3bWSGCH8hpFq2bfWYVTUVYX/0QOhrixL/KRenv/vABSgQXEMc6Ciox5OfeX9L
         VLoGykY/wHXwTxHjSFbapQhOQAHUKU4tsptWEpFYiHbfH4Fv8rvN6+TZpcQNOgb2WY9w
         Ni+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441271; x=1690033271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIhtCF+2bIU5OZrhhcx3B4LqCHYMW0Oi9grLA314xeQ=;
        b=I4ULLNtNTil1ee3IKrNPiOVjhUWtbzBSoF6xHhJ17kKVkhchH6v7Hvu9/49gCtZ6gn
         J/T0iEC+FKt2Oq1ZbJjvhkNr4cs6ltCgOq6EGy0xRaRF42CcXgkqPDnlOWUCqYyRRwPA
         3crxMXKPNQ5gi+B+zc1AB/YDuSDaMlo2SIeOPAoflc0qE6mwCZY41DjrFVREy5l9q9M9
         YemPFhYRAKfg+q4s5+oG1fsxd4B5zKwWHL+SYP/LSH++n7QO6wWGHfjjR/RV5MZESvrH
         cTM9pzE1X+u6fsYzc+nJ4jcHGLUeW9afeRhR20QdEJylJud0j4QLTbrIqczVhQZIkRVf
         bpXQ==
X-Gm-Message-State: AC+VfDzZbrD+wP/qMmpk6FJVmTULGUtoTpkqLA8jm3jZYanopZH2QdoQ
	mY4VMsqbCThIi9sdiigttn3zljcJde/G+c0jEbHKdA==
X-Google-Smtp-Source: ACHHUZ4HQegFZYAHau34cZnV6naxBSw7EwsMQUxvrfHZYCWvaXYunl5g2fuUAgcDi0DMEijIPR+NAg==
X-Received: by 2002:a17:902:db0e:b0:1b6:9b29:bb1a with SMTP id m14-20020a170902db0e00b001b69b29bb1amr3326037plx.9.1687441270580;
        Thu, 22 Jun 2023 06:41:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jb22-20020a170903259600b001ac896ff65fsm5420574plb.129.2023.06.22.06.41.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:41:09 -0700 (PDT)
Message-ID: <64944f75.170a0220.7e48f.b873@mx.google.com>
Date: Thu, 22 Jun 2023 06:41:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-61-g32a95f5a4e3b
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 12 runs,
 1 regressions (v6.1.31-61-g32a95f5a4e3b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 13:41:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12130

cip-gitlab/ci/pavel/linux-test ltp-ipc: 12 runs, 1 regressions (v6.1.31-61-=
g32a95f5a4e3b)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.31-61-g32a95f5a4e3b/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.31-61-g32a95f5a4e3b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      32a95f5a4e3b66089d84743bbec9da44020328ba

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6494443ec45263ccdf30612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-=
gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-=
gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6494443ec45263ccdf3061=
30
        failing since 7 days (last pass: v6.1.26-1314-g1ab0ac1d7e2e3, first=
 fail: v5.10.182-cip35-8-g2391124f19a70) =

 =20

