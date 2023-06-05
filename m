Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8101C7EE25
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 18:37:44 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.16988.1685990258072116662
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 11:37:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=BLSeeDjs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-652328c18d5so2454072b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685990257; x=1688582257;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfs3qMCvHDFCMlAbxx5YHUB5Ovyl7lH0g1xhJS5uU2c=;
        b=BLSeeDjsXbA8vjewS9gQ4ennMeuLKU4NJJtipU55sxxoJ5ee1zuTrKnHzvEhofXZh2
         PuHWS0g17atyxn6IGU0ojCPuytm3j1COhberoGwWd7VS+JNIU/nigbuLSgCsKlDD+iwp
         AaprSNVq3ftI3Q5hIxYsbalwKhphzo975oXGORUfcjtvVC31dVlO7Yic8Iyvwcjbs4ws
         H6W0ipte11E6P91Zw+n+BiS+LmSzWOnv5LPgShcFDcKwYlV2up088/nmmc0gLRyUxMjH
         ON6pNR4fJz5kGUoKUDr+r3D9pqYdbKwLKiTIKD/e1U1u+dtQmwWqsqyqi9NFmUEkmQK6
         z0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685990257; x=1688582257;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zfs3qMCvHDFCMlAbxx5YHUB5Ovyl7lH0g1xhJS5uU2c=;
        b=N//W/pXDKDDPEDa6YSH4QubHuRyixN6AgFXGDoZ5s75w0u66+jIQWf7NOpMYXhArqX
         pddXgsDQt2kIsR+jfqtqn3PVq3rJthI1m6WqFJmiXqQ2vS0mdvm/KlgIxEnXx0HdspF/
         vz4vTnBSja3wBaJGkC9DE7+NCR1zBybhK5JMLlTw8N/T+GW+xG66+yX9/okdlMUMs0g5
         QhUZb5RPc4sMkYyiVAzzZGMY4e3mq0dETMKuBLGOoE4cIRJW6rRfKhgVdtolqLkJowI/
         mAIVlhbY5luu7if4iaDOtfhwGK3r/UIt95zoh8Nh0gAcmF2ezDcSyVwQ+ch6ennQK/V5
         xLzw==
X-Gm-Message-State: AC+VfDyeh99Jv1EXKzv5bCT2K74YuvwH17RQl7jytWM+x5K883NOcl0U
	uCYh3r5DDFmPznLmuhrxUJAFlxi8bzk7x82CoEpsFg==
X-Google-Smtp-Source: ACHHUZ4nN65xQFPsmEwDAUi8fz0jcw4bqltVjLgf7ZRuHlmxWmiT2klTbqZqdlC83CEOOoUOmqrHlw==
X-Received: by 2002:a05:6a00:1a50:b0:65b:351a:e70a with SMTP id h16-20020a056a001a5000b0065b351ae70amr526800pfv.29.1685990256941;
        Mon, 05 Jun 2023 11:37:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t15-20020a62ea0f000000b006439ad979cbsm5444822pfh.152.2023.06.05.11.37.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:37:36 -0700 (PDT)
Message-ID: <647e2b70.620a0220.85ed9.a03b@mx.google.com>
Date: Mon, 05 Jun 2023 11:37:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-gc198172c84b6a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 16 runs,
 1 regressions (v5.10.180-cip34-26-gc198172c84b6a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 18:37:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11820

cip-gitlab/ci/pavel/linux-test ltp-ipc: 16 runs, 1 regressions (v5.10.180-c=
ip34-26-gc198172c84b6a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip34-26-gc198172c84b6a/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip34-26-gc198172c84b6a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c198172c84b6a9338925de15df053d71eda6a6cc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1db168eebc16c4f5df91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-ipc-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-ipc-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/647e1db168eebc16c4f5df=
92
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =20

