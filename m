Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FB5C4167E
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:37:27 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.345.1668033439475442827
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:37:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=FYHTXamo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id v17so55868plo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QN2sRop3uQ+bqxKtqViavKiIv7WX65j8ADm6oPZVwSI=;
        b=FYHTXamoFQW7Ft/WC5zzRqN7smVvbOpDIVFwyuX2fhp70hZOmI+smZaOYhYlS9/9ob
         UWHwjVR8dic9JGyo+NGBJJQV0EU9jkWN/Id4sYoKolwmIpKUgL7oLGhv2/F0sih4VjBV
         /ia7LE/KQSsbxPagXxiIShPWsvc/vHag55Xdzagx/03uLTcv8iVMQtF0EsIlyt8N82SS
         597W4o8hhThB9Ic2Nxbf7Bkg/juYFVws6RG4ISJEoujCq02brGCv/GXl28sCJtdjJ8o4
         QeuHvLX+KlMrNwdSeM3U/4AUaesHezCDjimTu7bLi50zhNfQxyJsYLMPn8U1UaDqK78m
         yq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QN2sRop3uQ+bqxKtqViavKiIv7WX65j8ADm6oPZVwSI=;
        b=qXWMyIvjrAWlCeSb9/bGxTmBG/v/zaDlnnHMN8pexBQYQJOfLmEW1ymaJWOLtdeqiU
         tHrCMC31qTdOBStHYJjN7l8cDo0945f/56mvbjQcERC+Bmfwzw0TFjaHnJzVgupmgET5
         mTKuq4TqgL3blNMtVxxs2agrAGgjHMUIZXL87RdLNb50ZAmAfCaeCIuhBtRlS6J6+XT9
         fg2ZZI6DK+s9UNQuxZzuuRJ8hODlgXwILU29SmyUiYUCHYZLup5zDoixC0+COVmpcKEF
         S+5DUHUbPFQEFvoBvmvqMap9Olcrz9MIRJnKk9rvjA1SONm65Xf9eTkxVIV5oQ3XuwkR
         jsnQ==
X-Gm-Message-State: ACrzQf17DJqfDyiHnISEhqUr3dxa4kZJ/+ZkENdkw1LLIa8xYfED+OhR
	M09dBFYp+FxDC6KBOyWgYVWU3Y6meBp5K83USTs=
X-Google-Smtp-Source: AMsMyM4N1o7O1myI5bAS7kabQnhToRoqDVD3vAwpwqoj+BiCUckfOkKT77gPycSX68NItP39dixz/Q==
X-Received: by 2002:a17:90a:73ca:b0:213:c06c:7004 with SMTP id n10-20020a17090a73ca00b00213c06c7004mr60391787pjk.111.1668033438873;
        Wed, 09 Nov 2022 14:37:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c21-20020a63ef55000000b004393f60db36sm8001906pgk.32.2022.11.09.14.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:37:18 -0800 (PST)
Message-ID: <636c2b9e.630a0220.e9be3.e49c@mx.google.com>
Date: Wed, 09 Nov 2022 14:37:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-3-gc76f4e7e5c71
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lib: 9 runs,
 1 regressions (v5.10.153-cip19-3-gc76f4e7e5c71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9976

cip/linux-5.10.y-cip kselftest-lib: 9 runs, 1 regressions (v5.10.153-cip19-=
3-gc76f4e7e5c71)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19-3-gc76f4e7e5c71/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19-3-gc76f4e7e5c71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c76f4e7e5c7160107c9b5d8ec188f61fe326cec3 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1cb7ea4f9ffc5ae7db76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselft=
est-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselft=
est-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/636c1cb7ea4f9ffc=
5ae7db77
        new failure (last pass: v5.10.153-cip19) =

 =20

