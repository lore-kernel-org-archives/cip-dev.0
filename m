Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1675BC3DA40
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:50:56 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.12430.1686750655037613957
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:50:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=fsv4A1Ev;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-666669bb882so479295b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686750654; x=1689342654;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEDzQA8sAHrYY/NTyBaKvIYgZJy6EIeeZTCh1x1Jcrk=;
        b=fsv4A1EvCNifiWoXAgb5AOgfRatDBl3C2SCSMnz5uxmOSLYKxfs/IUrzJXLvskcKo5
         B3wP0GpMRk8MRASO4bRl2E31v//BhbdOJRLYbe6cCPqQ60hkU679BRX2DNsHxtwgfZ9E
         xx1CYILTe0NsW6cGQSMW0ybFaYjZMR2fjTusmY+Yxp07g8LlaEe53G+4dApkdGRrhJZ8
         Lo2ZPqxO/Gdziqxs90FJfRUevfzccgbqcyTcF0dMXzu7qdRO7l5VRP2uHDTb3JEkNggD
         NQqbs1pzy4SISx89zhL+dCXXp1UmlBhfsXaf1v+XOumqozVwMxGlhf2iudCz0tgqsE0q
         5OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750654; x=1689342654;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEDzQA8sAHrYY/NTyBaKvIYgZJy6EIeeZTCh1x1Jcrk=;
        b=NrhFof+nzOgUcfmfvu/I6oGZwTltT+6gcZKXDKqjJu9gI+cRZfRJ0L2R1vtM8PvFy9
         Vk7izXAvG9pmPy2gqRPULr4kw6CDxUoQbUNMp6gy0vfeTzYzQo89Y+CAgt8dWUim1Pla
         PROiJNr/g/GZCW2HXlfGx9gsFpCkWhhEdqxPvY0bvI5bqdbvtcZEpia0VxF1WhHHBJi6
         dDDgBZ0Is2zyN0j5zd4v8hgGoddSVzCcYTNvQp2r7D5h8sAA8lDPkDStFrNqlgDy/GAc
         LET8PfZKxG4/Nc//F193ghphBVwcheSZ1FBhXdG1yGvS/ScC045Hi1wUiLEBV7M8RPTl
         RKFA==
X-Gm-Message-State: AC+VfDxpwOH8CPV8YUMNGwwoEienQktTntc2sTEjVBa111NeNMeeUu6J
	k7PDSF6B//elfyepg74Y8j/m4xcI9k09zVnq6hPp6Q==
X-Google-Smtp-Source: ACHHUZ75rcrECCCbptE0wsvgdZ41NJltRvhJeWQ4QmE6b8FwiZw1D4tNzAgo129XNyUWFYZyyj3LmQ==
X-Received: by 2002:a05:6a00:986:b0:665:c51d:ad0f with SMTP id u6-20020a056a00098600b00665c51dad0fmr2821135pfg.24.1686750654120;
        Wed, 14 Jun 2023 06:50:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a16-20020a62bd10000000b0065ecdefa57fsm10368351pff.0.2023.06.14.06.50.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Message-ID: <6489c5bc.620a0220.c0888.44f8@mx.google.com>
Date: Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-g2391124f19a70
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 8 runs,
 1 regressions (v5.10.182-cip35-8-g2391124f19a70)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:50:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12035

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 8 runs, 1 regressions (=
v5.10.182-cip35-8-g2391124f19a70)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.182-cip35-8-g2391124f19a70/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.182-cip35-8-g2391124f19a70
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2391124f19a7085376080a6a95b6e45ff525076a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b7f6b11a5aa5d1306153

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-fcntl-locktests-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-fcntl-locktests-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6489b7f6b1=
1a5aa5d1306154
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

