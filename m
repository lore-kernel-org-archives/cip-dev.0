Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B76C43217
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:37:57 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.298.1668033471355326731
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:37:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=CX6fHs2X;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id b185so63523pfb.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6HWjnJBbJucWEa9TOrBc3QcstFodiCXsVHXyewHpuXA=;
        b=CX6fHs2XLlZN4ENJFmzpmn/9o2jCPegQrAsNX4C1THxfhqzI4bHt9+BVgHgYmyzcCO
         Buj6MXE2n8z9IQUPDIYyA+TdY4Vd+0fdMXOcM3JL635INss8CWe22FLwDt6xmZjhjeyu
         VMlYw28PB4v4t4kHfuCEQf5+o97IWxQ0nHNtAVfq52zCxPbxMGmwcKa4mCFvm/SwO/SU
         rc2sUAedw64VKm+idZewTPrYHTSrdxGXraas1hN2wDpemBAka1bsYs7s8KJDqks0GVR4
         3Rp5xoJ41nNqC3DIWoxVPsdM3LXTfZA3bWQcwV4nOWiG+uXgoHsc1jg011/MGwFp52Il
         NcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HWjnJBbJucWEa9TOrBc3QcstFodiCXsVHXyewHpuXA=;
        b=2jrjmZ9+SASRN9Vfo91JSqjt4PyIkkXMFLeKIZoktncA34iQjAFdpeyPQFa/NfmmEI
         Z+y9XbVw6D9UV3PNLCqV4VS73JIzBkO3mlQaWZY1k/bVuZE1J4XHX+ADJsI3+EoxbswU
         lKUOPTH3/cjvb/MrRiwTGAk+VY5hxNAELQ3RIF0S1soBtzn7YPfohSUiuycK9clgpkeC
         z6tSGUhI2AqAoFaT3Nd5y5N66TzhvpaB7rMHNSZZh0+kpYlupNmUd5/1j6whm1pdvRE+
         pcLymzx56Zq+MSDXlWzg2nkk/ZFXKPPTWh6ePj27vcpe8vyNT/Hi81KrRGF2ubZnuotz
         eQ7Q==
X-Gm-Message-State: ACrzQf0LZ5fEZuLw8Q6qANDB5q/PBkWBbd7jAeHXucLMVDmVFT+CdL3V
	8wBk3o1CTkmakWeyfyKJrJ6ttH94ryUuFH/gGbw=
X-Google-Smtp-Source: AMsMyM5b7ZZTB/jiR8Z+DaITGyRWyoSXm8CaWkH6mXyZyhBftogYebynAfMA0yGi3Q8rujpmy+mfhw==
X-Received: by 2002:a05:6a00:b89:b0:56d:2a21:a6b3 with SMTP id g9-20020a056a000b8900b0056d2a21a6b3mr58339580pfj.56.1668033470608;
        Wed, 09 Nov 2022 14:37:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b004388ba7e5a9sm8011941pgk.49.2022.11.09.14.37.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:37:50 -0800 (PST)
Message-ID: <636c2bbe.630a0220.f7e9a.d91b@mx.google.com>
Date: Wed, 09 Nov 2022 14:37:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-rt74-1329-ga59fc50f38f6
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 6 runs,
 1 regressions (v5.10.145-rt74-1329-ga59fc50f38f6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:37:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9983

cip-gitlab/ci/pavel/linux-test ltp-mm: 6 runs, 1 regressions (v5.10.145-rt7=
4-1329-ga59fc50f38f6)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-rt74-1329-ga59fc50f38f6/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-rt74-1329-ga59fc50f38f6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a59fc50f38f6208d7d36629eb501bf5191bde812

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636c21b5552c808219e7db69

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/636c21b5552c808219e7db6a
        new failure (last pass: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

