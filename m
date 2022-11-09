Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF04C4321E
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 11:44:00 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.2265.1667994238976480821
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 03:43:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UgETP9t7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so1593264pjk.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 03:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jGaG5OQ/9N7/bk160cmS6c2hDur1pUBMS+hUtCT0tAA=;
        b=UgETP9t7+DYvvY+Es0UEnrffn0L4OlMCXoUAqqkQyO/Xb4O/H9Hl7VnzhHqWMIQbWk
         bP2cBv/IaBZV9STgY1Qj1h1SlfLyjxlRvlr9l6V+N91FDlnuLJHfGjUyD3QjrzQTO8Zs
         JLNVdsDATyveImGhJQuE9gp32pQlKDXRfrNvx/UUV//wULXekPEpQEhnpJTjEfB51wzw
         ObMVg2zK5jR1RZ42w28QckAT71XtyMg9BtFBYZO4/QJqaMeuytoSXh4ZYg8C1djsWy2f
         CDg4iCH/n3WG7Jqrpdv5CVVSL9AKfrxnqD9yezRbY4XXn8rOh5ieuN8n9JCnDGtTmacx
         HaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGaG5OQ/9N7/bk160cmS6c2hDur1pUBMS+hUtCT0tAA=;
        b=BTg96vxdzjaBE1H2/AlN0whEHLFi7GMkXGdWyAjlRBxQ1jVTGPuiRCvk2fFRZ4uDTn
         wZmfhgxNdXVYKqK/9H1hXcHkYx5x7gyf1Y1aTsR23q3vgKcosTZypk73uDmnJXQZCTnu
         +bDryM8z0F5//0J+heFgRMcUEiFpAlqwlkZN8TxLii5PI1oAOsWU94pUaCFHodEpK3Du
         IqsPwsTpVsTvyF22ui/pCzn6GzakbOTIMCd7MV5to4bkgVcTZu9G1dXYYZQh2R98Y8/8
         hoRnspUI4LurpXdfpa+GH0HHfdNs14T1notSxPoXlN87p1i6YryXfIWOuorP16T13/Rr
         khpA==
X-Gm-Message-State: ANoB5pnPp3QYBsYd7ssQjXj/L2c1zkZeYjJuco+AcDiqncdDu+tbfcje
	VDlDmydV3xjWp6vs1Qf6rMZcNSJW0NAePKZy
X-Google-Smtp-Source: AA0mqf5TMKq2fevupdPm8DMydXOYhju/0lez/v4NT/M8i9hZNXpJe4pZCLRnWwrSKN2AjMdpjGbFrg==
X-Received: by 2002:a17:902:f14a:b0:188:71b1:3061 with SMTP id d10-20020a170902f14a00b0018871b13061mr23634510plb.94.1667994238063;
        Wed, 09 Nov 2022 03:43:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902784400b001871acf245csm8829429pln.37.2022.11.09.03.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:43:57 -0800 (PST)
Message-ID: <636b927d.170a0220.cf8f2.e0dd@mx.google.com>
Date: Wed, 09 Nov 2022 03:43:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 9 runs,
 1 regressions (v5.10.153-cip19)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 11:44:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9960

cip/linux-5.10.y-cip kselftest-filesystems: 9 runs, 1 regressions (v5.10.15=
3-cip19)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f7fc281d55b27b299e8388c7d44809289ba8b99 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/636b82c141c4dc12f4e7db59

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-meson-g12b=
-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-meson-g12b=
-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/636b82c1=
41c4dc12f4e7db5a
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =

 =20

