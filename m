Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C334C4707C
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 14:11:05 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.7543.1704723057919486510
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 08 Jan 2024 06:10:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=uz96L2NY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6daa822be30so521395b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 08 Jan 2024 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704723056; x=1705327856; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bTXT9MFeRw8oFPm+PrtUuaW3EcGAyZoIS7q+m9KbPjM=;
        b=uz96L2NYwtd7oCI+0pOLzfyZ2u+kJPqAsud3AX9mjhdHs7vC0nLSX9g3yJmFZV00Iz
         6p8O8kn32+Sx4qUUZYBrx1f5RZC4cmKZfqmPunD7nTHKF3vNiaMeYwe6O5PQcNvWl7aF
         yh75bv0hpzKb9zxd/HU5Z44WoJ9wj7APBlQMgtTRzEu403Tur7Gw2VBS15BL5ys5V8in
         q+dNN20OquWF5a8I/P+lfn6lZ59fQA/mc4j6S7fPpwopuamKh8RDZdBSZuzU6mgyFuL7
         LvOtaPfQmhv95PtWAmB4Ga7eXDP7Xk4wE23Vt/mFFXckwuiR2+NJGOev/ukjQyyZ9Dss
         YDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723056; x=1705327856;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTXT9MFeRw8oFPm+PrtUuaW3EcGAyZoIS7q+m9KbPjM=;
        b=wEloAkgNnKvETakJK4AiKGKkWDKZ2TMB1fKGu+7fwE+z6pPSFh7r/wMMdzuhx6ro2S
         PZj37e+hJTHtHotrUYmB4+bJVnWA1CVMItsdFjoaxRMtsmirTMf50b6tJ+sOjAkl62Mr
         rM2WWs+tOPZTDzd2GW7h7dwgBeCii+kiWo6EwbUsfnHwYFGxNuWiw/jS2rwu8YK1iZ9T
         vb1lQeqv1Zyt9XMn4j0jsGgf9BTWkVB0G9gQhW1XQ9gWWr1gKRAjobM2Wz8wss554jrA
         g1C3zXvlInAPgjgJc2y3o6yDF6UkVO0z9voEoSuG8vhVHDNuFX7uXrdy78PZ6Pbc38io
         ctDQ==
X-Gm-Message-State: AOJu0Yzv/7VI46kAsfDdyxA2ZiWPV0CJWP53IXalstQGgLznmMAu/5T/
	ggpAeJUGtTaJj2isV9Ypfg4BXl+9R9wWkIkPdVqoXGEQrF0=
X-Google-Smtp-Source: AGHT+IHHyd2S8AtNW/ohM9HA+IHFveAi1okpppXbRZGwoyqVRYuqorrmDqTQyxWAO52Aae4cuhrz9Q==
X-Received: by 2002:aa7:92cb:0:b0:6da:c7cf:2a7c with SMTP id k11-20020aa792cb000000b006dac7cf2a7cmr1392946pfa.3.1704723056405;
        Mon, 08 Jan 2024 06:10:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a5-20020a636605000000b0059d34fb9ccasm6121363pgc.2.2024.01.08.06.10.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:10:55 -0800 (PST)
Message-ID: <659c026f.630a0220.50a3b.dcd3@mx.google.com>
Date: Mon, 08 Jan 2024 06:10:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.299-cip105-289-gad0914f265af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 6 runs,
 1 regressions (v4.19.299-cip105-289-gad0914f265af)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 14:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14282

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 6 runs, 1 regre=
ssions (v4.19.299-cip105-289-gad0914f265af)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-289-gad0914f265af/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.299-cip105-289-gad0914f265af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ad0914f265af139fd53d721f0db787b707de20ef =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/659bf6686ee179b67852a3f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/659bf6686ee179=
b67852a3f3
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =20

