Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E89DC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 03:54:45 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web08.80474.1656993278543166256
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:54:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=UzY0PCU3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id n10so10007126plp.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ecQY3vaGdiQTcsXc5I50GRr+LlIv801/aaWsEgf96uw=;
        b=UzY0PCU3UUmabfurhvso+pEpF6ha4PlJxi7oNqgSE4ncGrxRvKZWRgqURZBGaeHuZX
         7apZBNs0efOhW1teiWhMjTv/fL8e9mRsf59/7Pet7leJ4Kwdh5mNdXMsmh5viAKlWoin
         +RxPbicwr4TJWirwooyWjXcex4uuTGiwPZ+5SUpqUEMxbKLW3nLVmXFoeEenhWt5gbLN
         3ZmBMk4rrJ2zgMZ2uzBCVZDym/lb9LDTaxp7khM691ax/HGOf+lMlhE/u07gs9DaYfpL
         48BaJLIYtOSgvVViIZ36CcqkzkOtPxqJo4B5o0/DqgP5CpbUAzQ2WPZ28XqfqOnmWxha
         LnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ecQY3vaGdiQTcsXc5I50GRr+LlIv801/aaWsEgf96uw=;
        b=6cXAYwsKEJagV0Rk4nnP7UzZRVk9RbFYuvXf6Z+bR0iY93f9QUYAdS0qaXFRgDqjvf
         D8Jd3eujqWhXeZvuunuL++prpGZoz+MW/Q8YUxdf3zR89E6gyhzaLqY8Y+IlJ8Mk16PM
         OW41jAruaEfR15BC82YnXrat5QNeTjinZhjTYHUt4/KGVEXoYT6aAMG44cvxN7y6ZJGu
         Bluy+Bt59BN81YRgMUrntsypBeCpynKczOEErwAyXkOiD5bKSnKASyMID8BnyfBC5uaj
         F17Vwf6hE8iKJL9c2T8HxvYOlC5IOtCKUqa23oe2XuZFhBZ08WrWc0ASMQj2z9B+a0qt
         woxA==
X-Gm-Message-State: AJIora9+OeufFBCosStnzfOvP46mGFUYISp2rExjLiLkZ4TCuB9sSFgI
	2KGTITsnSk7yJcFpGjmR3tQcw4evSaYiG1HR
X-Google-Smtp-Source: 
 AGRyM1sSuO5EIZBP3MfwE3a0dA6Oogp4bAZ+IoJFArNuhu3NE5EyPj8NwUtsO5aIACOsF0i08xi72A==
X-Received: by 2002:a17:902:ea12:b0:16b:a264:3817 with SMTP id
 s18-20020a170902ea1200b0016ba2643817mr32615160plg.52.1656993277720;
        Mon, 04 Jul 2022 20:54:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y13-20020a62ce0d000000b0052896629f66sm242395pfg.208.2022.07.04.20.54.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:54:37 -0700 (PDT)
Message-ID: <62c3b5fd.1c69fb81.58132.0842@mx.google.com>
Date: Mon, 04 Jul 2022 20:54:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-120-gf70f522cb972
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 32 runs,
 1 regressions (v5.10.125-cip10-120-gf70f522cb972)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 03:54:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8666

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 32 runs, 1 regressions=
 (v5.10.125-cip10-120-gf70f522cb972)

Regressions Summary
-------------------

platform   | arch | lab          | compiler | defconfig       | regressions
-----------+------+--------------+----------+-----------------+------------
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-120-gf70f522cb972/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-120-gf70f522cb972
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f70f522cb9729264739dd5a10a8e68d86241981f =



Test Regressions
---------------- =



platform   | arch | lab          | compiler | defconfig       | regressions
-----------+------+--------------+----------+-----------------+------------
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3ad3f91adeaacd6a39bd1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c3ad3f91adeaacd6a39=
bd2
        failing since 35 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =20

