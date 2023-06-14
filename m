Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E665BEB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:51:05 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.12433.1686750657196832803
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:50:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=WGhFEiZf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b3d0b33dc2so20879875ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686750656; x=1689342656;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JbKNnUSdTSVy+9SWn5GXCiA6SZJgIRcEBNxjnVu/b3E=;
        b=WGhFEiZfOAn0BvhI0LPbsGyxcxt8p8usFxejpGoJRx01ZwSy7Giw4Sz9uTG8sKRx0f
         UUnrDk6eImCQNvK2nmn60nsFniXbOeqYfCADODKlsSGTQe4Run/wTIR6+UDw5PYgkQw9
         T19TRamZYuSGDcTpSFz9hdcW5oREa7QMnIrvicrbAIvKLkc9dzckzHwJKjQ3CvupNznu
         KtPIwfpDcf5A4L0X0ThipFTr4FMBYyC5oExF2cLhVZBofE12xkbXYhsrTZHv2XsJK9SS
         4KmbryJ3LIFnLyKXh8T0MN7IAVab+YGn4Yn6YV/mRQlwkhLzSObbxlleIAP5/kvWlX70
         tcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750656; x=1689342656;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbKNnUSdTSVy+9SWn5GXCiA6SZJgIRcEBNxjnVu/b3E=;
        b=WG4gAnGmKlz4SXMADbHOotTGsvYBL9GjUI8IKaqORBnPzZ8CELT2M0Aq1tRMG4tvXV
         IVPARam5laBSI7mWMd55twOoiCOsWG5JgNVJUJ4HxWiSDbKgLPL9JWLkcQtHgeIlv+1k
         MlIvQijShNLi3qWxt/+SpoD3O8hnh8+ELnVESd3wBx10Z8CS6a0uj5m+g05PBb+NNpME
         ZEyy1cluy4Ab2cyhISlq1azeXGka37BnSyS+NONG48X7S5kqodbf3EAfuw+J2+krDbUa
         cnhyh+j+75McU+Kzx3lytWShzYDHVs828qIEEyF67lYv1Y+wNMHONmHm/OZLw+lzB2As
         eIwQ==
X-Gm-Message-State: AC+VfDzSzAg+O49TKsIVHIzZ5wTdHtxErP0vgv3W1OSbrva8jpm+MFlN
	crS413srNrN+hx2x2WrrrWiSf6YdzPriKzjCpia9Lg==
X-Google-Smtp-Source: ACHHUZ7blrYylO7IbuWwEDqqm5gEXXMmgChbSWda7DPPtRACXvWgcb2pJqKMOoghCtuRSj6yh32/0g==
X-Received: by 2002:a17:902:c401:b0:1b1:753a:49ce with SMTP id k1-20020a170902c40100b001b1753a49cemr13877644plk.53.1686750656045;
        Wed, 14 Jun 2023 06:50:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o5-20020a1709026b0500b001b027221393sm1855524plk.43.2023.06.14.06.50.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Message-ID: <6489c5bc.170a0220.2ad2e.3e03@mx.google.com>
Date: Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-g2391124f19a70
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 12 runs,
 1 regressions (v5.10.182-cip35-8-g2391124f19a70)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:51:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12038

cip-gitlab/ci/pavel/linux-test ltp-ipc: 12 runs, 1 regressions (v5.10.182-c=
ip35-8-g2391124f19a70)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.182-cip35-8-g2391124f19a70/plan/ltp-ipc/

  Test:     ltp-ipc
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


  Details:     https://kernelci.org/test/plan/id/6489b7ed76f7f8f864306142

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6489b7ed76f7f8f8643061=
43
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

