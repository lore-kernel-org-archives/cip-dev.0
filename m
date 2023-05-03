Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52782C7EE26
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 10:01:19 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.15120.1683108077111568250
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 03:01:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=oCXzGaQ8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-64115e652eeso3576357b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683108076; x=1685700076;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KzFx8PH1dQ7WC+RrGtjF/S5kf1fKNTMZm5tGzVVTx/s=;
        b=oCXzGaQ8e45qpUXulDjkUUCJZJGr2aJ9uEnIl0b9qxyQpHDXUlvLaFARHfmLFhivf1
         TVczE3bJ5aD/tOdrVU7o/TybMum/+Nb3ewmv7z8CX3+XZgQEW3Dnqwh/2GHrF3fFG0Mb
         6gXx71NQunOu0vbjAG517uyr+9vfDfgtlYPEUyUBA+zUr6klO+jBjFyuGoE3B5uN9CG1
         N3JnN5JB89gnxoKkHuf4hRxS7qPRuTBAtgHL+ADPIdkwC+f+ef8HuQC7WvS6ks/sLC3r
         yiw2neV/dZjGONmozloNKujBXeza78sA8v3C8BX8GLmjTao6EI6ur9Ob0Q0xfKoIicl/
         zaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108076; x=1685700076;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzFx8PH1dQ7WC+RrGtjF/S5kf1fKNTMZm5tGzVVTx/s=;
        b=P6CdGo0GQr0Vjzz/okkpL7ARa3CGNAXpSrPC9YSL26qnlfaQhYVgbgSH7p/bvvKHzk
         2wgP3nOziXvOBZD/fbOAY8cbPSTcZEblmAqJjX/asvCm6yIWfGD4rV+Od3TCxXgaqfVY
         nTa9cQ0RKTLzsndib41lwvAsPrWQIf5MPYqnr1ZYgnLrJ6TQDqmAXiuGq1jSZeYNRur5
         tuO+vJM0WsDNb6yHj8aH+NyXBPI0go+BreZDnprVVJMfFXkghzZuwTor3cXsZu8bshxW
         ZIdM9oz5onX+rgUs+ahZU3jdskRYt5fCSruqvZ7s00xgDszjIjjzzZ9UmNs9R3h0olcw
         /KUA==
X-Gm-Message-State: AC+VfDy9KUgUsn0UA3SsV+ovuMmuytm1O9nbjB36T+mWjcFons0FTGHZ
	/J+FCGZogW/6TxMPBb2pIc0gJgY4RzTFV1HRAOI=
X-Google-Smtp-Source: ACHHUZ7KJd7I9D7NIu/ClN3YQwSrZ2KHTHbrLKqWaBEvp7H3bqcqEHEM3m9CZsobqMqtY5GECdUpsw==
X-Received: by 2002:a05:6a00:2e1d:b0:63b:87fd:a705 with SMTP id fc29-20020a056a002e1d00b0063b87fda705mr1475519pfb.10.1683108076079;
        Wed, 03 May 2023 03:01:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78d17000000b006414b2c9efasm6925267pfe.123.2023.05.03.03.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 03:01:15 -0700 (PDT)
Message-ID: <645230eb.a70a0220.7980.cc48@mx.google.com>
Date: Wed, 03 May 2023 03:01:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-gb629b961cbe6
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-timers: 8 runs,
 1 regressions (v4.4-st20-1186-gb629b961cbe6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 10:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11396

cip/linux-4.4.y-st-rc ltp-timers: 8 runs, 1 regressions (v4.4-st20-1186-gb6=
29b961cbe6)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-gb629b961cbe6/plan/ltp-timers/

  Test:     ltp-timers
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


  Details:     https://kernelci.org/test/plan/id/645223fb4634e204932e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230421.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/645223fb4634e204932=
e85e7
        failing since 29 days (last pass: v4.4-st20-1097-gd51b0e04681f, fir=
st fail: v4.4-st20-1097-g52d843097a439) =

 =20

