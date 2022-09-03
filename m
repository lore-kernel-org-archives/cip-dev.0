Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8B7ECAAD4
	for <webhook@archiver.kernel.org>; Sat,  3 Sep 2022 07:59:47 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web08.1118.1662191983059051373
 for <cip-dev@lists.cip-project.org>;
 Sat, 03 Sep 2022 00:59:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=jjmoBMYo;
 spf=pass (domain: miraclelinux.com, ip: 209.85.218.50,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ej1-f50.google.com with SMTP id p16so7793745ejb.9
        for <cip-dev@lists.cip-project.org>;
 Sat, 03 Sep 2022 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yv9cI/3izrv4F2v00xxbMwrRQ20oI0OcVOOcGR6CDf0=;
        b=jjmoBMYo4vwAbrMaMcVlEm08gT6iUFr6u1WAMGtF+h6IhfQd/YzuTQ+chWhknaEftw
         vP6lEXhlnp/OZ3Ua9DXkfauTRIJhwsliWBWBHU1lIw4EnQQr4Njm6BDuh6jHyaW+tujb
         gIqZQOoAlVmSBdroym74U9LWJxoZQ78zRN00XJ8UpjAnSBRqVxwzL0ynUEIKTW3Lp804
         hRWbORvsJLfrjGGCzfYMoeqpiIiQ3zBpT2l0nGCc5mbMB4irDku2v1cwidYEGYbVeChu
         PJCvDdMfiND6FYWNZhIJhAkTadMpkgnKDYNNTkvHjSg2spw724r6Y6X9zEHsGmPm+9T8
         XlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yv9cI/3izrv4F2v00xxbMwrRQ20oI0OcVOOcGR6CDf0=;
        b=rBLaSNoN2/heDR2qsouWmRjeRs2fBqYMhqVCEkY27MPxj9mhQXl4GgxPr7IDo76eMP
         zKYjQBg/EURVzAb/5XQPp8fTz+e4x3fk4qAa0yk9B59aCu4b1c+abdexSxdoRjvst+0Q
         DapYMp1PLPVYR8lNa9nVlRKeUDFpw2slqassOrFnR3vf/TzPnjlF4aoKBFuVfGWr+0Vr
         ZTDPm42eEres4+EObxnNHdo/MvrMNEOgC/kQKEGdnvFfdils0+rbsO1ApDhVrWm4gkHS
         WVrEaLfqHruTHnOWmObOVIXwYhFgEmkWPi+9v39XNIUey2ojV7dEoZElA8EdEnDgOXRJ
         MzyQ==
X-Gm-Message-State: ACgBeo2T7xgRR3t6AKD5GFg5KbnlBEtiMuopETXcXJ9cysTI7Z8+DxAT
	3QK0Kuyp9Fx7PV+FvzA/0IKWc5ZgUemqZhQrqDjxFCOuKg==
X-Google-Smtp-Source: 
 AA6agR6G8qbiRxWCDY7/BAPtt0+HF15s4jAj2qD2vVpNfGBSXDgTc6hfPqtemRbbOaV/TPXDH3J/cOzbmh+j10qIL18=
X-Received: by 2002:a17:907:97d5:b0:733:1ce:9572 with SMTP id
 js21-20020a17090797d500b0073301ce9572mr30581757ejc.220.1662191981409; Sat, 03
 Sep 2022 00:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1643303563.git.jan.kiszka@siemens.com>
 <b9f11b364d7a658ccfd11313afdce13d19f6da7d.1643303563.git.jan.kiszka@siemens.com>
 <49100f0d-819b-9b37-d0c2-e8b91530eef9@siemens.com>
 <1711151143769181.21591@lists.cip-project.org>
In-Reply-To: <1711151143769181.21591@lists.cip-project.org>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Sat, 3 Sep 2022 16:59:04 +0900
Message-ID: 
 <CANgtXuN=5EB61kS+hYwd9R4Q78+nYnTrueZo7QULSKiX4CO_ng@mail.gmail.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 3/6] Add script
 deploy-kernelci.py for upload the cip-core-image-kernelci
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Sep 2022 07:59:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9458

On Sat, Sep 3, 2022 at 12:35 AM Alice Ferrazzi via
lists.cip-project.org
<alice.ferrazzi=miraclelinux.com@lists.cip-project.org> wrote:
>
> > We do not use "extension" (it's always "kernelci"), that's an easy
> > cleanup. But more important, we also pass the dtb while we do not push
> > it to kernelci - by intention?
>
> I don't think changing extension to static name "kernelci" is useful.
> about dtb you are right. currently I don't remember if it was intentional.
> probably would be useful to upload also the dtb and we can than try to
> find a way of make KernelCI work with the generated dtb.
>

I was looking again the script and extension variable is actually not
used anymore,
I thought from your text to just replace it with a static "kernelci" variable.
Works for me to remove it.

Thanks,
Alicef


-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

