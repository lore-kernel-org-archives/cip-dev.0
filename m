Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C77DC3F6B0
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 15:04:29 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web12.280.1660316662728980259
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 08:04:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=wDHg1KPn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id pm17so1243927pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=iIy26Wkc9yJ2N4ylFDi4kBp4fICv8/VgNSCr2FxrwuA=;
        b=wDHg1KPntHwp0NBu6NK8ys2shJj8ydqD9F/mbEVJ6TyqPl5PNlVqXm9aHbA1MqDoTa
         D5Warsx7dvB0KNuuRrPAzaR46e2AkhAppdzDp+crPE1zCjfivc5Yakx6UPFJZccoj6SO
         EldtW/OrlBeO7IkL/6pfdqcJ9XAsNTGH4nO5yPVdHtpWxHpnH+rn+HZJBxbpfDAvVkUL
         jZrmZpBsRNZws70ykKP2knZA8D+oQ1or9dUPPPVy+06dEwM/NfuBcW5ifih8TzxjmznS
         oFY6FmWy7K2lqHndpKMfjgho1vG+3aMHzoJErKkw/tveh2oUZa0I5TpDfbO22YgDAdj+
         WuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=iIy26Wkc9yJ2N4ylFDi4kBp4fICv8/VgNSCr2FxrwuA=;
        b=mSGAa0EvpylTryZ5T3I2lJgedW+TRt7TfvzEl6L4MZ45+3GzgW9Akkocy/++DInYT9
         8buTmzfMYs4A7481U3IC22ZwSEpWkUpR6D9PVOU2+Yyxivtk4bu/TQSz0pyZej3xkc/v
         DVmtCMYrrNeJmU4sxng7EXtmF06RR99cjGnPpm2+Bi9I0jkVyTmb2GbILXnjOyCZC7f7
         yXh0jfFwg2OvMsXKqWwyytSCEOmAgw8NKQ77e9lu6eYX4d8WBRMLswk6S63iLsJ0itZ0
         NW9amQKFzE6LFMfrSvJRfaPUs4/MT/XqlNf6iKi6Bmwe2JdiDUTiY5Cevk7wpv1Et3sh
         voQQ==
X-Gm-Message-State: ACgBeo0Y+Z98cw/EgETviQ4EC1uwHSYyAA96gNsD1Bn33EZzamPOJ/1H
	QlB5A82cc/s2Y1hxYXCnRuMjAL54u+B7zXgX
X-Google-Smtp-Source: 
 AA6agR5/6jUaR+kaBAKfzcR8Iy1gZ32inPEyvLjKO3oxjOMsQZwwUV1vuNBoiPOi2uAZNYUfPTI1Cg==
X-Received: by 2002:a17:902:b207:b0:16f:2349:6116 with SMTP id
 t7-20020a170902b20700b0016f23496116mr4343064plr.80.1660316661621;
        Fri, 12 Aug 2022 08:04:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i5-20020a655b85000000b0042195f31243sm1448875pgr.74.2022.08.12.08.04.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:04:21 -0700 (PDT)
Message-ID: <62f66bf5.650a0220.7059f.2bf6@mx.google.com>
Date: Fri, 12 Aug 2022 08:04:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-35-gab58aa0904675
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 7 runs,
 1 regressions (v5.10.131-cip13-35-gab58aa0904675)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 15:04:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9201

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 7 runs, 1 regressions (=
v5.10.131-cip13-35-gab58aa0904675)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-35-gab58aa0904675/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-35-gab58aa0904675
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ab58aa0904675bdc00cf17ebe4f1b5aba242c1cd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  7e71b2c4b9a136602d9774c13097f5e06f6f04a9 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62f66476c5a52b6d92daf076

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl=
-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl=
-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220805.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62f66476c5=
a52b6d92daf077
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =20

