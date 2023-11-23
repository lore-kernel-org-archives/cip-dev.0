Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497D1C5AD4C
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 12:50:57 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.89832.1700743847458520683
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 04:50:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=3ejS9ifh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6cb66f23eddso740525b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 04:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700743846; x=1701348646; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AyV/VMeu7rmqM/UiXvvd5PTlIJYQA8nUzFtSlkzKRSY=;
        b=3ejS9ifhM8xQSk2hqp1Efl1dWldUa4m7lCpjXyoGWnw8gIbleTZLJiDZhZeO9N3GYS
         rB5EXPWm4g4K5CFqjoKsVFVFBHizJ8hnA4geh67qN4a3CztYgJgijX32PRB8ZcaM+s0u
         2Tuk3akS4nOpozD2WvJp+FljalMZNTJO78yAEzMyHxYuvF6JR7oSSF8NFXc5i3VpA6QQ
         D8hn2L86J6Ww+1lHAgO8baYKTOMOyxJwyj9M914MDMwO15BL0R9Dr0+1YN0qMxd1gm2N
         jdXrGpeXzgCvSQ3pwZmvLQP40ffGibrVZzosgs06yS4Of5nJyvNgmsTO/Py5njPSUiXF
         AXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700743846; x=1701348646;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyV/VMeu7rmqM/UiXvvd5PTlIJYQA8nUzFtSlkzKRSY=;
        b=R44Ogk2R8NlLehBU8ialko4Ewazy3H4isTXgkkKCIG+29u8QBdBdzZsrtE1Z7BbuFg
         LUdH+CA9XH8pp5Wq1BpsgECHSz9cTWji6ES446x27fvcXviFYCNxhuG1LTnCZtXXFyrx
         0uduOGQICUvu2ZunmMg0cukIoNAbPIHYDGIUA7uWBMIVpinAcEVPkSSQXtof6Tv+YAay
         mJM9UKYI5mlicGY5hfoDSMAtvimtVsZ9MSNguttp1m3otTTslUqW5RBrUWCCtOseBgcs
         2PKwLTPNQwCUacXzpWyq9b6SyvZvL4Cu8BiNlaDRXJo3uwqJz+6wSzE+qbZ8f+CxvOYf
         ZHrw==
X-Gm-Message-State: AOJu0YyC3ohX6FaMK69XttJAE3MWN6uiRaGy+1FznJuDiJzbcAaFsta7
	1CuK8kHCXNKZVnbDty2VXE5HYBoyK7ZeE4B66l8=
X-Google-Smtp-Source: AGHT+IEVjXOkWtWA93DVM7jUQBbtXBiXiNkTa9oGMRSW0B6ACuJHuTzJj8TnUXhW7RLuNSAEDfgRPA==
X-Received: by 2002:a05:6a00:1da8:b0:6cb:db73:a6db with SMTP id z40-20020a056a001da800b006cbdb73a6dbmr3367998pfw.21.1700743846166;
        Thu, 23 Nov 2023 04:50:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006cb797722e6sm1146720pfj.109.2023.11.23.04.50.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:50:45 -0800 (PST)
Message-ID: <655f4aa5.050a0220.52afa.23ed@mx.google.com>
Date: Thu, 23 Nov 2023 04:50:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.62-cip9-13-g34c303883a305
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 8 runs,
 1 regressions (v6.1.62-cip9-13-g34c303883a305)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 12:50:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13668

cip-gitlab/ci/pavel/linux-test ltp-pty: 8 runs, 1 regressions (v6.1.62-cip9=
-13-g34c303883a305)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.62-cip9-13-g34c303883a305/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.62-cip9-13-g34c303883a305
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      34c303883a305f474c4a18745cf56101db5e9b39

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:     https://kernelci.org/test/plan/id/655f444cc89fc7be5f7e4b76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-13-g34c303883a305/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/ltp-pty-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-13-g34c303883a305/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/ltp-pty-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/655f444cc89fc7be5f7e4b=
77
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =20

