Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7B9C77B7F
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 15:52:30 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.23644.1683129148028458433
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 08:52:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=WGvOzDbf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-63b5465fc13so4051623b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683129147; x=1685721147;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=geS31j2Dow4afRv0PLwl2sC9An7fVXhnDU6jby2IJGw=;
        b=WGvOzDbf6otVAoZo4fCHYYnwYMGmNufA7aQZZFtfMb+lroBhzGz/NbKEqnqGRWeI/g
         kZzNE+AvG1r3XRwC/kVuEZGEWmbO/lx3ASyyd8RyD+yLv3SF+9b2c/iMDibqyexwDXcR
         ZvvRVtIswlquObcAAEQG1AETRZFhAVgUgGsdhJScoKzuJgja22v5ctIE5MmwPmi9v7h1
         KpsghuNNV0wsVIkDoqrCQNXfYu3dYtmnQUMFasgJC7xV4UNtdhWVzt5SAV3TffFMRKDW
         GUT4SNJQt7ungy8/ie2XMRNRk5SoAvka6CzmiCo+emZwLTQvoDi80t29sgxwysHFTdBA
         oRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683129147; x=1685721147;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geS31j2Dow4afRv0PLwl2sC9An7fVXhnDU6jby2IJGw=;
        b=YwVIkUM66o8CqiaUG/4ExYv2XQLXKe+QPA5XtFWkyL60weEl7/DIknEd+sh39pgibe
         8Mb+dB5HWoUjW0LHo0w50uNslB2uGFOHPY3mABReAKUJZlPGvpKbrhqYlgQAZd/vMIia
         0yRErVHwJD8q6tfTujlJQlk+JI6kzbhy/FiJFV5RpIj4/DPRDGNfthAi1/LvDCWp9qo6
         uRlLI/lGm/liwUM28CF7EY05UvMG4QzIoj0h17sHI6JeRu8mzNetEoybemhbPbeaNOaD
         Vri9rC2M8qDEk7cLG4caMrj6/YyufIBvzJ6QG8ilEKVHykbslfbWoledOyEd1sgNRVQ7
         1LSw==
X-Gm-Message-State: AC+VfDzDnFtHAZ6CGUZLWfk1qjvF/R5Y1v5wD20dpB1pXLk61+z2Ik24
	7E21+DKlmW79QMgELlqRHqrN7KgNJ6+evqkFgQUk9w==
X-Google-Smtp-Source: ACHHUZ7xQpmNE2EtukLJwLRFxNlCgalP0kgF4LlRSjvtcmhbemLnmZI9H+U7NhAO8/fLX20iwkFYpw==
X-Received: by 2002:a05:6a00:15c4:b0:63d:24c0:1223 with SMTP id o4-20020a056a0015c400b0063d24c01223mr30612956pfu.29.1683129147017;
        Wed, 03 May 2023 08:52:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t40-20020a056a0013a800b0063d29df1589sm23828583pfg.136.2023.05.03.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:52:25 -0700 (PDT)
Message-ID: <64528339.050a0220.5d8a2.0c30@mx.google.com>
Date: Wed, 03 May 2023 08:52:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.302-cip72-372-ga3bc58e64f55
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip72-372-ga3bc58e64f55)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 15:52:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11406

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip72-372-ga3b=
c58e64f55)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-372-ga3bc58e64f55/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-372-ga3bc58e64f55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a3bc58e64f55aa72a4c70a5e27ee369c025756dd

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


  Details:     https://kernelci.org/test/plan/id/645276589fcba6a0c92e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230421.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/645276589fcba6a0c92e85=
e9
        failing since 293 days (last pass: v4.4.302-cip69-296-g52de9431d314=
, first fail: v4.4.302-cip69-508-gd887d54a1be6) =

 =20

