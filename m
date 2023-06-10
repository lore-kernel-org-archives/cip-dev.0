Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41343C7EE29
	for <webhook@archiver.kernel.org>; Sat, 10 Jun 2023 10:54:59 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.15341.1686394490106089804
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 10 Jun 2023 03:54:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=RqFZoeVA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-650bacd6250so2284057b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 10 Jun 2023 03:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686394489; x=1688986489;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jsxYA666Cc1XNELSk7dawbjHQANpKeHko2zEKtyTg3o=;
        b=RqFZoeVA0u6QQRrmjPq4NwDWB0ICGY7KXwjIC9FYRVJM5F/nEQuLm/6wEACpBp9V61
         hw45qrnhKu/mlCA4WKopoYgu9+59jlDJHYn4jkEdWsmmuNvEu9cCfdUj3ofVheH6iZWL
         MKFn1rwHRH8UIKFjhQCe2YAwQHZUO90B4asuSBaXeW4pToZCEue/B5SpIL+9LdrQZXgN
         beLnQ3oVmbjIYtuPtQRaUTWJWoj4KkvdKvExg2j9orYj+KaTuNDWjeXlPRLqlIiFLFwU
         AZC7grWYXx9qR1jnhgfXTsLYdFUgKnNund2BM19lQ9FnjUGwBOr5i/JmmDMWbdX9v1ii
         RBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686394489; x=1688986489;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsxYA666Cc1XNELSk7dawbjHQANpKeHko2zEKtyTg3o=;
        b=L3vhcrkNvZUfLMG1CU27rrF1E37dHFqwxNACiw8F20GS2/FOqncg90Vw2Q8tGIJ83/
         /3P24DMYdbFNu0xTTwJaVBI9Efb+/k5wABlgomdZdxUm8LSeFF1ot4uxwuafV6KRh0Cz
         oTLIVu6fuToKBMoqGztkcd+tlms0wGY7TnPta5hkqfuGMRQzSxmEBi5ejIq3Is4oPg7x
         ipFLEig3d4uCf2Klfk1CGyFRki/YQUm7SFetbu6G+KduD4lKFZX/WCyIADiF/cDdcac9
         1TFYFdQ5Chu0AEwJDwLfZyXUiG4RNWXC8aTEe3sw1kCmjRuWyODugsyO3DprG9XTfNFZ
         ibnQ==
X-Gm-Message-State: AC+VfDwc/1gI/dFLdQuBxb3hYGwIPFEhThs/6QKZJDl3sxoKUOriX/Tq
	NdRlNONktmjUay782SyBfX8Ejs8Mg8e5NKVQoXiJRg==
X-Google-Smtp-Source: ACHHUZ4ibv0+17j+1PUSsxe60SsAKGFBYwA78LZ8/4OD7XVq0ya8wOeR89dPk2/HCjcCCc9QBkkQbg==
X-Received: by 2002:a05:6a00:2d9d:b0:643:aa8d:8cd7 with SMTP id fb29-20020a056a002d9d00b00643aa8d8cd7mr4634222pfb.32.1686394489185;
        Sat, 10 Jun 2023 03:54:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c8-20020aa781c8000000b0064d5b82f987sm4092396pfn.140.2023.06.10.03.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 03:54:48 -0700 (PDT)
Message-ID: <64845678.a70a0220.61d8b.84c7@mx.google.com>
Date: Sat, 10 Jun 2023 03:54:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-45-gce658d9231044
Subject: cip/linux-6.1.y-cip baseline: 125 runs,
 1 regressions (v6.1.31-45-gce658d9231044)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Jun 2023 10:54:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11964

cip/linux-6.1.y-cip baseline: 125 runs, 1 regressions (v6.1.31-45-gce658d92=
31044)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-45-gce658d9231044/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-45-gce658d9231044
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ce658d9231044091c42896a08fbbfad40ebc58ce =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64844a81e9c1609d13306163

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64844a81e9c1609d13306=
164
        new failure (last pass: v6.1.26-1320-gc38e4a9845945) =

 =20

