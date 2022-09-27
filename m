Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33899C6FA93
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 09:39:43 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web09.8911.1664271573748339428
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:39:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=YWHgbNrD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id iw17so8623283plb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=3ndzLLYfTJdnTLrZgMf8oLmI/zWwS5JuAZJ+n/Mbj0c=;
        b=YWHgbNrD86fQiDHXHNZG0txa3+X4QlEniqFR8yufa6sI6X8+JP04hA+GEKPwoo0WD0
         6Bmg27xBDuhBleEGZVnpSEUhNHgiAXwvazS/Xo/azQXMw/WlaFPtxxNKBc/AsHIi4ePb
         mbbn0IVrmps3Ag3L63Oxm35i5r9hWjFOGquKCqHJjspis+QQmW0Si/9V+lgDDAbYIKhx
         m9uq2SBCVATaySCQzJXGBdDTRxNw94KX6fU9KCVoSesg6roeH+YGHUAeMa3FrkIs91Ux
         HvxnfYxwCyXt1qNvuDD/kQS/LhKCNBpqF6pBsQ79Cy/3ZrSDcMIF/IQAIZ8NNhjgUiz9
         ymiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=3ndzLLYfTJdnTLrZgMf8oLmI/zWwS5JuAZJ+n/Mbj0c=;
        b=ESq+ozx3aZUjtZqAZfbmTeGvgSu75kSZvuGwmIWTVV/cdVI3JfOxH4/1x8NzyOwQnE
         MPFUIZmwYXZKp+f8J8B7ZshV+vDU/PPIlqlndfhmJzbRuf+RdGzc3xhGPp2Cu5xlknZ8
         1le/hI1Fdh931zEZfISL2+UPwkW9vKi96yOTkF/m2VoXphvwweVfRvtF4VweShaUTVjE
         VDpLd8k7whTtcn5vD2f6qtEm403ArijDculfatQQkFyCSADlNE91harqWKMG7ViDpRMD
         IZCpmdLlQU2a+mn6O4i1/AaBERWmdkOCSahP6jXWweDnbf0e3IDtDKqLVP9hK2bd+cJb
         lW8Q==
X-Gm-Message-State: ACrzQf177ce6IijygXQVEYsOT2PKwT3tOHLnJOAbJO2tF1qe47oJ7zb1
	ZVxEmCpjUBqbjrfy8CzfYcC/rMGHnbDs2EYL
X-Google-Smtp-Source: 
 AMsMyM4GrYMHobd/mICHUdtHC4qODh0dcrF5HKIufviQfQFm2Frdohq7uMELCxZZLU+buNj72oVkvw==
X-Received: by 2002:a17:902:7795:b0:178:897e:16b2 with SMTP id
 o21-20020a170902779500b00178897e16b2mr25333606pll.153.1664271572978;
        Tue, 27 Sep 2022 02:39:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 f12-20020aa7968c000000b0055a5a3bda9asm1062995pfk.109.2022.09.27.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:39:32 -0700 (PDT)
Message-ID: <6332c4d4.a70a0220.955e9.1991@mx.google.com>
Date: Tue, 27 Sep 2022 02:39:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 10 runs,
 1 regressions (v5.10.145-cip17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 09:39:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9551

cip/linux-5.10.y-cip kselftest-filesystems: 10 runs, 1 regressions (v5.10.1=
45-cip17)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93a53e86925ce8c2e0608e173e2c7b952ee61cdd =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6332b64e33d222023dec4ec3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-meson-g12b=
-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-meson-g12b=
-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6332b64e=
33d222023dec4ec4
        failing since 40 days (last pass: v5.10.131-cip13-49-g1145e9c6352e6=
, first fail: v5.10.131-cip13-84-g3b53e4dbd9f41) =

 =20

