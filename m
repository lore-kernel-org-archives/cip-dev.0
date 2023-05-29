Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2530C77B7E
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 00:57:00 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.40521.1685321819584696746
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 May 2023 17:56:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=3RfMvUpj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b034ca1195so5891765ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 May 2023 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685321818; x=1687913818;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ka8nKqRk1yn+sUI6D/8CRnzyGq+VW446VorzJAA72ic=;
        b=3RfMvUpjvzpr3MbHRB+T1WspIezFaDg0sh6dVXb46/BvI9C39IIey8pBcb1uVCk4kH
         5HG6sEZgNU0E4dHvlYEHTEvJVZj98s2qt4sTqKRmfdPGUlrwmEanDClTTFhXBkjLe+uW
         AABenrke/WgFvqrjLW+9lMX2oJd+R3QcXZzTlB+68tVByFTxxAQgSEbf0B2BUqIEzRWx
         i3XZw3pTkxUFKV+X+zlARBqnOZSuQQeaNON8JUudn/mPZOqdeQHOGsTV9Cn6qnBytYVL
         yJHp4vkNKaHdnmV88WQjwCVP7+Y0E30/JML6MO2Fp5zHgnTOAoVyPX2sFwnL4s/5OImo
         XpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685321818; x=1687913818;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ka8nKqRk1yn+sUI6D/8CRnzyGq+VW446VorzJAA72ic=;
        b=jeEEsUYgWFLjdisA2pl/+gAzQHvvpNYNMsBqzE0CiWxdVtuLLuijDUnD6BDeAm0vJ6
         RLaOE0ZeVMbknIqDJAmt4s2/Ltp4u2DL4KEmhAJrQpByJi+ZRPK9KLCkIxYqaZvLsDXH
         /Wg0RNEETR0lLhCXiFqco7AHqcP6M2W2c6fwxZe83cCgrt5cWcUPAbbieFFDYcID++vd
         rvpYJ+tl4p5qFVq9n0pdk/pKKI0eQKuHkoOsixumJErXzgsrgP+ID/EJ9gFsPNyZvcvy
         7BKRpGXa+Efn+As4AKAzUT0965it5MnK8BmIhGhaN7NJYm6tGiV8swyO7isZR7E88Z4I
         H8Dw==
X-Gm-Message-State: AC+VfDxcvJ4qqs1dcSJy4/4BmWydOsJiQJYx14eezKxRcXzxCdisQOBg
	06ob6XWIp52nbqrp9tVMqiFW6t1gzNpqiEMaVToGCw==
X-Google-Smtp-Source: ACHHUZ5JegQXXvRaapY5kmbX/bUP+rHG6ZhJsSjTAV4Oa9H+f3eFlPcmJcwsIbuK3+7N9iC0FqcOyQ==
X-Received: by 2002:a17:902:e890:b0:1a6:c595:d7c3 with SMTP id w16-20020a170902e89000b001a6c595d7c3mr11075409plg.22.1685321818384;
        Sun, 28 May 2023 17:56:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jw3-20020a170903278300b001b045c9ababsm470417plb.264.2023.05.28.17.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:56:57 -0700 (PDT)
Message-ID: <6473f859.170a0220.6811e.0f36@mx.google.com>
Date: Sun, 28 May 2023 17:56:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-21-g8eb0cdf459a2
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 13 runs,
 1 regressions (v5.10.180-cip33-21-g8eb0cdf459a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 00:57:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11675

cip/linux-5.10.y-cip ltp-fcntl-locktests: 13 runs, 1 regressions (v5.10.180=
-cip33-21-g8eb0cdf459a2)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-21-g8eb0cdf459a2/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-21-g8eb0cdf459a2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8eb0cdf459a2bb2971bbf3eecc4f894d2717cff9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  04e8f2f4fd9493f595b34320403cf6b4f1f6789d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e837121754039b2e8737

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6473e83712=
1754039b2e8738
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =20

