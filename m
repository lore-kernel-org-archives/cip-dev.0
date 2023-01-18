Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C3DC54EBE
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 16:35:34 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.20562.1674059725849893971
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 08:35:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7bIJugQA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id b12so24909429pgj.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bov7iOl3Kj9PmLaCnSMO6Er9YgSOWQPjuJHp5g7tpSU=;
        b=7bIJugQAzyjBRJcJehRDTYQ2dJfeMRf722ooV4RNzr6o66DAup0xYQBfop56ieLmGw
         Ys8F7sEj/rtpx+B9Fir2E6wLKLigU3pOkrFnMvlCAtv3YYfAehV/6YBddS6jzFy92ulE
         /Wt5CBhAl12RhiwS7Tx2ZyOvgWhfksUusIvNDmnIQ/2rJ7TmMhHS2PymqsFFIxenyQTU
         BL8j5xP03cECVdp6xX2j1FocOHdWyC+6GsVUjXKfdqfyC4J04RYGymWwx5rUDD3VU2DP
         2xabJL6J1Xw4CWa8I1PJ4eAdoJaS8fDVzFmsBTIDWsGK/59MZm6RZgbR1kVcpF6RoH1/
         k6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bov7iOl3Kj9PmLaCnSMO6Er9YgSOWQPjuJHp5g7tpSU=;
        b=e8ILUNefEf4WKN9OEXLPPGE0pg8dHx3lyGJfFh/NIkLRPKXejqZG75G1iHSFJiRN3f
         wl04NnZCGw3rz9A97KX2exm0wdttJP6N5d6ES/eYlZumcRFNnB69N7N9XmXxtbuiNzdm
         IP16L7JP4ojhMua0YOk+HcyTZHEf5QletaLYOdWULp2dwYq1nqtP2/b7/hJxL5qWQygB
         aGfNmtAVKfe1VFqvz7Yb9/Vce9g9Uc1pVwtvNjMD9TlNExy1pN2ZJb2yTNjNlYy0t3xU
         NM1M5Rr5GexzDRJhSMGn7cP/gpAjh14EYrQySwZkW0cuFz+LUurFMkAi3CwyCvIQcsMu
         ZELg==
X-Gm-Message-State: AFqh2kobLRcHQeDK7dCD4OPexGX1h0yzu2+BONLOkEyjGPk6sZjW2NP3
	uO/iEOyIUHhZ/I7bqhQDJbOnLWD15eJT4ItBX/6bNA==
X-Google-Smtp-Source: AMrXdXvJDdkBwOMixZHqQEadLk5pRZTbaO0tXpqy/g39kLVsYZqcQqMUuwIL/D6d8Rmi3XVQsvIv9Q==
X-Received: by 2002:a05:6a00:3490:b0:58d:98a1:bb0d with SMTP id cp16-20020a056a00349000b0058d98a1bb0dmr8422393pfb.12.1674059724967;
        Wed, 18 Jan 2023 08:35:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78ed2000000b0058bbe1240easm9652369pfr.190.2023.01.18.08.35.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:35:24 -0800 (PST)
Message-ID: <63c81fcc.a70a0220.9740c.f64e@mx.google.com>
Date: Wed, 18 Jan 2023 08:35:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-853-g709bb3738fde
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 9 runs,
 1 regressions (v5.10.162-cip24-853-g709bb3738fde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 16:35:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10394

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 9 runs, 1 regress=
ions (v5.10.162-cip24-853-g709bb3738fde)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-10   | defconfig+kselftes=
t | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-853-g709bb3738fde/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-853-g709bb3738fde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      709bb3738fde9ab95ab1303d161730f508a6659e =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-10   | defconfig+kselftes=
t | 1          =


  Details:     https://kernelci.org/test/plan/id/63c80f063676f698d0915f04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-lib-meson-g12b-odroid-n2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-lib-meson-g12b-odroid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63c80f063676f698=
d0915f05
        new failure (last pass: v5.10.154-cip20-99-g0e320e4d37e4) =

 =20

