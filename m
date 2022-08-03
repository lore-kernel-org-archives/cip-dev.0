Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4333EC3F6B0
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 18:19:09 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web09.200.1659550745901138256
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 11:19:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=YaNAUa3F;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id
 f11-20020a17090a4a8b00b001f2f7e32d03so4181007pjh.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=z0jLJo5RlD1E72hfc3fzV5v/napymEsWMTkzON1yLY0=;
        b=YaNAUa3FSDcNulaeNFH5BpO0ZfU/BYsukxdDpe0zPZGeSsp30PP4tpsOSdPHkDi62Y
         uwzXgJ1iPHKHIqRGZGcPXwZ1mpKu36j9hTTWoJj1uQdB4uUNEf0ly40b8hlzacrrP/hQ
         C97oGjKwSD4XgAjZBIVqiIFRmAWxk48n1f/g3UkoqEmy6vbGopFAlYKF4uztZ8jLDfBu
         ivhAQBJMcvMcNZpJaC+byoioiW9wasN2OQ12eXXinOUhW8wVuS5+5zPKuo8CJD/uGS6l
         Gd5H9T/5h8aPpl0E7xfNro42ae1wtrh//nvZBPCWdNerZ2tievhDpnCOMyFpARo9OiOH
         rpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=z0jLJo5RlD1E72hfc3fzV5v/napymEsWMTkzON1yLY0=;
        b=FyKZrKNnlSWC3JrOG1kIzr6q3gP74xn1CcnX1JjnqUk83LcY8k+E98UfhuSO6LYLcH
         V0K4QWIJT1VaS18LwKCXPUSg4rneeVlwrBMN+q0KxRq10uw52sZ6rQqdBm8hg4rlu3WP
         cPYChRoJ6bWnSj6Bm2EFOrZzocRGqKb8SpWaLrwlK3QvqnLwxf6wWrCUmMDeLLdDfsCR
         RJrGQa5dMCRBvL5DTi82cJZSsQiV9PHPGOzZv6OeTH7Wr6sdTyB5NzP6B07qMytVEiTk
         M1zufqlOY4Jb3oFQveiXkFjbtAJ0cj2gRFpi14CRWI+TQqAysbLt26ImRVsnIg4+ZrYR
         rcAg==
X-Gm-Message-State: ACgBeo1qm5KWKZRuYwwJg2JzXdKiybT9IwJpSxYVN6Qbig7sxbdFnI4z
	5GmTgYRUmJyA0GB6GUT4HkRAW+x7U0mSqigIDC4=
X-Google-Smtp-Source: 
 AA6agR7vsqeJc03NaClKvo46nEafzQS4bxmvs5iIOfTO9oRyOIK2Pbm5BzhVCWYqWXHy5RTvw17CGw==
X-Received: by 2002:a17:902:7102:b0:16e:e49f:1329 with SMTP id
 a2-20020a170902710200b0016ee49f1329mr17095779pll.163.1659550745312;
        Wed, 03 Aug 2022 11:19:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w126-20020a623084000000b0052d417039c2sm8267325pfw.133.2022.08.03.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:19:04 -0700 (PDT)
Message-ID: <62eabc18.620a0220.7ddc1.d89e@mx.google.com>
Date: Wed, 03 Aug 2022 11:19:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-24-ga6f4ea41fe167
Subject: cip/linux-5.10.y-cip kselftest-lib: 9 runs,
 1 regressions (v5.10.131-cip13-24-ga6f4ea41fe167)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 18:19:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9101

cip/linux-5.10.y-cip kselftest-lib: 9 runs, 1 regressions (v5.10.131-cip13-=
24-ga6f4ea41fe167)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-24-ga6f4ea41fe167/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-24-ga6f4ea41fe167
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a6f4ea41fe167f956d4000eaf276a1e383603071 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/62eab47fc3162ea9eedaf0a0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62eab47fc3162ea9=
eedaf0a1
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20

