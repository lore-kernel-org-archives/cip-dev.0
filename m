Return-Path: <sergey@coolautomation.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF2C433F5
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 16:12:38 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web09.14529.1633536757542875497
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 09:12:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@coolautomation.com header.s=google header.b=AyFJ5rvE;
 spf=pass (domain: coolautomation.com, ip: 209.85.221.42,
 mailfrom: sergey@coolautomation.com)
Received: by mail-wr1-f42.google.com with SMTP id u18so10457776wrg.5
        for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coolautomation.com; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=SOYxvvi0JMPzDBJXDJXjUop9Ss+Jbg4mqTpOeDD7Eps=;
        b=AyFJ5rvEl7dfllMFhIYG4lZiOBAqT8Counm1vJTTN0IhWskDjITHogobU2J2Mt1tvJ
         vTWmn3BA7y0LkB3lAy5UaFsSpOVD3FbpIfBUdsEYdbCw0HO2mdqY889a3MmKUNsRlnpE
         DdheXmF8mw46WNUX7/tcVHToj3pEe5z6oI08I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=SOYxvvi0JMPzDBJXDJXjUop9Ss+Jbg4mqTpOeDD7Eps=;
        b=sPr055JdG6ELM+6zXhqBst6lprd2zMdxeWXlhYyg5FNhuQEbOQpQxYAadvF9PAIhEb
         hLhBZiS5unvukNsn9HKP1PJAmeXX13/Zr3aV4jC4VToVIMoIgouYDFqCRNUbmHtYOAoY
         2wyWMh+WNN6Mn7Un1N+yrFsHthJUH66s16vTw9wLuo6QjWs6qk2vUGAzmHpOGpr6tWEl
         /fyCoBz4dtb2ynBiZM3/2z7t11dk7ODyqlTDo+hesL62oJsNrdLwQGkAHyQDJEXsjyTT
         VEx9Gg2sVwbAHqFzz9ZWdadNrKEvm9n88ZY5DgOo53++K18bRZKLLBn0/pilX2vPY9d8
         LAww==
X-Gm-Message-State: AOAM5302g0Bb0OUy3Oqi4UZDYoAJBH52y5rxiCA3hhS3UluAif/Py6d2
	dtMxMxlmDQWNAgSq7kGxM9g1PMli/OUlrA==
X-Google-Smtp-Source: 
 ABdhPJw35YJDdE9QjU/yGOaiM/9I+BgZZ3G5+1WkpPNaAVwKA0bkPTpgEZEcAGfaDFwDwL2vj0R04w==
X-Received: by 2002:a05:600c:2057:: with SMTP id
 p23mr9462424wmg.67.1633536755592;
        Wed, 06 Oct 2021 09:12:35 -0700 (PDT)
Received: from cool (bzq-84-110-33-210.static-ip.bezeqint.net.
 [84.110.33.210])
        by smtp.gmail.com with ESMTPSA id
 l11sm8065461wms.45.2021.10.06.09.12.34
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:12:35 -0700 (PDT)
Date: Wed, 6 Oct 2021 19:12:33 +0300
From: Sergey Nazaryev <sergey@coolautomation.com>
To: cip-dev@lists.cip-project.org
Subject: Deby project status?
Message-ID: <20211006161233.ehdsr7n34dvr66rq@cool>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Oct 2021 16:12:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6793

Hi all,

Recently I've found the Deby project and I consider it as a candidate
for using on our new device.

However, as I can see, there is no activity in this project:

- last commit in cip-core/deby was in April
- it builds with errors
- there are no updates in Deby section of CIP core meetings reports
- all issues related to Deby (e.g. swupdate support) weren't updated
  since last year

It seems like a bad sign. Are all efforts aimed to isar-cip-core?

Anyway, is there any plans to develop Deby (or any other distro under
the aegis of CIP project for devices with storage restrictions) in
future?

Thank you in advance.

Best regards,
Sergey Nazaryev

