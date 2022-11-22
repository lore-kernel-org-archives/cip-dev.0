Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77A8C4332F
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 12:01:39 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.16807.1669118490056075115
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 04:01:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=p/sEnGop;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id g62so14150783pfb.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 04:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pqX/T8jqIkfXRaAi8c+9jqzzpFEvA1WmkcccdpTYCkE=;
        b=p/sEnGopuS9Kc9iMxv4paVoveINUBegH/ThLaHuKvSdaE7h2u7Q3edl7xwVoQxcDG5
         MLBl7BNmMG6rdlKnfuFyJSBwhjD69nTl4uN7xeUq6AqIXvh0tfYyhCo6rWSNBupyOtot
         Zlzc4zVJs459qsUfLHxKvWxlrH2rXacRsDgSrqZPnQtxGR03nKD+pJ+SFOfAUHSBrRGI
         ZnJWclVWEB1tFaPpilEzXgXPsREU/RID3q448gkqXcZodRwY1RukT8I0dfvrvXuAp6yw
         77R46sW4ytUDdwIRVM442BPG7eRED1CcfEFbNcizpX3bC/RuGJYllFSu1stooDU438KZ
         7NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqX/T8jqIkfXRaAi8c+9jqzzpFEvA1WmkcccdpTYCkE=;
        b=YN1tMSq8Scn/LCGCCF8lW9xBXuJJSu+210mU/7Nh5HmcUYnoXt06a6MS2/LqkqJUBa
         XxxT9dXsAPiZk8qPAMeKgLM1WlRnlcdojDtuYqKgUEt7SfbVihVfNXt1f5NMtNnSgnqi
         XObFR6UOeojwfpPEbd7OiGUQC76p0tRuGp8sCqAVv3zo20TN40Ksi0AlKNoL6Oq0upxS
         zY0OAKuBTAUDDL3AEUNXQg6R0lDMmfhyY1zLWLO8y/xTIGeMrLImnkB7H9x5zb4JDkHH
         S7mwjsV4h74ZKRUQhbhPPux872Wq7Fhyq0B6pPQLIAOcTt7DvUybKXISruHMPIyTtUj4
         i8dw==
X-Gm-Message-State: ANoB5pkmtl8+96pihn5tmFqDnLMyBbOUa5uhV0XkDM+Aebj4F//q+9Vf
	6ubt+j/D28XUJjFxNkmMtg7SgvRF4TDCkZwYs1s=
X-Google-Smtp-Source: AA0mqf42IA91odmOfIwIgRr+Io0kCPD+i9ZweeoFDMPDkeMlYt0R7B82GwBVm2ChcWmNw4guhTXKiw==
X-Received: by 2002:a62:9409:0:b0:562:e571:3f0e with SMTP id m9-20020a629409000000b00562e5713f0emr6858413pfe.72.1669118493531;
        Tue, 22 Nov 2022 04:01:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b00186e34524e3sm11714119pln.136.2022.11.22.04.01.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:01:32 -0800 (PST)
Message-ID: <637cba1c.170a0220.b0ccf.17ff@mx.google.com>
Date: Tue, 22 Nov 2022 04:01:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs,
 1 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 12:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10085

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4.302-cip70-2=
36-g69445bc0d4209)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-236-g69445bc0d4209/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cb21dd25a848bba2abd06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/637cb21dd25a848bba2abd07
        new failure (last pass: v4.19.265-cip85-rt27) =

 =20

