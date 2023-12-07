Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FA6C10F05
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:02:07 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web11.84318.1701957724396458536
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:02:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qoicMEau;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.48, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58d4968c362so354310eaf.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 06:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701957723; x=1702562523; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OF24zTluyzh4rvMYV7vuDknpWz4sfs/yTTAF1bm5CD8=;
        b=qoicMEautwqUrkmipkUroFJHvA+mA9sj7jAaok0v/354yLLW+5YpxFL4swOYDl6zG3
         dFM+Yv1Qg9IMwSyjgvDkXxnzPwQENRKYZSXsO849e+oKaek8kMAZr5n9TvQZ4qtJC4zL
         XQdLEXPTOizZcq7S2bS0Mc27F3qD1/vVvW5atsc/+VhtXqlgTbJ5RDeyBqo95KwMM1/n
         e1b6b6p3c934Imq80XpFDrejIURAaDW3+qXh7USRtCzmnceq+rkWkhLWdruZIfQ9KkZI
         k5OIDfP8zLmieRaBnI4tPdj5sgFEJZHHDyTP9XMARpFy9BmYwF4EavbVj843fQIbQV5c
         dS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957723; x=1702562523;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF24zTluyzh4rvMYV7vuDknpWz4sfs/yTTAF1bm5CD8=;
        b=I9YUJTpbTLixq9SxVmYgHaVY061TS1RUhWJjCD2u8kDrAPXaGDAr4f1lEP4jKdXMUs
         OMuSBy3oABiCfbMdc8yPjmfuwb5pUfNzebAHonupB10B5QiQK6swuylpP2wnDqB1o2SM
         6wmv6Sx6FW9buz0y9wAFHvGKILbAkIdftOs4MA8d3z3TSyVBEw7P8sfiaclMwttIST05
         o2ct8imbFgSzqQFdmYmXL8CjVQpaue/QavXcP/74Q8HgrgAbA/5SlAaFxxMbsNrBX2hG
         74CFCDiSM7mKhGvR49aAaC9h8+eywwzfpL+D8a+n3p4Greb/EOq06Hit2ziLalmuMfuY
         FynQ==
X-Gm-Message-State: AOJu0YxUv4rd5EWEqbWcvpEvAxiYKPL2P/gWvll3dVSdQvlbiYTYTOwj
	AsMiw0TJaX0h7dvHSHAkf96IsFxgwT/BomSqefjB8g==
X-Google-Smtp-Source: AGHT+IFVHtxXsRk5UsOjxF9ZvxHRYCgzBvwJ9RNft0/Gsv26ASIYhI2KLs3UbnlmgYeE6Fbrjv7M9Q==
X-Received: by 2002:a05:6359:4593:b0:170:8cdc:83ef with SMTP id no19-20020a056359459300b001708cdc83efmr120350rwb.20.1701957723211;
        Thu, 07 Dec 2023 06:02:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m8-20020a637d48000000b005b9083b81f0sm1294532pgn.36.2023.12.07.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:02:00 -0800 (PST)
Message-ID: <6571d058.630a0220.d8619.2f50@mx.google.com>
Date: Thu, 07 Dec 2023 06:02:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip ltp-pty: 9 runs,
 2 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13872

cip/linux-5.10.y-cip ltp-pty: 9 runs, 2 regressions (v5.10.201-cip41-16-g3c=
85fba3b6e5d)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6571cbd9a7fd0c799fe13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/ltp-pty-meson-g=
xl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/ltp-pty-meson-g=
xl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6571cbd9a7fd0c799fe134=
77
        new failure (last pass: v5.10.201-cip41-11-ga539098fe70dd) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6571b9f46ecabf5ba0e134a1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6571b9f46ecabf5ba0e134=
a2
        failing since 27 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.200-cip40) =

 =20

