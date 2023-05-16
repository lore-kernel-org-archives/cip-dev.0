Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76455C7EE24
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 21:11:55 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.34137.1684271507899054382
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 May 2023 14:11:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JA5QzcDj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so10475887a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 16 May 2023 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684271505; x=1686863505;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8VOhwXcUci7OTubbSDbCKApmqDOsyWyQaanPSi4iw1k=;
        b=JA5QzcDjQCfFAOaF+Uks/+iMTbRpwTdeiKpgO6rjbaONcIVTZ+P1U4W/D1bwhUe0vV
         FBQvBOrVHUMjRuiE+jHRPz16d1aoAoWr/TR/dVUrGRmENlfHpHZC70HkRFjIUBKs9gif
         qgwe8ebMv8LhMXwF4+gUsXpd8DC60YjYE5gXPGdyNFwFa2sTeBpEJfWsPz/M/D/TK0z5
         lRTJtqb+g3x4Ap1kyVSp1jC8c1nhjou0WbMk6LHd0Qy7tFcT1iJqWJUrcOGF0p1Diz8Q
         DEgYQj+5EQaiff6rDpm3AefShPZ+0S6oh5XCKKp1E7n5tsBacCg9TSDYN49VRBx5OacJ
         i70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271505; x=1686863505;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VOhwXcUci7OTubbSDbCKApmqDOsyWyQaanPSi4iw1k=;
        b=cvjUpYHnLLSF4XUqveXl997AeXAkkpTG6Xq75evIB4nam5psbugUB2J95tYgA4C0a8
         CLaUNLbjZloCYOrYH4etNenzW1tOrfx6O5XWjxr3a1gTZdCXv9GFueQ9SPzcUGpY8UpQ
         Vi9jGCipNV+OUp5qHQRNrP+DX98h6FytN5aA93YGwhhnb1iUssz0gQe3gIZUsshWjCxL
         IN0dqzHKTAEJqQZkjdY2b9svjT61jX3kZq6nXHjoanTs0cvjxqmUk5+Pz6fmhBrH+yfk
         OMNXV/909JtE68kNfmKKVUokHgFalv1jmAhU1B/4qanI+Ac8pY7dpMWG5YbfjIlSv0dp
         HQ5Q==
X-Gm-Message-State: AC+VfDwquhl6qN5FDCVC2jt1WSKiiqX2uu8Vq4TnW54v63ootqRuxR3y
	YCiC8uiOhkN3SntmYS4LL4zQcUKIjTIlBHATdq6v/w==
X-Google-Smtp-Source: ACHHUZ60hReKitURsfFV6ABDDsI0ZFbp9BcaqODXA2z82ha5keq435CO01A7TWtaMooX5rIj+pMX3A==
X-Received: by 2002:a05:6a20:4299:b0:100:bda9:4b39 with SMTP id o25-20020a056a20429900b00100bda94b39mr39100031pzj.34.1684271505533;
        Tue, 16 May 2023 14:11:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0062a7462d398sm14286314pfm.170.2023.05.16.14.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:11:43 -0700 (PDT)
Message-ID: <6463f18f.a70a0220.94f25.cde8@mx.google.com>
Date: Tue, 16 May 2023 14:11:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-4-gd8c029e4780f
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 13 runs,
 1 regressions (v5.10.179-cip32-4-gd8c029e4780f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 21:11:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11478

cip/linux-5.10.y-cip ltp-ipc: 13 runs, 1 regressions (v5.10.179-cip32-4-gd8=
c029e4780f)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.179-cip32-4-gd8c029e4780f/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.179-cip32-4-gd8c029e4780f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d8c029e4780f8e18a07a1a17c1a9de1e01f3adae

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e41c4894d113972e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6463e41c4894d113972e85=
ed
        new failure (last pass: v5.10.177-cip31) =

 =20

