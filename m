Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7622C001B5
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 15:35:06 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web12.73.1662132899781932871
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 08:35:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=AZDi5/a7;
 spf=pass (domain: miraclelinux.com, ip: 209.85.218.53,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ej1-f53.google.com with SMTP id bj12so4563393ejb.13
        for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=04lKqJmVu/74MLWuXQme49tiP4woWCPAI5VBLA78TJ8=;
        b=AZDi5/a7TF7/0/ZR3LsjUGGMRLxCjlPdNg/UGkkdMofxylox10AzLOIKVYV62dtcDR
         I0sCFo3+OAceEKXN3DVfabFAvAJApPjOI2VJ9BT9zjG+bUfRVQjgRAHZd574beN43Csh
         xPnGsSsSSAmQWwJen5Em4NF23Ao7JCYBBtMo2NpLG0aHFiOhOW2ZCbdvtclcd9cT6XoD
         OCYvze0EAIRFqE0sO/H3D414Xg/yAstB1jJBW+LAOYobk4muK2dI+aQlDGqMzfyc/0OC
         jS0M+gNd1D6buCVjHeg+ks/yGmSLaF3n2/C97uIeUBBrK9MjVcFgzhShH9jK/+iOpvx3
         Sxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=04lKqJmVu/74MLWuXQme49tiP4woWCPAI5VBLA78TJ8=;
        b=h7emh4K5FOmq6xVVdmEw3z0AVyRqbkyq19Vc1/N5IZeBniGO0/+T3lpKxdLD3ns1g3
         BGirXBNcICFYVSLr1TirMM8tkiy3enk7NrSOs+xXwWfyZl2M5VZzoSI1BYi+i3/yFSb2
         I9NWbGTd9c/bryqiSg/hvw1fKW9fh6fsuGi87Ilc7LmhyW1f4HmeU/TgbpZhgVNacCC2
         jm8P5GzvuKKHsdBKGr9GRAanvouOGtXai9tveGic7L9k1puj4EtDk0ihBLcqG2Zl6+nJ
         MYuzDnO8dSYWOIwLEXSu88ldsVxURJSgwMJpMZV7aeSz6hF9THayLKxsy9Su4O+Q6wU2
         8VxA==
X-Gm-Message-State: ACgBeo2toHZMeP+Q0I23OQ8qo5gj5LlG8mMxoE6OptH8+f3cZL7qBbTK
	DesK3peAgCD0+qO3aLUqGYqM829x1mYPL2hAnFda/zXf2Q==
X-Google-Smtp-Source: 
 AA6agR7LloD6aqTsZcleSqeRB4UGjZvKV5Yb7xrfaddPQyysbRTwTJOZiqBuEIAKcVQFgaskP9xm/nO0IFWxff5EXW4=
X-Received: by 2002:a17:907:2d86:b0:741:8888:de8 with SMTP id
 gt6-20020a1709072d8600b0074188880de8mr18159576ejc.547.1662132514617; Fri, 02
 Sep 2022 08:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1643303563.git.jan.kiszka@siemens.com>
 <b9f11b364d7a658ccfd11313afdce13d19f6da7d.1643303563.git.jan.kiszka@siemens.com>
 <49100f0d-819b-9b37-d0c2-e8b91530eef9@siemens.com>
In-Reply-To: <49100f0d-819b-9b37-d0c2-e8b91530eef9@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Sat, 3 Sep 2022 00:27:57 +0900
Message-ID: 
 <CANgtXuOPvDoHviRKREWNUjtEqwvEEQ4aqdah5nM1jhQ_Snn72w@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH v3 3/6] Add script deploy-kernelci.py for
 upload the cip-core-image-kernelci
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 15:35:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9457

> We do not use "extension" (it's always "kernelci"), that's an easy
> cleanup. But more important, we also pass the dtb while we do not push
> it to kernelci - by intention?

I don't think changing extension to static name "kernelci" is useful.
about dtb you are right. currently I don't remember if it was intentional.
probably would be useful to upload also the dtb and we can than try to
find a way of make KernelCI work with the generated dtb.

Thanks,
Alicef

--
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

