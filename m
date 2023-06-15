Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF79EB64DD
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 12:56:51 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.17415.1686833803519195798
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 05:56:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=IZSFszs8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b3c578c602so33235315ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686833802; x=1689425802;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fYi7xvfHvf7+D90L3/vJCiKojHAyG4P9jkfQsW3i6N0=;
        b=IZSFszs8ZskzGBjc+zrzfzA4Jh91yH0cs88aFahlIIlOInbWB1RPFU3Xg+xeAhFO9J
         s0prVPVsr3L9mL4gtpEbu9bjDW0BPmNzLQFtgj++s6ta2E/qea4s7MI/D0Zi+WbOHArJ
         GwPrgVy4ZpodXIU3YjWz9qsz0j5ev0m6Ht4D9y/H5cjAmn8TZMKm4qaftWnWZsnH+tlY
         UFBnHjnjpw6IFCtCXRwUgKisySU2S4a4IEt0VZy8jhCAO2s7xgzvo802wzweWVD4QOvv
         1063aLmQ39JCFtbVPbRU8lI0jiTikLbIKH+7yEqNTYEz3Q2Z4m/UtOyX3kA/JrIxCkZh
         Tszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833802; x=1689425802;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYi7xvfHvf7+D90L3/vJCiKojHAyG4P9jkfQsW3i6N0=;
        b=dH+PVUEZCJQRwrtvmcO3qaribWDgzqJB0WQdOdKcC0zANllojy+PkCETq0A39+qh0D
         pVUl6L9HEmhsU2sIyWTxYCndv0BN+misj3Zhy2YVHPMzDh61PgO+d2jQydVxUm9sxa4f
         z+JpbP3PlURuGSvq9lja+ADMP8pObJ+JYgVc5tdZLJcyRYbgR88ErHRIkBKrsog0zF7J
         5uG4WIVYL/ZD8lhBM6r7y9OcGkft6TV7jhkTaXXZcrrwb0wi4nRTYW9mrPJQ+N0oKl84
         fG4AawsafcKdYbQUq0P+ke0VQnCeTPxixISspV/FmFWCba/bH45XTcSD/Suw1kOsPxQA
         r/Ug==
X-Gm-Message-State: AC+VfDzFTysML6nFiUKdxJx3246O7XtKXLoAEf76ue1w0tEs3EQbWLT1
	EVs3XkW3CaI2R+zKKniyrC0/HP7AowBUBiRBoK2QOQ==
X-Google-Smtp-Source: ACHHUZ6C+eYb+nk/VaG5cK/N1HRBV8wlN0bkFF1TCppqGQZXnz5aJlUvEwK0xAkhxrDQYp/6pxpoJA==
X-Received: by 2002:a17:902:650d:b0:1b5:85f:cffa with SMTP id b13-20020a170902650d00b001b5085fcffamr3367906plk.51.1686833802396;
        Thu, 15 Jun 2023 05:56:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902f68b00b001b3ce789e3asm7818779plg.172.2023.06.15.05.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:56:41 -0700 (PDT)
Message-ID: <648b0a89.170a0220.7a912.fc2c@mx.google.com>
Date: Thu, 15 Jun 2023 05:56:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-53-g486caac40d06
Subject: cip/linux-6.1.y-cip ltp-ipc: 14 runs,
 1 regressions (v6.1.31-53-g486caac40d06)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 12:56:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12061

cip/linux-6.1.y-cip ltp-ipc: 14 runs, 1 regressions (v6.1.31-53-g486caac40d=
06)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-53-g486caac40d06/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-53-g486caac40d06
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      486caac40d06a2c987e5514b550d341cf6791b17

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/648af8c4712c50935b306159

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/648af8c4712c50935b3061=
5a
        new failure (last pass: v6.1.31-46-g4cc1cc26e90f) =

 =20

