Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBD2C54EE9
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 10:32:43 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web12.9404.1664274761597786809
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 03:32:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=QkO8rrwt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id bh13so9028112pgb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=bOqY2RPawGMt1kfVAgMlYocTW62aSkpxg3FyMohaACM=;
        b=QkO8rrwtN5e5mAAkauKD3ayeBXhp0Lc15ghLGV4qHVqA4J5ahr2BQHHJxnppLhCOsb
         7mmhcx4K6pq+aka1JxZMWnfkC5Te1t89xqg1Hoic6eeWzjzRQqMuc4liEAS1X1D/eK6u
         mcgkyaJjWVjDgXd3mwEdHth29JG+QQ+8LkrDMnB/sXnR5AP4Wny5Y4Lw8fTRu37FOoso
         IE8oD+6fwWNChBRa2jb3MfS9YH10rjCoekj0qgAG7xiyv2j4YPMRawtFqwK5HssnQov+
         JmYamO1X6ePvHXu4MqTsnXNC2ByRhSnBBM8JfCGabGnrb/ifCsK3ZzhBUKGV+DOJXt/U
         GWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=bOqY2RPawGMt1kfVAgMlYocTW62aSkpxg3FyMohaACM=;
        b=u1EW3qbpQrxMd2AlzU8ksT1+WGMo0ftS7SdGjYf4N5qf7nsGd9/tWGjyI/uelcg28h
         KEQNbHR/x5+R75Tq9tIa+AokIEbDaBrXaz/qxT/fAAOFoAPfJXN9hMd97RX3uXh6yYvY
         PYufgsjlz8I6XimaXwHmgjSfibcXoQfnwgXDwOAdnPMmqqG6uyZ7XzQqXKKjkXT+H7Pp
         oRk0uQJ3iJ+ArpFYSiB4a9Z9eqo0SVn4gQArrrcpm+wUJyt1aRntrSUlRqF6fAI5Tm/O
         R44Wtwh7GsZhmu5/m4WzhR6vp7dWEM9bKnYYQciFSxOojKTkrr0rytAaQ6yY2/Nont7n
         +uhQ==
X-Gm-Message-State: ACrzQf3DRIrbeiHcIBqaMZqiNTWv4oR74YZWKuX0Wi6qhAdbe0Vl8Gf1
	2AA10ADUsX9UouxeM3wWX950ZeRhr0Xkc1g8
X-Google-Smtp-Source: 
 AMsMyM5Y6RloVFjy0IhmwTIKr5/U05ar1elFN6yq2BnA5neFcWnB0CdxbmYEyRvESieOZaqQ0QTDkA==
X-Received: by 2002:aa7:859a:0:b0:549:e89d:5ead with SMTP id
 w26-20020aa7859a000000b00549e89d5eadmr29075606pfn.63.1664274760708;
        Tue, 27 Sep 2022 03:32:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x19-20020a17090300d300b001782f94cf5fsm1150670plc.17.2022.09.27.03.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:32:39 -0700 (PDT)
Message-ID: <6332d147.170a0220.9ef30.1d31@mx.google.com>
Date: Tue, 27 Sep 2022 03:32:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.259-cip82
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-fcntl-locktests: 5 runs,
 1 regressions (v4.19.259-cip82)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 10:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9558

cip/linux-4.19.y-cip ltp-fcntl-locktests: 5 runs, 1 regressions (v4.19.259-=
cip82)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.259-cip82/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.259-cip82
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91f283faebd1a92efc2cfe0a3de7c568c87e5ee5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6332c7142bc63f7f2eec4ea6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-fcntl-lock=
tests-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-fcntl-lock=
tests-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6332c7142b=
c63f7f2eec4ea7
        new failure (last pass: v4.19.256-cip80) =

 =20

