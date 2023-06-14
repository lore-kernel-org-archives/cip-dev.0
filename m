Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125AAEB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:50:56 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.12427.1686750653596529173
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:50:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=iF0y9Fok;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b3d0b33dc2so20879635ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686750652; x=1689342652;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LNSll3QE+XJSryzHI61erqimdyIMDBM7eh1Ku3p50r4=;
        b=iF0y9FokSgtSFfXbtRji4VBrHVs824coBlPby8Rw0QthqsK6Dh7NLSaOisExaJN6hC
         Y4JQfKA4Pj9KiW7AjljakJSYq6r8mBB+xA8FF3HSOIL1R9jr3Cgj9aY2trGLlvpXwkJ5
         6BlCEZaRoNFofzfJObewiIc1VGZAAZwBQujLJepOtlNVuMMJfdiHYN3SU8goKw9ctt/o
         iegkCb+j3pNoA7zYosyuOFdXrdMIUIFyFVWp4LT4V4OfBeexSFIn4EwjJypzmLSXxgEQ
         hbVduCCiY6wuh0xw/rIiQK9bd2wRZI0eSYZANEJ3aNZGSa1onVTV6l0mr6rsFKW1TpcC
         Li1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750652; x=1689342652;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNSll3QE+XJSryzHI61erqimdyIMDBM7eh1Ku3p50r4=;
        b=GpmYNRfLC5tlsd8AMSX/DnMJoFPlppbWlOPJGousZURG+JJH8ffvqaRLWVfuuoZQ8s
         lDBuFbLJpB0/P8Zj7wJR+WuK8R90HFPueefDZPGK0GbD/iIpVtRpW3H8XEt65Buzzn9U
         GQimhyn7y1Z+kmn3moSeTJKqO1Xx4HQitgZkLnCweHT+tdpSmOioWr6VQjtsMwZvL9dU
         Gnz6SafxyIKRigdwZeXtwwSIL/i4E8URMzw1aJr/f/OoT4AZGHy4oePThho4MCFKel51
         FWVb3EkAQwO+s3PqPCPA85LKxj0aITZ4N3Ua8FFaYyQqjaeuSAgxACFDKgkI6tGdDaBy
         PbRQ==
X-Gm-Message-State: AC+VfDwav81yI9jFZJWM3iL9daKZA/wvq/MgQmtltHJwRPz8+Xuszo/h
	LbqlQ/3NM3GL91FyyNHTsAE/e/D2Cn5zYpxSOzZRkQ==
X-Google-Smtp-Source: ACHHUZ6PgOtMwIrbCvhJpaKQ+u5xY4q+RE2vvFfUHSy7yJsgsao/38KZ96qkDsDZPKrhmktXNLct+Q==
X-Received: by 2002:a17:902:7c87:b0:1b1:7362:9a18 with SMTP id y7-20020a1709027c8700b001b173629a18mr9949349pll.27.1686750652522;
        Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001aaffe15f39sm12177863plt.30.2023.06.14.06.50.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Message-ID: <6489c5bc.170a0220.15c8c.8475@mx.google.com>
Date: Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-g2391124f19a70
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 8 runs,
 1 regressions (v5.10.182-cip35-8-g2391124f19a70)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:50:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12033

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 8 runs, 1 regressions=
 (v5.10.182-cip35-8-g2391124f19a70)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.182-cip35-8-g2391124f19a70/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.182-cip35-8-g2391124f19a70
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2391124f19a7085376080a6a95b6e45ff525076a =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b8bec4bd57ede5306143

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6489b8be=
c4bd57ede5306144
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

